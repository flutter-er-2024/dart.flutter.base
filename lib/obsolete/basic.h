/*
  STANDARD: `gnu-gcc-c23`
  DOCUMENTATION: `https://www.gnu.org/software/libc/manual` */

/*
	`https://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Attribute-Syntax.html`
	"`__attribute__((hot, nonnull)) void f(void_);` == `__attribute__((hot)) __attribute__((nonnull)) void f1(void_);`"(https://stackoverflow.com/a/5526125)

	all parameters: `__attribute__((nonnull))`
	mentioned parameters: `__attribute__((nonnull(1, 2, 3)))`

	multiple attributes: `__attribute__((hot, nonnull))`
	empty attribute (allowed): `__attribute__(())`

	example
		gcc docs: `extern void *my_memcpy(void *dest, const void *src, size_t len) __attribute__((nonnull));`
		linux usage: `__attribute__((nonnull)) static inline int value(const int value) { return value; }` */

/*
	function.parameter.feature.arr
		mod
			value is modified, inside the routine(macro function)
				hence, should be expected to be un-defined, after the routine's execution
		pmod
			value at the memory location, pointed by this pointer variable, is modified, inside the routine
				hence, should NOT be relied upon, after the execution, of the routine
			similar to marking the pointed value as `mod`
		mmod
			member(s) at the memory location, pointed by this `struct` object(like variable), is modified, inside the routine
			similar to marking the pointed value as `mod`
		ret
			`return`ed value
			value is set inside the routine, with result intension, like one of the answer(s), of the question(the routine)
			`mod` and `pmod`, MUST be explicit
		nul
			value, could be `NULL`
		typd
			need NOT be a variable, and can be typed(or written)
				like directly passing `10`, instead of first creating a variable `int ten = 10;`
		expr
			expression(or calculation), like `(i * j)`, could also be passed as argument */

#ifndef HEADER__basic
#define HEADER__basic

#define _GNU_SOURCE 1
#define _FILE_OFFSET_BITS 64

#include <stdlib.h>

#include <stdbool.h>
#include <stdint.h>
#include <limits.h>
#include <string.h>
#include <time.h>

#include <stdio.h>
#include "stdarg.h"

#include <errno.h>

#include <unistd.h>
#include <fcntl.h> /* `O_`* */

#include <sys/time.h>
#include <sys/stat.h>

/** server's block */
#include <arpa/inet.h>
#include <base__netdb.h>
#include <base__netinet/in.h>
#include <base__netinet/tcp.h>
#include <sys/socket.h>

//#include <sys/syscall.h>
//#include <sys/sysinfo.h>

//#include <sys/sendfile.h> /* `sendfile64` */

/*
	`u8`'s typedef MUST be the first statement of the source-code
		because `mk-cpp-out-human-rdble`, uses this statement, as the offset, to start processing the pre-processed output
			because, everything beow this statement, is ours, and also logical-invert */

typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;

typedef u32 u24;
typedef u32 u31/* for `res`, which is guaranteed to be positive, always */;
typedef u64 u63/* for never negative (always positive) `s64` */;

typedef u8 by;

typedef u8 u7;
typedef u8 u1/* bool, true, false */;

typedef u7 ch/* unsigned `char`; no problem in casting to `char` */;
typedef ch* /* s[] */ str;
typedef u24 wch/* char__wide */;

//typedef __uint128_t u128;

typedef uintmax_t uu; /* `printf`'s conversion specifier is `%ju` */
typedef size_t sz; /* use with `%zu`, in `printf` */

typedef uintptr_t ptr;

typedef int8_t s8;
typedef int16_t s16;
typedef int32_t s32;
typedef int64_t s64;

//typedef __int128_t s128;

typedef intmax_t ss;
typedef ssize_t ssz;

typedef u31 res/*
	`result`
	`INDICATE_SUCCESS` on success,
		otherwise 
			either some special non-error value, like `FILE__RESULT__END_OF_FILE` of `_IO__READ__BLOCKING`, 
			or a error value, like a private `errno`,
				to eliminate the need for the `errno.h` provided `errno`,
					which is a mere complexity, due to its variable.global nature
	if the value is surely success/error type value,
		then it could be used as `bFailed` inside `if` statements' condition,
			because `if` considers `INDICATE_SUCCESS`(which is `0`) as `false`,
				and all other values as `true`,
					hence all non-success values are `true`, and success value is `false`
			examples:
				`result r; if(r) handleError();`
				`result r; if(!r) processSuccessValue();`
	`errno` will always be Less than `u12__MAX`
		as given in `linux/err.h`::`MAX_ERRNO`

	TODO
		move to `u16`
			due to just above, point */;

#define BITS_PER_BYTE 8U

#define by__SIZE 1U

#define u8__SIZE by__SIZE
#define u16__SIZE (u8__SIZE * 2)
#define u24__SIZE (u16__SIZE + u8__SIZE)
#define u32__SIZE (u16__SIZE * 2)
#define u64__SIZE (u32__SIZE * 2)

#define ch__SIZE by__SIZE
#define wch__SIZE u24__SIZE

#define int__SIZE __SIZEOF_INT__/* `u32__SIZE` */
#define s64__SIZE u64__SIZE

#define u8__LIMIT (1U << (u8__SIZE * BITS_PER_BYTE))
#define u16__LIMIT (1U << (u16__SIZE * BITS_PER_BYTE))
#define u24__LIMIT (1U << (u24__SIZE * BITS_PER_BYTE))
#define u32__LIMIT (1UL << (u32__SIZE * BITS_PER_BYTE))
//#define u64__LIMIT (1 << (u64__SIZE * BITS_PER_BYTE))

#define u8__MAX UINT8_MAX/* `(u8__LIMIT -1)` */ /* 0xFF */
#define u16__MAX UINT16_MAX/* `(u16__LIMIT -1)` */ /* 0xFFFF */
#define u24__MAX (u24__LIMIT -1)
#define u32__MAX UINT32_MAX/* `(u32__LIMIT -1)` */ /* 0xFFFFFFFF */
#define u64__MAX UINT64_MAX/* `(u64__LIMIT -1)` */ /* 0xFFFFFFFFFFFFFFFF */

//#define sz__MAX (~(size_t)0) /* forked, from `SIZE_MAX`, at `linux-master/tools/virtio/ringtest/ptr_ring.c`, on 2023-3-16 */
#define sz__MAX SIZE_MAX
#define ptr__MAX UINTPTR_MAX

#define s8__MAX INT8_MAX /* 0x7F */
#define s16__MAX INT16_MAX /* 0x7FFF */
#define s32__MAX INT32_MAX /* 0x7FFFFFFF */
#define s64__MAX INT64_MAX /* 0x7FFFFFFFFFFFFFFF */

#define s8__MIN INT8_MIN
#define s16__MIN INT16_MIN
#define s32__MIN INT32_MIN
#define s64__MIN INT64_MIN

#define u8__WIDTH__RADIX__2 UINT8_WIDTH
#define u16__WIDTH__RADIX__2 UINT16_WIDTH
#define u32__WIDTH__RADIX__2 UINT32_WIDTH
#define u64__WIDTH__RADIX__2 UINT64_WIDTH

#define sz__WIDTH__RADIX__2 SIZE_WIDTH
#define ptr__WIDTH__RADIX__2 UINTPTR_WIDTH

#define u8__WIDTH__RADIX__10 3
#define u16__WIDTH__RADIX__10 5
#define u32__WIDTH__RADIX__10 10
#define u64__WIDTH__RADIX__10 20

#define u8__WIDTH__RADIX__16 2
#define u16__WIDTH__RADIX__16 4
#define u32__WIDTH__RADIX__16 8
#define u64__WIDTH__RADIX__16 16

/* following, are forked, from `linux-master/tools/virtio/ringtest/ptr_ring.c`, on 2023-3-16 */

#define uu__CONVERT__bool(i) \
	!!(i)

#define NULL__CONVERT__bool \
	uu__CONVERT__bool

#define attribute__expression__EXPECT(expr, res) __builtin_expect((expr), (res))
#define attribute__expression__EXPECT__TRUE(condition) attribute__expression__EXPECT(uu__CONVERT__bool(condition), 1)
/*
	original: `likely(x) (__builtin_expect(!!(x), 1))`
	`!!(expr)` is called "double negation"
		used to convert non-zero values, to 1(hence true), while 0 remain 0(false)
		example: `printf("%d(0), %d(!0), %d(!!0),  %d(1), %d(!1), %d(!!1),  %d(3), %d(!3), %d(!!3)" "\n", (0), (!0), (!!0),  (1), (!1), (!!1),  (3), (!3), (!!3));` / * output: `0(0), 1(!0), 0(!!0),  1(), 0(!1), 1(!!1),  3(3), 0(!3), 1(!!3)` * / */
#define attribute__expression__EXPECT__FALSE(condition) attribute__expression__EXPECT((condition), 0)
/* original: `unlikely(x) (__builtin_expect(!!(x), 0))` */

#define if__EXPECT__TRUE(condition) \
	if(attribute__expression__EXPECT__TRUE(condition))

#define if__EXPECT__FALSE(condition) \
	if(attribute__expression__EXPECT__FALSE(condition))

uu add__safe(
	uu a,
	uu b)/*
	forked, from `https://stackoverflow.com/questions/121240/how-to-do-unsigned-saturating-addition-in-c/124709#124709` */
{
	if__EXPECT__FALSE(b > (UINT32_MAX - a))
		return UINT32_MAX;
	else
		return (a + b);
}

uu add__safe__fast(
	uu a,
	uu b)/*
	actually, quite safe, and NOT fully safe
	forked, from `http://stackoverflow.com/questions/121240/how-to-do-unsigned-saturating-addition-in-c/166393#166393` */
{
	uu c = (a + b);
	if__EXPECT__FALSE(c < a)
		return ((uu)-1);
	else
		return c;
}

#define attribute__function__INLINE__ALWAYS __attribute__((always_inline))
#define inline__ALWAYS inline attribute__function__INLINE__ALWAYS
/*
	`inline`ing is not exactly the same as "type-checked, function-like macro"(or macro functions or routines),
		because c supports dynamic linking, so the functions could be called, even after the inlining
			but the body won't be found, since it has been inlined
			also the variables are isolated, hence not as efficient, but safe
		as checked from the assembly output through gcc-13, routines are
			more space efficient
			do not create variables (or fix-size memory block), but values are inlined in binary code, hence fastest access
		as found by comparision between `inline__ALWAYS void f(u16 value) { value += 1; }`, and `#define f(value) value += 1;`, using ```
#include <stdio.h>
int main(void_) {
	u16 v = 13;

	printf("%hu vs ", v);
	f(v);
	printf("%hu\n", v);

	return 0;
}
```
	function-to-routine algo
		rename the significant part of the function id, to upper-case; while keeping the domain, and types same
			example
				`by__array__cpy` to `by__array__CPY`
				`by__array__list__convert__by__arr` to `by__array__list__CONVERT__by__arr`
				`io__file__read__blocking` to `io__file__READ__BLOCKING`
		append the full id of the routine to the each, parameter, and local variable; separated by "__"(under-score *2)
			example
				`_domain__FUNCTION__(bys, count) { const count_ = (count -1); }`, to
					`_domain__FUNCTION__(bys___domain__FUNCTION__, count___domain__FUNCTION__) { const count____domain__FUNCTION__ = (count___domain__FUNCTION__ -1); }`
		append the '\'(back-slash) char to (the end of) each of the line, except the last one
			this is actually escaping all the line-feed chars, because the c-pre-processor uses line-feed is the de-limiter(or terminator) to directives
				so the cpp assumes the whole routine to be a single macro, if all the line-feed chars are escaped, and
					not escaping the last LF indicates the end of the routine
		find all the in-direct accesses, like pointers, and replace them with direct access
			because routine are purely in-place replacement, so everything accessible to the caller, is also to the callee
			example
				`*val = u8__MAX` to `val = u8__MAX`
		replace all the return statements with assignment to, one of the, parameters
			example
				`return res__FAILURE;` to `result = res__FAILURE;`
		re-understand the whole calling context, because a simple find-and-replace could break the system

	`inline__ALWAYS res history__log(char *file__path, const char *format, int segment_count, ...);` function
	can be converted to a macro-function as
	`#define HISTORY__LOG(\
		/ *res* / result__HISTORY__LOG,\
		/ *char ** /file__path__HISTORY__LOG,\
		/ *const char ** /format__HISTORY__LOG,\
		/ * dynamic * /...) \
	{ log(history__file__path, format, __VA_ARGS__); }`
	`__HISTORY__LOG` is appended to all the `parameter`s' ids, to prevent
	any of the symbols(functions, and variables), present(not only declared) in `HISTORY__LOG` to match any parameter's id, for example
	suppose `HISTORY__LOG` has a variable, `int fp`, declared, in the 1st line, of its body, before `log(` function; and 
	`HISTORY__LOG` is called, with an argument variable, named `fp` as `file__path`; then
	the `log(` function will not be passed with `file__path` as it should have been, but the `int`eger `fp`; which will break the system,
	this is a simple case, and will be caught by the compiler, because of the data-type mis-match, but suppose some complex happening takes place, in this or any other macro-function, where
	the types match; then boom, may be a security vulnerability has been created, even abort is an optimistic hope in that situation
	even this macro-function is vulnerable, in the form of `log(` function, as `log(log, format, __VA_ARGS__);`; but the author are helpless. also,
	if the code, calling this macro-function, has a variable named `log`, thats again a problem; and even bigger if the variable is function-like(maybe nested function), with
	similar parameter list; then boom, once again. all these problems can be mitigated(to an extent), by
	keeping a check on the "pre-process"ed output of the code; to stop the compilation process at pre-process stage, use `gcc -E` */

#define attribute__function__FAST_UP __attribute__((hot))
#define attribute__function__SLOW_DOWN __attribute__((cold))

/*
	ANY result(or return) value, other than `EXIT_SUCCESS`(which is 0),
		should be considered(and assumed) an error,
			and the value as a private `errno`,
				as to keep the `errno.h` provided `errno`, separate, isolated, and independent,
					from the program's "error management" implementation

	these defines are merely to prevent the hardcoding, of `EXIT_FAILURE`(which is 1), and `EXIT_SUCCESS`, as return value */
#define res__SUCCESS EXIT_SUCCESS
#define res__FAILURE/*\
	not every function(and function-like macros, called "routines", in this code base), return failure(like an error),\
		the statements which do NOT have any point of failure, return nothing(like `void` functions), which is implicit success\
\
	examples:\
		the `man`ual pages, of `gettimeofday`, and `settimeofday`,\
			are merged(and not separate, for both),\
			and almost, of the errors, mentioned at "ERRORS" section of the page, are `settimeofday` specific, either,\
				or, are NOT applicable to out implementation, because of NOT using the features, errors are applicable for\
		the `man`ual page, of `time`,\
			clearly mentions, at both "RETURN VALUE", and "ERRORS" sections,\
			that error(s) can happen, but\
			the `BUGS` section reads "When `tloc` is NULL, the call cannot fail.",\
				which is also the the case with out implementation, hence we are immune to errors here */ EXIT_FAILURE

/*
	`params`:
		in-parentheses, 
			1 indexed, 
			comma separated; 
			index-of parameter(s), 
			expected to NOT be `NULL`
	
	example:

		`int function(int *p1, int *p2, int *p3) _EXPECT_NON__NULL_((1, 3));`,
			`p1`, and `p3` can NOT be `NULL`
			`p2` parameter can(and should be expected to) be `NULL`, but

		`int function1(int *p1, int *p2) _EXPECT_NON__NULL_((2));`,
			`p1` parameter can be `NULL`, but
			`p2` can NOT be `NULL`
	
	docs: 
		`https://gcc.gnu.org/onlinedocs/gcc-4.7.2/gcc/Function-Attributes.html`, 
			then find-in-page for "nonnull"

	forked from `__attribute_nonnull__` */
//#define _NON_NULL(params) __attribute__ ((__nonnull__ params))

#define STRING__BLANK ""
#define empty__string STRING__BLANK
#define STRING__ERROR "***ERROR***"

/*
	const res result, const ch *format, dynamic ...

	`strerrordesc_np` is strictly `en_US`, and returns `const ch *`,
		while `strerror` is locale(or language) dependent, and returns `char *` */
#define print__ERROR(result, format, ...) \
	fprintf(stderr,\
		STRING__ERROR "  " "%u(`%s`, \"%s\")(error), "\
		"at \"%s\"::\"%s\"#%u, "\
		format "\n",\
		result, strerrorname_np(result), strerrordesc_np(result),\
		__FILE__/*const char filePath[]*/, __FUNCTION__/*const char functionId[]*/, __LINE__/*const uu lineId*/,\
		__VA_ARGS__);\

#define print__ERROR__ABORT(result, format, ...) {\
	print__ERROR(result, format, __VA_ARGS__) \
	abort();\
}

#define RETURN__CONVERT__res(return_value) \
	(((return_value) < 0) \
		? errno \
		: res__SUCCESS)

#define res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, format, ...) \
	if(result) \
		print__ERROR__ABORT(result, format, __VA_ARGS__)

#define res__CHECK__SUCCESS__ELSE__REPORT__BASIC__ABORT(result) \
	res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, empty__string, NULL)

#define _TEST__COMPARE__SIZE(a, b) \
	if(sizeof(a) != sizeof(b)) \
		print__ERROR__ABORT(0, "`sizeof(" #a ") != sizeof(" #b ")`", NULL)

#define TEST {\
	if(__WORDSIZE != 64) \
		print__ERROR__ABORT(0, "`WORDSIZE != 64`", NULL)\
\
	if(__BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__) \
		print__ERROR__ABORT(0, "`BYTE_ORDER != LITTLE_ENDIAN`", NULL)\
\
	if(!_LARGEFILE64_SOURCE) \
		print__ERROR__ABORT(0, /*"either `LARGE_FILE_64_SUPPORT != 1`, or `FILE_OFFSET_WIDTH != 64`,\n"*/\
			"`LARGE_FILE_64_SUPPORT != 1`,\n"\
			"\tshould have been correct, by-default, on 64 word-size systems, with `_GNU_SOURCE`,\n"\
			"\t\tas could be seen from the definition, of `_LARGEFILE64_SOURCE`,\n"\
			"\tcould be fixed, by defining it, and `_FILE_OFFSET_BITS` as `64` manually", NULL)\
\
	_TEST__COMPARE__SIZE(uintptr_t, u64) \
	_TEST__COMPARE__SIZE(size_t, u64) \
	_TEST__COMPARE__SIZE(uintmax_t, u64) \
	_TEST__COMPARE__SIZE(loff_t, u63) \
}

#define res__RE_SET(result__res__RE_SET) \
	result__res__RE_SET = res__SUCCESS;

#define res__CREAT(result__res__CREAT) \
	res__RE_SET(res result__res__CREAT)
/*
	id result
		identifier of the variable to create */

#define NULL__CHECK(ptr) \
	/*((ptr) == NULL)*/ !(ptr)

#define NULL__CHECK__NOT(ptr) \
	/*((ptr) != NULL)*/ NULL__CONVERT__bool(ptr)

#define mem__ALLOC__ARRAY(ptr, count) \
	if(NULL__CHECK(ptr = malloc(count * sizeof(*ptr)))) \
		print__ERROR__ABORT(errno, "`malloc(%ju * %zu)` failure", count, sizeof(*ptr))
/*
	void *ptr: ret, mod
	u63 count
		number of elements, not bytes

	`(count * sizeof(*ptr))` MUST NOT be greater than `PTRDIFF_MAX`(which is equal to `INT64_MAX`, on 64 word sized computers)
*/

#define mem__ALLOC(ptr) \
	mem__ALLOC__ARRAY(ptr, 1)

#define mem__FREE(ptr) \
	free(ptr); /*ptr = NULL;*/
/* void *ptr */

#endif
