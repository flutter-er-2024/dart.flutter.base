part of "_.dart";

extension fp__convert__text__representation__extension on fp {
  base__text__representation //
      convert__text__representation() => //
          base__value__convert__text__representation(
            this,
            Type__convert__string(fp),
          );
}

class base__fp__input__digits__fixed {
  base__fp__input__digits__fixed({
    final uu mantissa = 0,
    final bool mantissa__negative__ok = NO,
    final uu mantissa__digits__count = 3,
    final bool mantissa__truncate__ok = NO,
    final uu exponent = 0,
    final bool exponent__negative__ok = NO,
    final uu exponent__digits__count = 2,
    final bool exponent__truncate__ok = OK,
  })  : mantissa = base__ss__string__digits__fixed(
          mantissa,
          negative__ok: mantissa__negative__ok,
          digits__count: mantissa__digits__count,
          truncation: (mantissa__truncate__ok //
              ? base__ss__string__digits__fixed__truncation.ending
              : NIL),
        ),
        exponent = base__ss__string__digits__fixed(
          exponent,
          negative__ok: exponent__negative__ok,
          digits__count: exponent__digits__count,
          truncation: (exponent__truncate__ok //
              ? base__ss__string__digits__fixed__truncation.beginning
              : NIL),
        );

  final base__ss__string__digits__fixed //
      mantissa,
      exponent;

  void
      value__set__parse /*
throws ,for non-numbers and in-valid cases ,like `-.1`
absent non-negative mantissa is treated as zero
negative-zero is treated as non-negative */
      (
    final string value__new,
  ) {
    final values = value__new.split(
      char__dot,
    );

    if (values.elements__count > 2) {
      throw "more than one points";
    }

    {
      final value = values.element__first;

      if (value.empty__not()) {
        final mantissa_1 = ss.tryParse(
          value,
        );

        if (mantissa_1 == null) {
          throw "in-valid mantissa";
        }

        mantissa.value__set(
          mantissa_1,
        );
      } else {
        mantissa.value__set(
          0,
        );
      }
    }

    if (values.elements__count > 1) {
      final exponent_1 = ss.tryParse(
        values[1],
      );

      if (exponent_1 == null) {
        throw "in-valid exponent";
      }

      exponent.value__set(
        exponent_1,
      );
    }
  }

  string //
      value__convert__string() {
    return (mantissa.value__convert__string() + char__dot + exponent.value__convert__string());
  }
}

extension base__fp__input__digits__fixed__test //
    on base__fp__input__digits__fixed {
  void test() {
    [
      "0",
      ".0",
      "0.0",
      "-0",
      "-0.-0",
      ".-0",
      "1.1",
      "-1.1",
      "1.-1",
      "-1.-1",
      "12.12",
      "123.123",
      "-1234.-1234",
      "1234",
      ".1234",
    ].iterate__basic(
      (final _, final string v) {
        base__fp__input__digits__fixed(
          mantissa__truncate__ok: OK,
        )
          ..value__set__parse(v)
          ..value__convert__string().print();
        base__print__blank();
      },
    );
  }
}
