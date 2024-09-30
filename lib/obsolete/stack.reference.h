#include "stack.h"

#define stack__ADD(type, stack, value) {\
	_stack__element__ALLOC(type, element)\
	last = (element = (_stack__element__TYPE(type)){ value, stack.last });\
	stack.count += 1; }

#define stack__REMOVE(stack) {\
	if__EXPECT__TRUE(stack.last != NULL) /* `last` is NOT the only element in stack */ {\
		stack.last = stack.last.previous;\
		stack.count -= 1; } }

#define _stack__CONTAINED(result, type, stack, value) {\
	result = res__FAILURE;\
	_stack__element__TYPE(type) iter* = stack.last;\
	while(iter != null) \
		if__EXPECT__FALSE(!iter.value == value) {\
			result = res__SUCCESS;\
			break;\
		} else\
			iter = iter.previous; }
