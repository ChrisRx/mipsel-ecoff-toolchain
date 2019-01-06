
/*****************************************************************
 *
 * Copyright (c) 1996 Sony Computer Entertainment Inc.
 * All Rights Reserved.
 *
 *                                  Ver 1.00
 *
 *****************************************************************/

#ifndef _MALLOC_H
#define _MALLOC_H

#ifndef _SIZE_T
#define _SIZE_T
typedef unsigned int size_t;  /* result type of the sizeof operator (ANSI) */
#endif
#ifndef NULL
#define NULL 0		       /* null pointer constant */
#endif

#if defined(_LANGUAGE_C_PLUS_PLUS)||defined(__cplusplus)||defined(c_plusplus)
extern "C" {
#endif
extern void InitHeap (unsigned long *, unsigned long);
extern void free(void *);
extern void *malloc(size_t);	/**/
extern void *calloc(size_t, size_t); /**/
extern void *realloc(void *, size_t); /**/
#if defined(_LANGUAGE_C_PLUS_PLUS)||defined(__cplusplus)||defined(c_plusplus)
}
#endif

#endif /* _MALLOC_H */
