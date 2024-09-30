part of "_.dart";

string ch__ascii__array__new__generate(
  final bool b__mode /* {char-code | char} */,
) /*
  special cases are not handled
    due to perf penalty
      and lang dependence
    '$' -> r'$'
    ''' -> '\''
    '\' -> r'\' */
{
  const //
      a = r"""
exclamation !
quote__double "
hash #
dollar $
percent %
ampersand &
quote__single '
bracket__round__open (
bracket__round__close )
asterisk *
addition +
comma ,
dash -
dot .
slash__forward /
number__zero 0
number__one 1
number__two 2
number__three 3
number__four 4
number__five 5
number__six 6
number__seven 7
number__eight 8
number__nine 9
colon :
colon__semi ;
bracket__sharp__open <
equal =
bracket__sharp__close >
question ?
at @""",
      b = r"""bracket__square__open [
slash__backward \
bracket__square__close ]
caret ^
underscore _
quote__back `""",
      c = r"""bracket__curly__open {
pipe |
bracket__curly__close }
tilde ~""";

  final //
      prefix = (b__mode //
          ? "ch__ascii__"
          : "char__"),
      result = StringBuffer() //
        ..write("ch //");

  void write__raw(final string s) => //
      result.write("  $s,\n");

  void write(final string s, final int s1) => //
      write__raw("$prefix$s = ${b__mode ? s1 : "'${string.fromCharCode(s1)}'"}");

  void process(final string s) {
    s.split("\n").forEach((final s_) {
      final s__ = s_.split(char__space);
      write(s__[0], s__[1].codeUnitAt(0));
    });
  }

  process(a);

  for (int i = 0; i < 26; i += 1) {
    final //
        cu = (65 + i),
        su = string.fromCharCode(cu),
        cl = (97 + i),
        sl = string.fromCharCode(cl);

    write("alphabet__case__upper__$sl", cu);
    write__raw("  ${prefix}alphabet__$su = ${prefix}alphabet__case__upper__$sl,\n");
  }

  process(b);

  for (int i = 0; i < 26; i += 1) {
    final //
        c = (97 + i),
        s = string.fromCharCode(c);
    write("alphabet__case__lower__$s", c);
    write__raw("  ${prefix}alphabet__$s = ${prefix}alphabet__case__lower__$s,\n");
  }

  process(c);

  write__raw(";");

  return result.toString();
}
