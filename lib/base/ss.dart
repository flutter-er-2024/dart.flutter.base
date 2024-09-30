part of "_.dart";

enum base__ss__string__digits__fixed__truncation {
  beginning,
  ending,
}

class base__ss__string__digits__fixed {
  base__ss__string__digits__fixed(
    this.value__raw, {
    required this.negative__ok,
    required this.digits__count,
    required this.truncation,
  });

  final uu digits__count;

  final base__ss__string__digits__fixed__truncation? truncation;

  uu value__raw;

  bool negative__ok;

  void value__set(
    ss value__new,
  ) {
    if (negative__ok != value__new.isNegative) {
      negative__ok = value__new.isNegative;
    }

    if (negative__ok) {
      value__new = -value__new;
    }

    if (value__raw != value__new) {
      value__raw = value__new;
    }
  }

  string //
      value__convert__string() {
    final //
        value__string = value__raw.convert__string(),
        value__string__chars___count = value__string.chars___count,
        buffer = StringBuffer();

    if (negative__ok) {
      buffer.write(
        char__dash,
      );
    }

    if (value__string__chars___count < digits__count) {
      buffer
        ..write(zero * (digits__count - value__string__chars___count))
        ..write(value__string);
    } else if (value__string__chars___count > digits__count) {
      switch (truncation) {
        case NIL:
          {
            buffer.write(value__string);
          }
          break;
        case base__ss__string__digits__fixed__truncation.beginning:
          {
            buffer.write(
              value__string.substring(
                0,
                digits__count,
              ),
            );
          }
          break;
        case base__ss__string__digits__fixed__truncation.ending:
          {
            buffer.write(
              value__string.substring(
                (value__string__chars___count - digits__count),
                value__string__chars___count,
              ),
            );
          }
          break;
      }
    } else /*if (mantissa__string__chars___count == mantissa__digits__count)*/ {
      buffer.write(value__string);
    }

    final result = buffer.convert__string();

    buffer.clear();

    return result;
  }
}
