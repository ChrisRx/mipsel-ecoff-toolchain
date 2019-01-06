/*
 *		Copyright (C) 1996 by Sony Computer Entertainment Inc.
 *				All rights Reserved
 *
 *			main.c: sjis code viewer
 */

#include <libps.h>
#include "pad.h"

/* Now testing... */
/*
#define DEBUG					/* debugging now */

/* kanji defines */
#define MINSCODE	0x8140			/* min sjis code */
#define MAXSCODE	0x9870			/* max sjis code */
#define KFONT		15			/* kanji font size(11/13/15) */
#define KW		16			/* number of kanji(x) */
#define KH		13			/* number of kanji(y) */
#define KNUM		KW*KH			/* number of kanji(total) */
#define VW		16			/* kanji font size(yoko) */
#define VH		KFONT			/* kanji font size(tate) */
#define STARTX		16			/* KanjiPrint start address x */
#define STARTY		8			/* KanjiPrint start address y */
#define WX		64+STARTX		/* wall address x */
#define WY		16+STARTY		/* wall address y */
#define WW		KW*VW			/* wall width */
#define WH		KH*VW			/* wall height */
#define BUFSIZE		16*(KFONT+1)		/* buffer size */
#define COLOR		0x7fff			/* kanji texture fg */
#define BLACK		0x3000			/* kanji texture bg */
#define STEPMAX		30			/* padread speed up count */

/* defines */
#define OT_LENGTH	1			/* ordering table size */

/* variables */
GsOT		WorldOT[2];			/* ordering table */
GsOT_TAG	OTTags[2][1<<OT_LENGTH];	/* tag */

PACKET		GpuPacketArea[2][20];		/* GPU packet area */
GsSPRITE	sprt;				/* wall primitive */

u_short	cur_scode = MINSCODE;			/* current sjis code */
u_short cur_fg = COLOR;				/* current fg */
u_short cur_bg = BLACK;				/* current bg */

volatile u_char *bb0, *bb1;			/* for pad_read */

u_long	kimg[32*16*((KNUM-1)/16+1)+16];		/* tim image buffer */


/* prototype */
static void initTexture(u_short scode);	/* initialize kanji texture */
static int pad_read(void);			/* pad read routine */
static void init_prim(void);			/* initialize primitives */
static u_long PadRead(long id);			/* read pad status */

/*
 * main routine
 */
main()
{
	int	activeBuff;
	int	i;

	SetVideoMode(MODE_NTSC);        /* NTSC_MODE */
/*	SetVideoMode(MODE_PAL);         /* PAL_MODE  */

	GetPadBuf(&bb0, &bb1);

	if (GetVideoMode() == MODE_PAL) {
		GsInitGraph(368, 256, 4, 0, 0);
		GsDefDispBuff(0, 0, 0, 256);
		GsDISPENV.screen.y = 16;
		GsDISPENV.screen.h = 256;
	}
	else {
		GsInitGraph(368, 240, 4, 0, 0);
		GsDefDispBuff(0, 0, 0, 240);
	}

	for (i = 0; i < 2; i++) {
		WorldOT[i].length = OT_LENGTH;
		WorldOT[i].org = OTTags[i];
	}

	/* initialize texture */
	initTexture(cur_scode);

	/* initialize primitives */
	init_prim();

	/* initialize Kanji Font */
	KanjiFntOpen(STARTX, STARTY, 360, 240, 960, 0, 960, 256, 0, 256);

	while (pad_read() == 0) {
		/* get current buffer */
		activeBuff = GsGetActiveBuff();
		GsSetWorkBase((PACKET *)GpuPacketArea[activeBuff]);

		GsClearOt(0, 0, &WorldOT[activeBuff]);

		GsSortFastSprite(&sprt, &WorldOT[activeBuff], 0);

		/* swap buffer */
		DrawSync(0);		/* wait for end of drawing */
		VSync(0);		/* wait for the next V-BLNK */
		GsSwapDispBuff();	/* swap double buffer */

		/* clear bg */
		GsSortClear(60, 120, 120, &WorldOT[activeBuff]);

		/* draw */
		GsDrawOt(&WorldOT[activeBuff]);

		KanjiFntPrint("    0123456789ABCDEF\n");
		for (i = 0; i < KH; i++)
			KanjiFntPrint("%04x\n", cur_scode+i*KW);
		KanjiFntFlush(-1);
	}
	VSync(0);
	KanjiFntClose();
	return(0);
}

/*
 * pad read routine
 */
static int pad_read(void)
{
	static u_long	oldpadd = 0;
	static u_long	step_cnt = 0;

	int	ret = 0;	
	int	step = KW;
	int	stepc = 1;
	u_long	padd = PadRead(1);
	
	if (padd == oldpadd) {
		if (++step_cnt > STEPMAX) {
			if (step_cnt > STEPMAX*2) {
				step = KW*4;
				stepc = 4;
			} else {
				step = KW*2;
				stepc = 2;
			}
		}		
	} else {
		step_cnt = 0;
	}

	if (padd & PADLup) {
		cur_scode += step;

		if (cur_scode > MAXSCODE)
			cur_scode = MAXSCODE;
		initTexture(cur_scode);		
	}
	if (padd & PADLdown) {
		cur_scode -= step;

		if (cur_scode < MINSCODE)
			cur_scode = MINSCODE;
		initTexture(cur_scode);		
	}
	if (padd & PADL1) {
		cur_fg = (cur_fg+stepc)&0x7fff;
		initTexture(cur_scode);		
	}
	if (padd & PADL2) {
		cur_fg = (cur_fg-stepc)&0x7fff;
		initTexture(cur_scode);		
	}
	if (padd & PADR1) {
		cur_bg = (cur_bg+stepc)&0x7fff;
		initTexture(cur_scode);		
	}
	if (padd & PADR2) {
		cur_bg = (cur_bg-stepc)&0x7fff;
		initTexture(cur_scode);		
	}
	if (padd & PADselect) 	ret = -1;

	oldpadd = padd;

	return(ret);
}		

/*
 * initialize primitives
 */
static void init_prim(void)
{
	GsSPRITE	*sp;

	/* initialize wall */
	sp = &sprt;
	sp->attribute = 0 << 24;
	sp->x = WX;
	sp->y = WY;
	sp->w = WW;
	sp->h = WH;
	sp->tpage = GetTPage(0, 0, 640, 0);
	sp->u = 0;
	sp->v = 0;
	sp->cx = 640;
	sp->cy = 480;
	sp->r = sp->g = sp->b = 0x80;
	sp->mx = 0;
	sp->my = 0;
	sp->scalex = ONE;
	sp->scaley = ONE;
	sp->rotate = 0;
}

/*
 * initialize kanji data texture
 */
static void initTexture(u_short scode)
{
	GsIMAGE	tim;
	u_short	kbuf[KNUM+1];
	u_short ktmp;
	RECT	rect;
	int	i;

	DrawSync(0);

	for (i = 0; i < KNUM; i++) {
		ktmp = scode + i;

		/* swap upper 8bits and lower 8bits */
		kbuf[i] = ((ktmp & 0xff) << 8) | (ktmp >> 8);
	}
	kbuf[i] = 0;
	Krom2Tim2((u_char *)kbuf, (u_long *)kimg, 640, 0, 640, 480, 
		cur_fg, cur_bg);

	GsGetTimInfo((u_long *)(kimg+1), &tim);

	rect.x = tim.px; rect.y = tim.py;
	rect.w = tim.pw; rect.h = tim.ph;
	LoadImage(&rect, tim.pixel);

	rect.x = tim.cx; rect.y = tim.cy;
	rect.w = tim.cw; rect.h = tim.ch;
	LoadImage(&rect, tim.clut);
}

static u_long PadRead(long id)
{
	return(~(*(bb0+3) | *(bb0+2) << 8 | *(bb1+3) << 16 | *(bb1+2) << 24));
}
