#!/bin/sh
#
# Regenerates lib/*.S from the SDK's libps.a.
#
# Everything under lib/ is a derived file. The source
# of truth is sdk/lib/libps.a, the stub library Sony shipped, and this script
# is how that is restated in a form a current assembler accepts. Run it after
# changing the SDK library or the converter; the output is checked in so that
# building does not require ecoff2asm.
#
# ecoff2asm comes from https://github.com/ChrisRx/psxsdk and the dev shell has it,
# or point ECOFF2ASM at it.
#
set -eu

LIBPS=${LIBPS:-sdk/lib/libps.a}
ECOFF2ASM=${ECOFF2ASM:-ecoff2asm}

if ! command -v "$ECOFF2ASM" >/dev/null 2>&1; then
    echo "error: $ECOFF2ASM not found; run inside 'nix develop'" >&2
    exit 1
fi

if [ ! -f "$LIBPS" ]; then
    echo "error: $LIBPS not found" >&2
    exit 1
fi

mkdir -p lib

# symusr.o holds no code at all: zero bytes of .text, .data and .bss, and
# nothing but absolute symbols naming entry points in the resident libps.exe.
# It converts to a list of symbol definitions.
echo "generating lib/*.S"
NEW=$(mktemp -d lib.XXXXXX)
trap 'rm -rf "$NEW"' EXIT
"$ECOFF2ASM" --annotate --output-dir "$NEW" "$LIBPS"

# ecoff2asm writes the entry points as absolute symbols, which only lld can
# relocate a jal against, and this links with GNU ld. So each is respelled as
# an offset into an empty section that yaroze.ld places at 0x80000000, which
# gives the same address from a section relative symbol.
awk '
    /^# [0-9]+ absolute symbols: entry points in the resident library\.$/ {
        sub(/\.$/, ",")
        print
        print "# emitted as offsets from 0x80000000 into an empty .libps section."
        print "# A link script must place .libps at that address, as NOLOAD."
        next
    }
    /^\t\.weak / {
        if (!started) {
            print "\t.section .libps,\"a\",@nobits"
            started = 1
        }
        name = $2
        next
    }
    /^\t\.set / && name != "" {
        offset = substr($3, 5)
        sub(/^0+/, "", offset)
        print "\t.org 0x" offset
        print "\t.weak " name
        print name ":"
        name = ""
        next
    }
    { print }
' "$NEW/symusr.S" > "$NEW/symusr.S.new"
mv "$NEW/symusr.S.new" "$NEW/symusr.S"

rm -f lib/*.S
mv "$NEW"/*.S lib/

echo
echo "generated:"
ls lib/*.S | wc -l | tr -d ' ' | sed 's/$/ assembly files/'
