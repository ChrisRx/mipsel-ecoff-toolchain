/*****************************************************************
 *
 * Copyright (c) 1996 Sony Computer Entertainment Inc.
 * All Rights Reserved.
 *
 *                                  Ver 1.00
 *
 *****************************************************************/

#ifndef _LIBPS_H_
#define _LIBPS_H_

#include <sys/types.h>

/*
 * Structures
 */

/* Graphics Structures */
typedef struct {
	short x, y;		/* offset point on VRAM */
	short w, h;		/* width and height */
} RECT;

typedef struct  {
	short	m[3][3];	/* 3x3 rotation matrix */
	long    t[3];		/* transfer vector */
} MATRIX;

typedef struct {		/* long word type 3D vector */
	long	vx, vy;
	long	vz, pad;
} VECTOR;
	
typedef struct {		/* short word type 3D vector */	
	short	vx, vy;
	short	vz, pad;
} SVECTOR;
	       
typedef struct {		/* color type vector */	
	u_char	r, g, b, cd;
} CVECTOR;
	       
typedef struct {
	VECTOR  scale;
	SVECTOR rotate;
	VECTOR  trans;
} GsCOORD2PARAM;

typedef struct _GsCOORDINATE2 {
	unsigned long flg;
	MATRIX  coord;
	MATRIX  workm;
	GsCOORD2PARAM *param;
	struct _GsCOORDINATE2 *super;
	struct _GsCOORDINATE2 *sub;
} GsCOORDINATE2;

typedef struct {
	MATRIX  view;
	GsCOORDINATE2 *super;
} GsVIEW2;

typedef struct {
	long    vpx, vpy, vpz;
	long    vrx, vry, vrz;
	long    rz;
	GsCOORDINATE2 *super;
} GsRVIEW2;

typedef struct {
	int     vx, vy, vz;
	unsigned char r, g, b;
} GsF_LIGHT;


typedef struct {
	unsigned p:24;
	unsigned char num:8;
} GsOT_TAG;

typedef struct {
	unsigned long length;
	GsOT_TAG *org;
	unsigned long offset;
	unsigned long point;
	GsOT_TAG *tag;
} GsOT;

typedef struct {
	unsigned long attribute;/* pers,trans,rotate,disp */
	GsCOORDINATE2 *coord2;	/* local dmatrix */
	unsigned long *tmd;
	unsigned long id;	/* reserved */
} GsDOBJ2;

typedef struct {
	unsigned long attribute;
	short   x, y;
	unsigned short w, h;
	unsigned short tpage;
	unsigned char u, v;
	short   cx, cy;
	unsigned char r, g, b;
	short   mx, my;
	short   scalex, scaley;
	long    rotate;
} GsSPRITE;

typedef struct {
	unsigned char u, v;
	unsigned short cba;
	unsigned short flag;
	unsigned short tpage;
} GsCELL;

typedef struct {
	unsigned char cellw, cellh;
	unsigned short ncellw, ncellh;
	GsCELL *base;
	unsigned short *index;
} GsMAP;

typedef struct {
	unsigned long attribute;
	short   x, y;
	short   w, h;
	short   scrollx, scrolly;
	unsigned char r, g, b;
	GsMAP  *map;
	short   mx, my;
	short   scalex, scaley;
	long    rotate;
} GsBG;

typedef struct {
	unsigned long attribute;
	short   x0, y0;
	short   x1, y1;
	unsigned char r, g, b;
} GsLINE;

typedef struct {
	unsigned long attribute;
	short   x0, y0;
	short   x1, y1;
	unsigned char r0, g0, b0;
	unsigned char r1, g1, b1;
} GsGLINE;

typedef struct {
	unsigned long attribute;
	short   x, y;
	unsigned short w, h;
	unsigned char r, g, b;
} GsBOXF;

typedef struct {
	short   dqa;
	long    dqb;
	unsigned char rfc, gfc, bfc;
} GsFOGPARAM;

typedef struct {
	unsigned long pmode;
	short   px, py;
	unsigned short pw, ph;
	unsigned long *pixel;
	short   cx, cy;
	unsigned short cw, ch;
	unsigned long *clut;
} GsIMAGE;

typedef struct {
	short   offx, offy;
} _GsPOSITION;

typedef struct {
	u_long	tag;
	u_long	code[15];
} DR_ENV;
	       
typedef struct {
	RECT	clip;		/* clip area */
	short	ofs[2];		/* drawing offset */
	RECT	tw;		/* texture window */
	u_short tpage;		/* texture page */	
	u_char	dtd;		/* dither flag (0:off, 1:on) */
	u_char	dfe;		/* flag to draw on display area (0:off 1:on) */
	u_char	isbg;		/* enable to auto-clear */
	u_char	r0, g0, b0;	/* initital background color */
	DR_ENV	dr_env;		/* reserved */
} DRAWENV;
	       
typedef struct {
	RECT	disp;		/* display area */
	RECT	screen;		/* display start point */
	u_char	isinter;	/* interlace 0: off 1: on */
	u_char	isrgb24;	/* RGB24 bit mode */
	u_char	pad0, pad1;	/* reserved */
} DISPENV;


/* Sound Structure */
typedef struct {
	unsigned short left;    /* L Channel */
	unsigned short right;   /* R Channel */
} SndVolume;

/* Miscellaneous Structures */
typedef struct {
	u_char minute;		/* minute (BCD) */
	u_char second;		/* second (BCD) */
	u_char sector;		/* sector (BCD) */
	u_char track;		/* track (void) */
} CdlLOC;

typedef struct {
	CdlLOC	pos;		/* file location */
	u_long	size;		/* file size */
	char	name[16];	/* file name (body) */
} CdlFILE;

struct EXEC {                   
	unsigned long pc0;      
	unsigned long gp0;      
	unsigned long t_addr;   
	unsigned long t_size;   
	unsigned long d_addr;   
	unsigned long d_size;   
	unsigned long b_addr;   
	unsigned long b_size;   
	unsigned long s_addr;
	unsigned long s_size;
	unsigned long sp,fp,gp,ret,base;
};

struct DIRENTRY {
	char name[20];
	long attr;
	long size;
	struct DIRENTRY *next;
	long head;
	char system[4];
};


/*
 * Macros
 */

/* Graphics Macros */
#ifndef NULL
#define NULL 0
#endif

#define setRECT(r, _x, _y, _w, _h) \
	(r)->x = (_x),(r)->y = (_y),(r)->w = (_w),(r)->h = (_h)

#define limitRange(x, l, h)	((x)=((x)<(l)?(l):(x)>(h)?(h):(x)))

#define	ONE		4096	/* GTE regards 4096 as 1.0 */
#define WORLD NULL

#define GsDivMODE_NDIV 0
#define GsDivMODE_DIV  1
#define GsLMODE_NORMAL 0
#define GsLMODE_FOG    1
#define GsLMODE_LOFF   2

#define GsOFSGTE 0
#define GsOFSGPU 4
#define GsINTER  1
#define GsNONINTER 0

/* GsDOBJ2 attribute set macro */
#define GsFOG   (1<<3)
#define GsLLMOD (1<<5)
#define GsLOFF  (1<<6)
#define GsDIV1   (1<<9)
#define GsDIV2   (2<<9)
#define GsDIV3   (3<<9)
#define GsDIV4	 (4<<9)
#define GsDIV5	 (5<<9)
#define GsALON   (1<<30)
#define GsDOFF   (1<<31)

/* BG/sprite attribute set macro */
#define GsROTOFF (1<<27)

#define GsIncFrame()  (PSDCNT=(PSDCNT++ == 0?1:PSDCNT)), \
                      (PSDIDX= (PSDIDX==0?1:0));

#define getScratchAddr(offset)  ((u_long *)(0x1f800000+offset*4))

/* Sound */
#define SSPLAY_INFINITY  0 
#define SSPLAY_PAUSE     0
#define SSPLAY_PLAY      1
#define SS_REV_TYPE_OFF        0
#define SS_REV_TYPE_ROOM       1
#define SS_REV_TYPE_STUDIO_A   2
#define SS_REV_TYPE_STUDIO_B   3
#define SS_REV_TYPE_STUDIO_C   4
#define SS_REV_TYPE_HALL       5
#define SS_REV_TYPE_SPACE      6
#define SS_REV_TYPE_ECHO       7
#define SS_REV_TYPE_DELAY      8
#define SS_REV_TYPE_PIPE       9

#define SS_CD		0
#define SS_MUTE_OFF     0
#define SS_MUTE_ON      1
#define SS_SOFF		0      
#define SS_SON		1     
#define SS_MIX		0    
#define SS_REV		1   

/* Mathematical Macros */
#define _ABS(x)		((x) < 0 ? -(x) : (x))
#define fabs(x)		_ABS(x)

/* Miscellaneous Macros */

#define RCntCNT2	0xf2000002

/*
 * Video Mode:  NTSC/PAL
 */
#define MODE_NTSC	0
#define MODE_PAL	1

typedef unsigned char PACKET;

/*
 *	Global Variables 
 */
extern RECT CLIP2;		/* clipping area */
extern int GsLIGHT_MODE;	/* lighting mode global */
extern short PSDOFSX[2], PSDOFSY[2];	/* double buffer base */
extern short PSDIDX;		/* double buffer index */
extern u_long PSDCNT;		/* frame counter for using matrix cache */
extern _GsPOSITION POSITION;	/* 2d offset */
extern DRAWENV GsDRAWENV;	/* DRAWENV of Gs */
extern DISPENV GsDISPENV;	/* DISPENV of Gs */
extern MATRIX GsLSMATRIX;	/* Local-Screen Matrix of Gs */
extern MATRIX GsWSMATRIX;	/* Current World-Screen Matrix of Gs */
extern MATRIX GsLIGHTWSMATRIX;	/* World-Screen Light Matrix of Gs */
extern MATRIX GsIDMATRIX;	/* Unit Matrix */
extern MATRIX GsIDMATRIX2;	/* Unit Matrix including Aspect retio */
extern PACKET *GsOUT_PACKET_P;	/* Work Base pointer */
extern u_long GsLMODE, GsLIGNR, GsLIOFF, GsNDIV;
extern u_long GsTON, GsDISPON;

extern int math_errno;

/*
 * Prototypes
 */

/* Graphics Functions */
int VSync(int mode);
int VSyncCallback(void (*f)()) ;
extern DISPENV *PutDispEnv(DISPENV *env);
extern DRAWENV *PutDrawEnv(DRAWENV *env);
extern int ClearImage(RECT *rect, u_char r, u_char g, u_char b);
extern int DrawSync(int mode);
extern int FntOpen(int x, int y, int w, int h, int isbg, int n);
extern void KanjiFntClose(void);
extern int KanjiFntOpen(int x, int y, int w, int h, int dx, int dy, int cx, int cy, int isbg, int n);
extern int Krom2Tim(u_char *sjis, u_long *taddr, int dx, int dy, int cdx, int cdy, u_int fg, u_int bg);
extern int Krom2Tim2(u_char *sjis, u_long *taddr, int dx, int dy, int cdx, int cdy, u_int fg, u_int bg);
extern int LoadImage(RECT *rect, u_long *p);
extern int MoveImage(RECT *rect, int x, int y);
extern int ResetGraph(int mode);
extern int StoreImage(RECT *rect, u_long *p);
extern u_long *FntFlush(int id);
extern u_long *KanjiFntFlush(int id);
extern u_short GetClut(int x, int y) ;
extern u_short GetTPage(int tp, int abr, int x, int y) ;
extern void FntLoad(int tx, int ty);
extern void SetDispMask(int mask);
extern int FntPrint();
extern int KanjiFntPrint();
extern	void    GsInit3D(void);
extern	void    GsInitGraph(unsigned short x, unsigned short y, unsigned short intmode, unsigned short dith, unsigned short varmmode);
extern	void    GsMapModelingData(unsigned long *p);
extern	void    GsSetProjection(long h);
extern	int     GsSetFlatLight(int id, GsF_LIGHT * lt);
extern	void    GsSetLightMode(int mode);
extern	void    GsSetFogParam(GsFOGPARAM * fogparm);
extern	void    GsSetAmbient(long r, long g, long b);
extern	void    GsDrawOt(GsOT * ot);
extern	void    GsSetWorkBase(PACKET * outpacketp);
extern	void    GsSortObject4(GsDOBJ2 * objp, GsOT * ot, int shift, u_long * scratch);
extern	void    GsSortSprite(GsSPRITE * sp, GsOT * ot, unsigned short pri);
extern	void    GsSortFastSprite(GsSPRITE * sp, GsOT * ot, unsigned short pri);
extern	void    GsInitFixBg16(GsBG * bg, u_long * work);
extern	void    GsSortFixBg16(GsBG * bg, u_long * work, GsOT * otp, unsigned short pri);
extern	void    GsSortLine(GsLINE * lp, GsOT * ot, unsigned short pri);
extern	void    GsSortGLine(GsGLINE * lp, GsOT * ot, unsigned short pri);
extern	void    GsSortBoxFill(GsBOXF * bp, GsOT * ot, unsigned short pri);
extern	void    GsClearOt(unsigned short offset, unsigned short point, GsOT * otp);
extern	GsOT   *GsSortOt(GsOT * ot_src, GsOT * ot_dest);
extern	void    GsDefDispBuff(unsigned short x0, unsigned short y0, unsigned short x1, unsigned short y1);
extern	void    GsGetTimInfo(unsigned long *im, GsIMAGE * tim);
extern	void    GsSwapDispBuff(void);
extern	int     GsGetActiveBuff(void);
extern	void    GsSetDrawBuffClip(void);
extern	void    GsSetDrawBuffOffset(void);
extern	void    GsSetClip(RECT * clip);
extern	void    GsSetOffset(long x, long y);
extern	void    GsSetOrign(long x, long y);
extern	void    GsInitCoordinate2(GsCOORDINATE2 * super, GsCOORDINATE2 * base);
extern	void    GsGetLw(GsCOORDINATE2 * m, MATRIX * out);
extern	void    GsGetLs(GsCOORDINATE2 * m, MATRIX * out);
extern	void    GsGetLws(GsCOORDINATE2 * m, MATRIX * outw, MATRIX * outs);
extern	void    GsLinkObject4(unsigned long tmd_base, GsDOBJ2 * objp, int n);
extern	void    GsSetLightMatrix(MATRIX * mp);
extern	int     GsSetRefView2(GsRVIEW2 * pv);
extern	int     GsSetView2(GsVIEW2 * pv);
extern	void    GsSetLsMatrix(MATRIX * mp);
extern	void    GsSetClip2D(RECT * rectp);
extern	PACKET *GsGetWorkBase();
extern	void    GsSortClear(unsigned char r, unsigned char g , unsigned char b, GsOT *);
extern	void    GsScaleScreen(SVECTOR * scale);
extern MATRIX *MulMatrix0(MATRIX *m0,MATRIX *m1,MATRIX *m2);
extern VECTOR *ApplyMatrix(MATRIX *m,SVECTOR *v0,VECTOR *v1);
extern VECTOR *ApplyMatrixSV(MATRIX *m,SVECTOR *v0,SVECTOR *v1);
extern VECTOR *ApplyMatrixLV(MATRIX *m,VECTOR *v0,VECTOR *v1);
extern MATRIX *RotMatrix(SVECTOR *r,MATRIX *m);
extern MATRIX *RotMatrixX(long r,MATRIX *m);
extern MATRIX *RotMatrixY(long r,MATRIX *m);
extern MATRIX *RotMatrixZ(long r,MATRIX *m);
extern MATRIX *TransMatrix(MATRIX *m,VECTOR *v);
extern MATRIX *ScaleMatrix(MATRIX *m,VECTOR *v);
extern MATRIX *ScaleMatrixL(MATRIX *m,VECTOR *v);
extern MATRIX *TransposeMatrix(MATRIX *m0,MATRIX *m1);
extern MATRIX *CompMatrix(MATRIX *m0,MATRIX *m1,MATRIX *m2);
extern void PushMatrix();
extern void PopMatrix();
extern void gteMIMefunc(SVECTOR *otp, SVECTOR *dfp, long n, long p);

/* Sound Functions */
extern void  SsVabClose (short);          
extern short SsVabTransfer (unsigned char *, unsigned char *, short, short);
extern short SsSeqOpen (unsigned long*, short); 
extern void  SsSeqClose (short);                       
extern void  SsSeqPlay (short, char, short);    
extern void  SsSeqPause (short);                    
extern void  SsSeqReplay (short);                  
extern void  SsSeqStop (short);                   
extern void  SsSeqSetVol (short, short, short);  
extern void  SsSeqGetVol (short, short, short*, short*);
extern void  SsSeqSetNext (short, short);             
extern void  SsSeqSetRitardando (short, long, long);   
extern void  SsSeqSetAccelerando (short, long, long);  
extern void  SsSetMVol (short, short);              
extern void  SsGetMVol (SndVolume*);             
extern void  SsSetMute (char);                        
extern char  SsGetMute (void);                        
extern void  SsSetTempo (short, short, short);
extern short SsIsEos (short, short);
extern void  SsPlayBack (short, short, short);
extern void  SsSetSerialAttr (char, char, char);     
extern char  SsGetSerialAttr (char, char);           
extern void  SsSetSerialVol (char, short, short);    
extern void  SsGetSerialVol (char, SndVolume*); 
extern short SsUtKeyOn (short, short, short, short, short, short, short);
extern short SsUtKeyOff (short, short, short, short, short);
extern short SsUtPitchBend (short, short, short, short, short);
extern short SsUtChangePitch (short, short, short, short, short, short, short);
extern short SsUtSetVVol (short, short, short);
extern short SsUtGetVVol (short, short*, short*);
extern void  SsUtReverbOn (void);
extern void  SsUtReverbOff (void);
extern short SsUtSetReverbType (short);
extern short SsUtGetReverbType (void);
extern void  SsUtSetReverbDepth (short, short);
extern void  SsUtSetReverbFeedback (short);
extern void  SsUtSetReverbDelay (short);
extern void  SsUtAllKeyOff (short);

/* Mathematical Functions */
extern double pow(double, double);
extern double exp(double);
extern double log(double);
extern double log10(double);
extern double floor(double);
extern double ceil(double);
extern double fmod(double,double);
extern double modf(double,double *);
extern double sin(double);
extern double cos(double);
extern double tan(double);
extern double asin(double);
extern double acos(double);
extern double atan(double);
extern double atan2(double, double);
extern double sinh(double);
extern double cosh(double);
extern double tanh(double);
extern double sqrt(double);
extern double hypot(double, double);
extern double ldexp(double, int);
extern double frexp(double, int *);
extern double atof(char *);
extern double strtod(char *, char **);
extern int printf2(char *, ...);
extern int sprintf2(char *, char *, ...);

/* Misccellaneous Functions */
extern void GetPadBuf(volatile unsigned char **, volatile unsigned char **);
extern long GetRCnt(unsigned long);
extern long ResetRCnt(unsigned long);
extern long StartRCnt(unsigned long);
extern int open(char *, int);
extern int close(int);
extern int lseek(int, unsigned int, int);
extern int read(int, char *, int);
extern int write(int, char *, int);
extern struct DIRENTRY * firstfile(char *, struct DIRENTRY *);
extern struct DIRENTRY * nextfile(struct DIRENTRY *);
extern int delete(char *);
extern int format(char *);
extern int rename(char *, char *);
extern long LoadTest(char *, struct EXEC *);
extern long Load(char *, struct EXEC *);
extern long Exec(struct EXEC *, long, char **);
extern void FlushCashe(void);
extern long _get_errno(void);
extern int CdReadFile(char *file, u_long *addr, int nbyte);
extern int CdReadSync(int mode, u_char *result);
extern CdlFILE *CdSearchFile(CdlFILE *fp, char *name);
extern struct EXEC *CdReadExec(char *file);
extern int CdPlay(int mode, int *tracks, int offset);
extern void EnterCriticalSection(void);
extern void ExitCriticalSection(void);
extern long TestCard(long);
extern long GetVideoMode(void);
extern long SetVideoMode(long mode);

/* ----------------------------------------------------------------
 *	End on File
 * ---------------------------------------------------------------- */
#endif /* _LIBPS_H_ */
/* DON'T ADD STUFF AFTER THIS */

