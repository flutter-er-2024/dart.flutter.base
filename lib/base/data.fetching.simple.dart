part of "_.dart";

typedef asyn___elements__accessing__simple__fetch__function__format<element__type> //
    = asyn___value<array<element__type>> Function(
  uu element__id___offset,
);

class asyn___elements__accessing__simple__raw /*
the `elements:count` of the batches's elements are not checked ,hence in-valid accessing is un-defined */ //
    <element__type> //
    extends base__dispose__protocol {
  asyn___elements__accessing__simple__raw({
    required this.batch__size,
    required this.fetch__handle,
    required this.error__retry__ok,
    this.error__re_try__count__max_ = 3,
  })  : elements__batch__raw = /*asyn___elements__accessing__simple__batch<element__type>(offset: 0,)*/ NIL,
        elements__batch__alt___raw = /*asyn___elements__accessing__simple__batch<element__type>(offset: batch__size,)*/ NIL;

  final uu batch__size;
  final asyn___elements__accessing__simple__fetch__function__format<element__type> fetch__handle;

  final bool Function(Object) error__retry__ok;
  final uu error__re_try__count__max_ /* excluding the 1st try (which is not a re-try) */;

  asyn___elements__accessing__simple__batch<element__type>? //
      elements__batch__raw /* main batch */,
      elements__batch__alt___raw;

  asyn___value<element__type> //
      elements__batch__set__raw({
    required final uu batch__offset,
    required final uu element__id_,
  }) {
    final //
        elements__batch = elements__batch__alt___set__raw(
          batch__offset,
        ),
        promise = asyn___promise<element__type>();

    elements__batch.handle(
      (final elements__batch) {
        elements__batch__raw = asyn___elements__accessing__simple__batch<element__type>(
          elements__batch,
          offset: batch__offset,
        );

        promise.complete(
          elements__batch[element__id_ - batch__offset],
        );
      },
      promise.completeError,
    );

    return promise.future;
  }

  asyn___value<array<element__type>> //
      elements__batch__alt___set__raw(
    final uu batch__offset, [
    final uu error__re_try__count = 0,
  ]) {
    final //
        batch__alt_ = elements__batch__alt___raw,
        elements__batch = ((batch__alt_ != null) && (batch__alt_.offset == batch__offset)) //
            ? (batch__alt_.value__raw as asyn___value<array<element__type>>)
            : fetch__handle(
                batch__offset,
              ),
        promise = asyn___promise<array<element__type>>();

    elements__batch.handle(
      (final value) {
        elements__batch__alt___raw = NIL;

        promise.complete(value);
      },
      (final e, final t) {
        if ((error__re_try__count <= error__re_try__count__max_) && error__retry__ok(e)) {
          elements__batch__alt___set__raw(
            batch__offset,
            (1 + error__re_try__count),
          ).handle(
            promise.complete,
            promise.completeError,
          );
        } else {
          promise.completeError(e, t);
        }
      },
    );

    if (batch__alt_ == NIL) {
      elements__batch__alt___raw = asyn___elements__accessing__simple__batch<element__type>(
        elements__batch,
        offset: batch__offset,
      );
    }

    return promise.future;
  }

  asyn___value__hybrid<element__type> //
      element(
    uu id_,
  ) {
    final batch = elements__batch__raw;

    if /*F\* can happen only the 1st time *\*/ (batch == null) {
      return elements__batch__set__raw(
        batch__offset: 0,
        element__id_: id_,
      );
    }

    final batch__offset = batch.offset;

    if (id_ < batch__offset) {
      return elements__batch__set__raw(
        batch__offset: (batch__offset - batch__size),
        element__id_: id_,
      );
    }

    {
      final batch__next__offset = (batch__size + batch__offset);

      if (id_ >= batch__next__offset) {
        return elements__batch__set__raw(
          batch__offset: batch__next__offset,
          element__id_: id_,
        );
      }
    }

    /*if (id_ < ((batch__size ~/ 2) + batch__offset)) {
      if /*F*/ (elements is asyn___value<array<element__type>>) {
        return elements.handle(
          (final elements) => elements[id_],
        );
      }
    } else {
      final batch__next__element__first__id_ = (batch__size + id_);
      if /*F*/ (elements__batch__alt___raw.offset != batch__next__element__first__id_) {
        elements__batch__alt___set__raw(
          batch__next__element__first__id_,
        );
      }
    }*/

    id_ -= batch__offset;

    final elements = batch.value__raw;

    if /*F*/ (elements is asyn___value<array<element__type>>) /*
should never happen ,in non-advanced caching */
    {
      base__procedure__call__print("(elements is asyn___value<array<element__type>>)");

      final promise = asyn___promise<element__type>();

      elements.handle(
        (final elements) => promise.complete(
          elements[id_],
        ),
        promise.completeError,
      );

      return promise.future;
    }

    return (elements as array<element__type>)[id_];
  }

  @override
  void dispose() {
    elements__batch__raw = NIL;
    elements__batch__alt___raw = NIL;
  }
}

class asyn___elements__accessing__simple__batch //
    <element__type> {
  asyn___elements__accessing__simple__batch(
    this.value__raw, {
    required this.offset,
  });

  Object /*UNION (array<element__type> ,asyn___value<array<element__type>>)*/
      value__raw;

  final uu offset;
}

asyn___value<void> asyn___elements__accessing__simple__raw__test() async {
  const batch__size = 4;

  var error__throw__count = 0;

  final caching = asyn___elements__accessing__simple__raw<string>(
    batch__size: batch__size,
    fetch__handle: (final offset) {
      if ((offset == (batch__size * 3)) && (error__throw__count < 2)) {
        error__throw__count += 1;

        return asyn___value.error(
          "error",
        );
      }

      return asyn___value.value(
        array__new__generate(
          batch__size,
          (final i) => "value:${(i + offset)}",
        ),
      );
    },
    error__retry__ok: (final e) {
      base__procedure__call__print("asyn___elements__accessing__simple__raw.error__retry__ok");

      return OK;
    },
  );

  base__print__blank();

  {
    await base__iterate__basic__asyn_(
      5,
      (final batch__id_) async {
        batch__id_.convert__text__representation().print("iteration:id_");
        base__printing__indentation__increase();
        await base__iterate__basic__asyn_(
          batch__size,
          (var element__id_) async {
            element__id_ += (batch__id_ * batch__size);

            (await caching.element(element__id_)).convert__text__representation().print("elements[$element__id_]");
          },
        );
        base__printing__indentation__decrease();
      },
    );

    base__print__blank();

    await base__iterate__reverse__basic__asyn_(
      4,
      (final batch__id_) async {
        batch__id_.convert__text__representation().print("iteration:reverse:id_");
        base__printing__indentation__increase();
        await base__iterate__reverse__basic__asyn_(
          batch__size,
          (var element__id_) async {
            element__id_ += (batch__id_ * batch__size);

            (await caching.element(element__id_)).convert__text__representation().print("elements[$element__id_]");
          },
        );
        base__printing__indentation__decrease();
      },
    );
  }

  caching.dispose();
}

void main() => //
    asyn___elements__accessing__simple__raw__test();
