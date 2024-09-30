#ifndef HEADER__by__arr
#define HEADER__by__arr

#include "basic.h"

#define by__array__CPY(\
	dest__by__array__CPY, \
	src__by__array__CPY, \
	count__by__array__CPY) \
	while(count__by__array__CPY--) \
		dest__by__array__CPY[count__by__array__CPY] = src__by__array__CPY[count__by__array__CPY];
/*
	by dest[]: ret, pmod
	by src[]
	uu count: mod

	`memcpy` performs better
		because it copies in blocks of memory-bus's size
			rather than per-byte, which wastes the bus-width */

void by__array__cpy/*by__array__CPY__ISOLATED*/(
	by * const dest,
	by const * const src,
	uu count);

#define by__array__SET(\
	bys__by__array__SET, \
	value__by__array__SET, \
	count__by__array__SET) \
	while(count__by__array__SET--) \
		bys__by__array__SET[count__by__array__SET] = value__by__array__SET;
/*
	by bys[]: ret, mod
	by value: expr
	uu count: mod */

void by__array__set/*by__array__SET__ISOLATED*/(
	by * const bys,
	by const value,
	uu count);

#define by__array__CMP(\
	result__by__array__CMP, \
	lval__by__array__CMP, \
	rval__by__array__CMP, \
	count__by__array__CMP) {\
	while(count__by__array__CMP--) \
		if(lval__by__array__CMP[count__by__array__CMP] != rval__by__array__CMP[count__by__array__CMP]) {\
			result__by__array__CMP = res__FAILURE;\
			break;\
		}\
}
/*
	res result: ret, mod
	by lval[]
		left-value
	by rval[]
		right-value
	uu count: mod */

res by__array__cmp/*by__array__CMP__ISOLATED*/(
	by const * const lval,
	by const * const rval,
	uu count);

#define by__array__PRINT(\
	bys__by__array__PRINT, \
	count__by__array__PRINT) {\
	uu\
		bys__iter__by__array__PRINT = 0,\
		lines__iter__by__array__PRINT = 0,\
		segments__iter__by__array__PRINT;\
\
	while(bys__iter__by__array__PRINT < count__by__array__PRINT) {\
		printf("%ju:\t", (lines__iter__by__array__PRINT += 1));\
		segments__iter__by__array__PRINT = 0;\
		while((bys__iter__by__array__PRINT < count__by__array__PRINT) && (segments__iter__by__array__PRINT++ < 8)) \
			printf("\t%hu", bys__by__array__PRINT[bys__iter__by__array__PRINT++]);\
		putchar('\n');\
	}\
}
/*
	by bys[]
	uu count */

#define by__array__PRINT__SIMPLE(\
	bys__by__array__PRINT__SIMPLE, \
	count__by__array__PRINT__SIMPLE) {\
	uu bys__iter__by__array__PRINT__SIMPLE = 0;\
	while (bys__iter__by__array__PRINT__SIMPLE < count__by__array__PRINT__SIMPLE) \
		printf("%hu\t", bys__by__array__PRINT__SIMPLE[bys__iter__by__array__PRINT__SIMPLE++]);\
	putchar('\n');\
}
/*
	by bys[]
	uu count */

struct _by__array__list__element {
	uu bys__count/*__filled*/;
	by *bys;
	u1 bys__b__free;

	struct _by__array__list__element *next;
};

struct _by__array__list {
	uu
		elements__count/* arrays__count */,
		bys__count/*__filled*/;

	struct _by__array__list__element
		*first,
		*last;
};

#define _by__array__list__EMPTY \
	{ 0UL, 0UL, NULL, NULL }

#define by__array__list__CREAT(\
	ls__by__array__list__CREAT) \
	struct _by__array__list ls__by__array__list__CREAT = _by__array__list__EMPTY;

#define by__array__list__RE_SET(\
	ls__by__array__list__RE_SET) \
	ls__by__array__list__RE_SET = (struct _by__array__list)_by__array__list__EMPTY;

#define by__array__list__ADD(\
	ls__by__array__list__ADD, \
	bys__by__array__list__ADD, \
	bys__count__by__array__list__ADD, \
	bys__b__free__by__array__list__ADD) \
{\
	struct _by__array__list__element *element__by__array__list__ADD;\
	mem__ALLOC(element__by__array__list__ADD)\
	/*printf("%p(element)\n", element__by__array__list__ADD);*/\
	*element__by__array__list__ADD = (struct _by__array__list__element){ \
		bys__count__by__array__list__ADD, \
		bys__by__array__list__ADD, \
		bys__b__free__by__array__list__ADD, \
		NULL };\
\
	ls__by__array__list__ADD.last = \
		(ls__by__array__list__ADD.elements__count++/* non-zero, hence NOT the first element */ \
			? ((*(ls__by__array__list__ADD.last)).next = element__by__array__list__ADD)\
			: (ls__by__array__list__ADD.first = element__by__array__list__ADD));\
\
	ls__by__array__list__ADD.bys__count += bys__count__by__array__list__ADD;\
}
/*
	struct _by__array__list ls: mmod
	by *bys: expr, typd
	uu bys__count: expr, typd
	u1 bys__b__free: expr, typd */

#define by__array__list__CONVERT__by__arr(\
	ls__by__array__list__CONVERT__by__arr, \
	bys__by__array__list__CONVERT__by__arr, \
	bys__count__by__array__list__CONVERT__by__arr) \
{\
	/*printf("%ju(ls.elements__count)"\
		", %ju(ls.bys__count)"\
		", %p(ls.first)"\
		", %p(ls.last)"\
		"\n",\
		ls__by__array__list__CONVERT__by__arr.elements__count,\
		ls__by__array__list__CONVERT__by__arr.bys__count,\
		ls__by__array__list__CONVERT__by__arr.first,\
		ls__by__array__list__CONVERT__by__arr.last);*/\
\
	bys__count__by__array__list__CONVERT__by__arr = ls__by__array__list__CONVERT__by__arr.bys__count;\
	mem__ALLOC__ARRAY(bys__by__array__list__CONVERT__by__arr, bys__count__by__array__list__CONVERT__by__arr)\
\
	struct _by__array__list__element\
		*iter__by__array__list__CONVERT__by__arr = ls__by__array__list__CONVERT__by__arr.first,\
		*next__by__array__list__CONVERT__by__arr = NULL;\
	by \
		*bys___by__array__list__CONVERT__by__arr = bys__by__array__list__CONVERT__by__arr,\
		*bys____by__array__list__CONVERT__by__arr;\
	uu \
		bys__count__by__array__list__CONVERT__by__arr,\
		bys__count___by__array__list__CONVERT__by__arr;\
\
	do {\
		/*printf("%p(iter)"\
			", %ju(iter.bys__count)"\
			", %p(iter.bys)"\
			", %p(iter.next)"\
			"\n",\
			iter__by__array__list__CONVERT__by__arr,\
			(*iter__by__array__list__CONVERT__by__arr).bys__count,\
			(*iter__by__array__list__CONVERT__by__arr).bys,\
			(*iter__by__array__list__CONVERT__by__arr).next);*/\
\
		bys__count___by__array__list__CONVERT__by__arr = \
			(bys__count__by__array__list__CONVERT__by__arr = (*iter__by__array__list__CONVERT__by__arr).bys__count);\
		bys____by__array__list__CONVERT__by__arr = (*iter__by__array__list__CONVERT__by__arr).bys;\
		by__array__CPY(bys___by__array__list__CONVERT__by__arr, \
			bys____by__array__list__CONVERT__by__arr, \
			bys__count___by__array__list__CONVERT__by__arr)\
		bys___by__array__list__CONVERT__by__arr += bys__count__by__array__list__CONVERT__by__arr;\
\
		if((*iter__by__array__list__CONVERT__by__arr).bys__b__free) \
			mem__FREE((*iter__by__array__list__CONVERT__by__arr).bys)\
\
		next__by__array__list__CONVERT__by__arr = (*iter__by__array__list__CONVERT__by__arr).next;\
		mem__FREE(iter__by__array__list__CONVERT__by__arr)\
	} while((iter__by__array__list__CONVERT__by__arr = next__by__array__list__CONVERT__by__arr));\
\
	by__array__list__RE_SET(ls__by__array__list__CONVERT__by__arr)\
}
/*
	struct _by__array__list ls: mmod
	by *bys: ret, mod
	uu bys__count: ret, mod */

#endif
