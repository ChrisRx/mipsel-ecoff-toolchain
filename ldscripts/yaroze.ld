/*
 * yaroze.ld - link script for Net Yaroze programs built as mipsel-none-elf
 *
 * The Net Yaroze boot disk (DTL-S3035) leaves libps.exe resident in RAM and
 * runs a serial loader. A Net Yaroze program is therefore not self-contained:
 * it is linked against fixed addresses inside that resident library. lib/symusr.S
 * defines those addresses, generated directly from the absolute symbols in the
 * SDK's libps.a so they cannot drift from the original.
 *
 * RAM map:
 *
 *   0x80000000  kernel
 *   0x80010000  resident libps.exe
 *   0x80140000  user program (default; override with -Wl,--defsym,__load=...)
 *   0x801fff00  initial stack pointer, growing down
 *   0x80200000  end of 2MB RAM
 */

ENTRY(_start)

/* Load address of the program. 0x80140000 is where SIOCONS and eco2exe both
 * expect a Net Yaroze executable to live. */
__load = DEFINED(__load) ? __load : 0x80140000;

/* Where the stack starts and how much of it is reserved. These match what
 * eco2exe records in the PSX-EXE header and what stdef2.o gives startup.s as
 * _sys_init_stacksize, so the heap computed from them agrees with the one
 * startup.s hands to InitHeap. */
__stack_top = DEFINED(__stack_top) ? __stack_top : 0x801fff00;
__stack_size = DEFINED(__stack_size) ? __stack_size : 0x10000;

SECTIONS
{
  /* lib/symusr.S defines every libps entry point as an offset into .libps, so
   * placing the section here is what gives those symbols their real addresses.
   * The code is already in RAM, so nothing is loaded.
   *
   * NOLOAD rather than INFO, since an INFO section is PROGBITS and would put
   * 420KB of nothing in the ELF. The window does count as allocated memory, so
   * size(1) reports the span of the resident library as part of the program,
   * and a second PT_LOAD covers it with a file size of zero, which is what
   * eco2exe and sioload select on, so neither writes anything there.
   *
   * It has to be an object defining these rather than assignments in this
   * script. A script assignment is applied only after the linker has scanned
   * the input archives, so a reference to a routine libps shares with libgcc,
   * __extendsfdf2 for instance, would pull libgcc's copy into the image before
   * the resident address was ever considered. Defining them in an object that
   * is linked first means no such member is extracted at all, which is how the
   * SDK's own symusr.o behaved as a member of libps.a.
   */
  .libps 0x80000000 (NOLOAD) : { *(.libps) }

  . = __load;

  .text : ALIGN(4)
  {
    /* startup.o is first on the link line, so its _start lands at the base
     * of the image. Note that *(.text.*) has to stay below *(.text): at -O2
     * GCC puts main in .text.startup, and matching that first would place
     * main ahead of the real entry point. */
    *(.text)
    *(.text.*)
    *(.init)
    *(.fini)
  }

  .rodata : ALIGN(4)
  {
    *(.rodata)
    *(.rodata.*)
    *(.rdata)
    *(.rdata.*)
  }

  . = ALIGN(4);
  _fdata = .;

  .data : ALIGN(4)
  {
    *(.data)
    *(.data.*)
  }

  /* $gp is only meaningful when building with a non-zero -G, which puts
   * small objects in .sdata and addresses them gp-relative. The library is
   * built with -G0 so .sdata stays empty, but startup.s still loads $gp from
   * _sys_init_gp and the symbol has to resolve. */
  . = ALIGN(16);
  _gp = . + 0x7ff0;
  PROVIDE(__gp = _gp);

  .sdata : ALIGN(4)
  {
    *(.sdata)
    *(.sdata.*)
  }

  . = ALIGN(4);

  /* startup.s zeroes memory from _fbss up to _end. Both must be word
   * aligned, and the loop is a do-while, so it always writes at least the
   * word at _fbss. */
  _fbss = .;
  PROVIDE(__bss_start = _fbss);

  .sbss : ALIGN(4)
  {
    *(.sbss)
    *(.sbss.*)
    *(.scommon)
  }

  .bss : ALIGN(4)
  {
    *(.bss)
    *(.bss.*)
    *(COMMON)
  }

  . = ALIGN(4);
  _end = .;
  PROVIDE(end = _end);
  PROVIDE(__bss_end = _end);

  /* The heap runs from _end up to the stack, less the reserved stack size.
   * startup.s computes the size itself from _sys_init_stacksize. */

  /* Sections a modern toolchain emits that have no meaning here, and which
   * would otherwise be copied into the flat image handed to the console. */
  /DISCARD/ :
  {
    *(.reginfo)
    *(.MIPS.abiflags)
    *(.MIPS.options)
    *(.gnu.attributes)
    *(.pdr)
    *(.comment)
    *(.note)
    *(.note.*)
    *(.eh_frame)
    *(.eh_frame_hdr)
    *(.gcc_except_table)
    *(.gcc_except_table.*)
    *(.mdebug.*)
    *(.gnu.lto_*)
  }
}
