# GCC 2.95.3 and Binutils 2.22 for mipsel-ecoff as WebAssembly modules, for
# any WASI runtime on any host, with libgcc and the usual commands,
# mipsel-ecoff-gcc and the rest, that run them. See README.md in the
# directory above.
#
# They are cross compiled by wasi-sdk's clang, with the programs GCC runs to
# generate its own sources built for the build machine by its compiler. WASI
# has no processes, so the driver writes down what it would run, and
# mipsel-ecoff-gcc runs each step under the runtime. libgcc is built by that
# driver, so the modules build what the native toolchain does.
{ pkgs, toolchain }:
let
  wasi = pkgs.pkgsCross.wasi32;

  # The sources and patches toolchain.nix builds from.
  gccSrc = pkgs.fetchurl {
    url = "mirror://gnu/gcc/gcc-2.95.3/gcc-core-2.95.3.tar.gz";
    sha256 = "56811ee60990b4660d54c2a66f5e0253a487e330ee53b499d8a565882ff16ef7";
  };
  binutilsSrc = pkgs.fetchurl {
    url = "mirror://gnu/binutils/binutils-2.22.tar.gz";
    sha256 = "12c26349fc7bb738f84b9826c61e103203187ca2d46f08b82e61e21fcbc6e3e6";
  };
  unpack = ''
    tar xzf ${binutilsSrc}
    tar xzf ${gccSrc}
    patch -p1 -d binutils-2.22 < ${../patches/binutils-2.22-mixed-endian-ecoff.patch}
    patch -p1 -d binutils-2.22 < ${../patches/binutils-2.22-align-end.patch}
    patch -p1 -d gcc-2.95.3 < ${../patches/gcc-2.95.3-obstack-lvalue.patch}
    patch -p1 -d gcc-2.95.3 < ${../patches/gcc-2.95.3-no-gofast.patch}
    patch -p1 -d gcc-2.95.3 < ${../patches/gcc-2.95.3-libgcc-no-libc.patch}
    patch -p1 -d gcc-2.95.3 < ${../patches/gcc-2.95.3-large-int-args.patch}
    patch -p1 -d gcc-2.95.3 < ${../patches/gcc-2.95.3-lp64-host.patch}
    cp -f ${pkgs.gnu-config}/config.sub binutils-2.22/config.sub
    cp -f ${pkgs.gnu-config}/config.sub gcc-2.95.3/config.sub
  '';

  # wasi-libc emulates what these old programs need of signals, process
  # clocks, mmap and getpid. setjmp, which cpp uses to recover from a bad #if,
  # is WebAssembly exception handling, the current proposal, which is what
  # runtimes implement. -fwrapv and friends keep a current optimizer from
  # exploiting what was undefined behavior to begin with.
  wasiFlags = builtins.concatStringsSep " " [
    "-O2 -fwrapv -fno-strict-aliasing -fno-delete-null-pointer-checks -w -std=gnu89"
    "-mllvm -wasm-enable-sjlj -mllvm -wasm-use-legacy-eh=false"
    "-Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    "-Wno-error=implicit-function-declaration -Wno-error=implicit-int -Wno-error=return-type"
    "-D_WASI_EMULATED_SIGNAL -D_WASI_EMULATED_PROCESS_CLOCKS -D_WASI_EMULATED_MMAN -D_WASI_EMULATED_GETPID"
  ];
  # The compatibility library is linked whole, for the constructor that
  # starts each program in the host's directory, and in place of stat, to
  # give files the permissions WASI does not have.
  wasiLibs = "-lsetjmp -Wl,--whole-archive -lwasicompat -Wl,--no-whole-archive -Wl,--wrap=stat,--wrap=fstat,--wrap=lstat -lwasi-emulated-signal -lwasi-emulated-process-clocks -lwasi-emulated-mman -lwasi-emulated-getpid";

  # The build machine's compiler, for what GCC runs while it builds.
  buildCC = "${pkgs.stdenv.cc}/bin/cc -std=gnu89 -w -O0";

  platform = "--build=${pkgs.stdenv.buildPlatform.config} --host=wasm32-unknown-wasi --target=mipsel-ecoff";

  # Old code calls functions through pointers of other types, which native
  # code tolerates and WebAssembly traps on: binaryen's --fpcast-emu gives
  # every indirect call one type.
  wasmOpt = "${pkgs.binaryen}/bin/wasm-opt --enable-exception-handling --enable-bulk-memory --enable-sign-ext --enable-nontrapping-float-to-int --enable-mutable-globals --enable-reference-types --enable-multivalue --fpcast-emu -O2";

  version = "2.95.3";

  modules = wasi.stdenv.mkDerivation {
    pname = "mipsel-ecoff-toolchain-wasm";
    inherit version;

    dontUnpack = true;
    dontConfigure = true;
    dontStrip = true;

    nativeBuildInputs = with pkgs.buildPackages; [ bison flex perl gnum4 wasmtime ];

    buildPhase = ''
      runHook preBuild
      unset NIX_CFLAGS_LINK

      ${unpack}
      patch -p1 -d gcc-2.95.3 < ${../patches/gcc-2.95.3-wasm32-host.patch}

      mkdir compat
      cp ${./wasi-compat.h} compat/wasi-compat.h
      cp ${./wasi-compat.c} compat/wasi-compat.c
      (cd compat && $CC -O2 -c wasi-compat.c && $AR rcs libwasicompat.a wasi-compat.o)
      wasiCC="$CC ${wasiFlags} -include $PWD/compat/wasi-compat.h -L$PWD/compat ${wasiLibs}"

      mkdir build-binutils
      (
        cd build-binutils
        CC="$wasiCC" CC_FOR_BUILD="${buildCC}" CFLAGS= LDFLAGS= \
          ../binutils-2.22/configure ${platform} --prefix=/ \
          --disable-nls --disable-werror --disable-shared --disable-plugins --disable-largefile \
          --enable-64-bit-bfd
        make -j$NIX_BUILD_CORES MAKEINFO=true
      )

      mkdir build-gcc
      (
        cd build-gcc
        CC="$wasiCC" CC_FOR_BUILD="${buildCC}" HOST_CC="${buildCC}" CFLAGS= LDFLAGS= \
          ../gcc-2.95.3/configure ${platform} --prefix=/ \
          --enable-languages=c --disable-nls --with-gnu-as --with-gnu-ld
        make all-libiberty MAKEINFO=true
        make -C gcc -j$NIX_BUILD_CORES MAKEINFO=true CC="$wasiCC" CFLAGS= HOST_CC="${buildCC}" \
          xgcc cccp cc1 stmp-int-hdrs
      )

      # Laid out as the native toolchain installs, which is where the driver
      # looks, given GCC_EXEC_PREFIX: cpp0 and cc1 under lib/gcc-lib, as and
      # ld under mipsel-ecoff/bin, and the rest in libexec.
      lib=$out/lib/gcc-lib/mipsel-ecoff/${version}
      mkdir -p $out/bin $out/libexec/mipsel-ecoff $lib $out/mipsel-ecoff/bin
      for t in build-gcc/gcc/xgcc:$out/libexec/mipsel-ecoff/xgcc.wasm \
               build-gcc/gcc/cccp:$lib/cpp0 build-gcc/gcc/cc1:$lib/cc1 \
               build-binutils/gas/as-new:$out/mipsel-ecoff/bin/as \
               build-binutils/ld/ld-new:$out/mipsel-ecoff/bin/ld \
               build-binutils/binutils/ar:$out/libexec/mipsel-ecoff/ar.wasm \
               build-binutils/binutils/nm-new:$out/libexec/mipsel-ecoff/nm.wasm \
               build-binutils/binutils/objdump:$out/libexec/mipsel-ecoff/objdump.wasm; do
        ${wasmOpt} ''${t%%:*} -o ''${t##*:}
      done
      cp -r build-gcc/gcc/include $lib/include
      substitute ${./mipsel-ecoff-gcc} $out/bin/mipsel-ecoff-gcc --subst-var-by wasmtime ${pkgs.wasmtime}/bin/wasmtime
      for tool in as ld ar ranlib nm objdump; do
        substitute ${./mipsel-ecoff-tool} $out/bin/mipsel-ecoff-$tool --subst-var-by wasmtime ${pkgs.wasmtime}/bin/wasmtime
      done
      chmod +x $out/bin/*

      # libgcc, each multilib of it, built by the modules through the driver.
      export HOME=$PWD # wasmtime keeps a cache there
      make -C build-gcc/gcc stmp-multilib MAKEINFO=true CC=true HOST_CC="${buildCC}" \
        GCC_FOR_TARGET=$out/bin/mipsel-ecoff-gcc \
        AR_FOR_TARGET=$out/bin/mipsel-ecoff-ar RANLIB_FOR_TARGET=$out/bin/mipsel-ecoff-ranlib
      for dir in . eb mips3 single soft-float; do
        mkdir -p $lib/$dir
        cp build-gcc/gcc/$dir/libgcc.a $lib/$dir/libgcc.a
      done

      runHook postBuild
    '';

    dontInstall = true;
    # The commands are POSIX sh, for any host: the cross shell's shebang would
    # be the WebAssembly host's.
    dontPatchShebangs = true;
  };

  # Through mipsel-ecoff-gcc, the modules compile tests/output.c to what
  # the reference generated, at -O0 and -O2; build each libgcc as the native
  # toolchain does, which for the soft-float one is the reference too; and
  # compile, assemble and link a program using floats and long long to what
  # the native toolchain makes of it, less the debug information, which holds
  # the paths of each build.
  check = pkgs.runCommandLocal "mipsel-ecoff-wasm-check" {
    nativeBuildInputs = [ modules toolchain ];
  } ''
    export HOME=$PWD # wasmtime keeps a cache there
    native=${toolchain}/bin
    cp ${../tests/output.c} output.c
    for level in O0 O2; do
      ${modules}/bin/mipsel-ecoff-gcc -$level -msoft-float -S -o output.$level.s output.c
      diff -u ${../tests}/output.$level.s output.$level.s
    done

    ${modules}/bin/mipsel-ecoff-gcc -O2 -msoft-float -c -o wasm.o output.c
    $native/mipsel-ecoff-gcc -O2 -msoft-float -c -o native.o output.c
    cmp wasm.o native.o

    for dir in . eb mips3 single soft-float; do
      mkdir -p libgcc/$dir/wasm libgcc/$dir/native
      (cd libgcc/$dir/wasm && sh ${../tests/libgcc.sh} $native/mipsel-ecoff-objdump $native/mipsel-ecoff-ar \
        ${modules}/lib/gcc-lib/mipsel-ecoff/${version}/$dir/libgcc.a > ../wasm.txt)
      (cd libgcc/$dir/native && sh ${../tests/libgcc.sh} $native/mipsel-ecoff-objdump $native/mipsel-ecoff-ar \
        ${toolchain}/lib/gcc-lib/mipsel-ecoff/${version}/$dir/libgcc.a > ../native.txt)
      diff -u libgcc/$dir/native.txt libgcc/$dir/wasm.txt
    done
    diff -u ${../tests/libgcc.expected} libgcc/soft-float/wasm.txt

    printf 'double a = 1.5, b = 2.5;\nlong long n = 1000000007LL;\nint main(void) { return (int)(a * b / a) + (int)(n / 7) + (int)(n %% 13); }\n' > link.c
    link="-O2 -msoft-float -nostdlib -Wl,-Ttext,0x80140000,-e,main link.c -lgcc"
    ${modules}/bin/mipsel-ecoff-gcc -o wasm.out $link
    $native/mipsel-ecoff-gcc -o native.out $link
    $native/mipsel-ecoff-strip wasm.out native.out
    cmp wasm.out native.out

    touch $out
  '';
in
{
  inherit modules check;
}
