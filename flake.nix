{
  description = "Net Yaroze cross-compilation environments (mipsel-none-elf and legacy mipsel-ecoff)";

  # The toolchain is a long compile that cache.nixos.org does not have, since
  # this target's flags are its own. Only the toolchain and psxsdk commands are pushed
  # here, never libyaroze, which holds Sony's headers and is built locally.
  nixConfig = {
    extra-substituters = [ "https://psxsdk.cachix.org" ];
    extra-trusted-public-keys = [
      "psxsdk.cachix.org-1:Q9imi/jF8XVymfemuUFkTeXn2AoZWfUU8lhTH6VenxM="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Only its source is used, to build the commands below.
    psxsdk = {
      url = "github:ChrisRx/psxsdk";
      flake = false;
    };
  };

  outputs =
    { self, nixpkgs, psxsdk }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
        cross = import nixpkgs { inherit system crossSystem; };
      });

      # The Net Yaroze SDK targets 32-bit little-endian MIPS with no operating
      # system. mipsel-none-elf is the modern spelling of that target and is
      # still supported by current GCC and Binutils, unlike the mipsel-ecoff
      # target the SDK originally shipped for.
      #
      # The gcc attributes are not cosmetic. nixpkgs defaults this target to
      # mips32r2 with hardware floating point, and because cc-wrapper injects
      # -march= from gcc.arch, every compile arrives with -march=mips32r2
      # already applied. That is not just a wrong default to override on the
      # command line: GCC rejects the combination outright with "-mips32r2
      # conflicts with the other architecture options, which specify a mips1
      # processor". Setting them here also builds libgcc itself for MIPS I
      # without an FPU, which is what the PlayStation's R3000A needs.
      crossSystem = {
        config = "mipsel-none-elf";
        libc = "newlib";
        gcc = {
          arch = "mips1";
          float = "soft";
        };
      };

      # gccWithoutTargetLibc is the stage of the cross bootstrap that exists
      # before a target C library does, and it is the right stage here: the C
      # library for this platform is libps, which is already resident in the
      # console's RAM and is reached through the fixed addresses in
      # lib/symusr.S. Nothing ever links newlib, and depending on it
      # only adds a build that has to succeed, which its MIPS libgloss
      # board-support code does not do for MIPS I.
      crossToolchain = cross: [
        cross.buildPackages.gccWithoutTargetLibc
        cross.buildPackages.binutils-unwrapped
      ];

      # Commands from psxsdk.
      #
      # To move to a newer psxsdk: nix flake update psxsdk, and if its
      # dependencies moved, take the new vendorHash from the error nix reports.
      mkPsxsdkGo = pkgs: pname: subPackages: attrs: pkgs.buildGo127Module ({
        inherit pname subPackages;
        version = "0-${psxsdk.shortRev}";
        src = psxsdk;
        vendorHash = "sha256-vOOM6j4oOFzwjjj5hExEKbIB6TnNRjMA3yOGeiGyX6c=";
        env.CGO_ENABLED = 0;
        doCheck = false;

        # go writes its settings under $HOME/.config. Where Nix cannot sandbox,
        # as under nix-portable in a container, that creates /homeless-shelter,
        # and Nix then refuses every build after it for the home directory
        # existing.
        preBuild = "export HOME=$TMPDIR";
        overrideModAttrs = _: { preBuild = "export HOME=$TMPDIR"; };
      } // attrs);

      # Combines a linked program with the resident library into a PSX-EXE.
      mkEco2exe = pkgs: mkPsxsdkGo pkgs "eco2exe" [ "tools/eco2exe" ] { };

      # Regenerate and verify lib/, which only working on this repo needs.
      mkEcoffTools = pkgs: mkPsxsdkGo pkgs "ecoff-tools" [
        "tools/ecoff2asm"
        "tools/ecoffcmp"
      ] { };

      # yaroze iso builds disc images. Programs are run in an emulator of your own,
      # so yaroze run's window has none of the libraries it loads at run time.
      mkYaroze = pkgs: mkPsxsdkGo pkgs "yaroze" [ "cmd/yaroze" ] { };

      # GCC 2.95.3 for mipsel-ecoff, which has a host entry for 64-bit Linux.
      mkLegacy = pkgs: import ./legacy/toolchain.nix {
        inherit pkgs;
        eco2exe = mkEco2exe pkgs;
      };
      # The same as WebAssembly modules, checked against the native build.
      mkLegacyWasm = pkgs: import ./legacy/wasm/wasm.nix {
        inherit pkgs;
        toolchain = (mkLegacy pkgs).toolchain;
      };
      isLegacySystem = nixpkgs.lib.hasSuffix "-linux";
      onLegacySystem = system: nixpkgs.lib.optionalAttrs (isLegacySystem system);

      # The SDK laid out the way yaroze.mk expects: headers, libyaroze.a,
      # startup.o, symusr.o, the link scripts and yaroze.mk itself. Point
      # YAROZE_PREFIX at this and a program needs no further configuration.
      mkLibyaroze = pkgs: cross: pkgs.stdenv.mkDerivation {
        pname = "libyaroze";
        version = "1.0";
        src = pkgs.lib.fileset.toSource {
          root = ./.;
          fileset = pkgs.lib.fileset.unions [
            ./Makefile
            ./yaroze.mk
            ./compat
            ./include
            ./ldscripts
            ./lib
            ./sdk/include
          ];
        };
        nativeBuildInputs = crossToolchain cross;
        hardeningDisable = [ "all" ];
        buildPhase = "make lib";
        installPhase = "make install PREFIX=$out";
        doCheck = false;
      };
    in
    {
      devShells = forAllSystems (
        { system, pkgs, cross }:
        {
          # Everything needed to build libyaroze and the samples for
          # mipsel-none-elf, and to regenerate lib/ from the SDK's libps.a.
          default = pkgs.mkShell {
            name = "yaroze-elf";

            packages = crossToolchain cross ++ [
              pkgs.gnumake
              (mkEco2exe pkgs)
              (mkYaroze pkgs)
              (mkEcoffTools pkgs)
            ];

            # Nix's compiler wrapper injects hardening flags that mean nothing
            # on a bare-metal R3000 and would otherwise have to be undone on
            # every command line.
            hardeningDisable = [ "all" ];

            shellHook = ''
              echo "mipsel-none-elf toolchain:"
              echo "  $(mipsel-none-elf-gcc --version | head -n 1)"
              echo "  $(mipsel-none-elf-ld --version | head -n 1)"
              echo
              echo "build the library and samples with:  make"
              echo "check them against libps.a with:     make verify"
            '';
          };

          # For writing your own Net Yaroze program against a prebuilt SDK,
          # rather than working on this repository. YAROZE_PREFIX is set, so a
          # project Makefile is three lines:
          #
          #     PROG = hello
          #     SRCS = main.c
          #     include $(YAROZE_PREFIX)/yaroze.mk
          #
          sdk = pkgs.mkShell {
            name = "yaroze-sdk";

            packages = crossToolchain cross ++ [
              pkgs.gnumake
              (mkEco2exe pkgs)
              (mkYaroze pkgs)
            ];

            hardeningDisable = [ "all" ];

            shellHook = ''
              export YAROZE_PREFIX=${mkLibyaroze pkgs cross}
              echo "Net Yaroze SDK for mipsel-none-elf"
              echo "  YAROZE_PREFIX=$YAROZE_PREFIX"
              echo
              echo "start a project with:  nix flake init -t github:ChrisRx/yaroze-toolchain"
            '';
          };

          # The original toolchain in legacy/, GCC 2.95.3 for mipsel-ecoff, the
          # target the SDK shipped for: built by the flake on Linux, and
          # what legacy/mipsel-ecoff-toolchain needs to bootstrap it by hand.
          legacy = pkgs.mkShell {
            name = "yaroze-ecoff";

            packages = with pkgs; [
              flex
              bison
              gnumake
              autoconf
              automake
              curl
              patch
              readline
              texinfo
              gcc
            ] ++ nixpkgs.lib.optional (isLegacySystem system) (mkLegacy pkgs).sdk;

            shellHook = ''
              echo "legacy mipsel-ecoff build environment"
              if command -v mipsel-ecoff-gcc >/dev/null; then
                echo "  $(mipsel-ecoff-gcc --version) from the flake, as mipsel-ecoff-gcc"
              fi
              echo "bootstrap by hand with: cd legacy && ./mipsel-ecoff-toolchain PREFIX=\$PWD/yaroze"
            '';
          };
        }
      );

      packages = forAllSystems (
        { system, pkgs, cross }:
        onLegacySystem system {
          legacy-toolchain = (mkLegacy pkgs).toolchain;
          legacy-sdk = (mkLegacy pkgs).sdk;
          legacy-toolchain-wasm = (mkLegacyWasm pkgs).modules;
        } // rec {
          default = libyaroze;

          # The built SDK, consumable from another flake.
          libyaroze = mkLibyaroze pkgs cross;

          eco2exe = mkEco2exe pkgs;
          ecoff-tools = mkEcoffTools pkgs;
          yaroze = mkYaroze pkgs;

          # Exposed so the toolchain can be built and cached on its own, which
          # is the slow part of a first-time setup.
          gcc = cross.buildPackages.gccWithoutTargetLibc;
          binutils = cross.buildPackages.binutils-unwrapped;
        }
      );

      checks = forAllSystems (
        { system, pkgs, ... }:
        onLegacySystem system {
          legacy = (mkLegacy pkgs).check;
          legacy-output = (mkLegacy pkgs).outputCheck;
          legacy-tcc = (mkLegacy pkgs).tccCheck;
          legacy-wasm = (mkLegacyWasm pkgs).check;
        }
      );

      templates.default = {
        path = ./template;
        description = "A Net Yaroze program for mipsel-none-elf";
      };

      formatter = forAllSystems ({ pkgs, ... }: pkgs.nixpkgs-fmt);
    };
}
