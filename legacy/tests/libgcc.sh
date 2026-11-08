#!/bin/sh
#
# Prints a hash of the code in each member of a libgcc.a, leaving out debug
# information, which holds the paths of the build.
#
# Usage: libgcc.sh <objdump> <ar> <libgcc.a>
set -eu
export LC_ALL=C
objdump=$1 ar=$2 lib=$3
"$ar" x "$lib"
for member in *.o; do
    printf '%s ' "$member"
    "$objdump" -s -r --section=.text --section=.data --section=.rdata --section=.sdata "$member" \
        | sed 1,2d | sha256sum | cut -d' ' -f1
done | sort
