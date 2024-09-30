#include "basic.h"

struct _LinkedList1 {
	uu
		offset,
		count/** NOT the length, of the `string` variable, but the charCount, after `offset`, to replace, with `string` */;

	char *string/** replacement */;

	struct _LinkedList1 *next;
};

struct _LinkedList {
	uu offset;
	struct _LinkedList *next;
};

struct PatternOccurrencesContainer {
	uu count;

	struct _LinkedList
		*first,
		*last;
};

struct PatternOccurrencesContainer *findAllInString(const char *string, const char *pattern) {
	uu stringCharCounter = 0;

	struct PatternOccurrencesContainer *occurrences;
	MEM__ALLOC(occurrences)
	*occurrences = (struct PatternOccurrencesContainer){ZERO__UNSIGNED_LONG, NULL, NULL};

	struct _LinkedList *last = NULL;

	printf("%p((*occurrences).first)" ", " "%p((*occurrences).last)" ", " "%p(last)" "\n",
					 (*occurrences).first, (*occurrences).last, last);

	const uu patternCharCount = STRING__CHAR_COUNT__EXCLUDING_NULL(pattern);
	printf("%lu(patternCharCount)" "\n", patternCharCount);

	const char firstCharOfPattern = pattern[0];
	printf("'%hu'(firstCharOfPattern)" "\n", firstCharOfPattern);

	char charOfString;

	while ((charOfString = string[stringCharCounter++])) {
		/*printf("\t" "'%c'(%hu)(charOfString = string[%lu]) vs `firstCharOfPattern`" "\n",
							 charOfString, charOfString, (stringCharCounter -1));*/

		if (charOfString == firstCharOfPattern) {
			const uu offset = stringCharCounter;
			printf("\t\t" "'%c'(%hu)(charOfString) == `firstCharOfPattern`" "\n" "\t\t" "%lu(offset)" "\n", 
							 charOfString, charOfString, (offset -1));

			ii patternCharCounter = 1;
			while(patternCharCounter < patternCharCount) {
				/*printf("\t\t\t" "'%c'(%hu)(string[%lu]) vs '%hu'(pattern[%ld])" "\n", 
									 string[stringCharCounter], string[stringCharCounter], stringCharCounter, pattern[patternCharCounter], patternCharCounter);*/

				if (string[stringCharCounter++] != pattern[patternCharCounter++]) {
					printf("\t\t\t\t" "string[%lu] != pattern[%ld]" "\n", (stringCharCounter -1), (patternCharCounter -1));

#define _NOT_SET -1L

					patternCharCounter = _NOT_SET;
					break;
				}
			}

			if (patternCharCounter == _NOT_SET) {

#undef _NOT_SET

				stringCharCounter = offset;
			} else {
				printf("\t\t\t" "*** PATTERN MATCHED ***" "  at `string`'s `offset` %lu" "\n", (offset -1));
				
				struct _LinkedList *newElement;
				MEM__ALLOC(newElement)
				printf("\t\t\t" "%p(&newElement)" "\n", newElement);

				*newElement = (struct _LinkedList){((stringCharCounter = offset) -1), NULL};

				if (CHECK_NULL((*occurrences).first)) {
					printf("\t\t\t\t" "`(*occurrences).first` == `NULL`" "\n");

					(*occurrences).first = newElement;
				} else {
					(*last).next = newElement;
				}
				
				last = newElement;

				(*occurrences).count += 1;
			}
		}
	}

	(*occurrences).last = last;

	return occurrences;
}

void replaceAllInString(char *string, const char *pattern/** from */, const char *replacement/** to */) {
	const struct PatternOccurrencesContainer *occurrences = findAllInString(string, pattern);

	uu
		stringCharCount,
		patternCharCount,
		replacementCharCount,
		elementCount = ((stringCharCount = STRING__CHAR_COUNT__EXCLUDING_NULL(string)) - //
			((*occurrences).count * (patternCharCount = STRING__CHAR_COUNT__EXCLUDING_NULL(pattern))) + //
			((*occurrences).count * (replacementCharCount = STRING__CHAR_COUNT__EXCLUDING_NULL(replacement))));

	printf("%lu(stringCharCount)" ", " "%lu(patternCharCount)" ", " "%lu(replacementCharCount)" ", " "%lu(elementCount)" "\n",
		stringCharCount, patternCharCount, replacementCharCount, elementCount);

	const char *newString;
	MEM__ALLOC__ARRAY(newString, elementCount)
	MEM__FREE(newString)

	struct _LinkedList *iterator;
	for (iterator = (*occurrences).first; iterator != NULL; iterator = (*iterator).next) 
		printf("%p(iterator), %lu((*iterator).offset), %p((*iterator).next)\n", 
			iterator, (*iterator).offset, (*iterator).next);
}

/**
	`radix`:
		MUST be one of 2, or 10,
			16 was also tested, but alphabets are not correct, and not actually needed to be correct
			any other base, is un-tested
*/
char *integerAsRadixString(uu integer, const int radix/** base */) {
	char
		buffer[U64__CHAR_CODE__RADIX_2/** base 2 takes the most bytes */],
		*bytes;

	ii i = 0;

	while (integer /*> 0*/) {
		buffer[i++] = (integer % radix);
		integer /= radix;
	}

	MEM__ALLOC__ARRAY(bytes, (i +1))

	bytes[i--] = 0;

	u8 j = 0;
	do {
		bytes[j++] = (buffer[i] + '0');
	} while (i--);

	return bytes;
}

uu deSerializeInteger(by *bytes) {
	char c;

	uu
		result = 0,
		i = 0;

	while ((c = bytes[i++])) {
		result = ((result * 10) + c);
	}

	return result;
}

ii binarySearch(
	uu const * const list,
	const u64 itemCount,
	const u64 element
) {
	uu //
			begin = 0,
			mid,
			end = itemCount;

	while (begin < end) {
		const u64 _element = list[mid = ((begin + end) / 2)];

		if (_element < element) {
			begin = (mid + 1);
		} else if (_element > element) {
			end = mid;
		} else {
			return mid;
		}
	}

	return -mid;
}

int demoRemainders() {
	u64 num = 15, den = 2;

	printf("%lu(num %% den)", (num % den));

	/* '15' is equal to "((7 * 2) + 1)", where '7' is "(15 / 2)" */
	printf("\n%lu(num - ((num / den) * den))", (num - ((num / den) * den)));

	return EXIT_SUCCESS;
}
