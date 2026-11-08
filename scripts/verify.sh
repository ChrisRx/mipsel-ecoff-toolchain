#!/bin/sh
#
# Checks that the generated assembly really does reproduce libps.a.
#
# The original ECOFF objects are the only authority for what this library
# means, so the port is only trustworthy if it can be compared against them.
# Each object in libps.a is assembled from the generated source and the
# resulting .text is compared word by word against the ECOFF .text.
#
# Relocated words are compared under a mask. ECOFF is a REL format that stores
# addends in the instruction itself, while the generated source names a symbol
# and lets the assembler put the addend in the ELF relocation, so the
# immediate and jump-target fields legitimately differ. Everything outside
# those fields, including every opcode and register, must match exactly.
#
set -eu

CROSS=${CROSS:-mipsel-none-elf-}
LIBPS=${LIBPS:-sdk/lib/libps.a}
BUILD=${BUILD:-build/verify}

if ! command -v "${CROSS}as" >/dev/null 2>&1; then
    echo "error: ${CROSS}as not found; run inside 'nix develop'" >&2
    exit 1
fi

if ! command -v ecoffcmp >/dev/null 2>&1; then
    echo "error: ecoffcmp not found; run inside 'nix develop'" >&2
    exit 1
fi

mkdir -p "$BUILD"

echo "assembling generated sources"
for f in lib/*.S; do
    "${CROSS}gcc" -march=mips1 -mtune=r3000 -mabi=32 -EL -msoft-float -G0 \
        -mno-abicalls -fno-pic -c -o "$BUILD/$(basename "$f" .S).o" "$f"
done

echo "comparing against $LIBPS"
exec ecoffcmp \
    "$(cd "$(dirname "$LIBPS")" && pwd)/$(basename "$LIBPS")" \
    "$(cd "$BUILD" && pwd)"
