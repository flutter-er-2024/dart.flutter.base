#include "/home/w/projects/tree/_/c/src/9.io.data-base.h"

#define FILE_PATH "/tmp/f"

#define FILE_SIZE (1024 * 1024 * 1024 * 5UL)

int
	*DATABASE__fDs,
	DATABASE__fD;

uu DATABASE__publicHeapPosition;

struct _DATABASE__TRANSACTION _DATABASE__transaction;

#define bINITIALIZE 1

#define PRINT_HEAP_POSITION(message) \
	printf("%lu(DATABASE__publicHeapPosition), " message "\n", DATABASE__publicHeapPosition);

// rm -r /tmp/f* && clear && gcc -o /tmp/p.bin /home/w/projects/tree/_/c/src/testing.db.c && /tmp/p.bin
int main(void_) {
	printf(
		"\t\t"								"\toffset\t[:size]\t[:rowSize]\n"
		"`primaryTable`:"			"\t\t%ld,\t%ld,\t%ld\n"
		"`prsrvdDtaCnt`:"			"\t\t%ld,\t%ld\n"
		"`prsrvdDtaTbl`:"			"\t\t%ld,\t%ld,\t%ld\n"
		"`heapPosition`:"			"\t\t%ld,\t%ld\n"
		"`publicHeap`:  "			"\t\t%ld\n",
		DATABASE__PRIMARY_TABLE__OFFSET, DATABASE__PRIMARY_TABLE__SIZE, DATABASE__PRIMARY_TABLE__ROW__SIZE,
		DATABASE__PRESERVED_DATA__COUNT__OFFSET, DATABASE__PRESERVED_DATA__COUNT__SIZE,
		DATABASE__PRESERVED_DATA__TABLE__OFFSET, DATABASE__PRESERVED_DATA__TABLE__SIZE, DATABASE__PRESERVED_DATA__TABLE__ROW__SIZE,
		DATABASE__PUBLIC_HEAP_POSITION__OFFSET, DATABASE__PUBLIC_HEAP_POSITION__SIZE,
		DATABASE__OFFSET__HEAP__PUBLIC);

	RESULT__INIT(res)

	char *filePaths[] = {
		(FILE_PATH "1"),
		(FILE_PATH "2"),
		(FILE_PATH "3")};

	{
		MEM__ALLOC__ARRAY(DATABASE__fDs, TRANSACTION__SAFE_COPY_COUNT)

		int fD;

		uu i = TRANSACTION__SAFE_COPY_COUNT;
		while (i--) {
			CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(
				(fD = DATABASE__fDs[i] = FILE__open__READ_WRITE__CREATE(filePaths[i])),
				"`FILE__open__READ_WRITE__CREATE`ing \"%s\"", filePaths[i])

			printf("%d(\"%s\"'s `fD`)\n", fD, filePaths[i]);

			if (bINITIALIZE) {
				printf("`FILE__reSize`ing file to %lu bytes.\n", FILE_SIZE);

				CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(
					FILE__reSize(fD, FILE_SIZE),
					"`FILE__reSize`ing", 0)
			}
		}

		DATABASE__fD = DATABASE__fDs[0];
	}

	{
		by *buf;
		uu offset = DATABASE__OFFSET__HEAP__PUBLIC;
		uu count = 32;

		MEM__ALLOC__ARRAY(buf, 32)
		BYTES__SET(buf, 97, 32)
		_DATABASE__WRITE(res, offset, buf, 32)
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
		MEM__FREE(buf)

		FILE_SYSTEM__PRINT(res, DATABASE__fD, DATABASE__OFFSET__HEAP__PUBLIC, 64, "clean-set data:")
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)

		FILE_SYSTEM__PRINT(res, DATABASE__fD, 8192, 64, "preserved data (before):")
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)

		DATABASE__TRANSACTION__INITIALIZE

		{
			count = 7;
			MEM__ALLOC__ARRAY(buf, count)
			BYTES__SET(buf, 98, count)
			_DATABASE__WRITE__RELIABLE(res, offset, buf, count)
			CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
			offset += count;
		}

		{
			count = 13;
			MEM__ALLOC__ARRAY(buf, count)
			BYTES__SET(buf, 99, count)
			_DATABASE__WRITE__RELIABLE(res, offset, buf, count)
			CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
			offset += count;
		}

		FILE_SYSTEM__PRINT(res, DATABASE__fD, 8192, 64, "preserved data (in-between):")
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)

		{
			count = 6;
			MEM__ALLOC__ARRAY(buf, count)
			BYTES__SET(buf, 100, count)
			_DATABASE__WRITE__RELIABLE(res, offset, buf, count)
			CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
			offset += count;
		}

		{
			count = 6;
			MEM__ALLOC__ARRAY(buf, count)
			BYTES__SET(buf, 101, count)
			_DATABASE__WRITE__RELIABLE(res, offset, buf, count)
			CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
			offset += count;
		}

		FILE_SYSTEM__PRINT(res, DATABASE__fD, 8192, 128, "preserved data (after):")
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)

		FILE_SYSTEM__PRINT(res, DATABASE__fD, DATABASE__OFFSET__HEAP__PUBLIC, 64, "reliably written data (before writing):")
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)

		DATABASE__TRANSACTION__COMPLETE(res)
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)

		FILE_SYSTEM__PRINT(res, DATABASE__fD, DATABASE__OFFSET__HEAP__PUBLIC, 64, "reliably written data (after):")
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
	}
/*
	{
		DATABASE__READ(res, DATABASE__PUBLIC_HEAP_POSITION__OFFSET, buf, DATABASE__PUBLIC_HEAP_POSITION__SIZE)
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
		BYTES__PRINT(buf, 32)

		PRINT_HEAP_POSITION("before init")

		if (bINITIALIZE) {
			DATABASE__publicHeapPosition = DATABASE__OFFSET__HEAP__PUBLIC;
			_DATABASE__WRITE__RELIABLE(res, DATABASE__PUBLIC_HEAP_POSITION__OFFSET, &DATABASE__publicHeapPosition, DATABASE__PUBLIC_HEAP_POSITION__SIZE)
			CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
		} else {
			DATABASE__INITIALIZE__HEAP_POSITION__PUBLIC(res)
			CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
		}

		PRINT_HEAP_POSITION("after init")

		DATABASE__READ(res, DATABASE__PUBLIC_HEAP_POSITION__OFFSET, buf, DATABASE__PUBLIC_HEAP_POSITION__SIZE)
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
		BYTES__PRINT(buf, 32)
	}

	{
		const uu heapPosition = DATABASE__publicHeapPosition;

		PRINT_HEAP_POSITION("before creating table")
		DATABASE__WRITE__HEAP__APPEND(res, NULL, 96)
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
		PRINT_HEAP_POSITION("after creating table")

		by *copyBuffer = &heapPosition;
		BYTES__CPY(buf, copyBuffer, DATABASE__PUBLIC_HEAP_POSITION__SIZE)

		const uu count = U64__MAX;
		copyBuffer = &count;
		BYTES__CPY((buf + DATABASE__PUBLIC_HEAP_POSITION__SIZE), copyBuffer, SIZE__U64)

		DATABASE__WRITE__TABLE__ROW(res, DATABASE__PRIMARY_TABLE__OFFSET, 0, DATABASE__PRIMARY_TABLE__ROW__SIZE, buf, DATABASE__PRIMARY_TABLE__ROW__SIZE, 0)
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
	}

	{
		BYTES__SET(buf, 97, 13)
		puts("writing the following bytes");
		BYTES__PRINT(buf, 13)

		PRINT_HEAP_POSITION("before writing")
		DATABASE__WRITE__HEAP__APPEND(res, buf, 13)
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
		PRINT_HEAP_POSITION("after writing")
	}

	{
		BYTES__SET(buf, 98, 7)
		puts("writing the following bytes");
		BYTES__PRINT(buf, 7)

		PRINT_HEAP_POSITION("before writing")
		DATABASE__WRITE__HEAP__APPEND(res, buf, 7)
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)
		PRINT_HEAP_POSITION("after writing")
	}
*/
	//DATABASE__WRITE__RELIABLE(res, fDs, 0, buf, DATABASE__PRIMARY_TABLE__SIZE)

	/*CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(\
		FILE_SYSTEM__close(fD),\
		"`FILE_SYSTEM__close`ing \"%s\"",\
		FILE_PATH)*/

	return EXIT_SUCCESS;
}
