part of "_.dart";

void divide(
  final int nume,
  final int deno,
) {
  final bool isNegative;

  final int _deno;

  int //
      _nume,
      counter = 0;

  {
    if (nume < 0) {
      if (deno < 0) /* `deno` is ALSO -ve, hence result in +ve, as -ve cancel each other */ {
        _nume = -nume;
        _deno = -deno;
        isNegative = NO;
      } else /* ONLY `nume` is -ve, hence result in -ve */ {
        _nume = -nume;
        _deno = deno;
        isNegative = OK;
      }
    } else if (deno < 0) /* ONLY `deno` is -ve, hence result in -ve */ {
      _nume = nume;
      _deno = -deno;
      isNegative = OK;
    } else {
      _nume = nume;
      _deno = deno;
      isNegative = NO;
    }
  }

  while (_nume > 0) {
    _nume -= _deno;
    counter += 1;
    //print("\t$_nume  $counter");
  }

  print("$nume == " +
      (isNegative ? "-" : '') +
      ((_nume == 0) //
          ? "($deno * $counter)"
          : "(($deno * ${counter - 1}) + ${_nume + deno})"));
}

void divideStdLib(
  final int nume,
  final int deno,
) {
  final int _nume = (nume % deno);

  print("$nume == " +
      ((_nume == 0) //
          ? "($deno * ${nume ~/ deno})"
          : "(($deno * ${nume ~/ deno}) + $_nume)"));
}

void basic__math___divide__test() {
  const int //
      deno = 3;

  <int>[
    33,
    32,
    13,
    7,
    6,
    3,
    2,
    1,
    0,
    -1,
    -2,
    -3,
    -6,
    -7,
    -13,
    -32,
    -33,
  ].forEach((final int nume) {
    print("$nume ~/ $deno");

    divide(nume, deno);

    divideStdLib(nume, deno);

    print("\t${nume / deno}");
  });
}
