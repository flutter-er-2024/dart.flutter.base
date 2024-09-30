part of "_.dart";

dictionary<key__type, value__type> //
    dictionary__generate //
    <key__type, value__type>(
  final uu count,
  final ({
    key__type key,
    value__type value,
  })
          Function(uu)
      generate,
) {
  final result = <key__type, value__type>{};

  base__iterate__basic(count, (final i) {
    final kv = generate(i);
    result[kv.key] = kv.value;
  });

  return result;
}

extension dictionary__extension<key__type, value__type> //
    on dictionary<key__type, value__type> {
  uu get elements__count => //
      length;

  bool empty__ok() => //
      (this.elements__count == 0);

  bool empty__not() => //
      (this.elements__count != 0);
}

extension dictionary__print__extension //
    <key__type extends Object?, value__type extends Object?> //
    on dictionary<key__type, value__type>? {
  base__text__representation //
      convert__text__representation([
    final string Function(key__type)? key__convert__string,
    final string Function(value__type)? value__convert__string,
    final bool elements__truncate__ok = NO,
  ]) {
    final this_1 = this;

    if (this_1 == null) {
      return Null__text;
    }

    final //
        element__separat_or = (elements__truncate__ok.not ? char__line_feed : char__space),
        buffer = StringBuffer()
          ..write(char__bracket__square__open)
          ..write(char__space);

    if (this_1.empty__not()) {
      final //
          key__convert__string_1 = (key__convert__string ?? base__value__nil_able__convert__string<key__type>),
          value__convert__string_1 = (value__convert__string ?? base__value__nil_able__convert__string<value__type>);

      var element__first__ok = OK;

      this_1.forEach((
        final key__type key,
        final value__type value,
      ) {
        if (element__first__ok.not) {
          buffer
            ..write(element__separat_or)
            ..write(char__comma);
        } else {
          element__first__ok = NO;
        }

        buffer
          ..write(key__convert__string_1(key))
          ..write(char__space)
          ..write(char__equal)
          ..write(value__convert__string_1(value));
      });
    }

    buffer
      ..write(char__space)
      ..write(char__bracket__square__close);

    final result = buffer.toString();

    buffer.clear();

    return base__text__representation(
      result,
    );
  }
}
