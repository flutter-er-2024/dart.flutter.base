#include "basic.h"
#include "by__arr.h"
#include "io.h"
#include "string.h"

/* UN-TESTED program */

/*
	mk-cpp-out-human-rdble
		make c-pre-processor's output, to be human readable */

#define FIRST__STATEMENT "\ntypedef uint8_t u8;"

/*
	program
		args
			str file__path */
int main(int args__count,
	char **args)
{
	ch
		*file__path,
		*file__path__new;

	uu
		file__path__count,
		file__bys__iter,
		file__bys__offset,
		file__new__bys__count,
		file__new__bys__iter;

	u63
		file__offset,
		file__bys__count;

	by
		*file__bys,
		*file__new__bys;

	int
		fd,
		fd__new;

	u1 b__complete = 0;

	res__CREAT(result)


	io__file__OPEN__READ_ONLY(result, (file__path = args[1]), fd)
	res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, "`open`ing the file, at path \"%s\"", file__path)

	mem__ALLOC__ARRAY(file__bys, io__BUFFER__SIZE)

	const ch 
		FIRST__STATEMENT__char = FIRST__STATEMENT[0],
		FIRST__STATEMENT__char_ = FIRST__STATEMENT[1],
		*FIRST__STATEMENT__str = FIRST__STATEMENT,
		*FIRST__STATEMENT__str__part = (2 + FIRST__STATEMENT__str);

	printf("\"%s\"(FIRST__STATEMENT__str)"
		", \"%s\"(FIRST__STATEMENT__str__part)"
		", '%c'(FIRST__STATEMENT__char)"
		", '%c'(FIRST__STATEMENT__char_)"
		"\n",
		FIRST__STATEMENT__str,
		FIRST__STATEMENT__str__part,
		FIRST__STATEMENT__char,
		FIRST__STATEMENT__char_);

	uu FIRST__STATEMENT__str__part__count;
	string__CHARS__COUNT(FIRST__STATEMENT__str__part, FIRST__STATEMENT__str__part__count)



	label__find__offset:

	file__bys__count = io__BUFFER__SIZE;
	io__READ__BLOCKING(result, fd, file__bys, file__bys__count, file__offset)

	if(attribute__expression__EXPECT__FALSE(result == io__file__res__END)) {
		b__complete = 1;
		res__RE_SET(result)

		file__bys__count = (io__BUFFER__SIZE - file__bys__count);
	} else {
		res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, "`read`ing the file, at path \"%s\"", file__path)

		file__bys__count = io__BUFFER__SIZE; }

	file__bys__iter = 0;
	while(file__bys__iter < file__bys__count) {
		if(attribute__expression__EXPECT__FALSE(file__bys[file__bys__iter++] == FIRST__STATEMENT__char) &&
			attribute__expression__EXPECT__FALSE(file__bys[file__bys__iter++] == FIRST__STATEMENT__char_)) {
			if__EXPECT__FALSE(!(result = by__array__cmp((file__bys__iter + file__bys), FIRST__STATEMENT__str__part, FIRST__STATEMENT__str__part__count))) {
				file__offset += (file__bys__iter -1)/* set to `FIRST__STATEMENT__char_` */;
				printf("%ju(file__offset__logical)\n", file__offset);

				goto label__process;
			} else
				res__RE_SET(result) } }

	if(attribute__expression__EXPECT__FALSE(b__complete)) {
		printf("file(at path \"%s\")'s end, encountered"
			", before the processing stage, of user-written source-code;"
			" hence nothing to process\n",
			file__path);

		mem__FREE(file__bys)
		return EXIT_SUCCESS;
	} else {
		file__offset += io__BUFFER__SIZE;
		goto label__find__offset; }



	label__process:

	string__CHARS__COUNT(file__path, file__path__count)
	mem__ALLOC__ARRAY(file__path__new, (file__path__count + 3/* replace "*.i" with "*.1.i", in `file__path` */))
	by__array__cpy(file__path__new, file__path, (file__path__count -= 1));
	strcpy((file__path__new + file__path__count), "1.i");

	printf("\"%s\"((char[%zu])file__path__new)\n",
		file__path__new,
		strlen(file__path__new));

	io__file__OPEN__WRITE_ONLY__CREATE__TRUNCATE__APPEND(result, file__path__new, fd__new)
	res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, "`open`ing the file, at path \"%s\"", file__path__new)

	mem__ALLOC__ARRAY(file__new__bys, io__BUFFER__SIZE)



	label__process__loop:

	file__bys__count = io__BUFFER__SIZE;
	io__READ__BLOCKING(result, fd, file__bys, file__bys__count, file__offset)

	if(attribute__expression__EXPECT__FALSE(result == io__file__res__END)) {
		b__complete = 1;
		res__RE_SET(result)

		file__bys__count = (io__BUFFER__SIZE - file__bys__count);
	} else {
		res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, "`read`ing the file, at path \"%s\"", file__path)

		file__bys__count = io__BUFFER__SIZE; }

	file__bys__offset = 0;

	u1 b__pre_processor_directive = 0;

	file__new__bys__iter = 0;

	file__bys__iter = 0;
	while(file__bys__iter < file__bys__count) {
		putchar(file__bys[file__bys__iter]);
		if(attribute__expression__EXPECT__FALSE(file__bys[file__bys__iter++] == '\n')) {
				if(b__pre_processor_directive) {
					b__pre_processor_directive = 0;
					file__bys__offset = file__bys__iter;

					puts("setting offset"); }

				if__EXPECT__FALSE((file__bys[file__bys__iter] == '#') &&
					!b__pre_processor_directive) {
						b__pre_processor_directive = 1;

						if((file__new__bys__count = (file__bys__iter - file__bys__offset))) {
							puts("flushing");

							by__array__cpy(
								(file__new__bys__iter + file__new__bys),
								(file__bys__offset + file__bys),
								file__new__bys__count);

							file__new__bys__iter += file__new__bys__count; } } } }

	io__WRITE__APPEND__BLOCKING(result, fd__new, file__new__bys, file__new__bys__iter/*count*/)
	res__CHECK__SUCCESS__ELSE__REPORT__ABORT(result, "`io__WRITE__APPEND__BLOCKING`ing the file, at path \"%s\"", file__path__new)

	mem__FREE(file__new__bys);

	if(attribute__expression__EXPECT__FALSE(b__complete)) {
		mem__FREE(file__bys)

		printf("processed the file \"%s\" successfully"
			", and saved the result, in the file \"%s\"\n",
			file__path,
			file__path__new);

		mem__FREE(file__path__new)

		return EXIT_SUCCESS;
	} else {
		file__offset += io__BUFFER__SIZE;
		goto label__process__loop; }

	print__ERROR__ABORT(0, "reached the end of main; this should NOT have happended", NULL)
}
