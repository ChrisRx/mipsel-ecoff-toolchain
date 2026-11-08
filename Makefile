#
# Builds the Net Yaroze runtime library and samples for mipsel-none-elf using
# a current GCC, instead of the mipsel-ecoff GCC 2.95.3 the SDK shipped for.
#
# The machine code is the same either way: the R3000A is the R3000A. Only the
# object and executable container changes, and nothing downstream cares, since
# eco2exe only ever needed a flat image and an entry point.
#

CROSS     ?= mipsel-none-elf-
CC         = $(CROSS)gcc
AR         = $(CROSS)ar

SDK        = sdk
BUILD      = build
LDSCRIPTS  = ldscripts

# The PlayStation CPU is an R3000A: MIPS I, little-endian, o32, no FPU.
#
#   -G0           keep everything out of .sdata so no gp-relative addressing
#                 is generated. The resident libps was not built to share a
#                 $gp with the program.
#   -mno-abicalls these are not position independent objects, and the default
#                 PIC model would emit GOT references that cannot be resolved
#                 against a library that is simply resident at a fixed address.
#   -msoft-float  there is no FPU; float operations become calls to routines
#                 that libps itself provides.
#
# -march names the ISA and -mtune the scheduling model. Spelling the ISA as
# mips1 rather than r3000 matters only in that it matches what the Nix wrapper
# injects, which keeps the assembler from warning about a redundant override on
# every file; the two are the same instruction set.
ARCHFLAGS  = -march=mips1 -mtune=r3000 -mabi=32 -EL -msoft-float -G0 \
             -mno-abicalls -fno-pic

# include/ replaces the SDK headers a current compiler cannot read, so it has
# to come first.
CPPFLAGS   = -Iinclude -I$(SDK)/include -D_R3000 -Dpsx -Dunix

# The SDK headers and samples are 1996 K&R C and will not compile as anything
# newer. Two defaults have flipped since:
#
#   -std=gnu89  an empty parameter list means "unspecified arguments", not
#               "no arguments". libps.h declares its entire API that way
#               (extern int KanjiFntPrint();), so under the current default of
#               C23 every call with arguments is an error.
#   -fcommon    tentative definitions are merged rather than treated as
#               conflicting definitions, which is what this vintage of code
#               expects of globals declared in headers.
#
DIALECT    = -std=gnu89 -fcommon
CFLAGS     = $(ARCHFLAGS) $(DIALECT) -O2 -ffreestanding -fno-builtin \
             -fno-stack-protector -fno-asynchronous-unwind-tables \
             -fomit-frame-pointer
ASFLAGS    = $(ARCHFLAGS)

# -nostdlib keeps newlib out of the link: the C library here is whatever libps
# provides.
#
# libgcc is linked, and is needed. It is the only source of the 64-bit integer
# helpers (__divdi3, __moddi3, __ashldi3 and friends) and the bit counting
# helpers (__clzsi2, __popcountsi2) that MIPS I has no instructions for, so any
# program using long long fails to link without it. The SDK expected this too:
# "Net Yaroze For Linux" notes that LDFLAGS needs -msoft-float "so the program
# will get linked against the right version of libgcc.a".
#
# It comes last so that symusr.o has already defined the 30 soft-float routines
# libps and libgcc both provide, leaving libgcc to supply only what is actually
# missing.
LDFLAGS    = $(ARCHFLAGS) -nostdlib -nostartfiles -Wl,--build-id=none \
             -L$(LDSCRIPTS) -T yaroze.ld
LDLIBS     = -L$(BUILD) -lyaroze -lgcc

# startup.S is the crt0 and is linked explicitly rather than pulled from the
# archive, because nothing in the program references _start.
CRT0       = $(BUILD)/startup.o

# symusr.S defines the resident library's entry points, as offsets into the
# .libps section that yaroze.ld places at 0x80000000. It is linked explicitly,
# ahead of the archives, so those definitions are already in place when the
# linker scans them; otherwise libgcc would satisfy references such as
# __extendsfdf2 with its own copy of a routine that is already in RAM.
LIBPSSYMS  = $(BUILD)/symusr.o

STARTOBJS  = $(CRT0) $(LIBPSSYMS)

# Everything else from libps.a that is real code rather than an address.
LIBSRCS    = $(filter-out lib/startup.S lib/symusr.S,$(wildcard lib/*.S))
LIBOBJS    = $(patsubst lib/%.S,$(BUILD)/%.o,$(LIBSRCS))

# compat/ holds what the SDK declares and libps does not provide. They are
# archive members, so a program only picks up the ones it actually refers to.
COMPATSRCS = $(wildcard compat/*.c)
LIBOBJS   += $(patsubst compat/%.c,$(BUILD)/compat-%.o,$(COMPATSRCS))
COMPATASM  = $(wildcard compat/*.S)
LIBOBJS   += $(patsubst compat/%.S,$(BUILD)/compat-%.o,$(COMPATASM))
LIBYAROZE  = $(BUILD)/libyaroze.a

# Each name here is a directory under $(SDK)/sample containing a main.c.
#
# check does not run from a bare PSX-EXE. It calls datafile_search() and
# datafile_read() for \DATA\SOUND\*.{VH,VB,SEQ} before it ever reaches
# GsInitGraph(), and with no disc present datafile_read() spins in
# "while ((cnt = CdReadSync(1, 0)) > 0)" forever, so nothing is ever drawn. It
# wants the Net Yaroze boot disc, or those files in a disc image.
SAMPLES    = sjiscode check
SAMPLE_EXE = $(patsubst %,$(BUILD)/%.exe,$(SAMPLES))

# eco2exe combines a program with the resident library and wraps the result as
# a PSX-EXE, which is the only form an emulator will boot. It comes from psxsdk;
# the dev shell puts it on PATH.
ECO2EXE   ?= eco2exe

.PHONY: all lib samples install clean generate verify
.SECONDARY:

all: lib samples

lib: $(LIBYAROZE) $(STARTOBJS)

samples: $(SAMPLE_EXE)

# Samples are built through yaroze.mk, the same file a user includes from
# their own Makefile. Building them any other way would leave the path that
# actually matters untested.
YAROZE_MK_ARGS = YAROZE_CPPFLAGS="-I$(abspath include) -I$(abspath $(SDK)/include) -D_R3000 -Dpsx -Dunix" \
                 YAROZE_LIB=$(abspath $(BUILD)) \
                 YAROZE_LDSCRIPTS=$(abspath $(LDSCRIPTS)) \
                 ECO2EXE=$(ECO2EXE) \
                 BUILD=$(abspath $(BUILD))

$(SAMPLE_EXE): $(BUILD)/%.exe: lib $(LDSCRIPTS)/yaroze.ld
	$(MAKE) --no-print-directory -f yaroze.mk yaroze-all \
	    PROG=$* SRCS=$(abspath $(SDK)/sample/$*/main.c) \
	    CPPFLAGS=-I$(abspath $(SDK)/sample/$*) $(YAROZE_MK_ARGS)

$(LIBYAROZE): $(LIBOBJS)
	@mkdir -p $(dir $@)
	$(AR) rcs $@ $^

$(BUILD)/%.o: lib/%.S
	@mkdir -p $(dir $@)
	$(CC) $(ASFLAGS) $(CPPFLAGS) -c -o $@ $<

$(BUILD)/compat-%.o: compat/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

$(BUILD)/compat-%.o: compat/%.S
	@mkdir -p $(dir $@)
	$(CC) $(ASFLAGS) $(CPPFLAGS) -c -o $@ $<

# Lays the SDK out the way yaroze.mk expects to find it, so a program built
# anywhere on the system can include <prefix>/yaroze.mk and need no further
# configuration.
PREFIX ?= /usr/local/yaroze

install: lib
	@mkdir -p $(DESTDIR)$(PREFIX)/include $(DESTDIR)$(PREFIX)/lib \
	          $(DESTDIR)$(PREFIX)/ldscripts
	cp -R $(SDK)/include/. $(DESTDIR)$(PREFIX)/include/
	cp -R include/. $(DESTDIR)$(PREFIX)/include/
	cp $(LIBYAROZE) $(STARTOBJS) $(DESTDIR)$(PREFIX)/lib/
	cp $(LDSCRIPTS)/yaroze.ld $(DESTDIR)$(PREFIX)/ldscripts/
	cp yaroze.mk $(DESTDIR)$(PREFIX)/
	@echo
	@echo "installed to $(DESTDIR)$(PREFIX)"
	@echo "build your own program with:  include $(PREFIX)/yaroze.mk"

generate:
	./scripts/generate.sh

verify:
	./scripts/verify.sh

clean:
	rm -rf $(BUILD)
