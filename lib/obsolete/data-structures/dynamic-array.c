#include "dynamic-array.h"

#define INITIAL_SIZE 8

/**
	all functions, partially generated, by artificial-intelligence, at `http://chat.openai.com/chat`,
		through instruction "production grade implementation, of vector dynamic arrays of c++, in c, without comments",
		unless noted otherwise
*/

void growDynArrIfNeeded(DynArr *arr)
{
	if (((*arr).length +1) < (*arr).size) return;

	CHECK_VOID_SAFE(((*arr).elements = (((*arr).size != 0)
											? realloc((*arr).elements, ((*arr).size *= 2))
											: malloc((((*arr).size = INITIAL_SIZE) * u64__size)))), OBJECT_PATH)
}

void createDynArr(DynArr **arr)
{
	CHECK_VOID_SAFE((*arr = malloc(sizeof(DynArr))), OBJECT_PATH)

	(**arr).elements = NULL;
	(**arr).length = (**arr).size = 0;
}

/**
	partially generated, by artificial-intelligence, at `http://chat.openai.com/chat`,
		through instruction "write, production grade, c code, to insert element, into array, in middle"
*/
void addIntoDynArr (u64 data,
					u64 position,
					DynArr *arr)
{
	growDynArrIfNeeded(arr);

	for (u64 i = (*arr).length++; i > position; i--) {
		*((*arr).elements + i) = *((*arr).elements + (i -1));
	}

	*((*arr).elements + position) = data;
}

void addToDynArr (u64 data,
				  DynArr *arr)
{
	growDynArrIfNeeded(arr);

	*((*arr).elements + (*arr).length++) = data;
}

void removeFromDynArr (u64 index,
					   DynArr *arr)
{
	for (u64 length = (*arr).length--; index < length; index += 1) *((*arr).elements + index) = *((*arr).elements + (index +1));
}

void removeLastFromDynArr (DynArr *arr)
{
	if ((*arr).length > 0) (*arr).length -= 1;
}
