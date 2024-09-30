part of "_.dart";

extension Iterable__extension<T> on Iterable<T> {
  bool get empty__ok => //
      isEmpty;

  bool get empty__not => //
      isNotEmpty;

  Iterable<T>? get empty__not__else__null => //
      (empty__not ? this :  null);
}
