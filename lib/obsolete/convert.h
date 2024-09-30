#ifndef CONVERT_H
#define CONVERT_H

#include "1.types.h"

#define NULL_CHAR 0
#define U7__COUNT 128

extern const char characterSet[U7__COUNT] /* `http://en.wikipedia.org/wiki/ASCII` */;

extern char *characterSetPointers;

void initializeConvertVariables();

#endif
