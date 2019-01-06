
/*****************************************************************
 *
 * Copyright (c) 1996 Sony Computer Entertainment Inc.
 * All Rights Reserved.
 *
 *                                  Ver 1.00
 *
 *****************************************************************/

#ifndef _CONVERT_H
#define _CONVERT_H

#if defined(_LANGUAGE_C_PLUS_PLUS)||defined(__cplusplus)||defined(c_plusplus)
extern "C" {
#endif
extern int atoi(char *);
extern long atol(char *);
extern long strtol(char *,char**, int);
extern unsigned long strtoul(char *, char **, int);
extern long labs(long);

#if defined(_LANGUAGE_C_PLUS_PLUS)||defined(__cplusplus)||defined(c_plusplus)
}
#endif

#endif
