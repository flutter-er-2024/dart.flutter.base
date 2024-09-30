#include "8.io.file-system.h"

#define SIZE__BLOCK__OLD 512
#define SIZE__BLOCK/* this is hardcoded, because its value, is the future, and is very safe to be assumed */ 4096/* (4 * SIZE__BLOCK__OLD) */

#define DATABASE__PRIMARY_TABLE__OFFSET 0
#define DATABASE__PRIMARY_TABLE__ROW__SIZE/* struct { u64 offset, count; } */ (SIZE__U64 + SIZE__U64)
#define DATABASE__PRIMARY_TABLE__SIZE 4096/* (256 * DATABASE__PRIMARY_TABLE__ROW__SIZE) */

#define DATABASE__PRESERVED_DATA__COUNT__OFFSET (DATABASE__PRIMARY_TABLE__SIZE + DATABASE__PRIMARY_TABLE__OFFSET)
#define DATABASE__PRESERVED_DATA__COUNT__SIZE/* stores only the count, of preservation operations, but can not exceed 256 ops */ SIZE__BLOCK

#define DATABASE__PRESERVED_DATA__TABLE__OFFSET/* also called "roll-back journal", by others, like sqlite */ (DATABASE__PRESERVED_DATA__COUNT__SIZE + DATABASE__PRESERVED_DATA__COUNT__OFFSET)
#define DATABASE__PRESERVED_DATA__TABLE__ROW__SIZE/* struct { u64 offset; u8 count; by data[256]; } */ 265/*(SIZE__U64 + SIZE__U8 + (256 * SIZE__BYTE))*/
#define DATABASE__PRESERVED_DATA__TABLE__SIZE 67840/* (256 * DATABASE__PRESERVED_DATA__TABLE__ROW__SIZE) */

#define DATABASE__PUBLIC_HEAP_POSITION__OFFSET (DATABASE__PRESERVED_DATA__TABLE__SIZE + DATABASE__PRESERVED_DATA__TABLE__OFFSET)
#define DATABASE__PUBLIC_HEAP_POSITION__SIZE SIZE__U64

#define DATABASE__OFFSET__HEAP__PUBLIC/* ONLY used initially, then made obsolete by `uu DATABASE__publicHeapPosition` */ (DATABASE__PUBLIC_HEAP_POSITION__SIZE + DATABASE__PUBLIC_HEAP_POSITION__OFFSET)

extern int
	*DATABASE__fDs,
	DATABASE__fD/*
	used for read operations, hence the storage, with fastest read-ability, should be preferred
		could be same as `DATABASE__fDs[0]`, either, or
			not present in `DATABASE__fDs`
	exists merely to allow fast access, to the variable's value, and separation from `DATABASE__fDs` */;

extern uu DATABASE__publicHeapPosition/*
	named `public`, just to future-proof,
	`privateHeap`s are NOT implemented yet,
		were planned, but cancelled,
			due to being expensive, compared to gains */;

#define DATABASE__READ(result_, offset_, buffer_, count_) \
	FILE_SYSTEM__READ(result_, DATABASE__fD, offset_, buffer_, count_)

#define _DATABASE__WRITE(result_, offset_, buffer_, count_) {\
	int fD_;\
	uu i_ = TRANSACTION__SAFE_COPY_COUNT;\
\
	while (i_--) {\
		fD_ = DATABASE__fDs[i_];\
		FILE_SYSTEM__WRITE(result_, fD_, offset_, buffer_, count_)\
		if (result_) \
			break;\
	}\
}

struct _DATABASE__TRANSACTION__OPERATION {
	uu offset;
	u8 count;
	by *bytes;
	struct _DATABASE__TRANSACTION__OPERATION *next;
};

struct _DATABASE__TRANSACTION {
	u8 count;

	struct _DATABASE__TRANSACTION__OPERATION
		*first,
		*last;

	uu offset;
};

extern struct _DATABASE__TRANSACTION _DATABASE__transaction;

#define DATABASE__TRANSACTION__INITIALIZE \
	_DATABASE__transaction = (struct _DATABASE__TRANSACTION){\
		(u8)0,\
		NULL,\
		NULL,\
		(uu)DATABASE__PRESERVED_DATA__TABLE__OFFSET};

#define _DATABASE__WRITE__RELIABLE(\
	result_DATABASE__WRITE__RELIABLE,\
	offset_DATABASE__WRITE__RELIABLE,\
	buffer_DATABASE__WRITE__RELIABLE,\
	count_DATABASE__WRITE__RELIABLE/* MUST be `<= U8__MAX` */) \
{\
	by\
		*buffer__DATABASE__WRITE__RELIABLE = (by *)&offset_DATABASE__WRITE__RELIABLE,\
		*buffer___DATABASE__WRITE__RELIABLE;\
	uu count__DATABASE__WRITE__RELIABLE;\
	MEM__ALLOC__ARRAY(\
		buffer___DATABASE__WRITE__RELIABLE,\
		(count__DATABASE__WRITE__RELIABLE = (count_DATABASE__WRITE__RELIABLE + SIZE__U8 + DATABASE__PUBLIC_HEAP_POSITION__SIZE)))\
\
	BYTES__CPY(buffer___DATABASE__WRITE__RELIABLE, buffer__DATABASE__WRITE__RELIABLE, DATABASE__PUBLIC_HEAP_POSITION__SIZE)\
	*(buffer__DATABASE__WRITE__RELIABLE = (buffer___DATABASE__WRITE__RELIABLE + DATABASE__PUBLIC_HEAP_POSITION__SIZE)) = count_DATABASE__WRITE__RELIABLE;\
	/*if (preservedData_) \
		BYTES__CPY(buffer__, preservedData_, count_)\
	else \
		*/DATABASE__READ(result_DATABASE__WRITE__RELIABLE, offset_DATABASE__WRITE__RELIABLE, (buffer__DATABASE__WRITE__RELIABLE += 1), count_DATABASE__WRITE__RELIABLE)\
\
	if (!result_DATABASE__WRITE__RELIABLE) \
		_DATABASE__WRITE(result_DATABASE__WRITE__RELIABLE, _DATABASE__transaction.offset, buffer___DATABASE__WRITE__RELIABLE, count__DATABASE__WRITE__RELIABLE)\
	_DATABASE__transaction.offset += count__DATABASE__WRITE__RELIABLE;\
	MEM__FREE(buffer___DATABASE__WRITE__RELIABLE)\
\
	if (!result_DATABASE__WRITE__RELIABLE) {\
		struct _DATABASE__TRANSACTION__OPERATION *operation_DATABASE__WRITE__RELIABLE; MEM__ALLOC(operation_DATABASE__WRITE__RELIABLE)\
		*operation_DATABASE__WRITE__RELIABLE = (struct _DATABASE__TRANSACTION__OPERATION){\
			offset_DATABASE__WRITE__RELIABLE,\
			count_DATABASE__WRITE__RELIABLE,\
			buffer_DATABASE__WRITE__RELIABLE,\
			NULL};\
		if (_DATABASE__transaction.last) \
			_DATABASE__transaction.last = (*_DATABASE__transaction.last).next = operation_DATABASE__WRITE__RELIABLE;\
		else \
			_DATABASE__transaction.last = _DATABASE__transaction.first = operation_DATABASE__WRITE__RELIABLE;\
		_DATABASE__transaction.count += 1;\
	}\
}

#define _DATABASE__TRANSACTION__WRITE__FIRST_BLOCK(\
	result_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK,\
	buffer_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK,\
	count_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK) \
{\
	buffer_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK[0] = \
	buffer_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK[1] = \
	buffer_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK[510/* ((SIZE__BLOCK__OLD -1) -1) */] = \
	buffer_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK[511/* (SIZE__BLOCK__OLD -1) */] = \
	buffer_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK[4094/* ((SIZE__BLOCK -1) -1) */] = \
	buffer_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK[4095/* (SIZE__BLOCK -1) */] = \
	count_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK;\
\
		FILE_SYSTEM__PRINT(res, DATABASE__fD, (DATABASE__PRESERVED_DATA__COUNT__OFFSET -2), 4100, "`preservedDataCount` (before writing):")\
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)\
\
	_DATABASE__WRITE(\
		result_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK,\
		DATABASE__PRESERVED_DATA__COUNT__OFFSET,\
		buffer_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK,\
		DATABASE__PRESERVED_DATA__COUNT__SIZE)\
\
		FILE_SYSTEM__PRINT(res, DATABASE__fD, (DATABASE__PRESERVED_DATA__COUNT__OFFSET -2), 4100, "`preservedDataCount` (after writing):")\
		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT__SIMPLE(res)\
}

#define DATABASE__TRANSACTION__COMPLETE(\
	result_DATABASE__TRANSACTION__COMPLETE) \
{\
	by *buffer_DATABASE__TRANSACTION__COMPLETE;\
	MEM__ALLOC__ARRAY(buffer_DATABASE__TRANSACTION__COMPLETE, DATABASE__PRESERVED_DATA__COUNT__SIZE)\
	_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK(\
		result_DATABASE__TRANSACTION__COMPLETE,\
		buffer_DATABASE__TRANSACTION__COMPLETE,\
		_DATABASE__transaction.count)\
\
	if (!result_DATABASE__TRANSACTION__COMPLETE) {\
		struct _DATABASE__TRANSACTION__OPERATION\
			*iterator_DATABASE__TRANSACTION__COMPLETE = _DATABASE__transaction.first,\
			*next_DATABASE__TRANSACTION__COMPLETE;\
		do {\
			printf("%lu((*iterator).offset), %hhu(*(*iterator).bytes), %lu((*iterator).count)\n",\
				(*iterator_DATABASE__TRANSACTION__COMPLETE).offset,\
				*(*iterator_DATABASE__TRANSACTION__COMPLETE).bytes,\
				(*iterator_DATABASE__TRANSACTION__COMPLETE).count);\
			_DATABASE__WRITE(\
				result_DATABASE__TRANSACTION__COMPLETE,\
				(*iterator_DATABASE__TRANSACTION__COMPLETE).offset,\
				(*iterator_DATABASE__TRANSACTION__COMPLETE).bytes,\
				(*iterator_DATABASE__TRANSACTION__COMPLETE).count)\
			if (result_DATABASE__TRANSACTION__COMPLETE) break;\
			MEM__FREE((*iterator_DATABASE__TRANSACTION__COMPLETE).bytes)\
			next_DATABASE__TRANSACTION__COMPLETE = (*iterator_DATABASE__TRANSACTION__COMPLETE).next;\
			MEM__FREE(iterator_DATABASE__TRANSACTION__COMPLETE)\
		} while (iterator_DATABASE__TRANSACTION__COMPLETE = next_DATABASE__TRANSACTION__COMPLETE);\
\
		_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK(\
			result_DATABASE__TRANSACTION__COMPLETE,\
			buffer_DATABASE__TRANSACTION__COMPLETE,\
			0)\
	}\
	MEM__FREE(buffer_DATABASE__TRANSACTION__COMPLETE)\
}

#define DATABASE__RESULT__RECOVERY__CORRUPTION__PRESERVED_DATA__COUNT 2

#define DATABASE__RECOVER_IF_REQUIRED(\
	result_DATABASE__RECOVER_IF_REQUIRED) \
{\
	by *buffer_DATABASE__RECOVER_IF_REQUIRED;\
	MEM__ALLOC__ARRAY(buffer_DATABASE__RECOVER_IF_REQUIRED, DATABASE__PRESERVED_DATA__COUNT__SIZE)\
	DATABASE__READ(\
		result_DATABASE__RECOVER_IF_REQUIRED,\
		DATABASE__PRESERVED_DATA__COUNT__OFFSET,\
		buffer_DATABASE__RECOVER_IF_REQUIRED,\
		DATABASE__PRESERVED_DATA__COUNT__SIZE)\
\
	if (!result_DATABASE__RECOVER_IF_REQUIRED) {\
		u8 count_DATABASE__RECOVER_IF_REQUIRED;\
		if (((((buffer_DATABASE__RECOVER_IF_REQUIRED[0] ==  buffer_DATABASE__RECOVER_IF_REQUIRED[1]) \
			== buffer_DATABASE__RECOVER_IF_REQUIRED[510]) \
				== buffer_DATABASE__RECOVER_IF_REQUIRED[511]) \
					== buffer_DATABASE__RECOVER_IF_REQUIRED[4094]) \
						== (count_DATABASE__RECOVER_IF_REQUIRED = buffer_DATABASE__RECOVER_IF_REQUIRED[4095]))/* exact index values are copied, from `_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK` */ {\
			if (count_DATABASE__RECOVER_IF_REQUIRED) {\
				by *preservedData_DATABASE__RECOVER_IF_REQUIRED;\
				MEM__ALLOC__ARRAY(preservedData_DATABASE__RECOVER_IF_REQUIRED, DATABASE__PRESERVED_DATA__TABLE__SIZE)\
				DATABASE__READ(\
					result_DATABASE__RECOVER_IF_REQUIRED,\
					DATABASE__PRESERVED_DATA__TABLE__OFFSET,\
					preservedData_DATABASE__RECOVER_IF_REQUIRED,\
					DATABASE__PRESERVED_DATA__TABLE__SIZE)\
				if (!result_DATABASE__RECOVER_IF_REQUIRED) {\
					by *iterator_DATABASE__RECOVER_IF_REQUIRED = preservedData_DATABASE__RECOVER_IF_REQUIRED;\
					u64 offset_DATABASE__RECOVER_IF_REQUIRED; u8 count__DATABASE__RECOVER_IF_REQUIRED;\
					do {\
						offset_DATABASE__RECOVER_IF_REQUIRED = *(u64 *)iterator_DATABASE__RECOVER_IF_REQUIRED;\
						iterator_DATABASE__RECOVER_IF_REQUIRED += SIZE__U64;\
						count__DATABASE__RECOVER_IF_REQUIRED = *(iterator_DATABASE__RECOVER_IF_REQUIRED++);\
						_DATABASE__WRITE(\
							result_DATABASE__RECOVER_IF_REQUIRED,\
							offset_DATABASE__RECOVER_IF_REQUIRED,\
							iterator_DATABASE__RECOVER_IF_REQUIRED,\
							count__DATABASE__RECOVER_IF_REQUIRED)\
						if (result_DATABASE__RECOVER_IF_REQUIRED) break;\
						iterator_DATABASE__RECOVER_IF_REQUIRED += count__DATABASE__RECOVER_IF_REQUIRED;\
					} while (count_DATABASE__RECOVER_IF_REQUIRED -= 1);\
					if (!result_DATABASE__RECOVER_IF_REQUIRED) \
						_DATABASE__TRANSACTION__WRITE__FIRST_BLOCK(\
							result_DATABASE__RECOVER_IF_REQUIRED,\
							buffer_DATABASE__RECOVER_IF_REQUIRED,\
							0)\
				}\
				MEM__FREE(preservedData_DATABASE__RECOVER_IF_REQUIRED)\
			}\
		} else \
			result_DATABASE__RECOVER_IF_REQUIRED = DATABASE__RESULT__RECOVERY__CORRUPTION__PRESERVED_DATA__COUNT;\
	}\
	MEM__FREE(buffer_DATABASE__RECOVER_IF_REQUIRED)\
}

#define DATABASE__CLEAR(\
	/* result */result_,\
	writeRoutine/* `_DATABASE__WRITE__`*`RELIABLE` */,\
	/* const uu */offset_,\
	/* const uu */byteCount_) {\
	by *blankBuffer_; MEM__ALLOC__ARRAY(blankBuffer_, byteCount_)\
	BYTES__SET(blankBuffer_, 0, byteCount_);\
	writeRoutine(result_, offset_, blankBuffer_, byteCount_)\
	MEM__FREE(blankBuffer_)\
}

#define _DATABASE__INITIALIZE__HEAP_POSITION(\
	/* result */result_,\
	/* uu */heapPositionCounter_,\
	/* const uu */heapPositionOffset,\
	/* const us */heapPositionSize) \
{\
	uu count_;\
	by buffer_[heapPositionSize];\
	DATABASE__READ(result_, heapPositionOffset, buffer_, heapPositionSize)\
	U64__PARSE(heapPositionCounter_, buffer_, heapPositionSize)\
}

#define DATABASE__INITIALIZE__HEAP_POSITION__PUBLIC(/* result */result_) \
	_DATABASE__INITIALIZE__HEAP_POSITION(\
		result_,\
		DATABASE__publicHeapPosition,\
		DATABASE__PUBLIC_HEAP_POSITION__OFFSET,\
		DATABASE__PUBLIC_HEAP_POSITION__SIZE)

#define DATABASE__INITIALIZE__rowCounter(\
	/* result */result_,\
	/* uu */tableRowCounter_,\
	/* const uu */tableRowCountOffset_,\
	/* const us */tableRowCountSize_) \
{\
	by buffer_[tableRowCountSize_];\
	DATABASE__READ(result_, tableRowCountOffset_, buffer_, tableRowCountSize_)\
	if (!result_) \
		U64__PARSE(tableRowCounter_, buffer_, tableRowCountSize_)\
}

#define _DATABASE__TABLE__ROW_OFFSET(\
	tableRowsOffset_,\
	rowId_,\
	rowSize_,\
	inRowOffset_) \
	((inRowOffset_ + (rowId_ * rowSize_)) + tableRowsOffset_)

/*
	void
*/
#define DATABASE__READ__TABLE__ROW(\
	result_,\
	tableOffset_,\
	tableRowsOffset_,\
	rowId_,\
	rowSize_,\
	buffer_) \
	const uu offset_ = _DATABASE__TABLE__ROW_OFFSET(tableRowsOffset_, rowId_, rowSize_, 0);\
	DATABASE__READ(result_, offset_, buffer_, rowSize_)

/*
	void
*/
#define DATABASE__WRITE__TABLE__ROW__APPEND(\
	result_,\
	tableRowsOffset_,\
	rowCountSize_,\
	rowCounter_,\
	rowSize_/* MUST be equal to `count_` */,\
	buffer_)/* append/add row, and NOT append data to row */ {\
	const uu\
		rowId_ = rowCounter_++,\
		offset_ = _DATABASE__TABLE__ROW_OFFSET(tableRowsOffset_, rowId_, rowSize_, 0);\
	_DATABASE__WRITE(result_, offset_, buffer_, rowSize_)\
	if (!result_) \
		_DATABASE__WRITE__RELIABLE(result_, 0, &rowCounter_, rowCountSize_)\
}

/*
	void
*/
#define DATABASE__WRITE__TABLE__ROW(result_, tableRowsOffset_, rowId_, rowSize_, buffer_, count_, inRowOffset_) {\
	const uu offset_ = _DATABASE__TABLE__ROW_OFFSET(tableRowsOffset_, rowId_, rowSize_, inRowOffset_);\
	_DATABASE__WRITE__RELIABLE(result_, offset_, buffer_, count_)\
}

#define _DATABASE__WRITE__HEAP__APPEND(\
	result_,\
	heapPositionCounter_,\
	buffer_/* pass `NULL`, if the intention, is to mere reSize(or truncate) the heap, like when creating a new table */,\
	count_,\
	heapPositionOffset_,\
	heapPositionSize_) \
{\
	CHECK__NOT_NULL(buffer_)\
		_DATABASE__WRITE(result_, heapPositionCounter_, buffer_, count_)\
	heapPositionCounter_ += count_;\
	_DATABASE__WRITE__RELIABLE(result_, heapPositionOffset_, &heapPositionCounter_, heapPositionSize_)\
}

#define DATABASE__WRITE__HEAP__APPEND(\
	result_,\
	buffer_,\
	count_) \
	_DATABASE__WRITE__HEAP__APPEND(\
		result_,\
		DATABASE__publicHeapPosition,\
		buffer_,\
		count_,\
		DATABASE__PUBLIC_HEAP_POSITION__OFFSET,\
		DATABASE__PUBLIC_HEAP_POSITION__SIZE)
