part of "_.dart";

const //
    language__hindi__numbers__count = 10,
    language__latin__english__alphabets__count = 26;

void language__english__count__string__convert__plural__if__needed__buffer(
  final StringBuffer buffer,
  final uu count,
  final string word, [
  final bool suffix___s__ok /* {'s'|"es"} */ = OK,
]) {
  buffer
    ..write(count)
    ..write(char__space)
    ..write(word);

  if (count != 1) //
    buffer.write(suffix___s__ok //
        ? "s"
        : "es");
}

string language__english__count__string__convert__plural__if__needed(
  final uu count,
  final string word, [
  final bool suffix___s__ok = OK,
]) {
  final buffer = StringBuffer();

  language__english__count__string__convert__plural__if__needed__buffer(
    buffer,
    count,
    word,
    suffix___s__ok,
  );

  return buffer.toString();
}
