part of "_.dart";

class base__text__representation /*
`string` vs `text`
  the former is ,an array of char.s ,and a member of the type-system 
    ,while the latter is ,a representation of a value ,and {type-system}-independent abstraction */
{
  const base__text__representation(
    this.value,
  );

  final string value;
}

const Null__text = base__text__representation(
  Null__value__string,
);

extension base__text__representation__print__extension //
    on base__text__representation {
  void print([
    final string? path,
    final string? label,
  ]) {
    base__print__labeled(
      value,
      path,
      label,
    );
  }
}
