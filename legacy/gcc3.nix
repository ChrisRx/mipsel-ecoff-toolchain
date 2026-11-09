# GCC 3.2.3 and Binutils 2.23.2 for mipsel-ecoff, the last releases with the
# target: GCC 3.3 made it obsolete and 3.4 removed it, and Binutils 2.24
# removed it from the assembler and linker. Built as toolchain.nix builds
# 2.95.3, by TinyCC alone, as static programs on musl, but for mipsel-ecoff in
# general rather than the Net Yaroze: none of that toolchain's SDK patches
# apply. See README.md in this directory.
{ pkgs }:
let
  tinycc = import ./tcc.nix { inherit pkgs; };

  version = "3.2.3";
  binutilsVersion = "2.23.2";

  gccSrc = pkgs.fetchurl {
    url = "mirror://gnu/gcc/gcc-${version}/gcc-core-${version}.tar.gz";
    sha256 = "712df2ef0e7af25cac2d7828d336965a0cc2d627ba56f1d8aaa4c941d0386175";
  };

  binutilsSrc = pkgs.fetchurl {
    url = "mirror://gnu/binutils/binutils-${binutilsVersion}.tar.gz";
    sha256 = "d42cb1d82ead40ef55edd978d31c22f2d105712fc3a280dbba42cf7a316d0d56";
  };

  hostCC = tinycc.staticCC;

  platform = "--build=${pkgs.stdenv.buildPlatform.config} --host=${pkgs.stdenv.hostPlatform.config} --target=mipsel-ecoff";

  toolchain = pkgs.stdenvNoCC.mkDerivation {
    pname = "mipsel-ecoff-toolchain";
    inherit version;

    dontUnpack = true;
    dontConfigure = true;
    dontStrip = true; # the host's strip does not understand the target's libraries

    nativeBuildInputs = with pkgs; [ tinycc.tcc binutils-unwrapped bison flex perl ];

    buildPhase = ''
      runHook preBuild

      tar xzf ${binutilsSrc}
      tar xzf ${gccSrc}
      patch -p1 -d gcc-${version} < ${./patches/gcc-3.2.3-ecoff-unaligned-ops.patch}
      patch -p1 -d gcc-${version} < ${./patches/gcc-3.2.3-ecoff-no-mips3-multilib.patch}
      patch -p1 -d gcc-${version} < ${./patches/gcc-3.2.3-real-sign-extend.patch}
      patch -p1 -d gcc-${version} < ${./patches/gcc-3.2.3-aarch64-host.patch}

      # Neither knows every host this builds on.
      cp -f ${pkgs.gnu-config}/config.sub binutils-${binutilsVersion}/config.sub
      cp -f ${pkgs.gnu-config}/config.sub gcc-${version}/config.sub

      mkdir build-binutils
      (
        cd build-binutils
        CC="${hostCC}" CFLAGS= ../binutils-${binutilsVersion}/configure ${platform} --prefix=$out \
          --disable-nls --disable-werror --disable-shared
        make -j$NIX_BUILD_CORES MAKEINFO=true CFLAGS=
        make MAKEINFO=true install
      )

      export PATH=$out/bin:$PATH

      mkdir build-gcc
      (
        cd build-gcc
        CC="${hostCC}" CFLAGS= ../gcc-${version}/configure ${platform} --prefix=$out \
          --enable-languages=c --disable-nls --with-gnu-as --with-gnu-ld
        # There are no target headers for fixincludes to fix, and it does not
        # build without the host's C library anyway.
        sed -i 's/^STMP_FIXINC = .*/STMP_FIXINC =/; s/^STMP_FIXPROTO = .*/STMP_FIXPROTO =/' gcc/Makefile
        make -j$NIX_BUILD_CORES MAKEINFO=true CC="${hostCC}" CFLAGS=
      )

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      make -C build-gcc MAKEINFO=true CC="${hostCC}" CFLAGS= install

      # Host libraries nothing here links against, which a 64-bit host installs
      # under a name stdenv then tries and fails to merge.
      rm -rf $out/lib64

      runHook postInstall
    '';
  };

  # What it generates has to stay what a separate 32-bit x86 build of the same
  # sources and patches generated, by GCC rather than TinyCC: tests/output.c,
  # and the code in every libgcc. To regenerate, see tests/gcc-3.2.3/README.
  outputCheck = pkgs.runCommandLocal "mipsel-ecoff-${version}-output-check" {
    nativeBuildInputs = [ toolchain ];
  } ''
    ref=${./tests/gcc-3.2.3}
    cp ${./tests/output.c} output.c
    for level in O0 O2; do
      mipsel-ecoff-gcc -$level -msoft-float -S -o output.$level.s output.c
      diff -u $ref/output.$level.s output.$level.s
    done

    for dir in . eb single single/eb soft-float soft-float/eb; do
      rm -rf members
      mkdir members
      (cd members && sh ${./tests/libgcc.sh} mipsel-ecoff-objdump mipsel-ecoff-ar \
        ${toolchain}/lib/gcc-lib/mipsel-ecoff/${version}/$dir/libgcc.a | sed "s|^|$dir |")
    done > libgcc.actual
    diff -u $ref/libgcc.expected libgcc.actual

    touch $out
  '';

  dist = import ./dist/dist.nix {
    inherit pkgs toolchain gccSrc binutilsVersion;
    reference = ./tests/gcc-3.2.3;
    drivers = [ "gcc" "cpp" ];
    multilibs = "-EB, -msingle-float and -msoft-float";
    about = ''
      These are the last releases with the target: GCC 3.3 made it obsolete
      and 3.4 removed it, and Binutils 2.24 removed it from the assembler and
      linker. For the Net Yaroze, use the 2.95.3 archive instead, which is
      what its SDK was made for and is patched for it.

      main calls __main, which runs constructors and gives atexit the
      destructors, so a program without a C library defines atexit, or its
      own __main. There is no mips3 libgcc: with -mips3 this compiler makes
      pointers 64 bits, which ECOFF cannot relocate.
    '';
  };
in
{
  inherit toolchain outputCheck;
  distArchive = dist.archive;
  distCheck = dist.check;
}
