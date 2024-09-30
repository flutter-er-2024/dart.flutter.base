part of "_.dart";

array<element__type> array__new__copy<element__type>(
  final array<element__type> arr_, {
  final uu offset = 0,
  final uu? count,
}) =>
    arr_.sublist(
      offset,
      ((count ?? arr_.elements__count) + offset),
    );

array<element__type> array__new__fill<element__type>(
  final uu count,
  final element__type value,
) =>
    array<element__type>.filled(
      count,
      value,
      growable: NO,
    );

array<element__type> array__new__generate<element__type>(
  final uu count,
  final element__type Function(uu i) generate,
) =>
    array<element__type>.generate(
      count,
      generate,
      growable: NO,
    );

array<element__type> //
    array__new__empty<element__type>() => //
        array__new__generate<element__type>(
          0,
          (final _) => throw Exception(),
        );

array<element__type> array__new__elements__single<element__type>(
  final element__type value,
) =>
    array__new__fill<element__type>(
      1,
      value,
    );

extension array__array__merge_ing<element__type> //
    on array<array<element__type>> {
  array<element__type> merge() {
    var elements__count = 0;

    iterate__reverse__basic(
      (final _, final e) {
        elements__count += e.elements__count;
      },
    );

    elements__count.convert__text__representation().print("elements__count");

    var //
        element__offset = 0,
        array__offset = 0;

    final result = array__new__generate(
      elements__count,
      (var element__id_) {
        "$element__id_   $element__offset   $array__offset".print();

        element__id_ -= element__offset;

        final array = element(
          array__offset,
        );

        final result = array[element__id_];

        if /*F*/ ((element__id_ += 1) == array.elements__count) {
          element__offset += array.elements__count;
          array__offset += 1;
        }

        return result;
      },
    );

    return result;
  }

  void merge__test() {
    ([
      [3, 2, 1],
      [6, 5, 4],
      [9, 8, 7],
      [0],
      empty__arr
    ]..convert__text__representation().print("un_merge_ed"))
        .merge()
        .convert__text__representation()
        .convert__text__representation()
        .print("merge_ed");
  }
}

uu array__reverse__element__id_(
  final uu element__id_,
  final uu elements__count,
) =>
    ((elements__count - 1) - element__id_);

by__arr uu__array__convert__by__arr(
  final array<uu> arr,
) {
  arr.iterate__reverse__basic(
    (final i, final value) {
      if /*F*/ (value > u8__max) {
        throw "$value(`arr[$i]`) exceeds the limits of `by`";
      }
    },
  );

  return by__arr.fromList(
    arr,
  );
}

extension array__extension<element__type> on array<element__type> {
  uu get elements__count => //
      length;

  element__type get element__first => //
      first;

  set element__first(
    final element__type value,
  ) {
    first = value;
  }

  bool empty__ok() => //
      (this.elements__count == 0);

  bool empty__not() => //
      (this.elements__count != 0);

  array<element__type>? empty__not__else__nil() => //
      (empty__not() ? this : NIL);

  element__type element__last() => //
      this[this.elements__count - 1];

  void iterate(
    final bool Function(uu element__id_, element__type element) operate, {
    final uu? count,
    final uu offset = 0,
  }) =>
      base__iterate(
        (count ?? (this.elements__count - offset)),
        (final element__id_) => //
            operate(element__id_, this[element__id_]),
        offset: offset,
      );

  void iterate__basic(
    final void Function(uu element__id_, element__type element) operate, {
    final uu? count,
    final uu offset = 0,
  }) =>
      base__iterate__basic(
        (count ?? (this.elements__count - offset)),
        (final element__id_) => //
            operate(element__id_, this[element__id_]),
        offset: offset,
      );

  void iterate__reverse(
    final bool Function(uu element__id_, element__type element) operate, {
    final uu? count,
  }) {
    base__iterate__reverse(
      (count ?? this.elements__count),
      (final element__id_) {
        return operate(
          element__id_,
          this[element__id_],
        );
      },
    );
  }

  void iterate__reverse__basic(
    final void Function(uu element__id_, element__type element) operate, {
    final uu? count,
  }) =>
      base__iterate__reverse__basic(
        (count ?? this.elements__count),
        (final element__id_) => //
            operate(element__id_, this[element__id_]),
      );

  element__type element(
    final uu element__id_,
  ) =>
      this[element__id_];

  void fill(
    final element__type value, {
    uu? count,
    uu offset = 0,
  }) {
    count = ((count == null) //
        ? (elements__count - offset)
        : (count + offset));

    while (offset < count) {
      this[offset++] = value;
    }
  }

  uu? /*
un-equal element's id_, if any */
      un_equal__element__id_(
    final array<element__type> other, {
    final uu? count,
    final uu offset = 0,
  }) {
    uu? result;

    base__iterate(
      (count ?? other.elements__count),
      (final element__id_) {
        if (this[element__id_] == other[element__id_]) {
          return OK;
        }

        result = element__id_;

        return NO;
      },
      offset: offset,
    );

    return result;
  }

  bool equal__ok(
    final array<element__type> other,
  ) {
    if (elements__count != other.elements__count) {
      return NO;
    }

    return (un_equal__element__id_(other) == null);
  }

  bool equal__not(
    final array<element__type> other,
  ) {
    if (elements__count != other.elements__count) {
      return OK;
    }

    return (un_equal__element__id_(other) != null);
  }

  uu? /*
`id` if present ,otherwise NUL */
      search__simple(
    final bool Function(element__type) element__equal__ok, {
    final bool reverse__ok = NO,
  }) {
    uu? result;

    bool operate(
      final uu element__id_,
      final element__type element,
    ) {
      if (NOT(element__equal__ok(element))) {
        return OK;
      }

      result = element__id_;

      return NO;
    }

    (reverse__ok //
        ? iterate__reverse
        : iterate)(operate);

    return result;
  }

  uu? search(
    final element__type value,
    final bool Function(
      element__type element,
      element__type value,
    ) element__equal__ok, {
    final bool reverse__ok = NO,
  }) =>
      search__simple(
        (final e) => element__equal__ok(e, value),
        reverse__ok: reverse__ok,
      );

  uu? /*element__id_*/ search__segment(
    final array<element__type> segment,
  ) {
    uu? segment__element__id_;

    iterate(
      (final i, final e) {
        if (segment__element__id_ != NIL) {
          final $segment__element__id_ = (segment__element__id_ = (1 + segment__element__id_!));
          if /*F*/ (($segment__element__id_ == segment.elements__count) /*
whole `segment` has been iterated ,and was not un-equal to `this[(i-segment__element__id_)..segment.elements__count]` */ //
                  ||
                  (i == (elements__count - 1)) /*
`e` is the last element ,of `this` */
              ) /*
whole `segment` has been iterated ,and was not un-equal to `this[(i-segment__element__id_)..segment.elements__count]` */
          {
            segment__element__id_ = (i - $segment__element__id_) /* result */;
            return NO;
          }

          if /*T*/ (e != segment[$segment__element__id_]) {
            segment__element__id_ = NIL;
          }

          return OK;
        }

        if (e == segment.element__first) {
          segment__element__id_ = 0;
        }

        return OK;
      },
    );

    return segment__element__id_;
  }

  void search__segment__test() {
    [
      (input: [0, 1, 2, 3], segment: [0], result: 0),
      (input: [0, 1, 2, 3], segment: [0, 1], result: 0),
      (input: [0, 1, 2, 3], segment: [1], result: 1),
      (input: [0, 1, 2, 3], segment: [1, 2], result: 1),
      (input: [0, 1, 2, 3], segment: [1, 2, 3], result: 1),
      (input: [0, 1, 2, 3], segment: [1, 3], result: NIL),
    ].iterate__basic((final _, final e) {
      final result = e.input.search__segment(e.segment) //
        ..convert__text__representation().print("${e.input}.search__segment(${e.segment})");
      if (result != e.result) {
        throw "un-expected result :($result =~ ${e.result})";
      }
    });
  }

  bool search__segment__begin(
    final array<element__type> segment,
  ) /*
equality is not considered prefix 
  ,like `abc` is prefixed to `abcxyz` ,but neither `abcxyz` ,nor `xyzabc`
more run-time efficient ,than `search__segment` */
  {
    if ((elements__count > segment.elements__count).not) /*
`segment` can prefix `this` ,only if ,`segment`'s length is less than `this` */
    {
      return NO;
    } else if (element__first != segment.element__first) {
      return NO;
    }

    var prefix_ed__ok = OK;

    segment.iterate__reverse(
      (final i, final e) {
        if (e == this[i]) {
          return OK;
        } else {
          prefix_ed__ok = NO;
          return NO;
        }
      },
    );

    return prefix_ed__ok;
  }

  void search__segment__begin__test() {
    [
      (input: [0, 1, 2, 3], segment: [0, 1], result: OK),
      (input: [0, 1, 2, 3], segment: [1, 2], result: NO),
      (input: [0, 1, 2, 3], segment: [0, 1, 2, 3], result: NO),
      (input: [0, 1, 2], segment: [0, 1, 2, 3], result: NO),
    ].iterate__basic((final _, final e) {
      final result = e.input.search__segment__begin(e.segment) //
        ..convert__text__representation().print("${e.input}.search__segment__begin(${e.segment})");
      if (result != e.result) {
        throw "un-expected result :($result =~ ${e.result})";
      }
    });
  }

  bool contains__ok(
    final bool Function(element__type) element__equal__ok,
  ) =>
      (search__simple(
            element__equal__ok,
            reverse__ok: OK,
          ) !=
          null);

  bool contains__not(
    final bool Function(element__type) element__equal__ok,
  ) =>
      (search__simple(
            element__equal__ok,
            reverse__ok: OK,
          ) ==
          null);

  void element__remove(
    final uu element__id_,
  ) {
    removeAt(
      element__id_,
    );
  }

  bool remove(
    final bool Function(element__type) element__equal__ok,
  ) {
    final element__id_ = search__simple(
      element__equal__ok,
      reverse__ok: OK,
    );

    if (element__id_ == null) {
      return NO;
    }

    element__remove(
      element__id_,
    );

    return OK;
  }

  string join__string(
    final string Function(element__type) element__convert__string, [
    final string separator = ", ",
  ]) {
    if (empty__ok()) {
      return empty__string;
    }

    final buffer = StringBuffer(
      element__convert__string(element__first),
    );

    iterate__basic(
      (final _, final element) {
        buffer
          ..write(separator)
          ..write(element__convert__string(element));
      },
      offset: 1,
    );

    final result = buffer.toString();

    buffer.clear();

    return result;
  }

  array<element__new__type> //
      convert<element__new__type>(
    final element__new__type Function(element__type) operate,
  ) {
    return map(
      operate,
    ).toList(
      growable: NO,
    );
  }

  array<element__new__type> //
      convert__definitive<element__new__type>(
    final element__new__type Function(uu, element__type) operate,
  ) {
    var i = 0;

    return convert(
      (final e) => operate(i++, e),
    );
  }
}

extension array__convert__text__representation__extension //
    <element__type extends Object?> //
    on array<element__type>? {
  base__text__representation //
      convert__text__representation([
    final string Function(element__type)? element__convert__string,
    final bool elements__truncate__ok /* the middle part */ = OK,
  ]) {
    final this_1 = this;

    if (this_1 == null) {
      return Null__text;
    }

    final //
        buffer = StringBuffer(),
        elements__count_1 = this_1.elements__count;

    buffer
      ..write("<")
      ..write(
        element__type.convert__string(),
      )
      ..write("[")
      ..write(elements__count_1)
      ..write("]>")
      ..write("[ ");

    final element__convert__string_1 = (element__convert__string ?? base__value__nil_able__convert__string<element__type>);

    if (this_1.empty__not()) {
      if ((elements__count_1 > u8__limit) //
          &&
          elements__truncate__ok) {
        this_1.iterate__basic(
          (final _, final value) {
            buffer
              ..write(element__convert__string_1(value))
              ..write(" ,");
          },
          count: u7__limit,
        );

        buffer.write(static__indicate__short_en_ing);

        this_1.iterate__basic(
          (final _, final value) {
            buffer
              ..write(" ,")
              ..write(element__convert__string_1(value));
          },
          count: u7__limit,
          offset: (elements__count_1 - u7__limit),
        );
      } else {
        buffer.write(
          element__convert__string_1(this_1.element__first),
        );

        this_1.iterate__basic(
          (final _, final value) {
            buffer
              ..write(" ,")
              ..write(element__convert__string_1(value));
          },
          offset: 1,
        );
      }
    }

    buffer.write(" ]");

    final result = buffer.toString();

    buffer.clear();

    return base__text__representation(
      result,
    );
  }
}

extension element__type__array__report__definitive__extension<element__type> //
    on array<element__type> {
  string //
      convert__string__concise__definitive(
    final uu elements__count,
    final uu element__id_,
  ) {
    string element(
      final ss id___diff_,
    ) {
      return this[element__id_ + id___diff_].convert__string();
    }

    return ("$element__id_: $static__indicate__short_en_ing " + //
        (((element__id_ - 4) > 0) ? " ,${element(-4)}" : empty__string) +
        (((element__id_ - 3) > 0) ? " ,${element(-3)}" : empty__string) +
        (((element__id_ - 2) > 0) ? " ,${element(-2)}" : empty__string) +
        (((element__id_ - 1) > 0) ? " ,${element(-1)}" : empty__string) + //
        "  ,${element(0)} " + //
        (((element__id_ + 1) < elements__count) ? " ,${element(1)}" : empty__string) +
        (((element__id_ + 2) < elements__count) ? " ,${element(2)}" : empty__string) +
        (((element__id_ + 3) < elements__count) ? " ,${element(3)}" : empty__string) +
        (((element__id_ + 4) < elements__count) ? " ,${element(4)}" : empty__string) + //
        static__indicate__short_en_ing);
  }
}
