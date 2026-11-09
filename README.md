# yaroze-toolchain

Build Sony PlayStation [Net Yaroze](https://en.wikipedia.org/wiki/Net_Yaroze) programs in C with current GCC and Binutils, targeting `mipsel-none-elf`. The Net Yaroze SDK is included.

The SDK shipped for `mipsel-ecoff`, a target long since removed from GCC, but that was only ever a container. The PlayStation CPU is an R3000A either way, and the console's serial loader takes a flat image, a load address and an entry point, so a current compiler produces the same kind of program with no old toolchain to bootstrap. The original GCC 2.95.3 is still here, in [legacy/](legacy/README.md), and the flake can build it too.

## Looking for more than GCC?

[psxsdk](https://github.com/ChrisRx/psxsdk) also compiles Net Yaroze C projects, with [its `yaroze` command](https://chrisrx.github.io/psxsdk/tools/yaroze/#c-projects) and nothing else but Go to install, and does a ton more: writing programs in Go, converting art, sound and models to the console's formats, building discs, an emulator, [playable examples](https://chrisrx.github.io/psxsdk/examples/) and [Sony's manuals](https://chrisrx.github.io/psxsdk/manuals/). This repository is for building with GCC specifically.

## Just a mipsel-ecoff toolchain?

For other little-endian MIPS work with ECOFF objects, such as an R3000 simulator like vmips, there are two native toolchains, each a static build with nothing to install that unpacks anywhere on Linux:

 * **GCC 2.95.3 and Binutils 2.22**, the compiler the Net Yaroze SDK was made for and patched for it. Use this one for the Net Yaroze. It also comes with C++, as a toolchain of its own.
 * **GCC 3.2.3 and Binutils 2.23.2**, the last releases that support the target, with no Net Yaroze patches.

For x86_64 Linux, with the aarch64 builds and the C++ one in [legacy/](legacy/README.md#downloads):

```
curl -LO https://files.yaroze.dev/toolchains/mipsel-ecoff-gcc-3.2.3-x86_64-linux.tar.gz
tar xzf mipsel-ecoff-gcc-3.2.3-x86_64-linux.tar.gz
export PATH=$PWD/mipsel-ecoff-gcc-3.2.3/bin:$PATH
```

Use `mipsel-ecoff-gcc-2.95.3` in place of `3.2.3` for the Net Yaroze. [legacy/](legacy/README.md#which-toolchain) has the differences.

## Writing your own program

You do not need a copy of this repository to build against the SDK. Start a project from the template:

```
nix flake init -t github:ChrisRx/yaroze-toolchain
nix develop github:ChrisRx/yaroze-toolchain#sdk
make
```

That gives you a `build/hello.exe` an emulator can boot. The whole project Makefile is:

```make
PROG = hello
SRCS = main.c

include $(YAROZE_PREFIX)/yaroze.mk
```

`yaroze.mk` carries the compiler flags, the link against the resident libps, and the `.elf` → `.bin` → `.exe` steps. `YAROZE_PREFIX` is set by the `sdk` dev shell; `CFLAGS`, `CPPFLAGS`, `LDFLAGS` and `LDLIBS` are appended to its defaults, so adding to them in your Makefile works as expected. The samples in this repo are built through the same file, so that path stays exercised.

## Nix

Nix is the supported way to build here. A flake provides each environment, so none of them needs packages installed by hand:

```
nix develop             # work on this repo: toolchain, psxsdk commands, make
nix develop .#sdk       # write your own program against a prebuilt SDK
nix develop .#legacy    # the original mipsel-ecoff GCC 2.95.3, Linux only, see legacy/
nix build .#legacy-toolchain-dist        # GCC 2.95.3 as an archive to use without Nix
nix build .#legacy-toolchain-cxx-dist    # GCC 2.95.3 with C++
nix build .#legacy-toolchain-gcc3-dist   # GCC 3.2.3
```

The `mipsel-none-elf` toolchain and the psxsdk commands come from a binary cache named in the flake, so Nix asks once whether to trust its settings. Say yes, or pass `--accept-flake-config`, or the toolchain compiles locally instead. On a multi-user install this also needs your user in `trusted-users`. `nix build .#gcc` builds just the compiler; `nix build .#libyaroze` builds the SDK tree that `YAROZE_PREFIX` points at.

Without Nix installed, [nix-portable](https://github.com/DavHau/nix-portable) runs all of this from one binary, with no root, daemon or `/nix`:

```
curl -L -o nix-portable https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname -m)
chmod +x nix-portable
NP_RUNTIME=bwrap ./nix-portable nix develop github:ChrisRx/yaroze-toolchain#sdk --accept-flake-config
```

`NP_RUNTIME` is needed because the runtime it picks by itself cannot run `nix develop`, failing with `setting up a private mount namespace: Operation not permitted`. Use `proot` where `bwrap` is not allowed. It keeps its store in `~/.nix-portable`, and it does not work on NixOS, which has no need of it. 

Bring your own emulator to run what it builds.

## Working on this repository

```
nix develop
make             # build libyaroze and the samples
make verify      # check the library against the SDK's libps.a
make generate    # regenerate lib/ from libps.a
```

```
Makefile      builds libyaroze.a and the samples
yaroze.mk     builds one program; what a project includes
lib/          generated from libps.a: the crt0, entry points and code members
ldscripts/    memory layout and section placement
include/      replaces the SDK headers a current compiler cannot read
compat/       what the SDK declares and libps lacks
scripts/      generate.sh and verify.sh
sdk/          the Net Yaroze SDK, as Sony shipped it
template/     the project `nix flake init` starts from
legacy/       the original mipsel-ecoff toolchain, by script or by flake
```

[docs/internals.md](docs/internals.md) explains how the library is converted and why the link works the way it does.

## Resources

 * [PSXDEV](http://www.psxdev.net/) - the community here is great and has collected a lot of helpful info about PSX development
 * [Net Yaroze For Linux](http://www.cebix.net/downloads/yarlinux.pdf)
