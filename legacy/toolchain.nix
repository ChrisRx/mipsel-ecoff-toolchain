# GCC 2.95.3 and Binutils 2.22 for mipsel-ecoff, built by TinyCC as static native
# programs on 64-bit Linux, with no dependencies at run time. See README.md in
# this directory.
{ pkgs, eco2exe }:
let
  inherit (pkgs) stdenv lib;

  tinycc = import ./tcc.nix { inherit pkgs; };

  gccSrc = pkgs.fetchurl {
    url = "mirror://gnu/gcc/gcc-2.95.3/gcc-core-2.95.3.tar.gz";
    sha256 = "56811ee60990b4660d54c2a66f5e0253a487e330ee53b499d8a565882ff16ef7";
  };

  binutilsSrc = pkgs.fetchurl {
    url = "mirror://gnu/binutils/binutils-2.22.tar.gz";
    sha256 = "12c26349fc7bb738f84b9826c61e103203187ca2d46f08b82e61e21fcbc6e3e6";
  };

  # The C++ front end and its runtime, unpacked over the same tree.
  gxxSrc = pkgs.fetchurl {
    url = "mirror://gnu/gcc/gcc-2.95.3/gcc-g++-2.95.3.tar.gz";
    sha256 = "f82baf09502b0e908851bb983847c4431c8029493038e4b375c8a98f0ec7e73f";
  };

  # TinyCC stays where it is pinned, so this does not move with a current GCC.
  hostCC = tinycc.staticCC;

  platform = "--build=${stdenv.buildPlatform.config} --host=${stdenv.hostPlatform.config} --target=mipsel-ecoff";

  # libgcc's archives the same from every build: ar's D leaves out the dates,
  # owners and modes of the members and, with the binutils patch, of the
  # index, and ar writes the index as it adds the members, so ranlib, which
  # would date it again, has nothing to do. They go at the end of
  # gcc/Makefile, where the last assignment wins, since the top-level
  # Makefile passes no command-line variables down (MAKEOVERRIDES=).
  deterministicAr = "printf '%s\\n' 'AR_FLAGS_FOR_TARGET = rcD' 'RANLIB_FOR_TARGET = true' >> gcc/Makefile";

  # The compiler and binutils alone, which is what goes in the binary cache, so
  # none of Sony's files may end up in the output, which the end of the install
  # checks. Nothing of the SDK goes into building it either: see the
  # gcc-2.95.3-libgcc-no-libc patch.
  #
  # There is no compiler in this environment other than TinyCC.
  #
  # With cxx, C++ as well, in a toolchain of its own: its libgcc has the C++
  # runtime, and collect2 gathers constructors, so the C toolchain, what it
  # is checked against, and the WebAssembly build of it stay as they are. What
  # cxx adds goes at the ends of lines, so that without it the derivation is
  # the same.
  mkToolchain = { cxx ? false }: pkgs.stdenvNoCC.mkDerivation {
    pname = "mipsel-ecoff-toolchain${lib.optionalString cxx "-cxx"}";
    version = "2.95.3";

    dontUnpack = true;
    dontConfigure = true;
    dontStrip = true; # the host's strip does not understand the target's libraries

    nativeBuildInputs = with pkgs; [ tinycc.tcc binutils-unwrapped bison flex perl ];

    buildPhase = ''
      runHook preBuild

      tar xzf ${binutilsSrc}
      tar xzf ${gccSrc}${lib.optionalString cxx "\ntar xzf ${gxxSrc}"}
      patch -p1 -d binutils-2.22 < ${./patches/binutils-2.22-mixed-endian-ecoff.patch}
      patch -p1 -d binutils-2.22 < ${./patches/binutils-2.22-align-end.patch}
      patch -p1 -d binutils-2.22 < ${./patches/binutils-2.22-ecoff-deterministic-armap.patch}
      patch -p1 -d gcc-2.95.3 < ${./patches/gcc-2.95.3-obstack-lvalue.patch}
      patch -p1 -d gcc-2.95.3 < ${./patches/gcc-2.95.3-no-gofast.patch}
      patch -p1 -d gcc-2.95.3 < ${./patches/gcc-2.95.3-libgcc-no-libc.patch}
      patch -p1 -d gcc-2.95.3 < ${./patches/gcc-2.95.3-large-int-args.patch}
      patch -p1 -d gcc-2.95.3 < ${./patches/gcc-2.95.3-lp64-host.patch}${lib.optionalString cxx ''

      patch -p1 -d gcc-2.95.3 < ${./patches/gcc-2.95.3-ecoff-collect2.patch}
      patch -p1 -d gcc-2.95.3 < ${./patches/gcc-2.95.3-ecoff-no-libstdcxx.patch}''}

      # Neither is old enough not to know these hosts' names otherwise.
      cp -f ${pkgs.gnu-config}/config.sub binutils-2.22/config.sub
      cp -f ${pkgs.gnu-config}/config.sub gcc-2.95.3/config.sub

      mkdir build-binutils
      (
        cd build-binutils
        CC="${hostCC}" CFLAGS= ../binutils-2.22/configure ${platform} --prefix=$out \
          --disable-nls --disable-werror --disable-shared
        make -j$NIX_BUILD_CORES MAKEINFO=true CFLAGS=
        make MAKEINFO=true install
      )

      export PATH=$out/bin:$PATH

      mkdir build-gcc
      (
        cd build-gcc
        CC="${hostCC}" CFLAGS= ../gcc-2.95.3/configure ${platform} --prefix=$out \
          --enable-languages=c${lib.optionalString cxx ",c++"} --disable-nls --with-gnu-as --with-gnu-ld
        sed -i 's/^ALL_TARGET_MODULES/#&/; s/^INSTALL_TARGET_MODULES/#&/' Makefile
        ${deterministicAr}
        make -j$NIX_BUILD_CORES MAKEINFO=true CC="${hostCC}" CFLAGS=
      )

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      # MAKEINFO=true writes no documentation, which install expects to find.
      touch build-gcc/gcc/cpp.info build-gcc/gcc/gcc.info${lib.optionalString cxx " build-gcc/gcc/cp/g++.info"}
      make -C build-gcc MAKEINFO=true install

      # Host libraries nothing here links against, which a 64-bit host installs
      # under a name stdenv then tries and fails to merge.
      rm -rf $out/lib64
      if grep -rlI 'Sony Computer Entertainment' $out; then
        echo "error: the toolchain output holds files from the SDK" >&2
        exit 1
      fi

      runHook postInstall
    '';
  };

  toolchain = mkToolchain { };
  toolchainCxx = mkToolchain { cxx = true; };

  # The toolchain with the SDK, built locally and never cached. Specs in a file
  # do what the original script edited into the compiler's own: libps is the C
  # library, ahead of libgcc so that it wins the soft-float routines both have,
  # and startup.o is the crt0.
  sdk = pkgs.runCommandLocal "mipsel-ecoff-sdk-${toolchain.version}" { } ''
    target=$out/mipsel-ecoff
    mkdir -p $out/bin $out/lib $target/bin
    cp -R ${../sdk}/. $target/
    chmod -R u+w $target

    cat > $out/lib/yaroze.specs <<SPECS
    *startfile:
    $target/lib/startup.o

    *lib:
    %{pg:-lprof1} %{p:-lprof1} -lps

    *libgcc:
    -lps -lgcc

    SPECS
    sed -i 's/^    //' $out/lib/yaroze.specs

    # -idirafter so that GCC's own stdarg.h and friends still come first, as when
    # the SDK is installed in the compiler's own prefix.
    cat > $out/bin/mipsel-ecoff-gcc <<WRAPPER
    #!${pkgs.runtimeShell}
    exec ${toolchain}/bin/mipsel-ecoff-gcc -specs=$out/lib/yaroze.specs \
      -idirafter $target/include -L$target/lib -Dpsx -Dunix "\$@"
    WRAPPER
    sed -i 's/^    //' $out/bin/mipsel-ecoff-gcc
    chmod +x $out/bin/mipsel-ecoff-gcc

    for tool in ${toolchain}/bin/mipsel-ecoff-*; do
      name=$(basename $tool)
      [ -e $out/bin/$name ] || ln -s $tool $out/bin/$name
    done

    # Where the samples' Makefiles look for the compiler: CC = ../../bin/gcc
    ln -s $out/bin/mipsel-ecoff-gcc $target/bin/gcc
  '';

  # What this compiler generates has to stay what the reference generated, with
  # any compiler or libc under it, on any host. To regenerate after deliberately
  # changing the compiler, see tests/output.c and tests/libgcc.sh.
  outputCheck = pkgs.runCommandLocal "mipsel-ecoff-output-check" {
    nativeBuildInputs = [ toolchain ];
  } ''
    cp ${./tests/output.c} output.c
    for level in O0 O2; do
      mipsel-ecoff-gcc -$level -msoft-float -S -o output.$level.s output.c
      diff -u ${./tests}/output.$level.s output.$level.s
    done

    mkdir libgcc
    cd libgcc
    sh ${./tests/libgcc.sh} mipsel-ecoff-objdump mipsel-ecoff-ar \
      ${toolchain}/lib/gcc-lib/mipsel-ecoff/${toolchain.version}/soft-float/libgcc.a > libgcc.actual
    diff -u ${./tests/libgcc.expected} libgcc.actual

    touch $out
  '';

  # The C++ toolchain still generates the C toolchain's C, and its C++ has to
  # stay what a separate 32-bit x86 build of it generated, by GCC rather than
  # TinyCC: tests/cxx/output.cc, and the code in every libgcc, which is the C
  # toolchain's but for the C++ runtime and the _ctors.o collect2 needs. See
  # tests/cxx/README.
  cxxOutputCheck = pkgs.runCommandLocal "mipsel-ecoff-cxx-output-check" {
    nativeBuildInputs = [ toolchainCxx ];
  } ''
    cp ${./tests/output.c} output.c
    cp ${./tests/cxx/output.cc} output.cc
    for level in O0 O2; do
      mipsel-ecoff-gcc -$level -msoft-float -S -o output.$level.s output.c
      diff -u ${./tests}/output.$level.s output.$level.s
      mipsel-ecoff-g++ -$level -msoft-float -S -o output.cc.$level.s output.cc
      diff -u ${./tests/cxx}/output.$level.s output.cc.$level.s
    done

    lib=${toolchainCxx}/lib/gcc-lib/mipsel-ecoff/${toolchainCxx.version}
    for dir in $(cd $lib && find . -name libgcc.a | LC_ALL=C sed 's|/libgcc.a$||; s|^\./||; s|^\.$|.|' | LC_ALL=C sort); do
      rm -rf members
      mkdir members
      (cd members && sh ${./tests/libgcc.sh} mipsel-ecoff-objdump mipsel-ecoff-ar $lib/$dir/libgcc.a | sed "s|^|$dir |")
    done > libgcc.actual
    diff -u ${./tests/cxx/libgcc.expected} libgcc.actual

    touch $out
  '';

  # Builds the SDK's sample, then a program using floats, which is what needs the
  # patches. Doubles have to land on the resident library's addresses, and the
  # results have to turn into executables.
  check = pkgs.runCommandLocal "mipsel-ecoff-check" {
    nativeBuildInputs = [ sdk eco2exe pkgs.gnumake pkgs.file ];
  } ''
    cp -R ${sdk}/mipsel-ecoff/sample/sjiscode .
    chmod -R u+w sjiscode
    mipsel-ecoff-gcc -O2 -msoft-float -c -o sjiscode/main.o sjiscode/main.c
    mipsel-ecoff-gcc -Wl,-Ttext,0x80140000,-e,_start -msoft-float -o sjiscode/main sjiscode/main.o
    file sjiscode/main | grep -q 'MIPSEL ECOFF executable'
    eco2exe sjiscode/main sjiscode.exe

    cat > float.c <<SRC
    #include <stdio.h>
    double a = 1.5, b = 2.5;
    float f = 1.5f;
    int i = 3;
    int main(void)
    {
      puts("float");
      return (int)(a + b * a / b - (double)i) + (int)(f * f + (float)i) + (a < b);
    }
    SRC
    mipsel-ecoff-gcc -O2 -msoft-float -Wl,-Ttext,0x80140000,-e,_start -o float float.c
    mipsel-ecoff-nm float | grep -q '^8003df74 . __adddf3$'
    eco2exe float float.exe

    touch $out
  '';
  # The toolchain as an archive, for hosts without Nix.
  dist = import ./dist/dist.nix {
    inherit pkgs toolchain gccSrc;
    binutilsVersion = "2.22";
    reference = ./tests;
    drivers = [ "gcc" ];
    multilibs = "-EB, -mips3, -msingle-float and -msoft-float";
    about = ''
      This is the compiler the Net Yaroze SDK was made for, and it is patched
      for the SDK: it calls libps's soft-float routines by their standard
      names, reads the mixed-endian objects in its libps.a, and word aligns
      _end for its InitHeap. The SDK itself is not included. For mipsel-ecoff
      in general, the 3.2.3 archive has the last releases with the target.
      The gcc-g++ archive is the same compiler with C++.
    '';
  };

  distCxx = import ./dist/dist.nix {
    inherit pkgs gccSrc;
    toolchain = toolchainCxx;
    compiler = "gcc-g++";
    binutilsVersion = "2.22";
    reference = ./tests;
    drivers = [ "gcc" "g++" "c++" ];
    multilibs = "-EB, -mips3, -msingle-float and -msoft-float";
    cxx = true;
    about = ''
      This is the 2.95.3 toolchain for the Net Yaroze, with the same patches
      for its SDK, and C++ as well: mipsel-ecoff-g++. There is no libstdc++,
      which needs a C library, so no iostreams, strings or containers: the
      language, and its runtime, new, delete, typeinfo and exceptions, which
      are in libgcc. That runtime calls malloc, free, abort, memset, strcmp
      and strlen, which libps has all of but abort, so a Net Yaroze program
      defines abort. -fno-exceptions keeps programs smaller.

      Constructors and destructors of globals are gathered by collect2 at
      link time, into __CTOR_LIST__ and __DTOR_LIST__, and main calls __main
      to run them. The SDK's startup.o has a __main of its own that does
      nothing, so on the Net Yaroze a program runs them itself, first thing
      in main:

          typedef void (*func_ptr)(void);
          extern "C" func_ptr __CTOR_LIST__[];

          for (unsigned long i = (unsigned long)__CTOR_LIST__[0]; i > 0; i--)
              __CTOR_LIST__[i]();

      dynamic_cast across a hierarchy, to a sibling base, gives a null
      pointer in this compiler. Casts down to a derived class work.
    '';
  };
in
{
  inherit toolchain toolchainCxx sdk check outputCheck cxxOutputCheck;
  tccCheck = tinycc.check;
  distArchive = dist.archive;
  distCheck = dist.check;
  distCxxArchive = distCxx.archive;
  distCxxCheck = distCxx.check;
}
