#ifndef HEADER__string
#define HEADER__string

#include "basic.h"

/*
	`string` == `char__arr` == `char*` */

#define char__CONVERT__string(c) (char [2]){(c), 0}
/*
	ch *string

	char c */

#define string__CHARS__COUNT(s, s__count) \
	s__count = 0;\
	while(s[s__count++]);\
	s__count -= 1;
/*
	ch *s
	uu s__count: ret, mod
		excludes the delimiter('\0' char)

	equivalent of `strlen(` */

char *string__catenate(uu *chars__count, u31 segments__count, ...);
/*
	uu *chars__count: ret, pmod; both, only, if `chars__count` not `NULL`
	u31 segments__count
		type is `u31` due to the chances of breakage(or un-defined behavior) with larger values, like `u64`,
			because, `...` cannot have infinite args, there must be some limit, however un-known
			`int` is the standard(and default) type of c-lang, everything is based on `int`; hence a safe, conservative bet
			above all, u31__MAX is no less, in fact, more than a billion
	char *...
		the actual segments,
		count must be equal to `segments__count`

	history:
		`CATENATE_STRINGS` was created, for catenating(or combining) `filePathSegments`, separated by `FILE__PATH_SEPARATOR`,
			hence, was mold-ed accordingly,
			the `separator` char, was placed after each segment,
				and the string delimiter, '\0'(or `NULL`), was assigned in-place, of the last `separator`,
					which was un-needed, by-product, but a necessity of the loop
			`separator` was later removed, because many results were not possible,
				to achieve with the presence of a `separator`, either efficiently, or entirely
				and a separator could easy be added, as required, by passing extra arguments,
					like `catenateStrings('/', 2, "usr", "bin")`, was same as `catenateStrings(2, "usr", "/", "bin")` */

#endif
