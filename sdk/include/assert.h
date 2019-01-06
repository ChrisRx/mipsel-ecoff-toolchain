
/*****************************************************************
 *
 * Copyright (c) 1996 Sony Computer Entertainment Inc.
 * All Rights Reserved.
 *
 *                                  Ver 1.00
 *
 *****************************************************************/

#ifndef	_ASSERT_H
#define	_ASSERT_H

# ifdef NDEBUG

# define _assert(x)
# define assert(x)

# else

# define _assert(x)	{if (!(x)){printf("Assertion failed: file \"%s\", line %d\n", __FILE__, __LINE__);exit(1);}}
# define assert(x)	_assert(x)

# endif

#endif	/* _ASSERT_H */
