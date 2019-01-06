/*	
 *	Draw bouncing ball pattern on screen
 *	Increase/decrease ball pattern number by up/down key
 *	Read sound data from boot disk and play back as BGM
 *
 *	Copyright (C) 1996 Sony Computer Entertainment Inc.
 *	All Rights Reserved
*/

/*Preparation include header */
#include <libps.h>
#include "pad.h"

/*----------------------------------------------------------------------
	Macros
----------------------------------------------------------------------*/
/* Basic setup */
#define KANJI				/*  Switch to display Kanji*/
#define OT_LENGTH	1		/*  Ordering table number*/
#define MAXOBJ		1500		/*  Sprites (balls) maximum number*/
#define MVOL		127		/*  Main volume level*/
#define SVOL		127		/*  SEQ volume level*/
#define DFILE		3		/*  File number*/

/*  Macros relating to data arrangement */
#define VH_ADDR		0x80090000
#define VB_ADDR		0x800a0000
#define SEQ_ADDR	0x80110000

/*  Macros relating to display area */
#define FRAME_X		320	/* Display area size(horizontal) */
#define FRAME_Y		240	/* Display area size(vertical)*/
#define WALL_X		(FRAME_X-16)	/* Ball pattern movement area size 							(horizontal) */
#define WALL_Y		(FRAME_Y-16)	/* Ball pattern movement area size 							(vertical) */

/*  Range check macro */
#define limitRange(x, l, h)	((x)=((x)<(l)?(l):(x)>(h)?(h):(x)))

/*----------------------------------------------------------------------
	External variables
----------------------------------------------------------------------*/
/*  Ordering table related variables */
GsOT		WorldOT[2];
GsOT_TAG	OTTags[2][1<<OT_LENGTH];

/*  Primitive related variables */
PACKET	GpuPacketArea[2][MAXOBJ*(20+4)];
GsSPRITE	sprt[MAXOBJ];

/*  Ball pattern movement related variables */
typedef struct {
	u_short x, y;			/* Location */
	u_short dx, dy;		/* Speed */
} POS;

/*  Controller related variables */
volatile u_char *bb0, *bb1;

/*  File reading related variables */
typedef struct {
	char		*fname;
	void		*addr;
	CdlFILE	finfo;
} FILE_INFO;

static FILE_INFO dfile[DFILE] = {
	{"\\DATA\\SOUND\\STD0.VH;1", (void *)VH_ADDR, 0},
	{"\\DATA\\SOUND\\STD0.VB;1", (void *)VB_ADDR, 0},
	{"\\DATA\\SOUND\\SAMPLE1.SEQ;1", (void *)SEQ_ADDR, 0},
};

/* Sound related variables */
short vab, seq;

/*----------------------------------------------------------------------
	Static functions template
----------------------------------------------------------------------*/
static void init_prim();		/* Ball pattern graphics related 							initialisation */
static void init_point(POS *pos);	/* Ball pattern movement related 							initialisation */
static long pad_read(long n);		/* Controller state analysis */
static u_long PadRead(long id);	/* Controller state reading */
static void datafile_search();	/* File retrieval on CD-ROM */
static void datafile_read();		/* File reading on CD-ROM */
static void init_sound();		/* Sound data on memory playback 							preparation */
static void play_sound();		/*  Sound playback start */
static void stop_sound();		/*  Sound playback termination */

/*----------------------------------------------------------------------
	Main functions
----------------------------------------------------------------------*/
main()
{
	int	nobj = 1;		/* Number of ball patterns displayed
								 (from 1)*/
	GsOT	*ot;			/* Pointer to drawing OT */
	int	i, cnt, x, y;		/* Working variables*/
	int	activeBuff;
	GsSPRITE	*sp;
	POS	pos[MAXOBJ];
	POS	*pp;

	SetVideoMode( MODE_NTSC );	/* NTSC Mode */
/*	SetVideoMode( MODE_PAL );	/* PAL Mode */

	GetPadBuf(&bb0, &bb1);		/* Get controller reception buffer */
	datafile_search();		/* Data file retrieval */
	datafile_read();		/* Data file reading */

	GsInitGraph(320, 240, 4, 0, 0);	/* Drawing and display 
environment setting */
	GsDefDispBuff(0, 0, 0, 240);		/* Same as above */
	/* 
	When drawing in (0,0)-(320,240), display (0,240)-(320,480)(db[0])
	When drawing in (0,240)-(320,480), display (0,  0)-(320,240)(db[0])
	*/

	/* Ordering table information setting */
	for (i = 0; i < 2; i++) {
		WorldOT[i].length = OT_LENGTH;
		WorldOT[i].org = OTTags[i];
	}
	/* Font setting */
#ifdef KANJI    		/* In the case of Kanji display */
	KanjiFntOpen(160, 16, 256, 240, 704, 0, 768, 256, 0, 512);
#endif
	FntLoad(960, 256);	
/* Load basic font pattern in frame buffer */
	FntOpen(16, 16, 256, 200, 0, 512);	
/* Font display location setting */

	init_prim();		/* Primitive buffer initial setting */
	init_point(pos);	/* Ball pattern movement initial setting */
	init_sound();		/* Sound initial setting */
	play_sound();		/* Sound playback start */

	/* Main loop */
	while ((nobj = pad_read(nobj)) > 0) {
		/* Double buffer switch */
		activeBuff = GsGetActiveBuff();
		GsSetWorkBase((PACKET *)GpuPacketArea[activeBuff]);

		/* Ordering table clear */
		GsClearOt(0, 0, &WorldOT[activeBuff]);

		/* Ball pattern location update and registration to OT */
		sp = sprt;	pp = pos;
		for (i = 0; i < nobj; i++, sp++, pp++) {
			/* Horizontal coordinate value update */
			if ((x = (pp->x += pp->dx) % WALL_X*2) >= WALL_X)
				x = WALL_X*2 - x;
			/* Vertical coordinate value update */
			if ((y = (pp->y += pp->dy) % WALL_Y*2) >= WALL_Y)
				y = WALL_Y*2 - y;

			/* Set new coordinate value for sprite primitive */
			sp->x = x;	sp->y = y;
			/* Registration to sprite primitive ordering table */
			GsSortFastSprite(sp, &WorldOT[activeBuff], 0);
		}

		DrawSync(0);		/* Waiting for end of drawing */
		cnt = VSync(0);	/* Waiting for vertical synchronisation 						interrupt */
		GsSwapDispBuff();	/* Double buffer switching */

		/* Registration to screen clear primitive ordering table */
		GsSortClear(60, 120, 120, &WorldOT[activeBuff]);

		/* Drawing of primitive registered in OT */
		GsDrawOt(&WorldOT[activeBuff]);

		/* Printing number of balls and elapsed time */
#ifdef KANJI
		KanjiFntPrint("Num  =%d\n", nobj);
		KanjiFntPrint("Time =%d\n", cnt);
		KanjiFntFlush(-1);
#endif
		FntPrint("sprite = %d\n", nobj);
		FntPrint("total time = %d\n\n\n", cnt);
		FntPrint("UP    : INCREASE\n");
		FntPrint("DOWN  : DECREASE\n");
		FntPrint("L1    : PAUSE\n");
		FntPrint("SELECT: END\n");
		FntFlush(-1);
	}	/* Main loop terminal */

	/* Execute this by pressing select button and verifying */
	stop_sound();		/* Sound playback termination */
	return(0);			/* Program termination */
}


/*----------------------------------------------------------------------
	Ball pattern initialisation
----------------------------------------------------------------------*/
#include "balltex.h"		/* Ball pattern texture pattern */

/* Ball pattern graphics related initialisation */
static void init_prim()
{
	GsSPRITE	*sp;
	u_short	tpage;
	RECT		rect;
	int		i;

	rect.x = 640;	rect.y = 0;
	rect.w = 16/4;	rect.h = 16;
	LoadImage(&rect, ball16x16);
	tpage = GetTPage(0, 0, 640, 0);

	for (i = 0; i < 32; i++) {
		rect.x = 0;	rect.y = 480+i;
		rect.w = 256;	rect.h = 1;
		LoadImage(&rect, ballcolor[i]);
	}

	/* Sprite initialisation */
	for (sp = sprt, i = 0; i < MAXOBJ; i++, sp++) {
		sp->attribute = 0;
		sp->x = 0;
		sp->y = 0;
		sp->w = 16;

		sp->h = 16;
		sp->tpage = tpage;
		sp->u = 0;
		sp->v = 0;
		sp->cx = 0;
		sp->cy = 480+(i%32);
		sp->r = sp->g = sp->b = 0x80;
		sp->mx = 0;
		sp->my = 0;
		sp->scalex = ONE;
		sp->scaley = ONE;
		sp->rotate = 0;
	}
}

/* Ball pattern movement related initialisation */
static void init_point(POS *pos)
{
	int	i;
	for (i = 0; i < MAXOBJ; i++) {
		pos->x  = rand();	
/* Start coordinate X  */
		pos->y  = rand();			
/* Start coordinate Y  */
		pos->dx = (rand() % 4) + 1;	
/* Movement distance X 1<=x<=4) */
		pos->dy = (rand() % 4) + 1;	
/* Movement distance Y 1<=y<=4) */
		pos++;
	}
}

/*----------------------------------------------------------------------
	Reading and analysis of controller state
----------------------------------------------------------------------*/
/* Analysis of controller state */
/*	Return value
	-1 : At time of pressing select button and verifying
	1st argument + 4 : At time of pressing up button and verifying
	1st argument - 4 : At time of pressing down button and verifying
	Pause in function while pressing L1 key */
static long pad_read(long n)
{
	u_long padd = PadRead(1);		/* Controller reading */

	if (padd & PADLup)	n += 4;	/* Left cross key up */
	if (padd & PADLdown)	n -= 4;	/* Left cross key down */

	if (padd & PADL1)
		while (PadRead(1)&PADL1);	/* Pause */

	if(padd & PADselect)
		return(-1);			/* Program termination */
	limitRange(n, 1, MAXOBJ-1);	/* n is given value 1<=n<=(MAXOBJ-1) */
	return(n);
}

/* Controller state reading */
static u_long PadRead(long id)
{
	return(~(*(bb0+3) | *(bb0+2) << 8 | *(bb1+3) << 16 | *(bb1+2) << 24));
}

/*----------------------------------------------------------------------
	Reading the file on CD-ROM (DFILE)
----------------------------------------------------------------------*/
/* Retrieving file on CD-ROM */
static void datafile_search()
{
	int i, j;

	for (i = 0; i < DFILE; i++) {		/* Deal with DFILE file */
		for (j = 0; j < 10; j++) {	/* Return loop */
			if (CdSearchFile(&(dfile[i].finfo), dfile[i].fname) != 0)
				break;		
/* Retry loop interruption on normal termination */
			else
				printf("%s not found.\n", dfile[i].fname);
		}
	}
}

/* CD-ROM file reading */
static void datafile_read()
{
	int i, j;
	int cnt;

	for (i = 0; i < DFILE; i++) {		/* Deal with DFILE file */
		for (j = 0; j < 10; j++) {	/* Retry loop */
			CdReadFile(dfile[i].fname,
					dfile[i].addr,dfile[i].finfo.size);

/* Normal processing can be executed by other side of read */
/* Here, remaining sector number is monitored until Read terminated */

			while ((cnt = CdReadSync(1, 0)) > 0 )
				VSync(0);		/* Waiting for vertical
							synchronisation 
							interrupt (for time
								adjustment */

			if (cnt == 0)
				break;	/* Retry loop interruption on normal
 								termination*/
		}
	}
}


/*----------------------------------------------------------------------
 Sound related
----------------------------------------------------------------------*/
/* Sound data on memory playback preparation */
static void init_sound()
{
	/* VAB opening and transmission to sound buffer */
	vab = SsVabTransfer( (u_char*)VH_ADDR, (u_char*)VB_ADDR, -1, 1 );
	if (vab < 0) {
		printf("SsVabTransfer failed (%d)\n", vab);
		return;
	}

	/* SEQ opening */
	seq = SsSeqOpen((u_long *)SEQ_ADDR, vab);
	if (seq < 0)
		printf("SsSeqOpen failed (%d)\n", seq);
}

/* Sound playback start */
static void play_sound()
{
	SsSetMVol(MVOL, MVOL);			/* Main volume setting*/
	SsSeqSetVol(seq, SVOL, SVOL);		/* Volume setting for each SEQ */
	SsSeqPlay(seq, SSPLAY_PLAY, SSPLAY_INFINITY);/* Playback switch ON */
}

/* Sound playback termination */
static void stop_sound()
{
	SsSeqStop(seq);			/* Playback switch OFF */
	VSync(0);
	VSync(0);
	SsSeqClose(seq);			/* SEQ close */
	SsVabClose(vab);			/* VAB close */
}

/* Source code termination */
