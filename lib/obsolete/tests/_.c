#include "data-structures/byte-array.h"
#include "data-structures/table.row-oriented.h"

#define FILE_COUNT 3

size_t sizeOfTable;

void initTableVars() { sizeOfTable = sizeof(Table); }

int openFiles (char *filePath,
			   u64 specialIndex,
			   int *fDs)
{
	u64 lastFile = (FILE_COUNT -1);

	for (u64 i = 0; i < lastFile; *(filePath + specialIndex) = (48 + (i += 1)))
	{
		if ((*(fDs + i) = open(filePath, O_RDWR)) == INDICATE_FAILURE) {
			REGISTER_TIME
			REGISTER_INFO(filePath, "filePath");
			REGISTER_ERR("open(filePath)");

			return INDICATE_FAILURE;
		}
	}

	if (openBlockingFile(filePath,
						 (fDs + lastFile)) == INDICATE_FAILURE) {
			REGISTER_TIME
			REGISTER_INFO(filePath, "filePath");
			REGISTER_ERR("openBlockingFile(filePath)");

		return INDICATE_FAILURE;
	}

	return EXIT_SUCCESS;
}

int writeFiles (int *fDs,
				u8 *bytes,
				u64 byteCounter,
				u64 byteCount)
{
	u64
		savedByteCounter = byteCounter,
		savedByteCount = byteCount;

	ssize_t result;

	u64 i = 0;
	while (i++ < FILE_COUNT) {
		do {
			result = write(*fDs++,
						   (bytes + byteCounter),
						   byteCount);

			if(result == INDICATE_FAILURE) {
				return INDICATE_FAILURE;
			}

			byteCounter += result;
			byteCount -= result;
		} while (byteCount != 0);

		byteCounter = savedByteCounter;
		byteCount = savedByteCount;
	}

	return EXIT_SUCCESS;
}

void printBytes (u8 * bytes,
				 u64 byteCount)
{
	printf("\n\n%lu bytes:",
		   byteCount);

	u64 i = 0;
	while (i < byteCount) {
		printf("\n%lu\t%hu",
			   i++,
			   *bytes++);
	}

	putchar('\n');
}

/**

  allocate ,initialize, and return a new variable of type `Table`

  - `indexFilePath`:
    absolute filePath to the file, which is intended to be used as index for the
  table

  - `dumpFilePath`:
    absolute filePath to the file, intended to be used as the heap for the array
  data of the table, is similar to heap, in the sense that, the beginning of
  data, acts as an address, should have the capacity, to be able to store the
  amount of data, intended to be stored currently, and in future altough,
  in-future scalibility is very simple and easy, and especially not-at-all hard

  - `identifier`:
    a descripter used to relate and differentiate different files of a table
    should NOT be exactly same as some other table's `identifier`

    - `0`: automatically use the timestamp, with nano seconds precision

 */
int createTable (char *filePath,
				 u64 specialIndex)
{
#define TABLE_CREATION_FILE_FLAGS (O_WRONLY | O_CREAT | O_EXCL | O_DSYNC | O_TRUNC)
#define TABLE_CREATION_FILE_MODES (S_IRUSR | S_IWUSR /* `| S_IRGRP | S_IWGRP` */)

	u64
		byteCount,
		byteCounter;

	u8 *bytes;

	{
		int fDs[FILE_COUNT];

		for (u64 i = 0; i < FILE_COUNT;
			filePath[specialIndex] = (i += 1)) {
			if ((fDs[i] = open (filePath,
								TABLE_CREATION_FILE_FLAGS,
								TABLE_CREATION_FILE_MODES)) == INDICATE_FAILURE) {
				REGISTER_TIME
				REGISTER_INFO(filePath, "filePath");
				REGISTER_ERR("open(filePath)");

				return INDICATE_FAILURE;
			}
		}

		byteCount = (u8__size/** table version (or protocol identifier) */
						+ u64__size /** `rowCount` */);

		CHECK_VOID_SAFE((bytes = malloc(byteCount)), "`bytes=malloc()`");

		byteCounter = 0;

		*(bytes + byteCounter++) = TABLE_VERSION;
		*(u64 *)(bytes + byteCounter) = 0;

		printBytes(bytes, byteCount);

		if(writeFiles (fDs,
					   bytes,
					   0,
					   byteCount) == INDICATE_FAILURE) {
				REGISTER_TIME
				REGISTER_ERR("writeFiles()");

			return INDICATE_FAILURE;
		}

		FREE_MEM(bytes);


/*/ **
	pre allocation, for better performance, like array

	TO DO: add error checking
* /
		int truncRes = ftruncate(fD, expectedIndexFileSize);*/

		u64 i = 0;
		while (i < FILE_COUNT) {
			int res = close(fDs[i++]);

			if ((res != EXIT_SUCCESS) || (res == INDICATE_FAILURE)) {
				REGISTER_TIME
				REGISTER_ERR("close()");

				return INDICATE_FAILURE;
			}
		}
	}

	{
		int fDs[FILE_COUNT];

		for (u64 i = 0, _specialIndex/** index of heap indicator 'h', suffied to each heap file, not file extension */ = (strlen (filePath) -2);
			 i < FILE_COUNT; i += 1) {
			filePath[specialIndex] = i;
			filePath[_specialIndex] = 'h';

			if ((fDs[i] = open (filePath,
								TABLE_CREATION_FILE_FLAGS,
								TABLE_CREATION_FILE_MODES)) == INDICATE_FAILURE) {
				REGISTER_TIME
				REGISTER_INFO(filePath, "filePath");
				REGISTER_ERR("open(filePath)");

				return INDICATE_FAILURE;
			}
		}

		byteCount = (2 * u64__size)/** byteCount(or byteCounter, total number of bytes stored (including `discardedByteCount`)),
										  discardedByteCount(total, of size, of discarded arrays) */;

		CHECK_VOID_SAFE((bytes = calloc(0, byteCount)), "`bytes=calloc()`");

		byteCounter = 0;

		if(writeFiles (fDs,
					   bytes,
					   0,
					   byteCount) == INDICATE_FAILURE) {
			REGISTER_TIME
			REGISTER_ERR("writeFiles()");

			return INDICATE_FAILURE;
		}

		FREE_MEM(bytes);

		u64 i = 0;
		while (i < FILE_COUNT) {
			int res = close(fDs[i++]);

			if ((res != EXIT_SUCCESS) || (res == INDICATE_FAILURE)) {
				REGISTER_TIME
				REGISTER_ERR("close()");

				return INDICATE_FAILURE;
			}
		}
	}

  /*printf("%ld(indexFileDescripter.SEEK_SET), %ld(dumpFileDescripter.SEEK_SET)\n",
         lseek(indexFileDescripter, 0, SEEK_CUR),
         lseek(dumpFileDescripter, 0, SEEK_CUR));*/

	return EXIT_SUCCESS;
}

/*int initializeTable (Table *table,
					 char ***filesPath)
{

	const int fileFlags = (O_RDWR | O_DSYNC);

	u64
	byteCount,
	byteCounter;

	u8 * bytes;

	{
		(*table).indexFD = open(indexPath, fileFlags);

		registerValue("table.indexFD", (*table).indexFD);

		if ((*table).indexFD == INDICATE_FAILURE) {
			registerError("open(indexPath,...)", (*table).indexFD);

			return INDICATE_FAILURE;
		}

		byteCount = (u8__size + (2 * u64__size));

		if (readFile((*table).indexFD,
			&bytes,
			0,
			byteCount) == INDICATE_FAILURE) {
			registerError("readFile(table.indexFD,...)", INDICATE_FAILURE);

		return INDICATE_FAILURE;
			}

			printBytes(bytes, byteCount);

			byteCounter = 0;

			free(bytes);
	}

	{
		(*table).heapFD = open(heapPath, fileFlags);

		registerValue("table.heapFD", (*table).heapFD);

		if ((*table).heapFD == INDICATE_FAILURE) {
			registerError("open(heapPath,...)", (*table).heapFD);

			return INDICATE_FAILURE;
		}

		byteCount = (u8__size + (3 * u64__size));

		if (readFile((*table).heapFD,
			&bytes,
			0,
			byteCount) == INDICATE_FAILURE) {
			registerError("readFile(table.heapFD,...)", INDICATE_FAILURE);

		return INDICATE_FAILURE;
			}

			printBytes(bytes, byteCount);

			byteCounter = 0;

			free(bytes);
	}

	//table.columnCount = columnCount;

	//table.arrayColumns = malloc((columnCount * sizeOfUint8));

	return EXIT_SUCCESS;
}*/

int
main(void_)
{
	initBasicVars("/tmp/history.log");
	initTableVars();
	initByteArrayVars();

	char
		path[] = "/tmp/0_tj",
		*filePath;

	CHECK_VOID_SAFE((filePath = malloc((strlen(path) * SIZE_CHAR))), "`filePath=malloc()`");

	strcpy(filePath, path);

	int fDs[FILE_COUNT];

	printf("\n%d(openFiles())",
		   openFiles(filePath, 5, fDs));

	for (u64 i = 0; i < FILE_COUNT; i+=1) {
		printf("\n%d(fDs[%lu])", fDs[i], i);
	}


	/*printf("\n%d(createTable())",
		   createTable(filePath,
					   5));*/

	//Table table;
	//printf("\n%d(initializeTable())", initializeTable(&table, filesPath));

	putchar('\n');
	return EXIT_SUCCESS;
}

int serializeTableColumnSpecification(u8 * result,
									  u8 elementSize,
									  u8 isArray,
									  u8 isSearchOptimized)
{
	*result = ((elementSize == u8__size) /* byte */
	? 0
	: ((elementSize == u16__size)
	? 1
	: ((elementSize == u32__size) /* `int` */
	? 2
	: ((elementSize == u64__size)
	? 3
	: 128))));

	if (*result == 128) {
		REGISTER_TIME
		REGISTER_VAL(elementSize, "elementSize");
		REGISTER_ERR("(*result==128)");

		return INDICATE_FAILURE;
	}

	if (isArray) {
		*result |= tableColumnArrayFlag;
	}

	if (isSearchOptimized) {
		*result |= tableColumnSortFlag;
	}

	return EXIT_SUCCESS;
}

uint8_t *deSerializeColumnSpecification(uint8_t serializedByte) {
	uint8_t *result = malloc((3 * u8__size));
	CHECK_VOID_SAFE(result, "`result=malloc()`");

	if ((serializedByte & 1) == 1) {
		if ((serializedByte & 2) == 2) {
			*result = u32__size;
		} else {
			*result = u64__size;
		}
	} else {
		if ((serializedByte & 2) == 2) {
			*result = u16__size;
		} else {
			*result = u8__size;
		}
	}

	*(result + 1) = ((serializedByte & 4) == 4);

	*(result + 2) = ((serializedByte & 8) == 8);

	return result;
}
#include "/home/w/projects/tree/_/c/src/2.codes.h"

#define ALIGNMENT 4096
#define SIZE (8 * ALIGNMENT)

int main() {
	void *ptr;
	
	/*ptr = aligned_alloc(ALIGNMENT, SIZE);
	printf("%p\n%ju\n%ju\n%s\n\n",
		ptr,
		ptr,
		(uintptr_t)ptr,
		integerAsRadixString((uintptr_t)ptr, 2));
	free(ptr);

	posix_memalign(&ptr, ALIGNMENT, SIZE);
	printf("%p\n%ju\n%ju\n%s\n\n",
		ptr,
		ptr,
		(uintptr_t)ptr,
		integerAsRadixString((uintptr_t)ptr, 2));
	free(ptr);*/

	ptr = malloc(SIZE);
	printf("%p\n%ju\n%ju\n\n",
		ptr,
		ptr,
		(uintptr_t)ptr);

	uintptr_t
		position/** `offset`, `p` */ = (uintptr_t)(3 * ALIGNMENT)/* `ptr` */,
		newPosition/** n */ = (p + SIZE),
		pAlignedBlock = ((position >> 12/** number of zeros, at the end of 4096's binary representation */) << 12),
		pAlignedBlockEfficient = (position & ~0xfff),
		nAlignedBlock = ((position + SIZE) - (pAlignedBlock + SIZE)),
		nAlignedBlockEfficient = (position - pAlignedBlock),
		uAlignedBefore = (ALIGNMENT - nAlignedBlock),
		uAlignedAfter = (newPosition - position);

	printf("%ju(pAlignedBlock)  MUST EQUAL  %ju(pAlignedBlockEfficient)", pAlignedBlock, pAlignedBlockEfficient);
	printf("%ju(nAlignedBlock)  MUST EQUAL  %ju(nAlignedBlockEfficient)", nAlignedBlock, nAlignedBlockEfficient);

	printf(
		"%ju\n%ju\n%ju\n"
		"%ju\n%ju\n%ju\n"
		"\n",
		pAlignedBlock, uAlignedBefore, position,
		nAlignedBlock, uAlignedAfter, newPosition);

	free(ptr);
}
#include "/home/w/projects/tree/_/c/src/9.io.data-base.h"

#define FILE_PATH "/tmp/tmpo"

int main(void_) {
	int fD;
	CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(
		(fD = FILE__open__READ_WRITE__CREATE(FILE_PATH)),
		"`FILE__open__READ_WRITE__CREATE`ing \"%s\"",
		FILE_PATH)

	printf("%d(fD)\n", fD);

	RESULT__INIT(res)

	by buff[32];
	//BYTES__SET(buff, 98, 16)

	FILE_SYSTEM__READ(res, fD, 4, buff, 32)
	CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT(res, "`FILE_SYSTEM__READ`ing \"%s\"", FILE_PATH)

	BYTES__PRINT(buff, 32)

	CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(FILE_SYSTEM__close(fD), "`FILE_SYSTEM__close`ing \"%s\"", FILE_PATH);

	return EXIT_SUCCESS;
}
