part of "_.dart";

/*
  conclusions, from `test__search__de_limiter` function are:
    `{{0}, `
      `{192, 193}, `
      `{245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255}}`
      charCodes can be used as de-limiter(or separator), in the encoded strings
    all the 256(possible single-byte) byte values, were en-countered, 
      by 3078013 as `byteCounter`, and 243 as `charCode`, 
      but the last encountered `charCode` was 244(at `byteCounter` 169856)
    the `byteCount` of the `encodedBytes` was 4388733 */

by__arr string__convert__utf_8__bytes(final string s) => //
    (const convert.Utf8Encoder()).convert(s);

uu? /*id_*/ string__search /*
forked ,from `array__search` */
    (
  final string string_,
  final string segment /*
sub-string to search */
  , {
  final uu? offset /*
by-default 0 ,if `reverse:OK` is `NOT OK` ,else `char:last:id` */
  ,
  final bool reverse__ok = NO,
}) {
  if ((offset != null) && NOT(offset < string_.chars___count)) {
    throw RangeError.range(
      offset,
      0,
      string_.chars___count,
    );
  }

  final uu result;

  if /*F*/ (reverse__ok) {
    result = string_.lastIndexOf(
      segment,
      offset,
    );
  } else {
    result = string_.indexOf(
      segment,
      (offset ?? 0),
    );
  }

  if (result < 0) {
    return NIL;
  }

  return result;
}

bool string__numbers__ok(
  final string s,
) {
  for (final c in s.codeUnits) {
    if ((c < 48) || (c > 57)) {
      return NO;
    }
  }
  return OK;
}

string utf_8__bytes__convert__string(final by__arr bytes) => //
    (const convert.Utf8Decoder()).convert(bytes);

uu /*(char:bytes:count -1)*/ utf_8__bytes__char__bytes__count__remain_ing(
  final by b /*char:bytes:first*/,
) {
  if (b < 128 /*1000_0000*/) {
    return 0;
  } else if (b < 192 /*1100_0000*/) {
    throw "BAD encod-ing" /*
source :`http://stackoverflow.com/questions/26070766/utf-8-how-does-only-0-127-store-into-a-single-byte/26073762#26073762` */
        ;
  } else if (b < 224 /*1110_0000*/) {
    return 1;
  } else if (b < 240 /*1111_0000*/) {
    return 2;
  } else if (b < 248 /*1111_1000*/) {
    return 3;
  } else {
    throw "utf-8's limit has exceeded";
  }
}

final asyn___value<string> Function(Stream<by__arr>) utf_8__by__array__Stream__convert__string = //
    (const convert.Utf8Codec()).decodeStream;

final asyn___value<string> Function(Stream<array<u8>>) utf_8__u8__array__Stream__convert__string = //
    (const convert.Utf8Codec()).decodeStream;

extension string__extension on string {
  uu get chars___count => //
      length;

  bool empty__ok() => //
      isEmpty;

  bool empty__not() => //
      isNotEmpty;

  string? empty__not__else__null() {
    if (empty__ok()) {
      return NIL;
    }

    return this;
  }

  void print__raw() /*
should never be needed(only wanted)
  prefer `::print` */
  {
    base__print__handle(
      this,
    );
  }

  void print([
    final string? label,
  ]) {
    base__print__labeled(
      this,
      NIL,
      label,
    );
  }
}

extension string__convert__text__representation__extension on string {
  base__text__representation //
      convert__text__representation() => //
          base__value__convert__text__representation(
            (char__quote__double + this + char__quote__double),
            Type__convert__string(string),
          );
}
