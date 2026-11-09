# TinyCC at a pinned revision, on musl, compiled until it reproduces itself.
#
# Whatever C compiler this starts from, the stages after it are built by TinyCC
# alone, so they come out the same: that is checked here for GCC and clang, and on
# x86_64 for a TinyCC that nixpkgs builds up from a seed of a few hundred bytes,
# through stage0-posix and mes, with no C compiler to start with. It means the
# compiler that builds GCC 2.95 does not move when nixpkgs does, and any good
# enough C compiler on any platform could stand in as the first stage.
{ pkgs }:
let
  inherit (pkgs) lib;

  src = pkgs.fetchgit {
    url = "https://repo.or.cz/tinycc.git";
    rev = "3dc99dbc82f8e07308c5d398136803e62f9676df";
    hash = "sha256-qYsGgihowp2C6WFzbQuXEWgJG6evtu/10p5IH/ozIKY=";
  };

  libc = lib.getLib pkgs.musl;
  libcDev = lib.getDev pkgs.musl;

  # Builds three stages under the given prefix, and fails unless the last two are
  # the same, which is the fixed point.
  stages = { seed, firstStage ? "$CC -O2 -w", prefix, install }: seed.mkDerivation {
    pname = "tcc";
    version = "0.9.27-3dc99db";
    inherit src;
    dontConfigure = true;
    dontStrip = true;
    hardeningDisable = [ "all" ];
    nativeBuildInputs = [ pkgs.which pkgs.perl ];

    buildPhase = ''
      runHook preBuild

      stage() {
        name=$1
        shift
        mkdir ../$name
        cp -R . ../$name/
        (
          cd ../$name
          echo 0.9.27 > VERSION
          ./configure --prefix=${prefix} --config-musl --config-bcheck=no \
            --crtprefix=${libc}/lib \
            --sysincludepaths={B}/include:${libcDev}/include \
            --libpaths={B}:${libc}/lib \
            --elfinterp=${libc}/lib/ld-musl-${pkgs.stdenv.hostPlatform.parsed.cpu.name}.so.1 \
            --cc="$*"
          make -j$NIX_BUILD_CORES tcc libtcc1.a
        )
      }

      stage stage1 ${firstStage}
      stage stage2 $PWD/../stage1/tcc -B$PWD/../stage1
      stage stage3 $PWD/../stage2/tcc -B$PWD/../stage2
      cmp ../stage2/tcc ../stage3/tcc
      cmp ../stage2/libtcc1.a ../stage3/libtcc1.a

      runHook postBuild
    '';

    installPhase = install;
  };

  tcc = stages {
    seed = pkgs.stdenv;
    prefix = "$out";
    install = ''
      mkdir -p $out/bin $out/lib/tcc
      cp ../stage3/tcc $out/bin/
      cp ../stage3/libtcc1.a $out/lib/tcc/
      cp -R ../stage3/include $out/lib/tcc/include
    '';
  };

  # The host compiler for the toolchains: static programs, and no optimizer to
  # exploit undefined behavior in code from the 1990s. It is a script because
  # libtool removes -static from a command line.
  staticCC = pkgs.writeShellScript "tcc-static" ''
    exec ${tcc}/bin/tcc -static -w ${wcharFix} "$@"
  '';

  # TinyCC defines wchar_t as int on arm64, where it is unsigned and musl's headers
  # say so. Only the host's is affected: GCC uses the target's.
  wcharFix = lib.optionalString pkgs.stdenv.hostPlatform.isAarch64 "'-D__WCHAR_TYPE__=unsigned'";

  # What the fixed point is from one seed, under a prefix that does not depend on
  # the seed the way a store path would.
  fixedPoint = args: stages (args // {
    prefix = "/fixed-point";
    install = ''
      sha256sum ../stage3/tcc ../stage3/libtcc1.a | cut -d' ' -f1 > $out
    '';
  });

  fromSeed = with pkgs.minimal-bootstrap.tinycc-musl; {
    seed = pkgs.stdenvNoCC;
    # A script because TinyCC only takes -ar as its first argument.
    firstStage = pkgs.writeShellScript "seed-tcc" ''
      case "$1" in
        -ar) exec ${compiler}/bin/tcc "$@" ;;
        *) exec ${compiler}/bin/tcc -static -w -B${libs}/lib -I${libs}/include -L${libs}/lib "$@" ;;
      esac
    '';
  };

  seeds = [
    { seed = pkgs.stdenv; }
    { seed = pkgs.clangStdenv; }
  ] ++ lib.optional pkgs.stdenv.hostPlatform.isx86_64 fromSeed;

  check = pkgs.runCommandLocal "tcc-fixed-point-check" { } ''
    for point in ${lib.concatMapStringsSep " " fixedPoint seeds}; do
      cmp $point ${fixedPoint { seed = pkgs.stdenv; }}
    done
    touch $out
  '';
in
{
  inherit tcc staticCC check;
}
