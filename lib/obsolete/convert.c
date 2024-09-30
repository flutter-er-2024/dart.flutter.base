#include "convert.h"

const char characterSet[SIGNED_BYTE_LIMIT] = {
	'\0' /* `NUL`, `null`, `^@` */, //
	NULL_CHAR /* `SOH`, `startOfHeading`, `^A` */,
	NULL_CHAR /* `STX`, `startOfText`, `^B` */,
	NULL_CHAR /* `ETX`, `endOfText`, `^C` */,
	NULL_CHAR /* `EOT`, `endOfTransmission`, `^D` */,
	NULL_CHAR /* `ENQ`, `enquiry`, `^E` */,
	NULL_CHAR /* `ACK`, `acknowledgement`, `^F` */, //
	'\a' /* `BEL`, `bell`, `^G` */,
	'\b' /* `BS`, `backspace`, `^H` */,
	'\t' /* `HT`, `horizontalTab`, `^I` */,
	'\n' /* `LF`, `lineFeed`, `^J` */,
	'\v' /* `VT`, `verticalTab`, `^K` */,
	'\f' /* `FF`, `formFeed`, `^L` */,
	'\r' /* `CR`, `carriageReturn`, `^M` */, //
	NULL_CHAR /* `SO`, `shiftOut`, `^N` */,
	NULL_CHAR /* `SI`, `shiftIn`, `^O` */,
	NULL_CHAR /* `DLE`, `dataLinkEscape`, `^P` */,
	NULL_CHAR /* `DC1`, `deviceControlOne`, `^Q` */,
	NULL_CHAR /* `DC2`, `deviceControlTwo`, `^R` */,
	NULL_CHAR /* `DC3`, `deviceControlThree`, `^S` */,
	NULL_CHAR /* `DC4`, `deviceControlFour`, `^T` */,
	NULL_CHAR /* `NAK`, `negativeAcknowledgement`, `^U` */,
	NULL_CHAR /* `SYN`, `synchronousIdle`, `^V` */,
	NULL_CHAR /* `ETB`, `endOfTransmissionBlock`, `^W` */,
	NULL_CHAR /* `CAN`, `cancel`, `^X` */,
	NULL_CHAR /* `EM`, `endOfMedium`, `^Y` */,
	NULL_CHAR /* `SUB`, `substitute`, `^Z` */, //
	'\e' /* `ESC`, `escape`, `^[` */,           //
	NULL_CHAR /* `FS`, `fileSeparator`, `^\` */,
	NULL_CHAR /* `GS`, `groupSeparator`, `^]` */,
	NULL_CHAR /* `RS`, `recordSeparator`, `^^` */,
	NULL_CHAR /* `US`, `unitSeparator`, `^_` */, //
	' ',
	'!',
	'"',
	'#',
	'$',
	'%',
	'&',
	'\'',
	'(',
	')',
	'*',
	'+',
	',',
	'-',
	'.',
	'/', //
	'0',
	'1',
	'2',
	'3',
	'4',
	'5',
	'6',
	'7',
	'8',
	'9',
	':',
	';',
	'<',
	'=',
	'>',
	'?',
	'@', //
	'A',
	'B',
	'C',
	'D',
	'E',
	'F',
	'G',
	'H',
	'I',
	'J',
	'K',
	'L',
	'M',
	'N',
	'O',
	'P',
	'Q',
	'R',
	'S',
	'T',
	'U',
	'V',
	'W',
	'X',
	'Y',
	'Z', //
	'[',
	'\\',
	']',
	'^',
	'_',
	'`', //
	'a',
	'b',
	'c',
	'd',
	'e',
	'f',
	'g',
	'h',
	'i',
	'j',
	'k',
	'l',
	'm',
	'n',
	'o',
	'p',
	'q',
	'r',
	's',
	't',
	'u',
	'v',
	'w',
	'x',
	'y',
	'z', //
	'{',
	'|',
	'}',
	'~',       //
	NULL_CHAR /* `DEL`, `delete`, `^?` */
};

char *char_set_pointers__de_code;

void initializeConvertVariables ()
{
	CHECK_VOID_SAFE((characterSetPointers = malloc(((2 * SIGNED_BYTE_LIMIT) * u8__size))), "`characterSetPointers=malloc()`");

	u8 i = 0, j;

	/* `numbers` */
	{
		j = 48;
		while (j < 58) {
			char_set_pointers__de_code[i++] = j++;
		}
	}

	/* `lineFeed` */
	{
		char_set_pointers__de_code[i++] = 10;
	}

	/* `space` */
	{
		char_set_pointers__de_code[i++] = 32;
	}

	/* `lowerCaseAlphabets` */
	{
		j = 97;
		while (j < 123) {
			char_set_pointers__de_code[i++] = j++;
		}
	}

	/* `upperCaseAlphabets` */
	{
		j = 65;
		while (j < 91) {
			char_set_pointers__de_code[i++] = j++;
		}
	}

	/* `firstNonAlphanumerics`, `beforeNumbers` */ {
		j = 33;
		while (j < 48) {
			char_set_pointers__de_code[i++] = j++;
		}
	}

	/* `secondNonAlphanumerics`, `betweenNumbersAndUpperCaseAlphabets` */
	{
		j = 58;
		while (j < 65) {
			char_set_pointers__de_code[i++] = j++;
		}
	}

	/* `thirdNonAlphanumerics`, `betweenUpperCaseAndLowerCaseLetters` */ {
		j = 91;
		while (j < 97) {
			char_set_pointers__de_code[i++] = j++;
		}
	}

	/* `fourthNonAlphanumerics`, `afterLowerCaseAlphabets` */ {
		j = 123;
		while (j < 127) {
			characterSetPointers[i++] = j++;
		}
	}
}

char *characterSetPointers;

void initializeConvertVariables ()
{
	CHECK_VOID_SAFE((characterSetPointers = malloc(((2 * SIGNED_BYTE_LIMIT) * u8__size))), "`characterSetPointers=malloc()`");

	uint8_t i = 0, j;

	/* `numbers` */
	{
		j = 48;
		while (j < 58) {
			*(characterSetPointers + i) = j;

			i += 1;
			j += 1;
		}
	}

	/* `lineFeed` */
	{
		*(characterSetPointers + i) = 10;

		i += 1;
	}

	/* `space` */
	{
		*(characterSetPointers + i) = 32;

		i += 1;
	}

	/* `lowerCaseAlphabets` */
	{
		j = 97;
		while (j < 123) {
			*(characterSetPointers + i) = j;

			i += 1;
			j += 1;
		}
	}

	/* `upperCaseAlphabets` */
	{
		j = 65;
		while (j < 91) {
			*(characterSetPointers + i) = j;

			i += 1;
			j += 1;
		}
	}

	/* `firstNonAlphanumerics`, `beforeNumbers` */ {
		j = 33;
		while (j < 48) {
			*(characterSetPointers + i) = j;

			i += 1;
			j += 1;
		}
	}

	/* `secondNonAlphanumerics`, `betweenNumbersAndUpperCaseAlphabets` */
	{
		j = 58;
		while (j < 65) {
			*(characterSetPointers + i) = j;

			i += 1;
			j += 1;
		}
	}

	/* `thirdNonAlphanumerics`, `betweenUpperCaseAndLowerCaseLetters` */ {
		j = 91;
		while (j < 97) {
			*(characterSetPointers + i) = j;

			i += 1;
			j += 1;
		}
	}

	/* `fourthNonAlphanumerics`, `afterLowerCaseAlphabets` */ {
		j = 123;
		while (j < 127) {
			*(characterSetPointers + i) = j;

			i += 1;
			j += 1;
		}
	}
}
