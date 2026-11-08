#
# yaroze.mk - build a Net Yaroze program for mipsel-none-elf
#
# Include this from your own Makefile:
#
#     PROG = mygame
#     SRCS = main.c world.c sprites.S
#     include $(YAROZE_PREFIX)/yaroze.mk
#
# and run `make`. The sdk dev shell sets YAROZE_PREFIX for you.
#
# Targets: $(PROG).elf, $(PROG).bin (the flat image) and $(PROG).exe (a
# PSX-EXE an emulator can boot), all under $(BUILD). Default is .exe.
#
# Everything below can be overridden from your Makefile or the command line.
#

# Locate the SDK relative to this file, so an installed tree needs no
# configuration. The expected layout is
#
#     <prefix>/yaroze.mk
#     <prefix>/include     SDK headers
#     <prefix>/lib         libyaroze.a, startup.o, symusr.o
#     <prefix>/ldscripts   yaroze.ld
#
YAROZE_MK_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
YAROZE_PREFIX    ?= $(YAROZE_MK_DIR)
YAROZE_INCLUDE   ?= $(YAROZE_PREFIX)/include
YAROZE_LIB       ?= $(YAROZE_PREFIX)/lib
YAROZE_LDSCRIPTS ?= $(YAROZE_PREFIX)/ldscripts

CROSS   ?= mipsel-none-elf-
CC       = $(CROSS)gcc
OBJCOPY  = $(CROSS)objcopy
SIZE     = $(CROSS)size

BUILD   ?= build
PROG    ?= main
SRCS    ?= main.c

# eco2exe turns the linked ELF into a PSX-EXE and yaroze turns that into a disc
# image. Both come from psxsdk; the dev shell puts them on PATH.
ECO2EXE ?= eco2exe
YAROZE  ?= yaroze

# DISC names a directory whose contents are placed on the disc alongside the
# program, keeping their layout. Leave it absent if the program loads nothing
# from the disc.
DISC      ?= disc
VOLUME_ID ?= $(PROG)

# The PlayStation CPU is an R3000A: MIPS I, little-endian, o32, no FPU.
#
#   -G0           keep everything out of .sdata so no gp-relative addressing is
#                 generated. The resident libps does not share a $gp with you.
#   -mno-abicalls these are not position independent objects, and the default
#                 PIC model emits GOT references that cannot be resolved
#                 against a library that is simply resident at a fixed address.
#   -msoft-float  there is no FPU; float operations become calls to routines
#                 libps already provides.
#
# -march names the ISA and -mtune the scheduling model. mips1 and r3000 are the
# same instruction set; spelling the ISA as mips1 matches what the Nix wrapper
# injects and so avoids a redundant-override warning on every file.
YAROZE_ARCHFLAGS ?= -march=mips1 -mtune=r3000 -mabi=32 -EL -msoft-float -G0 \
                    -mno-abicalls -fno-pic

# The SDK headers are 1996 K&R C. Two language defaults have flipped since:
# an empty parameter list now means "no arguments" rather than "unspecified"
# (libps.h declares its whole API that way), and tentative definitions are no
# longer merged. Both have to be put back.
YAROZE_DIALECT ?= -std=gnu89 -fcommon

YAROZE_CPPFLAGS ?= -I$(YAROZE_INCLUDE) -D_R3000 -Dpsx -Dunix
YAROZE_CFLAGS   ?= $(YAROZE_ARCHFLAGS) $(YAROZE_DIALECT) -O2 -ffreestanding \
                   -fno-builtin -fno-stack-protector \
                   -fno-asynchronous-unwind-tables -fomit-frame-pointer
YAROZE_ASFLAGS  ?= $(YAROZE_ARCHFLAGS)

# -nostdlib keeps any host C library out of the link: the C library here is
# libps, already resident in the console's RAM.
#
# libgcc is linked and is needed. It is the only source of the 64-bit integer
# helpers (__divdi3, __moddi3, __ashldi3) and bit counting helpers (__clzsi2,
# __popcountsi2) that MIPS I has no instruction for, so anything using long
# long will not link without it. It comes last so that symusr.o has already
# defined the soft-float routines libps and libgcc both provide, leaving libgcc
# to supply only what is genuinely missing.
YAROZE_LDFLAGS ?= $(YAROZE_ARCHFLAGS) -nostdlib -nostartfiles \
                  -Wl,--build-id=none -L$(YAROZE_LDSCRIPTS) -T yaroze.ld
YAROZE_LDLIBS  ?= -L$(YAROZE_LIB) -lyaroze -lgcc

# startup.o is the crt0 and symusr.o defines the resident library's entry
# points. Both are linked explicitly: nothing references _start, and the
# resident addresses have to be in place before the archives are scanned.
YAROZE_STARTUP ?= $(YAROZE_LIB)/startup.o $(YAROZE_LIB)/symusr.o

# Your CPPFLAGS, CFLAGS, ASFLAGS, LDFLAGS and LDLIBS are appended to the
# YAROZE_* defaults rather than replacing them, and the rules below reference
# both. Appending with += here would not work: a variable set on the make
# command line overrides every assignment to it in a makefile, so a recursive
# invocation passing CPPFLAGS=-Ifoo would silently drop the SDK include path.
# To replace a default rather than add to it, set the YAROZE_* variable.

# Objects go in a per-program subdirectory so that several programs can share
# one build directory without their main.o colliding. The artifacts stay at
# the top so paths remain short.
OBJDIR = $(BUILD)/$(PROG)
OBJS = $(addprefix $(OBJDIR)/,$(addsuffix .o,$(basename $(notdir $(SRCS)))))

ELF = $(BUILD)/$(PROG).elf
BIN = $(BUILD)/$(PROG).bin
EXE = $(BUILD)/$(PROG).exe

# The disc image keeps its own stem, because $(BIN) above is already the flat
# memory image of the program, which is a different thing entirely.
DISCBIN = $(BUILD)/$(PROG)-disc.bin

.PHONY: yaroze-all yaroze-disc yaroze-clean
.SECONDARY:

yaroze-all: $(EXE)
	@$(SIZE) $(ELF)

# A bootable disc image, which is what a real console loads and what an
# emulator needs if the program reads any of its own files: a bare .exe has
# no filesystem behind it, so every CD call fails by construction.
yaroze-disc: $(DISCBIN)

$(DISCBIN): $(EXE)
	$(YAROZE) iso -o $@ --volume-id $(VOLUME_ID) --boot MAIN.EXE \
	    --file MAIN.EXE=$(EXE) $(wildcard $(DISC))

# Sources may live outside the build directory, so search their directories.
vpath %.c $(sort $(dir $(SRCS)))
vpath %.S $(sort $(dir $(SRCS)))

$(OBJDIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(YAROZE_CFLAGS) $(CFLAGS) $(YAROZE_CPPFLAGS) $(CPPFLAGS) -c -o $@ $<

$(OBJDIR)/%.o: %.S
	@mkdir -p $(dir $@)
	$(CC) $(YAROZE_ASFLAGS) $(ASFLAGS) $(YAROZE_CPPFLAGS) $(CPPFLAGS) -c -o $@ $<

$(ELF): $(OBJS) $(YAROZE_STARTUP) $(YAROZE_LIB)/libyaroze.a \
        $(YAROZE_LDSCRIPTS)/yaroze.ld
	@mkdir -p $(dir $@)
	$(CC) $(YAROZE_LDFLAGS) $(LDFLAGS) -Wl,-Map,$(ELF:.elf=.map) -o $@ \
	    $(YAROZE_STARTUP) $(OBJS) $(YAROZE_LDLIBS) $(LDLIBS)

# The flat image is what a Net Yaroze program is once loaded: the console takes
# bytes and a start address, with no container around them.
$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

# A Net Yaroze program is not bootable on its own, because the library it calls
# into is normally left in RAM by the boot disc. eco2exe combines the two.
$(EXE): $(ELF)
	$(ECO2EXE) $< $@

yaroze-clean:
	rm -rf $(BUILD)
