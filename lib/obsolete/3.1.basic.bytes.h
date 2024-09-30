#include "basic.h"

/**
	int! result
	by const * const restrict lval
		left-value
	by const * const restrict rval
		right-value
	uu __MODIFIED__ count
*/
/*#define _MEM_CMP(result, lval, rval, count) {\
	while(count-- && (lval[count] == rval[count]));\
	/ ** tough un-tested, but should report in-correct result, if `lval[0] != rval[0]`, as count is already made 0, before * /\
\
	if (count) \
		result = INDICATE__FAILURE;\
}*/
