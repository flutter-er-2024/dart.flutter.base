part of "_.dart";

class union {
  union(
    this._value,
    this._types,
  );

  final array<Type> _types /*
sub-typing is not supported
/*must be ordered in narrow-to-wide sequence 
  ,like `[u8 ,u16 ,u24 ,... ,uu]` ,because `u8` is `u16` ,but `u16` is-not `u8`*/ */
      ;

  dynamic _value;

  dynamic get value => //
      _value;

  void value__set(
    final dynamic value__new,
  ) {
    var type__ok = NO;

    _types.iterate(
      (
        final _,
        final e,
      ) {
        if (value__new.runtimeType == e) {
          type__ok = OK;

          return NO;
        }

        return OK;
      },
    );

    if (type__ok.not) {
      throw "\"$value__new\" of type `${value__new.runtimeType}` ,cannot be assigned to union$_types";
    }

    _value = value__new;
  }

  bool equal__ok(
    final union other,
  ) /*
`_types` is ignored */
  {
    return ((runtimeType == other.runtimeType) //
        &&
        (_value == other._value));
  }

  @override
  bool operator ==(
    final Object other,
  ) {
    return ((other is union) &&
        equal__ok(
          other,
        ));
  }

  string convert__string() {
    return "<${_value.runtimeType}>${_value ?? Null__value__string}";
  }

  @override
  String toString() => //
      convert__string();
}

void union__test() {
  final u = union(
    NIL,
    [Null, uu, string],
  );

  void value__set(
    final dynamic value__new,
  ) {
    u
      ..toString().print("u.value.before")
      ..value__set(value__new)
      ..toString().print("u.value");
  }

  value__set("zero");
  value__set("zer0");
  value__set("0");
  value__set(0);
  value__set(1);
  value__set("one");
  value__set(1.0);
  value__set(NIL);
}
