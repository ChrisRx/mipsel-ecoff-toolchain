
/*****************************************************************
 *
 * Copyright (c) 1996 Sony Computer Entertainment Inc.
 * All Rights Reserved.
 *
 *                                  Ver 1.00
 *
 *****************************************************************/

#ifndef _RAND_H
#define _RAND_H

#define RAND_MAX	32767

#if defined(_LANGUAGE_C_PLUS_PLUS)||defined(__cplusplus)||defined(c_plusplus)
extern "C" {
#endif
extern int  rand(void);
extern void srand(unsigned int);
#if defined(_LANGUAGE_C_PLUS_PLUS)||defined(__cplusplus)||defined(c_plusplus)
}
#endif

#endif /* _RAND_H */
