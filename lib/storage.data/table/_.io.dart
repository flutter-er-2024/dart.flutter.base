import "package:base/base/_.dart";
import "package:base/print.dart";
import "package:base/uu.size.dart";

import "../_.dart";
import "../_.io.dart";
import "_.dart";

/*sz base__storage__data__table__rows__count__size(
  final uu rows__count,
) {
  if (rows__count < u8__limit) {
    return u8__size;
  } else if (!(u16__size > base__storage__data__position__size) /*
  "`u16__size` is NOT MORE than `base__storage__data__position__size`"
  equal to "`u16__size` is EQUAL OR LESS than `base__storage__data__position__size`"
  if `base__storage__data__position__size` is standard(`u`*`__size`)
    also equal to "`u16__size` is EQUAL to `base__storage__data__position__size`" */
      && //
      (rows__count < u16__limit)) {
    return u16__size;
  } else if (!(u24__size > base__storage__data__position__size) && //
      (rows__count < u24__limit)) {
    return u24__size;
  } else if (!(u32__size > base__storage__data__position__size) && //
      (rows__count < u32__limit)) {
    return u32__size;
  } else if (!(u64__size > base__storage__data__position__size) && //
      (rows__count < u64__limit)) {
    return u64__size;
  } else {
    throw "$rows__count(row__count) exceeds the limits of $base__storage__data__position__size(base__storage__data__position__size)";
  }
}*/

void base__storage__data__table__row__ensure__space({
  required final uu rows__count,
  required final uu rows__count__max,
}) {
  if (!(rows__count < rows__count__max)) //
    throw "$rows__count__max(rows__count__max) reached; can NOT add any row";
}

void base__storage__data__table__row__ensure__exists({
  required final uu row__id_,
  required final uu rows__count,
}) {
  if (!(row__id_ < rows__count)) //
    throw "$row__id_(row__id_) does NOT exist";
}

uu base__storage__data__table__row__bytes__base__storage__data__offset({
  required final uu row__id_,
  required final uu row__size,
  required final uu table__bytes__base__storage__data__offset,
  final uu row__offset = 0,
}) =>
    ((row__offset + (row__id_ * row__size)) + table__bytes__base__storage__data__offset);

uu base__storage__data__table__row__bytes__count({
  required final uu row__size,
  final uu rows__count = 1,
  final uu row__offset = 0,
}) =>
    ((row__size * rows__count) - row__offset);

void base__storage__data__table__rows__count__update(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__table__meta__protocol table__meta, {
  required final uu rows__count__bytes__base__storage__data__offset,
}) /*
  MUST be called, AFTER, the whole process, if `table__row__add(` was called, during the process */
{
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__data__table__rows__count__update",
      table__meta.debug__label,
    );
  }

  base__printing__indentation__increase();

  final rows__count = uu__cast__bys(
    table__meta.rows__count,
    table__meta.rows__count__size__id_,
  );

  base__storage__data__write__replace(
    ds___meta,
    bytes: rows__count.bys,
    bytes__count: rows__count.size,
    base__storage__data__offset: rows__count__bytes__base__storage__data__offset,
  );

  base__printing__indentation__decrease();
}
