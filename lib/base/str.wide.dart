part of "_.dart";

const //
    unicode__ch__max = 0x10ffff /* 1114111, 0b100001111111111111111 */,
    unicode__ch__limit = (unicode__ch__max + 1),
    unicode__ch__size = wch__size,
    unicode__ch__per__byte__max /*
  bytes needed, for storing `ch__unicode__max` */
    = wch__size;

uu wch__bytes__count(final wch wc) => //
    ((wc < u7__limit) //
        ? ch__size
        : ((wc < u14__limit) //
            ? 2
            : ((wc < u21__limit) //
                ? 3
                : throw "`wch` MUST be `<u21__limit`")));

wstr string__unicode__convert__wstr(
  final string s, [
  final uu? chars___count__initial /*
  usually `u16__max` */
  ,
]) {
  final runes = Runes /* Dart's rune, is, Unicode's code-point */ (s).iterator;

  var //
      chars___count = (chars___count__initial ?? s.chars___count),
      /*array<wch>*/ chars_ = u32__arr(
        chars___count,
      ),
      char__id_ = 0;

  while (runes.moveNext()) {
    if (chars___count == char__id_) {
      final //
          chars__1 = chars_,
          chars___count_1 = chars___count;

      base__copy(
        (chars_ = u32__arr(chars___count *= 2)),
        chars__1,
        count: chars___count_1,
      );

      //chars_.mem_:free()
    }

    final wc = runes.current;

    chars_[char__id_++] = ((wc < ch__limit) //
        ? ch__ascii__convert__ch(wc)
        : wc);
  }

  final result = wstr(char__id_);

  base__copy(
    result,
    chars_,
    count: char__id_,
  );

  //chars_.mem_:free()

  return result;
}

wch char__unicode__convert__wch(
  final string char,
) {
  final runes = Runes(char).iterator;

  if (behavior__correct__ok && //
      runes.moveNext().not) //
    throw "empty string";

  final wc = runes.current;

  return ((wc < ch__limit) //
      ? ch__ascii__convert__ch(wc)
      : wc);
}

/*
  code-point is separated, into parts of 7 bit, each
    hence a code-point(which has 21 bits of data) can take at-most 3 bytes, after encoding
      the first bit of each byte(not code-point) indicates, that the current byte has more data (bits), of the code-point, or is last
        1 if code-point(original, before encoding) has more data (hence next byte, belongs to the current wch),
        0 if is the last byte
      the last 7 bits of the code-point, are contained in the first byte, while the first 7, go in last byte,
        hence reversed, but this is irrelevant, after decoding

  example:
    1 0000 1111 1111 1111 1111 (largest unicode code-point), becomes
      1 1111111  1 1111111  0 1000011
      ^          ^          ^
      numbers highlighted with the caret are indicators,
        rest are actual data, of the code-point

  /*conclusions, after the execution of `DelimiterTester::testUnicode` function are:
    NO charCode can be used as de-limiter(or separator), in the enCoded strings,
      ONLY the prePended size can be used to separate these strings
      but, the ONLY charCode containing 0(or `NUL`, or `'\0'`) is 128, 
        because 128 requires the 8th bit,
          hence needs 2 bytes after enCoding,
          the second byte is 129, while the first byte is the culprit 0,
    all the 256(possible single-byte) byte values, were en-countered, by 32384 as byteCounter
    the `byteCount` of the `encodedBytes` was 3325823, 
      excluding the prePended size
      compared to 4388733, of `Utf8::enCode`*/ */ /* *** outdated info *** */
by__arr wstr__convert__bytes(
  final array<wch> ws,
) {
  final sink = base__by__array__accumulation__size__dynamic();

  ws.iterate__basic(
    (final _, final wc) => //
        sink.add__uu(
      wc,
    ),
  );

  final result = sink.convert__by__arr();

  sink.flush();

  return result;
}

/*by__arr wstr__bytes__convert__encrypted /*__iterate*/ (
  final by__arr bytes, [
  final sz? chars___count__prefixed__size,
]) {
  final //
      bytes__count = bytes.count,
      result = by__arr(bytes__count);

  bool ascii__ok /*
  char is standalone, or single-byte (ascii, not unicode)
    hence needs encryption */
      = OK;

  base__iterate__basic(
    bytes__count,
    (final i) {
      final wc = bytes[iter];

      if ((wc < ch__ascii__limit) || (ascii__ok = NO)) {
        if (ascii__ok || (ascii__ok = OK).not) //
          result[iter] = ch__encrypt(wc);
      }
    },
    ((chars___count__prefixed__size !=  null) //
        ? chars___count__prefixed__size
        : uu__bytes__convert(bytes).count),
  );

  return result;
}*/

wstr wstr__bytes__convert(
  final by__arr bytes,
) {
  /*if (bytes.empty__ok) //
    return wstr(0);*/

  final //
      bytes_ = bytes__kampa(
        bytes,
      ),
      sink = base__accumulation<wch>();

  while (bytes_.iterate__ok) //
    sink.add__element(
      bytes_.read__uu().value,
    );

  final result = wstr.fromList(
    sink.convert__array(),
  );

  sink.dispose();

  return result;
}

string wstr__convert__string(
  final wstr ws,
) {
  if /*F*/ (ws.empty__ok()) {
    return empty__string;
  }

  final //
      count = ws.elements__count,
      ws__copy = u32__arr(
        count,
      );

  base__iterate__reverse__basic(count, (final wide_char__id_) {
    final wc = ws[wide_char__id_];
    ws__copy[wide_char__id_] = ((wc < ch__limit) //
        ? ch__convert__ch__ascii(wc)
        : wc);
  });

  final result = string.fromCharCodes(
    ws__copy,
  );

  //ws__copy.mem_:free()

  return result;
}
