#include "basic.h"
#include "io.h"
#include "by__arr.h"

/*
	program
		args
			str file__path
			u63 {offset|file__offset|file__position}?
			u63 {count|file__count|file__size}? */
int main(int const args__count/* number of arguments */,
	char const * const * const args/* value of arguments */)
{
	//printf("%d(args__count)\n", args__count);

	ch const * const file__path = args[1];

	res__CHECK__SUCCESS__ELSE__REPORT__ABORT(\
		io__file__EXISTS__PATH(file__path), \
		"`io__file__EXISTS__PATH`ing \"%s\"; maybe, the file does NOT exist", \
		file__path)

	u63
		offset = ((args__count > 2)
			? strtol(args[2], NULL, 10)
			: 0),
		count,
		count_;

	res__CREAT(result)

	if(args__count > 3)
		count = strtol(args[3], NULL, 10);
	else {
		io__file__SIZE__PATH(result, count/*file__size*/, file__path)
		res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, "`io__file__SIZE__PATH`ing \"%s\"", file__path)

		count -= offset;
	}

	printf("%ju(offset)"
		", %ju(count)",
		offset,
		count);

	int fd;

	io__file__OPEN__READ_ONLY(result, file__path, fd)
	res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, "`io__file__OPEN__READ_ONLY`ing \"%s\"", file__path)

	by *file__bys;
	mem__ALLOC__ARRAY(file__bys, count)

	count_ = count;
	io__READ__BLOCKING(result, fd, file__bys, count_, offset)
	if__EXPECT__FALSE(result == io__file__res__END) {
		puts("provided `count` exceeds the `file__size`");
		count -= count_;
	} else
		res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, "`io__READ__BLOCKING`ing \"%s\"", file__path)

	by__array__PRINT(file__bys, count)

	return EXIT_SUCCESS;
}
