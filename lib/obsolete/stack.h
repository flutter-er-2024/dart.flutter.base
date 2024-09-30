#ifndef HEADER__stack
#define HEADER__stack

#include "basic.h"

#define _stack__element__TYPE(type___stack__element__TYPE) \
	struct _ ## type___stack__element__TYPE ## __stack__element

#define _stack__TYPE(type___stack__TYPE) \
	struct type___stack__TYPE ## __stack

#define stack__DECLARE(type__stack__DECLARE) \
	_stack__element__TYPE(type__stack__DECLARE) {\
		type__stack__DECLARE value;\
		_stack__element__TYPE(type__stack__DECLARE)* previous; };\
	_stack__TYPE(type__stack__DECLARE) {\
		uu count;\
		_stack__element__TYPE(type__stack__DECLARE)* last; };
/*
	type type
		(data-)type of the `value`, to be stored in the `struct`
			MUST follow the standard(gnu-c-23) id(-entifier) naming rules
				like, using `by__arr`, instead of `by *`
		example
			`u64`, `by`, `by__arr`
		wrong
			`u64 `, ` u16`, `by*`, `by *` */

#define _stack__element__ALLOC(type___stack__element__ALLOC, id___stack__element__ALLOC) \
	_stack__element__TYPE(type___stack__element__ALLOC) id___stack__element__ALLOC*;\
	mem__ALLOC(id___stack__element__ALLOC)

#define stack__EMPTY \
	{ 0UL, NULL }

#define stack__CREAT(type__stack__CREAT, id__stack__CREAT) \
	_stack__TYPE(type__stack__CREAT) id__stack__CREAT = stack__EMPTY;

#define stack__RE_SET(type__stack__RE_SET, id__stack__RE_SET) \
	id__stack__RE_SET = (_stack__TYPE(type__stack__RE_SET))stack__EMPTY;

#endif
