#
# A Net Yaroze program.
#
# YAROZE_PREFIX is set for you inside the SDK dev shell.
#
PROG = hello
SRCS = main.c

include $(YAROZE_PREFIX)/yaroze.mk

# `make` builds build/$(PROG).exe, which any PlayStation emulator can boot.
#
# Other targets: build/$(PROG).elf and build/$(PROG).bin, the flat image that
# would be sent to a real console over the serial link.
#
# Flags are appended to the defaults, so you can add to them here:
#
#     CPPFLAGS += -Iinclude
#     CFLAGS   += -Wall
#
