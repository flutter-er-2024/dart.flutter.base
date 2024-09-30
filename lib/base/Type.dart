part of "_.dart";

extension Type__convert__text__representation__extension //
    on Type {
  string //
      convert__string() => //
          Type__convert__string(
            this,
          );
}

string //
    Type__convert__string(
  final Type type,
) {
  return switch (type) {
    int => "uu|ss",
    uu => "uu",
    ss => "ss",
    fp => "fp",
    string => "string",
    _ => type.toString(),
  };
}
