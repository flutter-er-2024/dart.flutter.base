import "package:base/base/_.dart";
import "package:base/by.arr.dart";
import "package:base/uu.size.dart";

import "../_.dart";
import "../_.io.dart";
import "../tar.dart";
import "../tbl.dart";

import "column.dart";

sz base__storage__data__table__row__column__type__uit__write({
  required final by__arr column__bytes,
  required final uu__size__id__enum size__id_,
  required final uu value,
}) {
  final value_ = uu__cast__bys(
    value,
    size__id_,
  );

  base__copy(
    column__bytes,
    value_.bys,
  );

  return value_.size;
}

sz base__storage__data__table__row__column__type__uit__write__nil_able({
  required final by__arr column__bytes,
  required final uu__size__id__enum size__id_,
  required final uu? data,
}) {
  if (data !=  null) //
    return base__storage__data__table__row__column__type__uit__write(
      column__bytes: column__bytes,
      size__id_: size__id_,
      value: (data + 1),
    );

  final size = uu__size__id__convert(
    size__id_,
  );

  by__array__fill(
    column__bytes,
    count: size,
  );

  return size;
}

void base__storage__data__table__row__column__type__in_direct__write__nil({
  required final by__arr column__bytes,
}) /*
  `(base__storage__data__offset == 0)` implies `null`.
    like c-lang */
    =>
    by__array__fill(
      column__bytes,
      count: base__storage__data__position__size,
    );

void base__storage__data__table__row__column__type__rbt__write({
  required final base__storage__data__meta__kampa ds___meta,
  required final uu__size__id__enum count__size__id_,
  required final by__arr column__bytes,
  required final by__arr data,
  required final bool b__replace,
}) {
  if (b__replace) //
    ds___meta.wastage__change += uu__bys__cast__basic(
      column__bytes.view(
        base__storage__data__position__size,
      ),
      count__size__id_,
    ) /*data__old__count*/;

  final data__count = uu__cast__bys(
    data.bys__count,
    count__size__id_,
  );

  base__copy(
    column__bytes,
    data__count.bys,
    dest__offset: base__copy(
      column__bytes,
      uu__cast__bys__basic(
        base__storage__data__write__append(
          ds___meta,
          data,
        ),
        base__storage__data__position__size__id_,
      ),
      count: base__storage__data__position__size,
    ).dest__offset__new,
    count: data__count.size,
  );
}

void base__storage__data__table__row__column__type__tar__write({
  required final base__storage__data__meta__kampa ds___meta,
  required final uu__size__id__enum rows__count__size__id_,
  required final by__arr column__bytes,
}) =>
    base__storage__data__tar__create(
      ds___meta,
      column__bytes: column__bytes,
      rows__count__size__id_: rows__count__size__id_,
    );

void base__storage__data__table__row__column__type__ear__write({
  required final base__storage__data__meta__kampa ds___meta,
  required final uu__size__id__enum elements__count__size__id_,
  required final by__arr column__bytes,
  required final uu elements__count,
  required final by__arr elements__bys,
}) {
  final elements__count_ = uu__cast__bys(
    elements__count,
    elements__count__size__id_,
  );

  base__copy(
    column__bytes,
    elements__count_.bys,
    dest__offset: base__copy(
      column__bytes,
      uu__cast__bys__basic(
        base__storage__data__write__append(
          ds___meta,
          elements__bys,
        ),
        base__storage__data__position__size__id_,
      ),
      count: base__storage__data__position__size,
    ).dest__offset__new,
    count: elements__count_.size,
  );
}

void base__storage__data__table__row__column__type__irb__write({
  required final by__arr column__bytes,
  required final sz size,
  required final by__arr data,
}) {
  base__copy(
    column__bytes,
    data,
    count: size,
  );
}

void base__storage__data__table__row__column__type__tbl__write({
  required final base__storage__data__meta__kampa ds___meta,
  required final uu__size__id__enum rows__count__size__id_,
  required final uu rows__count__max,
  required final sz row__size,
  required final by__arr column__bytes,
}) =>
    base__storage__data__tbl__create(
      ds___meta,
      column__bytes: column__bytes,
      rows__count__size__id_: rows__count__size__id_,
      rows__count__max: rows__count__max,
      row__size: row__size,
    );

by__arr base__storage__data__table__row__column__bytes({
  required final base__storage__data__table__column__kampa table__column,
}) =>
    by__arr(
      base__storage__data__table__column__size(
        table__column,
      ),
    );

uu /*value*/ base__storage__data__table__row__column__type__uit__read({
  required final by__arr column__bytes,
  required final uu__size__id__enum size__id_,
}) =>
    uu__bys__cast__basic(
      column__bytes,
      size__id_,
    );

uu? /*data*/ base__storage__data__table__row__column__type__uit__read__nil_able({
  required final by__arr column__bytes,
  required final uu__size__id__enum size__id_,
}) {
  final value = base__storage__data__table__row__column__type__uit__read(
    column__bytes: column__bytes,
    size__id_: size__id_,
  );

  return ((value > 0) //
      ? (value - 1)
      :  null);
}

({
  uu count,
  uu base__storage__data__offset,
}) base__storage__data__table__row__column__type__in_direct__bytes__read({
  required final base__storage__data__table__column__type__in_direct__meta__protocol column__meta,
  required final by__arr column__bytes,
}) =>
    (
      count: uu__bys__cast__basic(
        column__bytes.view(
          base__storage__data__position__size,
        ),
        column__meta.count__size__id_,
      ),
      base__storage__data__offset: uu__bys__cast__basic(
        column__bytes,
        base__storage__data__position__size__id_,
      ),
    );
