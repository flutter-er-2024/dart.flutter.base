part of "_.dart";

typedef int__big = BigInt;
typedef uint__big = BigInt;

extension int__big__extension on int__big {
  bool value__zero__ok() {
    return ((bitLength == 0) && isNegative.not);
  }
}

extension int__convert__text__representation__extension on int {
  base__text__representation //
      convert__text__representation() => //
          base__value__convert__text__representation(
            this,
            Type__convert__string(int),
          );
}
