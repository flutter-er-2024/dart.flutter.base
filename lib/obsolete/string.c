#include "string.h"

struct _string__list__element {
	int len;
	char *str;

	struct _string__list__element *next;
};

char *string__catenate(uu *chars__count, u31 segments__count, ...) {\
	va_list args;\
\
	struct _string__list__element\
		*first = NULL,\
		*last = NULL,\
		*element;\
\
	uu bys__count = 1/* '\0' */;\
\
	va_start(args, segments__count);\
\
	while(segments__count--) {\
		MEM__ALLOC(element)\
\
		if(first) {\
			(*last).next = element;\
		} else {\
			first = element;\
		}\
\
		(*(last = element)).next = NULL;\
\
		char *s = ((*element).str = va_arg(args, char *));\
		uu s__count;\
		string__CHARS__COUNT(s, s__count)\
		bys__count += ((*element).len = s__count); }\
\
	va_end(args);\
\
	char\
		*result,\
		*buffer;\
\
	MEM__ALLOC__ARRAY(result, bys__count)\
\
	buffer = result;\
\
	element = first;\
\
	do {\
		strncpy(buffer, (*element).str, (*element).len);\
		buffer += (*element).len;\
\
		/* `*(buffer++) = separator;` */\
	} while((element = (*element).next));
\
	*buffer = 0;\
\
	if(chars__count) \
		*chars__count = (bys__count -1);\
\
	return result;\
}
