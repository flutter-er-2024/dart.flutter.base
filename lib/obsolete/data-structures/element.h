#ifndef TREE_H
#define TREE_H

#include "../basic.h"

struct _TreeElement {
  u64 identifier;

  by *dataBytes;
  u64 dataBytesCount;

  struct _TreeElement *previous, *next;
};

typedef struct _TreeElement TreeElement;

/**
 *
 * `u64 identifier`:
 *   `modificationCounter++`
 *
 * `byte * dataBytes`
 *
 * `u64 dataBytesCount`:
 *   `(sizeof(dataBytes) / sizeof(byte))`: #1
 *
 * `Element * previous`:
 *   `iterator`:  #1,
 *   `NULL`:  to initialize the collection with its first element
 *
 *
 * Currently, `inBetween` and `atBegin` additions, are NEITHER supported, NOR
 * planned ONLY appending to the end is supported
 *
 *
 * #1: when called for an actual data addition
 * #2: when called to add a remotely-stored-data removal instruction
 *
 */
TreeElement *linkElement (u64 identifier,
						  by *dataBytes,
						  u64 dataBytesCount,
						  TreeElement *previous);

void unLinkElement(TreeElement *e);

struct _ElementCollection {
  u64 elementCount;
  TreeElement *firstElement, *lastElement;
};

typedef struct _ElementCollection Collection;

void initializeCollection(Collection *c);

void printCollection(Collection *c);

struct _ElementCollectionsContainer {
  Collection direct;

  u64 childrenCount;
  struct _ElementCollectionsContainer *children;
};

typedef struct _ElementCollectionsContainer Container;

void _printContainer(Container *c);

void printContainer(Container *c, uint64_t recursionLevel);

u64 modificationCounter /* `potentialIdentifier` */;

void publishNotice (by *noticeBytes,
					u64 noticeBytesCount,
					u64 *classifications,
					u64 classificationsCount);

void dePublishRelease(u64 identifier,
					  Collection *parentContainer);

#endif
