/*
 *		Copyright (C) 1996 by Sony Computer Entertainment Inc.
 *				All rights Reserved
 *
 *			pad.h: PadRead() accsess macro
 */

#define PADLup     (1<<12)
#define PADLdown   (1<<14)
#define PADLleft   (1<<15)
#define PADLright  (1<<13)
#define PADRup     (1<< 4)
#define PADRdown   (1<< 6)
#define PADRleft   (1<< 7)
#define PADRright  (1<< 5)
#define PADi       (1<< 9)
#define PADj       (1<<10)
#define PADk       (1<< 8)
#define PADl       (1<< 3)
#define PADm       (1<< 1)
#define PADn       (1<< 2)
#define PADo       (1<< 0)
#define PADh       (1<<11)
#define PADL1      PADn
#define PADL2      PADo
#define PADR1      PADl
#define PADR2      PADm
#define PADstart   PADh
#define PADselect  PADk
