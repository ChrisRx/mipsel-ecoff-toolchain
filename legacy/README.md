# Legacy mipsel-ecoff toolchain

A cross compiler toolchain for the Sony Playstation [Net Yaroze](https://en.wikipedia.org/wiki/Net_Yaroze). The Net Yaroze SDK (included) uses the mipsel-ecoff target which has long since been considered obselete in GCC and therefore requires a much older version of GCC. Compiling these older versions of Binutils/GCC is achieved by using a modern version of GCC to compile an intermediate version of GCC that allows stepping backwards to the desired version (e.g. GCC v8.2.1 -> GCC v3.3.4 -> GCC v2.95.2). The final cross compiler is then able to cross compile the defunct combination of 32-bit MIPS (LE) and the ECOFF file object format used with the Net Yaroze SDK.

This is how the repository started. For building programs today, see [the main README](../README.md).

## With Nix

On x86_64 and aarch64 Linux the flake builds this toolchain directly, and the SDK along with it:

```
nix build .#legacy-toolchain    # GCC 2.95.3 and Binutils 2.22 alone
nix develop .#legacy            # the same with the SDK, as mipsel-ecoff-gcc
nix flake check                 # includes the checks described below
```

The script below steps back through an intermediate compiler because modern compilers reject the old C and GCC 2.95 has no 64-bit host. The flake does neither: [toolchain.nix](toolchain.nix) adds a 64-bit host, and builds it with [TinyCC](tcc.nix) alone, as static programs on musl with nothing they depend on at run time.

Three checks hold this in place, since what matters most here is that the compiler stays correct and stays the same:

 * `legacy-output` compiles [tests/output.c](tests/output.c), and compares the result, and the code in `libgcc`, with what a separate 32-bit x86 build of this compiler generated. So no host, compiler or libc underneath may change what it generates. If you change the compiler on purpose, regenerate `tests/output.*.s`, and `tests/libgcc.expected` with `tests/libgcc.sh`.
 * `legacy-tcc` builds the pinned TinyCC from different compilers, and requires the same bytes from each once it has rebuilt itself: GCC, clang, and on x86_64 a TinyCC from nixpkgs' `minimal-bootstrap`, which starts from a seed of a few hundred bytes with no C compiler at all. So what compiles GCC 2.95 does not depend on where it came from.
 * `legacy` builds the SDK's sample and a program using floats and `puts`, and checks that doubles land on the resident library.

The same compiler builds as WebAssembly modules, for any WASI runtime on any host, so that it stays available however hosts change. `nix build .#legacy-toolchain-wasm` gives `mipsel-ecoff-gcc`, `-as`, `-ld`, `-ar`, `-ranlib`, `-nm` and `-objdump`, which run the modules under wasmtime, or the runtime `MIPSEL_ECOFF_WASI_RUNTIME` names, which has to take wasmtime's arguments and implement WebAssembly exception handling, for the `setjmp` `cpp` recovers from a bad `#if` with. The modules are cross compiled by wasi-sdk's clang from the same sources and patches ([wasm/wasm.nix](wasm/wasm.nix)), and laid out as the native toolchain installs; `libgcc`, each multilib of it, is built by the modules themselves.

WASI has no processes, so the driver cannot run `cpp0`, `cc1`, `as` and `ld` itself: it writes each command to a plan instead, and [mipsel-ecoff-gcc](wasm/mipsel-ecoff-gcc) runs them in turn and stops at the first that fails. Each module sees the host's file system as it is and starts in the directory it was run from. The `legacy-wasm` check holds the modules to the native build: `tests/output.c` compiled to the reference at `-O0` and `-O2`, the same object from `-c`, every `libgcc` the same as the native one, and a program using floats and `long long` linked to the same executable, less the debug information, which holds each build's paths.

`gcc-2.95.3-wasm32-host` adds the host, fixes two calls that only worked where a call's arguments are not checked against its callee, and writes the driver's commands to its plan. [wasm/wasi-compat.c](wasm/wasi-compat.c) makes the process calls WASI lacks fail as a system without them would, starts each program in the host's directory, and gives files the permissions WASI does not have, which `ar` records. Binutils is built with `--enable-64-bit-bfd`, as a 32-bit host needs for the `mips3` multilib's 64-bit constants.

To use the toolchain somewhere else, without Nix, copy it there, and set `GCC_EXEC_PREFIX` to `<where>/lib/gcc-lib/` so that it can find `cc1`, or pass `-B`.

[toolchain.nix](toolchain.nix) applies these patches, each explained at the top of its file in [patches/](patches/):

 * `gcc-2.95.3-obstack-lvalue` is what a current C compiler needs to build it.
 * `gcc-2.95.3-lp64-host` adds the 64-bit Linux host.
 * `gcc-2.95.3-large-int-args` fixes calls TinyCC rejects for missing an argument.
 * `gcc-2.95.3-no-gofast` makes floating point call `__adddf3` and friends, as libps provides, rather than GOFAST's `dpadd`.
 * `gcc-2.95.3-libgcc-no-libc` builds `libgcc` without the SDK's headers, whose `LONG_MIN` breaks converting a `double` to a `long long`.
 * `binutils-2.22-mixed-endian-ecoff` reads `puts.o` and the `*SF*.O` helpers in `libps.a`, which have big-endian headers around little-endian code.
 * `binutils-2.22-align-end` word aligns `_end`, since libps's `InitHeap` faults on an odd address before `main` runs.

The last two, the GOFAST and `libgcc` patches, and `-lps` ahead of `-lgcc`, fix problems that the script below still has: programs using floats, `puts` or `long long` conversions, or whose `.bss` ends on a stray byte, can fail to link or crash.

Some problems are not fixed here, because they are how the original software behaves:

 * libps's `__floatsidf` never returns for `INT_MIN`, under any compiler, and this compiler also calls it to convert an `unsigned` of `0x80000000` to a `double`.
 * libps's `sprintf` has no `%f`, which gives an empty result.
 * libps's `memcmp` compares a byte when its length is 0.
 * `va_arg` in GCC's `va-mips.h` reads a struct whose size is not a multiple of 4 from the wrong place, on little-endian MIPS.

GCC's own c-torture tests run against this toolchain as `TestCTorture` in [psxsdk](https://github.com/ChrisRx/psxsdk), in its emulator, which holds the compiler to the right answers. That test lists each that does not pass and why.

## Building

Run these from this directory. `nix develop ..#legacy` provides what the script needs. If a `PREFIX` isn't given, it simply defaults to `$PWD/yaroze`.

```
./mipsel-ecoff-toolchain PREFIX=$PWD/yaroze
```

This will make folders during the build process: `{build,sources,stamps}`. These can be cleaned up also using `make clean`.

Originally, I was building this toolchain in a docker container, but ultimately found it not necessary on the OSes I was working with (Ubuntu and Arch Linux). However, others have had success building this toolchain on a different OS/platform using docker. For example, [docker-yaroze](https://github.com/Davermouse/docker-yaroze) has compiled Net Yaroze executables successfully on macOS. I'm unfamiliar with the docker environment on Windows, but the capability to run linux containers should be roughly the same (probably through WSL). In any case, it's worth giving a look if you are needing to build on a non-linux OS.

## Compiling the sample

The sample project is one included with the Net Yaroze SDK and can be used to verify that the toolchain is working:

```
cd <PREFIX>/mipsel-ecoff/sample/sjiscode
make
```

Should produce a binary that looks like this:

```
$ file main
main: MIPSEL ECOFF executable (paged) not stripped - version 2.11
```

## Running executables

Since Net Yaroze executables are not PSX-EXE files (PS1 executable format) they cannot be loaded into an emulator or CD iso builder. The Net Yaroze Boot Disk (DTL-S3035) runs a program that listens for serial I/O commands and loads the entire Net Yaroze SDK into memory. At this point, SIOCONS.EXE can be used to load the Net Yaroze executable at the correct starting address and the serial command to execute whats loaded into memory can then be sent. It is possible to prebuild a PSX-EXE that loads a bare Net Yaroze executable in a similar way by combining it with the SDK into a single PSX-EXE file. To do this, I've adapted the [https://github.com/gwald/Yarexe](https://github.com/gwald/Yarexe) tool (itself also a combination of the work of others) into [eco2exe](https://github.com/ChrisRx/psxsdk#eco2exe) over in the repo I currently keep assorted psx/ny dev tools. I adapted it with the hopes that it will be slightly more portable and maintainable as a Go project.

With a valid PSX-EXE it can now be ran in emulators that can load the PSX-EXE format (mednafen, NO$PSX) or a PSX CD image can be made with something like [https://github.com/Lameguy64/mkpsxiso](https://github.com/Lameguy64/mkpsxiso).
