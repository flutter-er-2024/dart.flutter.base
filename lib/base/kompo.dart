part of "_.dart";

typedef base__kampa__member__dictionary = dictionary<string, Object?>;

base__text__representation base__kampa__convert__text__representation(
  final string name,
  final base__kampa__member__dictionary members,
) {
  final buffer = StringBuffer()
    ..write(name)
    ..write(char__space)
    ..write(char__bracket__round__open);

  if (members.empty__not()) {
    var element__first__ok = OK;

    members.forEach((
      final name,
      final value,
    ) {
      if (element__first__ok.not) {
        buffer
          ..write(char__space)
          ..write(char__comma);
      } else {
        element__first__ok = NO;
      }

      buffer
        ..write(char__dot)
        ..write(name)
        ..write(char__equal)
        ..write(value.convert__string());
    });
  }

  buffer.write(char__bracket__round__close);

  final result = buffer.convert__string();

  buffer.clear();

  return base__text__representation(
    result,
  );
}
