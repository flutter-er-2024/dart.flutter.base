#ifndef DYNAMIC_ARRAY_H
#define DYNAMIC_ARRAY_H

#include "../convert.h"

struct _DynamicU64Array {
	u64
		length/** elementCount(number of elements) */,
		size/** allocation(or capacity) */,
		*elements;
};

typedef struct _DynamicU64Array DynArr;

int growDynArr(DynArr *array);

#endif
