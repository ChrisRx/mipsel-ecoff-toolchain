/*
 * stdarg.h - variable arguments for a current compiler
 *
 * This is found ahead of the SDK's own, which cannot compile under GCC 16: its
 * va_arg assigns to a cast, an extension long since removed, and its va_end
 * uses NULL without including anything that defines it. It also walks the
 * stack from the address of the last named parameter, which an optimizer does
 * not promise to keep there. The compiler's builtins know where they went.
 */

#ifndef _STDARG_H
#define _STDARG_H

typedef __builtin_va_list va_list;

#define va_start(ap, last) __builtin_va_start(ap, last)
#define va_arg(ap, type)   __builtin_va_arg(ap, type)
#define va_end(ap)         __builtin_va_end(ap)

#endif /* _STDARG_H */
