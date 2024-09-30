part of "_.dart";

class _stack__element__kampa<T> {
  const _stack__element__kampa(
    this.value,
    this.previous,
  );

  final T value;
  final _stack__element__kampa<T>? previous;
}

//typedef stack__element__kampa<T> = _stack__element__kampa<T>;

class base__stack<T> {
  base__stack();

  uu elements__count = 0;

  _stack__element__kampa<T>? element__last;

  bool get empty__ok => //
      (elements__count == 0);

  T? get element__last__value => //
      element__last?.value;

  void flush() {
    element__last = null;
    elements__count = 0;
  }

  void add(final T value) {
    element__last = _stack__element__kampa<T>(
      value,
      element__last,
    );

    elements__count += 1;
  }

  void push(final T value) => //
      add(value);

  T? remove() {
    final _stack__element__kampa<T>? last_ = element__last;

    if (last_ == null) {
      return null;
    }

    element__last = last_.previous;

    elements__count -= 1;

    return last_.value;
  }

  void pop() => //
      remove();

  void iterate(final bool Function(T element) function) {
    _stack__element__kampa<T>? iterator = element__last;

    while (iterator != null) {
      if (!function(iterator.value)) {
        break;
      }

      iterator = iterator.previous;
    }
  }

  void iterate__basic(final void Function(T element) function) => //
      iterate((final T element) {
        function(element);
        return OK;
      });

  T? contained(final bool Function(T element) b__check) {
    T? result;

    this.iterate((final element_) {
      if (b__check(element_)) {
        result = element_;
        return NO;
      }

      return OK;
    });

    return result;
  }

  bool b__contained(final bool Function(T element) b__check) => //
      (contained(b__check) != null);

  string convert__str([
    final bool b_verbose = NO,
  ]) {
    final buffer = StringBuffer("count: ")..write(elements__count);

    if (b_verbose) {
      buffer
        ..write(", last: ")
        ..write(element__last.convert__string())
        ..write(", last.value: ")
        ..write(element__last__value);
    }

    return buffer.toString();
  }

  array<T> convert__array() {
    final buf_ = base__accumulation<T>();

    iterate__basic(
      buf_.add__element,
    );

    final result = buf_.convert__array();
    buf_.dispose();

    return result;
  }

  string convert__string() {
    final buffer = StringBuffer("count: ") //
      ..write(elements__count);

    buffer
      ..write(", last.value: ")
      ..write(element__last__value);

    return buffer.convert__string();
  }
}
