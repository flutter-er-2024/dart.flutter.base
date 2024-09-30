#ifndef HEADER__register
#define HEADER__register

#include "basic.h"

#define _register__TYPE__TIME__COARSE/* hour precision; `u16` size */ 0
#define _register__TYPE__TIME/* second precision; `u32` size */ (1+ _register__TYPE__TIME__COARSE)
#define _register__TYPE__TIME__FINE/* nano-second precision; `u64` size (`u32` for seconds, and nano-second-s part, each) */ \
	(1+ _register__TYPE__TIME)

#define _register__TYPE__ERROR (1+ _register__TYPE__TIME__FINE)
#define _register__TYPE__ERROR__POTENTIAL (1+ _register__TYPE__ERROR)

#define _register__TYPE__VALUE__BYTE (1+ _register__TYPE__ERROR__POTENTIAL)
#define _register__TYPE__VALUE__SHORT (1+ _register__TYPE__VALUE__BYTE)
#define _register__TYPE__VALUE__INT (1+ _register__TYPE__VALUE__SHORT)
#define _register__TYPE__VALUE__LONG (1+ _register__TYPE__VALUE__INT)

#define _register__TYPE__INFO/* only the data should be provided, especially not the ids, of the variables, as can be taken from the location */ \
	(1+ _register__TYPE__VALUE__LONG)

#define _register__TYPE__VALUE__CHAR _register__TYPE__VALUE__BYTE
#define _register__TYPE__VALUE__STRING _register__TYPE__INFO

/*
	var
		could be a variable, constant, define, or even a (written) expression
	fts
		format specifier, like "%d" for `signed int` */
#define _print__uu__VALUE(var, fts) \
	printf(fts "(" #var ")" "\n", var);

#define print__uu__VALUE(var) \
	_print__uu__VALUE(var, "%ju")

#define print__ss__VALUE(var) \
	_print__uu__VALUE(var, "%jd")

#define _print__UN_BUFFERED(type, ...) \
	fprintf(stderr, #type ": " __VA_ARGS__); putc('\n', stderr);

#define register__TIME {\
	_print__UN_BUFFERED(_register__TYPE__TIME, "%d(time.reduced.hours)", (time__SECONDS__REDUCED / 360/** MINUTES_PER_HOUR * SECONDS_PER_MINUTE */))\
}

#define register__TIME__FINE {\
	_print__UN_BUFFERED(_register__TYPE__TIME__FINE, "%d(time.reduced.seconds)", time__SECONDS__REDUCED)\
}

#define register__TIME__FINEST {\
	uu seconds, nanoSeconds; TIME__SECONDS__WITH_NANO_PART__REDUCED(seconds, nanoSeconds)\
	_print__UN_BUFFERED(_register__TYPE__TIME__FINEST, "%u(time.reduced.seconds) %u(time.reduced.part.nano-seconds)", seconds, nanoSeconds)\
}

/* res result */
#define register__ERROR(result) {\
	_print__UN_BUFFERED(_register__TYPE__ERROR,\
		STRING__ERROR "  %d:`%s`:\"%s\"(error), at \"%s\"::`%s`#%lu, software built at %s, of %s",\
		result, strerrorname_np(result), strerrordesc_np(result),\
		__FILE__, __FUNCTION__, __LINE__,\
		__TIME__, __DATE__)\
}

#define register__ERROR__POTENTIAL(text) {\
	_print__UN_BUFFERED(_register__TYPE__ERROR__POTENTIAL, "\"%s\"", text)\
}

#define register__VALUE__BYTE(value) {\
	_print__UN_BUFFERED(_register__TYPE__VALUE__BYTE, "%hu(" #value ")", value)\
}

#define register__VALUE__SHORT(value) {\
	_print__UN_BUFFERED(_register__TYPE__VALUE__SHORT, "%hu(" #value ")", value)\
}

#define register__VALUE__INT(value) {\
	_print__UN_BUFFERED(_register__TYPE__VALUE__INT, "%u(" #value ")", value)\
}

#define register__VALUE__LONG(value) {\
	_print__UN_BUFFERED(_register__TYPE__VALUE__LONG, "%lu(" #value ")", value)\
}

#define register__INFO(info) {\
	_print__UN_BUFFERED(_register__TYPE__INFO, "\"%s\"", info)\
}

#define register__VALUE__CHAR register__VALUE__BYTE
#define register__VALUE__STRING register__INFO

/*
	serilization format
		VAL
			SIZE_BYTE[typeId]:u64__size[`val`]:{SIZE_CHAR * `(strlen(path) +1)`}[`path`]
		ERROR
			SIZE_BYTE[typeId]:SIZE_INT[`errno`]:{SIZE_CHAR * `(strlen(path) +1)`}[`path`]
			almost same as `REGISTER_VAL`
		INFO
			SIZE_BYTE[typeId]:{SIZE_CHAR * `(strlen(info) +1)`}[`info`]:{SIZE_CHAR * `(strlen(path) +1)`}[`path`] */

#endif
