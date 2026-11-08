/*
 * A minimal Net Yaroze program: set up a double-buffered 320x240 display,
 * then clear and draw a frame forever with a frame counter on screen.
 *
 * Everything called here lives in the libps that the boot disc leaves
 * resident in RAM, so the program itself stays tiny.
 */

#include <libps.h>

#define OT_LENGTH	1	/* ordering table size, as a power of two */

GsOT		WorldOT[2];			/* one ordering table per buffer */
GsOT_TAG	OTTags[2][1 << OT_LENGTH];
PACKET		GpuPacketArea[2][64];		/* GPU packet scratch space */

main()
{
	int i, cnt, activeBuff;

	SetVideoMode(MODE_NTSC);
	GsInitGraph(320, 240, 4, 0, 0);
	GsDefDispBuff(0, 0, 0, 240);

	for (i = 0; i < 2; i++) {
		WorldOT[i].length = OT_LENGTH;
		WorldOT[i].org = OTTags[i];
	}

	FntLoad(960, 256);			/* font into the frame buffer */
	FntOpen(16, 16, 256, 200, 0, 512);	/* where text will appear */

	cnt = 0;
	for (;;) {
		activeBuff = GsGetActiveBuff();
		GsSetWorkBase((PACKET *)GpuPacketArea[activeBuff]);
		GsClearOt(0, 0, &WorldOT[activeBuff]);

		DrawSync(0);			/* wait for drawing to finish */
		VSync(0);			/* wait for vertical blank */
		cnt = VSync(-1);		/* vertical blanks so far */
		GsSwapDispBuff();

		/* Background color cycles so a live frame is obvious. */
		GsSortClear(0, (cnt / 2) % 200, 120, &WorldOT[activeBuff]);
		GsDrawOt(&WorldOT[activeBuff]);

		FntPrint("hello from mipsel-none-elf\n");
		FntPrint("frame = %d\n", cnt);
		FntFlush(-1);
	}
	return 0;
}
