#include "3.basic.h"

/**
	ii result
*/
#define _SYSTEM__resolve(id_) \
	sysconf(id_)

/**
	ii maxFileDescriptorCount
	
	synonym, of `getdtablesize` function
*/
#define SYSTEM__maxFDCount \
	_SYSTEM__resolve(_SC_OPEN_MAX)

/**
	ii pageSize
	
	pageSize is dynamic (or runtime dependent), and NOT static
	synonym, of `getpagesize` function
*/
#define SYSTEM__pageSize \
	_SYSTEM__resolve(_SC_PAGESIZE)

/**
	ii maxMemory
		total number, of memory pages, available to the system kernel,
			on a computer system, with 4 KiB primary memory,
				should be `(4 * 1024) / SYSTEM__pageSize`
	
	synonym, of `get_phys_pages` function
*/
#define SYSTEM__maxMemPgs \
	_SYSTEM__resolve(_SC_PHYS_PAGES)

/**
	ii availableMemory
		number of memory pages, available for use,
			either by the current process, or by all the processes of system
	
	synonym, of `get_avphys_pages` function
*/
#define SYSTEM__availMemPgs \
	_SYSTEM__resolve(_SC_AVPHYS_PAGES)

/**
	ii maxMemoryBytes
*/
#define SYSTEM__getMaxMem \
	(SYSTEM__maxMemPgs * SYSTEM__pageSize)
