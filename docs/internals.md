# Internals

This builds Net Yaroze programs with a current GCC and Binutils, targeting
`mipsel-none-elf` instead of the long-removed `mipsel-ecoff`.

The machine code is unchanged: the PlayStation CPU is an R3000A either way, and
MIPS I is still a supported GCC target. What changes is only the container the
code is delivered in, and nothing downstream cares. The console's serial loader
is handed a flat image, a load address and an entry point; `eco2exe` needs the
same three things. ECOFF was never load-bearing.

## What libps.a actually is

`sdk/lib/libps.a` is small, and most of it is not code. Across all 25 objects
there are about 4.4KB of machine instructions:

| member | size | what it is |
| --- | --- | --- |
| `symusr.o` | **0 bytes** | 266 absolute symbols, no sections at all |
| `startup.o` | 448 + 336 | the crt0, originally `startup.s` |
| `stdef1-8.o` | 16 each | one `.sdata` word each |
| 13 `*SF*.O` | ~1.7KB | single-precision soft-float helpers |
| `krom2tm2.o` | 1552 | `Krom2Tim2`, kanji ROM to texture |
| `puts.o`, `video.o` | 160 | `puts`, `SetVideoMode` |

`symusr.o` is the whole libps API and it contains no instructions whatsoever:
its `.text`, `.data` and `.bss` are all zero length. It is 266 symbols with
storage class `SC_ABS`, holding fixed addresses in the `libps.exe` that the
boot disk (DTL-S3035) leaves resident in RAM:

```
[  0] e 00000000800100C8 st 1 sc 5  GetPadBuf
[  3] e 0000000080010754 st 1 sc 5  malloc
[ 46] e 000000008001F4B8 st 1 sc 5  GsSortFixBg16
```

So there is nothing to port there, only addresses to restate. Those become
`lib/symusr.S`, which defines each one at its fixed address. The remaining
~4.4KB is converted to assembly, and `lib/startup.S` is the crt0.

## Why disassembling libps.a does not work on its own

ECOFF is a REL format: relocations live in side tables and the relocated
instruction holds only an addend. A plain disassembly of `puts.o` therefore
reads

```
lui     $s0, 0x0
jal     0x0
```

because the real references are in the relocation table, not the instruction
stream. Reassembling that produces code that calls address zero. `ecoff2asm`
(in [psxsdk](https://github.com/ChrisRx/psxsdk)) reads the relocation tables
and respells each relocated word symbolically, which is what makes the output
usable:

```
lui $s0, %hi(.Lsect_rdata)
j .Lsect_text+0x28
addiu $s0, $s0, %lo(.Lsect_rdata)
jal putchar
```

Everything else is emitted as a literal `.word`, so only words that carry a
relocation are reinterpreted at all.

## Verifying against the original

The old ECOFF objects are the only authority for what this library means, so
`make verify` assembles every generated source and compares its `.text`
against the ECOFF `.text` word by word:

```
956 words compared across 16 objects (861 exact, 95 relocated), 9 skipped
all objects match libps.a
```

The nine skipped are the members with no `.text` at all: `symusr.o`, which is
nothing but absolute symbols, and the eight `stdef*.o`, which are one
`.sdata` word each.

Relocated words are compared under a mask, because ECOFF keeps the addend in
the instruction's immediate or jump-target field while the generated source
names a symbol and lets the addend live in the ELF relocation. Those fields
differ by design. Every opcode and register field, and every word carrying no
relocation, must match exactly.

## Things that bite

**The SDK is K&R C.** `libps.h` declares its entire API with empty parameter
lists (`extern int KanjiFntPrint();`). In C89 that means "unspecified
arguments"; since C23, which is GCC's default, it means "no arguments", so
every call with arguments is a hard error. `-std=gnu89 -fcommon` is required,
not optional.

**The SDK's `stdarg.h` does not compile.** Its `va_arg` assigns to a cast, which
GCC no longer accepts, so `include/stdarg.h` is found ahead of it and uses the
compiler's builtins. `sdk/` itself is left as Sony shipped it, since the old
toolchain still reads it.

**`abs` is declared and not provided.** The SDK headers promise it but libps has
no such entry point, so `compat/abs.c` supplies it.

**nixpkgs defaults this target to mips32r2 with an FPU.** `cc-wrapper` injects
`-march=` from `gcc.arch`, and GCC then refuses the build outright rather than
letting a later `-march=r3000` win. The flake sets `gcc.arch = "mips1"` and
`gcc.float = "soft"` so the injected flags agree with the target.

**`jal` cannot reach an absolute symbol.** The obvious way to define the libps
addresses, and what `symusr.o` itself did, is a global absolute symbol:
`GetPadBuf = 0x800100C8`. That does not work with ELF. ld does not apply the
usual MIPS PC-region masking to an absolute symbol, so even though the target
is in the same 256MB region as the caller, the link fails with
`relocation truncated to fit: R_MIPS_26 against 'GetPadBuf'`. `lib/symusr.S`
therefore emits them as offsets into an empty `@nobits` section that
`yaroze.ld` places at 0x80000000, which keeps the addresses exact while leaving
the symbols section relative, and those relocate correctly. `ecoff2asm` itself
now writes absolute symbols, which lld can relocate, so `scripts/generate.sh`
respells them.

Incidentally, the SDK's own compiler seems to have hit the same wall from the
other side: `video.o` reaches its one libps call with a `lui`/`ori`/`jalr`
sequence rather than a `jal`.

**`main` is not in `.text`.** At `-O2` GCC puts `main` in `.text.startup`.
A link script matching `*(.text.startup)` before `*(.text)` will therefore
place `main` at the image base, ahead of the real entry point.

## libgcc

libgcc is linked, and is needed. "Net Yaroze For Linux" says as much about the
original setup: `LDFLAGS` needs `-msoft-float` "so the program will get linked
against the right version of `libgcc.a`".

It is the only source of the helpers MIPS I has no instruction for. The 64-bit
integer routines (`__divdi3`, `__moddi3`, `__udivdi3`, `__umoddi3`, `__muldi3`,
`__ashldi3`, `__ashrdi3`, `__lshrdi3`, `__cmpdi2`) mean any use of `long long`
fails to link without it, and the bit-counting routines (`__clzsi2`,
`__ctzsi2`, `__popcountsi2`, `__ffssi2`) back `__builtin_clz` and friends,
since the R3000 has no `CLZ`. In total libgcc defines 1157 symbols that neither
libps nor `libyaroze.a` does.

Thirty symbols are defined by both, though, and for those the resident copy
should win: there is no reason to carry a second soft-float implementation in a
2MB machine when one is already in RAM. libps provides 18 of them (`__adddf3`,
`__subdf3`, `__muldf3`, `__divdf3`, `__extendsfdf2`, `__truncdfsf2`,
`__fixdfsi`, `__floatsidf`, `__negdf2`, the six `*df2` comparisons, plus
`__addsf3`, `__mulsf3`, `__divsf3`) and `libyaroze.a` the 12 single-precision
ones the SDK shipped as real code.

Getting that split right is exactly why `lib/symusr.S` is an object and not a
link script. A script assignment is applied only after the linker has scanned
the input archives, so `PROVIDE(__adddf3 = ...)` loses the race: libgcc's
member is already extracted. Defining the symbols in an object linked ahead of
the archives means no such member is extracted at all. On a small test program
using both `double` and `long long`, that is the difference between a 12,864
byte and a 4,464 byte image.

So the ordering rule is: `symusr.o` first, then `-lyaroze`, then `-lgcc` last.
To confirm it on your own program, check that the soft-float calls land in the
resident range:

```sh
mipsel-none-elf-objdump -d build/yourprog.elf | grep 'jal.*__'
```

Addresses in `0x8001`–`0x8004` are the resident library; anything at your load
address was linked in.

## Layout notes

`make install PREFIX=...` lays `yaroze.mk`, `include/`, `lib/` and `ldscripts/`
out in the arrangement `yaroze.mk` discovers relative to itself, so an
installed SDK needs no configuration beyond pointing `YAROZE_PREFIX` at it. The
samples are built by recursing into `yaroze.mk` rather than by their own rules,
so the path that users depend on is the one that gets tested.

`lib/` is derived, checked in so that building
does not need `ecoff2asm`. `sdk/lib/libps.a` remains the source
of truth; rerun `make generate` after changing it.
