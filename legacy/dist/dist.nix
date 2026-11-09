# A native toolchain as an archive for hosts without Nix: its programs are
# static already, so this lays them out under one directory, with a driver
# script that finds the rest from wherever that directory is unpacked. See
# README in this directory, which goes in the archive.
{ pkgs
, toolchain
  # What the archive holds, as xPack's toolchains name it, and with GNU's
  # name for the C++ part of 2.95: gcc, or gcc-g++.
, compiler ? "gcc"
, gccSrc
, binutilsVersion
  # tests/output.c compiled at -O0 and -O2, as output.O0.s and output.O2.s.
, reference
  # The drivers in bin, each run through the script.
, drivers
  # For the README: which libgcc multilibs there are, and what this version
  # is for.
, multilibs
, about
  # Whether there is C++ to check: tests/cxx/output.cc compiled to its
  # reference, and a constructor that collect2 gathers.
, cxx ? false
}:
let
  inherit (toolchain) version;
  name = "mipsel-ecoff-${compiler}-${version}";
  # gzip rather than xz, which is a third the size, but missing from minimal
  # systems, as Ubuntu's container image.
  file = "${name}-${pkgs.stdenv.hostPlatform.system}.tar.gz";

  # The binutils commands, each in bin with the target's prefix and, for those
  # gcc and collect2 run, in mipsel-ecoff/bin without it.
  tools = [ "addr2line" "ar" "as" "c++filt" "elfedit" "ld" "ld.bfd" "nm" "objcopy" "objdump" "ranlib" "readelf" "size" "strings" "strip" ];
  toolDir = [ "ar" "as" "ld" "ld.bfd" "nm" "objcopy" "objdump" "ranlib" "strip" ];

  readme = pkgs.replaceVars ./README {
    inherit name;
    gcc = version;
    binutils = binutilsVersion;
    inherit multilibs;
    about = about;
  };

  archive = pkgs.runCommandLocal file { } ''
    root=$PWD/${name}
    mkdir -p $root/bin $root/libexec $root/lib $root/mipsel-ecoff/bin $root/mipsel-ecoff/lib

    for tool in ${toString tools}; do
      cp ${toolchain}/bin/mipsel-ecoff-$tool $root/bin/
    done
    for tool in ${toString toolDir}; do
      ln -s ../../bin/mipsel-ecoff-$tool $root/mipsel-ecoff/bin/$tool
    done
    for driver in ${toString drivers}; do
      cp ${toolchain}/bin/mipsel-ecoff-$driver $root/libexec/
      cp ${./mipsel-ecoff-gcc} $root/bin/mipsel-ecoff-$driver
    done
    cp -R ${toolchain}/lib/gcc-lib $root/lib/
    cp -R ${toolchain}/mipsel-ecoff/lib/ldscripts $root/mipsel-ecoff/lib/

    cp ${readme} $root/README
    tar xzf ${gccSrc} --strip-components=1 -C $root gcc-${version}/COPYING gcc-${version}/COPYING.LIB
    tar xzf ${pkgs.musl.src} --wildcards --strip-components=1 -O '*/COPYRIGHT' > $root/COPYRIGHT.musl

    chmod -R u+w,go-w $root
    chmod 755 $root/bin/* $root/libexec/*

    # The same bytes from the same inputs.
    tar --sort=name --mtime=@1 --owner=0 --group=0 --numeric-owner \
      --format=gnu -cf - ${name} | gzip -9 -n > $out
  '';

  # Unpacked somewhere new, in a directory with a space in its name, with
  # none of the Nix store paths the programs were built with: the reference
  # output, a link, and the driver run through a link of its own.
  check = pkgs.runCommandLocal "${name}-dist-check" { } (''
    if [ -e ${builtins.unsafeDiscardStringContext toolchain.outPath} ]; then
      echo "error: the toolchain the archive came from is visible here" >&2
      exit 1
    fi

    mkdir "unpacked here"
    tar xzf ${archive} -C "unpacked here"
    prefix="$PWD/unpacked here/${name}"
    export PATH="$prefix/bin:$PATH"

    cp ${../tests/output.c} output.c
    for level in O0 O2; do
      mipsel-ecoff-gcc -$level -msoft-float -S -o output.$level.s output.c 2> warnings
      diff -u ${reference}/output.$level.s output.$level.s
      if [ -s warnings ]; then cat warnings; exit 1; fi
    done

    # atexit for GCC 3's __main, which gives it the destructors.
    cat > link.c <<'SRC'
    double a = 1.5, b = 2.5;
    long long n = 1000000007LL;
    int atexit(void (*f)(void)) { return 0; }
    int main(void) { return (int)(a * b / a) + (int)(n / 7) + (int)(n % 13); }
    SRC
    mkdir elsewhere
    ln -s "$prefix/bin/mipsel-ecoff-gcc" elsewhere/cc
    elsewhere/cc -O2 -msoft-float -nostdlib -Wl,-Ttext,0x80140000,-e,main -o link.out link.c -lgcc
    mipsel-ecoff-nm link.out | grep -q ' T main$'
    mipsel-ecoff-nm link.out | grep -q ' __divdi3$'
    mipsel-ecoff-objdump -f link.out | grep -q 'ecoff-littlemips'

    for driver in ${toString drivers}; do
      mipsel-ecoff-$driver --version > /dev/null
    done
  '' + pkgs.lib.optionalString cxx ''

    cp ${../tests/cxx/output.cc} output.cc
    for level in O0 O2; do
      mipsel-ecoff-g++ -$level -msoft-float -S -o output.cc.$level.s output.cc
      diff -u ${../tests/cxx}/output.$level.s output.cc.$level.s
    done

    # collect2 runs nm and the compiler from the archive, and puts the
    # constructor in __CTOR_LIST__: a count, then the constructors.
    cat > ctor.cc <<'SRC'
    int value;
    struct Init { Init() { value = 42; } } init;
    int main() { return value; }
    SRC
    ln -s "$prefix/bin/mipsel-ecoff-c++" elsewhere/c++
    elsewhere/c++ -O2 -msoft-float -fno-exceptions -nostdlib -Wl,-Ttext,0x80140000,-e,main -o ctor.out ctor.cc -lgcc
    ctor=$(mipsel-ecoff-nm ctor.out | awk '$3 ~ /^_GLOBAL_\$I\$/ { print $1 }')
    list=$(mipsel-ecoff-nm ctor.out | awk '$3 == "__CTOR_LIST__" { print $1 }')
    # The words from objdump's hex columns, which start after the address,
    # turned around from little-endian.
    words=$(mipsel-ecoff-objdump -s --start-address=0x$list --stop-address=0x$(printf %x $((0x$list + 8))) ctor.out \
      | awk '/^ [0-9a-f]+ / { printf "%s", substr($0, 11, 35) }' | tr -d ' ' | cut -c1-16 \
      | sed 's/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1 /g; s/ $//')
    if [ "$words" != "00000001 $ctor" ]; then
      echo "error: __CTOR_LIST__ holds $words, not 1 and $ctor" >&2
      exit 1
    fi
  '' + ''

    touch $out
  '');
in
{
  inherit archive check;
}
