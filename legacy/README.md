# Legacy mipsel-ecoff toolchain

A cross compiler toolchain for the Sony Playstation [Net Yaroze](https://en.wikipedia.org/wiki/Net_Yaroze). The Net Yaroze SDK (included) uses the mipsel-ecoff target which has long since been considered obselete in GCC and therefore requires a much older version of GCC. Compiling these older versions of Binutils/GCC is achieved by using a modern version of GCC to compile an intermediate version of GCC that allows stepping backwards to the desired version (e.g. GCC v8.2.1 -> GCC v3.3.4 -> GCC v2.95.2). The final cross compiler is then able to cross compile the defunct combination of 32-bit MIPS (LE) and the ECOFF file object format used with the Net Yaroze SDK.

This is how the repository started. For building programs today, see [the main README](../README.md).

## Which toolchain

There are two, both for `mipsel-ecoff`, both built by the flake on x86_64 and aarch64 Linux as static programs with nothing they need at run time, and both packed as archives to use without Nix:

| | GCC 2.95.3, Binutils 2.22 | GCC 3.2.3, Binutils 2.23.2 |
|---|---|---|
| For | the Net Yaroze | `mipsel-ecoff` in general |
| Why this version | what the SDK was made for | the last releases with the target: GCC 3.3 made it obsolete and 3.4 removed it, Binutils 2.24 removed it from the assembler and linker |
| Patches | builds on 64-bit hosts, plus fixes for the SDK's `libps` | fixes for the target itself, none for the Net Yaroze |
| `libgcc` multilibs | `-EB`, `-mips3`, `-msingle-float`, `-msoft-float` | the same but `-mips3` |
| Toolchain | `nix build .#legacy-toolchain` | `nix build .#legacy-toolchain-gcc3` |
| Archive | `nix build .#legacy-toolchain-dist` | `nix build .#legacy-toolchain-gcc3-dist` |

Use 2.95.3 for the Net Yaroze: the SDK expects it, and only it has the fixes the SDK's `libps` needs. For anything else, such as an R3000 simulator like vmips, either works, and 3.2.3 is the newer compiler.

For C++, there is a third: 2.95.3 again, with the same patches, and C++ as well (`nix build .#legacy-toolchain-cxx`, and `.#legacy-toolchain-cxx-dist` for its archive). It is separate so that the C toolchain, and everything checked against it, stays as it is. See [C++](#c) below.

An archive, `mipsel-ecoff-gcc-VERSION-SYSTEM.tar.gz`, or `mipsel-ecoff-gcc-g++-2.95.3-SYSTEM.tar.gz` with C++, 6 to 7 MB, unpacks anywhere on a Linux host with the same CPU:

```
tar xzf mipsel-ecoff-gcc-2.95.3-x86_64-linux.tar.gz
export PATH=$PWD/mipsel-ecoff-gcc-2.95.3/bin:$PATH
mipsel-ecoff-gcc -O2 -msoft-float -c hello.c
```

It has the compiler, Binutils, `libgcc` and the licenses, but nothing of the SDK, and no C library: link with `-nostdlib` and your own startup code, or a C library of your own.

## GCC 2.95.3

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

Because the programs are static, the toolchain also works without Nix, as an archive ([dist/dist.nix](dist/dist.nix), the same for both toolchains). Its `mipsel-ecoff-gcc` is a script ([dist/mipsel-ecoff-gcc](dist/mipsel-ecoff-gcc)) that points the driver at the directory it was unpacked in, through `GCC_EXEC_PREFIX` and `COMPILER_PATH`, since the driver otherwise looks under the store path it was built with. The archive is reproducible, and the `legacy-dist` check unpacks it with the original store path out of reach, in a directory with a space in its name, and requires the reference output and a working link, with the driver run through a link of its own.

The same compiler builds as WebAssembly modules, for any WASI runtime on any host, so that it stays available however hosts change. `nix build .#legacy-toolchain-wasm` gives `mipsel-ecoff-gcc`, `-as`, `-ld`, `-ar`, `-ranlib`, `-nm` and `-objdump`, which run the modules under wasmtime, or the runtime `MIPSEL_ECOFF_WASI_RUNTIME` names, which has to take wasmtime's arguments and implement WebAssembly exception handling, for the `setjmp` `cpp` recovers from a bad `#if` with. The modules are cross compiled by wasi-sdk's clang from the same sources and patches ([wasm/wasm.nix](wasm/wasm.nix)), and laid out as the native toolchain installs; `libgcc`, each multilib of it, is built by the modules themselves.

WASI has no processes, so the driver cannot run `cpp0`, `cc1`, `as` and `ld` itself: it writes each command to a plan instead, and [mipsel-ecoff-gcc](wasm/mipsel-ecoff-gcc) runs them in turn and stops at the first that fails. Each module sees the host's file system as it is and starts in the directory it was run from. The `legacy-wasm` check holds the modules to the native build: `tests/output.c` compiled to the reference at `-O0` and `-O2`, the same object from `-c`, every `libgcc` the same as the native one, and a program using floats and `long long` linked to the same executable, less the debug information, which holds each build's paths.

`gcc-2.95.3-wasm32-host` adds the host, fixes two calls that only worked where a call's arguments are not checked against its callee, and writes the driver's commands to its plan. [wasm/wasi-compat.c](wasm/wasi-compat.c) makes the process calls WASI lacks fail as a system without them would, starts each program in the host's directory, and gives files the permissions WASI does not have, which `ar` records. Binutils is built with `--enable-64-bit-bfd`, as a 32-bit host needs for the `mips3` multilib's 64-bit constants.

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

## C++

`mkToolchain { cxx = true; }` in [toolchain.nix](toolchain.nix) builds the same 2.95.3 with the C++ front end, `mipsel-ecoff-g++`, which TinyCC compiles with no further patches. There is no libstdc++, which needs a C library, so no iostreams, strings or containers, but the whole language and its runtime: `new`, `delete`, `typeinfo` and exceptions, which are in `libgcc`. That runtime calls `malloc`, `free`, `abort`, `memset`, `strcmp` and `strlen`. libps has all of them but `abort`, so a Net Yaroze program defines `abort`. `-fno-exceptions` keeps programs smaller.

Two patches, which only this toolchain is built with:

 * `gcc-2.95.3-ecoff-collect2` gathers constructors and destructors with `collect2`, as GCC does on the other ECOFF MIPS targets. Without it, the compiler only marks each in a stabs set that nothing on ECOFF collects, so global constructors never run. `collect2` runs `nm` on the linked program, writes a table of what it finds and links again. It also changes `libgcc`'s `_ctors.o`; every other C member stays the C toolchain's.
 * `gcc-2.95.3-ecoff-no-libstdcxx` stops `g++` adding `-lstdc++ -lm` to every link.

`main` calls `__main`, which runs the table. On the Net Yaroze, the SDK's `startup.o` has a `__main` of its own that does nothing, so a program runs the constructors itself, first thing in `main`:

```c++
typedef void (*func_ptr)(void);
extern "C" func_ptr __CTOR_LIST__[];

for (unsigned long i = (unsigned long)__CTOR_LIST__[0]; i > 0; i--)
	__CTOR_LIST__[i]();
```

`dynamic_cast` to a sibling base, across a hierarchy, gives a null pointer in this compiler. Casts down to a derived class, `typeid`, and `dynamic_cast<void *>` work.

`legacy-cxx-output` holds its C to the C toolchain's reference, and its C++ and every `libgcc` to a separate 32-bit x86 build ([tests/cxx/README](tests/cxx/README)). `legacy-cxx-dist` checks its archive, including that `collect2`, run from the unpacked archive, puts a constructor in the table. [tests/cxx/output.cc](tests/cxx/output.cc), and a Net Yaroze program with a global constructor, were also run on psxsdk's emulator, under Sony's BIOS and libps.

## GCC 3.2.3

[gcc3.nix](gcc3.nix) builds GCC 3.2.3 and Binutils 2.23.2 the same way, by TinyCC alone, as static programs on musl, for `mipsel-ecoff` in general:

```
nix build .#legacy-toolchain-gcc3        # the toolchain
nix build .#legacy-toolchain-gcc3-dist   # as an archive
```

None of the Net Yaroze patches above apply to it, and Binutils needs none. GCC needs these, each explained at the top of its file:

 * `gcc-3.2.3-ecoff-unaligned-ops` gives non-ELF MIPS targets the assembler syntax for unaligned data. Without it, the frame tables that `-g` and `-fexceptions` bring in abort the compiler while it builds `libgcc`, on any host: GCC 3.2.3 cannot build itself for `mipsel-ecoff` as released.
 * `gcc-3.2.3-ecoff-no-mips3-multilib` leaves out the `-mips3` `libgcc`. With `-mips3` this compiler makes pointers 64 bits, which ECOFF has no relocation for.
 * `gcc-3.2.3-real-sign-extend` sign-extends the words of floating-point constants, which a 64-bit host otherwise writes as unsigned. The code is the same either way, but the assembly then matches a 32-bit host's.
 * `gcc-3.2.3-aarch64-host` adds the 64-bit ARM Linux host, which `configure` otherwise rejects.

fixincludes does not run: there are no target headers for it to fix, and it does not build without the host's C library.

As with 2.95.3, `legacy-gcc3-output` holds what it generates to a separate 32-bit x86 build of the same sources, by GCC rather than TinyCC: `tests/output.c` at `-O0` and `-O2`, and the code in every `libgcc`. [tests/gcc-3.2.3/README](tests/gcc-3.2.3/README) has how that was made and how to regenerate it. `legacy-gcc3-dist` checks its archive.

Two things differ from 2.95.3 in use. `main` calls `__main`, which runs constructors and gives `atexit` the destructors, so a program without a C library defines `atexit`, or its own `__main`. And GCC 3.2.3 installs `mipsel-ecoff-cpp` too, which the archive includes.

## Building with the script

This is the original way to build 2.95.3, kept as it was. On a current distribution it fails while its intermediate compiler runs fixincludes over the host's own headers, which that compiler cannot parse. The flake's builds above, or their archives, avoid that.

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
