#include "basic.h"
#include "by__arr.h"

void by__array__cpy(
	by * const dest,
	by const * const src,
	uu count)
{
	by__array__CPY(dest, src, count)
}

void by__array__set(
	by * const bys,
	by const value,
	uu count)
{
	by__array__SET(bys, value, count)
}

res by__array__cmp(
	by const * const lval,
	by const * const rval,
	uu count)
{
	res__CREAT(result);
	by__array__CMP(result, lval, rval, count)
	return result;
}
