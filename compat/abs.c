/*
 * abs.c - abs, which the SDK declares and libps does not provide
 *
 * abs.h and stdlib.h both promise it, and -fno-builtin keeps every use a real
 * call, so a program using it does not link without this.
 */

int
abs(int i)
{
	return i < 0 ? -i : i;
}
