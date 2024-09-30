import "package:base/base/_.dart";
import "package:base/by.arr.dart";
import "package:base/print.dart";
import "package:base/uu.size.dart";

import "_.dart";
import "_.io.dart";
import "table/_.dart";
import "table/_.io.dart";

class base__storage__data__ear__meta__kampa {
  const base__storage__data__ear__meta__kampa({
    required this.elements__count,
    required this.elements__count__size__id_,
    required this.element__size,
    required this.elements__bytes__base__storage__data__offset,
    required this.meta__bytes__base__storage__data__offset,
  });

  final uu //
      elements__count;

  final uu__size__id__enum //
      elements__count__size__id_;

  final sz //
      element__size;

  final uu //
      elements__bytes__base__storage__data__offset,
      meta__bytes__base__storage__data__offset;
}

typedef base__storage__data__ear__result__kampa = ({
  by__arr elements__bys,
  uu elements__count,
});

base__storage__data__ear__result__kampa base__storage__data__ear({
  required final uu elements__count,
  required final sz element__size,
  required final void Function(uu, by__arr) element__fill,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__ear",
    );

  base__printing__indentation__increase();

  final bys = by__arr(elements__count * element__size);

  base__iterate__basic(
      elements__count,
      (final element__id_) => //
          element__fill(
            element__id_,
            bys.view__partial(
              (element__id_ * element__size),
              element__size,
            ),
          ));

  base__printing__indentation__decrease();

  return (
    elements__bys: bys,
    elements__count: elements__count,
  );
}

base__storage__data__table__row__kampa base__storage__data__ear__element__read(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__ear__meta__kampa ear__meta, {
  required final uu element__id_,
  final uu elements__count = 1,
}) /*
  checkout `base__storage__data__tbl__row` */
{
  final uu count;
  if (elements__count < 2) {
    base__storage__data__table__row__ensure__exists(
      row__id_: element__id_,
      rows__count: elements__count,
    );

    count = ear__meta.element__size;
  } else {
    base__storage__data__table__row__ensure__exists(
      row__id_: (element__id_ + (elements__count - 1)),
      rows__count: elements__count,
    );

    count = (elements__count * ear__meta.element__size);
  }

  final offset = ((element__id_ * ear__meta.element__size) + //
      ear__meta.elements__bytes__base__storage__data__offset);

  return (
    bytes: base__storage__data__read(
      ds___meta,
      count: count,
      base__storage__data__offset: offset,
    ),
    bytes__base__storage__data__offset: offset,
  );
}

void base__storage__data__ear__elements__all__iterate(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__ear__meta__kampa ear__meta,
  final void Function(
    uu element__id_,
    by__arr element__bytes,
    uu element__bytes__base__storage__data__offset,
  ) element__handle,
) /*
  read all the elements, in one op, then iterate */
{
  final //
      elements__all = base__storage__data__ear__element__read(
        ds___meta,
        ear__meta,
        element__id_: 0,
        elements__count: ear__meta.elements__count,
      ),
      element__size = ear__meta.element__size;

  uu offset = /*column.row__offset*/ 0;

  base__iterate__basic(ear__meta.elements__count, (final element__id_) {
    element__handle(
      element__id_,
      elements__all.bytes.view__partial(
        offset,
        element__size,
      ),
      (offset + elements__all.bytes__base__storage__data__offset),
    );

    offset += element__size;
  });
}
