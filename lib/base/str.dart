part of "_.dart";

/*
  TASK:
    long:
      bring the whole unicode coverage into `latin__basic`-style encoding,
        because excluding chinese-japanese-korean, and other east-asian scripts, from unicode;
          brings the code-point counter to <16k */

typedef str = by__arr;

final //
    empty__str = empty__by__arr;

str string__ascii__convert__str(
  final string s,
) {
  if (s.empty__ok()) {
    return empty__str;
  }

  final //
      chars___count = s.chars___count,
      result = str(
        chars___count,
      );

  base__iterate__reverse__basic(
    chars___count,
    (final char__id_) {
      result[char__id_] = ch__ascii__convert__ch(
        s.codeUnitAt(
          char__id_,
        ),
      );
    },
  );

  return result;
}

string str__convert__string(
  final str s,
) {
  if (s.empty__ok()) {
    return empty__string;
  }

  final //
      count = s.elements__count,
      result = str(
        count,
      );

  base__iterate__reverse__basic(
    count,
    (final char__id_) {
      result[char__id_] = ch__convert__ch__ascii(
        s[char__id_],
      );
    },
  );

  return string.fromCharCodes(
    result,
  );
}
