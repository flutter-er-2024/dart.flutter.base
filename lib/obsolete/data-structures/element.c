#include "element.h"

#define lineBreak "\n\n"

TreeElement *linkElement(uint64_t identifier,
                         uint8_t *dataBytes,
                         uint64_t dataBytesCount,
                         TreeElement *previous) {
  printf(lineBreak "%lu(`linkElement`.call)" lineBreak "%lu(identifier)"
                   ", %u(* dataBytes)"
                   ", %lu(dataBytesCount)"
                   ", %p(&previous)",
         getFinestTimeStamp(), identifier, *dataBytes, dataBytesCount,
         previous);

  TreeElement *current = malloc(sizeof(TreeElement));
  printf(lineBreak "%p(`&current`.new)", current);

  (*current).identifier = identifier;

  (*current).dataBytes = dataBytes;
  (*current).dataBytesCount = dataBytesCount;

  printf(lineBreak "(%p(previous) != NULL)", previous);
  if (previous != NULL) /* `isNotFirst` */ {
    printf(lineBreak "if");

    (*previous).next = current;
    printf(lineBreak "%p(`previous.&next`.after)", (*previous).next);
  }

  (*current).previous = previous;
  printf(lineBreak "%p(current.&previous)", (*current).previous);

  (*current).next = NULL;
  printf(lineBreak "%p(current.&next)", (*current).next);

  return current;
}

void unLinkElement(TreeElement *e) {
  printf(lineBreak "%lu(unLinkElement)" lineBreak "%p(&e)", getFinestTimeStamp(),
         e);

  if ((*e).previous == NULL) /* `isFirst` */ {
    if ((*e).next != NULL) /* `isNotLast` */ {
      (*(*e).next).previous = NULL;
    }
  } else if ((*e).next == NULL) /* `isLast` */ {
    (*(*e).previous).next = NULL;
  } else { /* `isInBetween` */
    (*(*e).next).previous = (*e).previous;
    (*(*e).previous).next = (*e).next;
  }

  free(e);
}

void initializeCollection(Collection *c) {
  printf(lineBreak "%lu(`initializeCollection`.call)" lineBreak "%p(&c)",
         getFinestTimeStamp(), c);

  (*c).elementCount = 0;
  (*c).lastElement = (*c).firstElement = NULL;
}

void printCollection(Collection *c) {
  printf(lineBreak "%lu(c.elementsCount)"
                   ", %p(&c)"
                   ", %p(c.&firstElement)"
                   ", %p(c.&lastElement)",
         (*c).elementCount, c, (*c).firstElement, (*c).lastElement);

  if ((*c).firstElement == NULL) {
    printf(lineBreak "(%p(c.&firstElement) == NULL)", (*c).firstElement);

    return;
  }

  TreeElement *e = (*c).firstElement;

  for (uint64_t i = 0;; i += 1) {
    printf(lineBreak "%lu(i)"
                     ", %p(&e)"
                     ", %lu(e.identifier)"
                     ", %p(e.&previous)"
                     ", %p(e.&next)"
                     ", %lu(e.dataBytesCount)",
           i, e, (*e).identifier, (*e).previous, (*e).next,
           (*e).dataBytesCount);

    if ((*e).dataBytesCount > 0) {
      uint64_t lastDataByteIndex = ((*e).dataBytesCount - 1);
      printf(lineBreak "%u(e.dataBytes[%u])"
                       ", %u(e.dataBytes[%lu])",
             *(*e).dataBytes, 0, (*e).dataBytes[lastDataByteIndex],
             lastDataByteIndex);
    }

    if ((*e).next == NULL) {
      break;
    }

    e = (*e).next;
  }
}

void _printContainer(Container *c) {
  printf(lineBreak "%lu(`printContainer`.call)" lineBreak "%p(&c)",
         getFinestTimeStamp(), c);

  for (uint64_t i = 0, recursionLevel = 0;; i += 1) {
    printf(lineBreak "%lu(i)"
                     ", %lu(recursionLevel)",
           i, recursionLevel);

    printCollection(&(*c).direct);

    if ((*c).children == NULL) {
      return;
    }

    printf(lineBreak "%p(c.&children)" lineBreak "%lu(c.childrenCount)",
           (*c).children, (*c).childrenCount);

    for (uint64_t j = 0, furtherRecursion = (recursionLevel + 1); (*c).childrenCount;
         j += 1) {
      printf(lineBreak "%lu(i)", j);

      c = ((*c).children + j);
      recursionLevel = furtherRecursion;
    }
  }
}

void printContainer(Container *c, uint64_t recursionLevel) {
  printf(lineBreak "%lu(`printContainer`.call)" lineBreak "%p(&c)"
                   ", %lu(recursionLevel)",
         getFinestTimeStamp(), c, recursionLevel);

  printCollection(&(*c).direct);

  if ((*c).children == NULL) {
    printf(lineBreak "(%p(c.children) == NULL)", (*c).children);

    return;
  }

  printf(lineBreak "%p(c.&children)" lineBreak "%lu(c.childrenCount)",
         (*c).children, (*c).childrenCount);

  for (uint64_t i = 0, furtherRecursion = (recursionLevel + 1);
       i < (*c).childrenCount; i += 1) {
    printf(lineBreak "%lu(i)", i);

    printContainer(((*c).children + i), furtherRecursion);
  }
}

void publishNotice(uint8_t *noticeBytes,
                   uint64_t noticeBytesCount,
                   uint64_t *classifications,
                   uint64_t classificationsCount) {
  printf(lineBreak "%lu(`publishNotice`.call)" lineBreak "%u(* noticeBytes)"
                   ", %lu(noticeBytesCount)"
                   ", %lu(* classifications)"
                   ", %lu(classificationsCount)",
         getFinestTimeStamp(), *noticeBytes, noticeBytesCount, *classifications,
         classificationsCount);

  uint64_t li = 0, ci = 0, icc;
  Container *csp = &notices;

  printf(lineBreak "`loopIterator`(li)"
                   ", `classificationIterator`(ci)"
                   ", `IndexOfCurrentClassification`(icc)"
                   ", `collectionStatePersistence`(csp)");

  while (ci < classificationsCount) {
    if (classifications[ci] == 0) {
      printf(lineBreak "`classifications[%lu]`.isNullReplacement", ci);

      break;
    }

    icc = (classifications[ci] - 1);

    printf(lineBreak "%lu(li), %lu(ci), %p(&csp)" lineBreak
                     "(%lu((*csp).childrenCount) > %lu(icc))",
           li++, ci, csp, (*csp).childrenCount, icc);

    if ((*csp).childrenCount > icc) {
      printf(lineBreak "if");

      csp = ((*csp).children + icc);
      ci += 1;
    } else {
      printf(lineBreak "else");

      uint64_t ci1 /* `newlyAllocatedCollectionIterator` */,
          len /* `requiredLength` */ = (icc + 1),
              size = (len * sizeof(Container));

      printf(lineBreak "`newlyAllocatedCollectionIterator`(ci1)"
                       ", `requiredLength`(len)"
                       ", `(len * sizeof(ContainerCollection))`(size)" lineBreak
                       "%lu(len), %lu(size)" lineBreak
                       "`((*csp).childrenCount > 0)`" lineBreak
                       "(%lu((*csp).childrenCount) > 0)",
             len, size, (*csp).childrenCount);

      if ((*csp).childrenCount > 0) /* `isNotEmpty` */ {
        printf(lineBreak "if");

        (*csp).children = realloc((*csp).children, size);
        ci1 = (*csp).childrenCount;
      } else {
        printf(lineBreak "else");

        (*csp).children = malloc(size);
        ci1 = 0;
      }

      for (Container *c; ci1 < len; ci1 += 1) {
        c = ((*csp).children + ci1);

        printf(lineBreak "%lu(ci1)"
                         ", %p(&c)",
               ci1, c);

        initializeCollection(&(*c).direct);
        (*c).childrenCount = 0;
        (*c).children = NULL;
      }

      (*csp).childrenCount = len;
    }
  }

  printf(lineBreak "%p(csp.direct.&lastElement)", (*csp).direct.lastElement);

  (*csp).direct.lastElement =
      linkElement((modificationCounter++), noticeBytes, noticeBytesCount,
                  (*csp).direct.lastElement);

  if ((*csp).direct.firstElement == NULL) {
    printf(lineBreak "(%p(csp.direct.&firstElement) == NULL)",
           (*csp).direct.firstElement);

    (*csp).direct.firstElement = (*csp).direct.lastElement;
  }

  (*csp).direct.elementCount += 1;
}

void dePublishRelease(uint64_t identifier, Collection *parentContainer) {
  printf(lineBreak "%lu(`dePublishRelease`.call)", getFinestTimeStamp());

  TreeElement *iterator = (*parentContainer).firstElement;

  for (uint64_t i = 0;; i += 1) {
    printf(lineBreak "%lu(i)", i);

    if ((*iterator).identifier == identifier) {
      linkElement(modificationCounter++, NULL, 0,
                  (*parentContainer).lastElement);

      if ((*iterator).previous == NULL) /* `isFirst` */ {
        (*parentContainer).firstElement = (*iterator).next;
      }

      if ((*iterator).next == NULL) /* `isLast` */ {
        (*parentContainer).lastElement = (*iterator).previous;
      }

      unLinkElement(iterator);

      (*parentContainer).elementCount -= 1;
    }

    if ((*iterator).next == NULL) {
      ////// `releaseNotFound`
      break;
    }

    iterator = (*iterator).next;
  }
}
