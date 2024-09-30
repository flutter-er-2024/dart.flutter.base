import "package:base/base/_.dart";
import "package:base/by.arr.dart";
import "package:base/print.dart";
import "package:base/uu.size.dart";

import "_.dart";
import "_.io.dart";
import "table/_.dart";
import "table/_.io.dart";
import "table/column.dart";

void base__storage__data__tbl__create(
  final base__storage__data__meta__kampa ds___meta, {
  required final by__arr column__bytes,
  required final uu__size__id__enum rows__count__size__id_,
  required final uu rows__count__max,
  required final sz row__size,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__tbl__create",
      ds___meta.debug__label,
    );

  base__printing__indentation__increase();

  base__copy(
    column__bytes,
    uu__cast__bys__basic(
      base__storage__data__write__reserve(
        ds___meta,
        (rows__count__max * row__size),
      ),
      base__storage__data__position__size__id_,
    ),
    count: base__storage__data__position__size,
  );

  by__array__fill(
    column__bytes.view(
      base__storage__data__position__size,
    ),
    count: uu__size__id__convert(
      rows__count__size__id_,
    ),
  );

  base__printing__indentation__decrease();
}

class base__storage__data__tbl__meta__kampa //
    extends base__storage__data__table__meta__protocol {
  base__storage__data__tbl__meta__kampa({
    required super.rows__count,
    required super.rows__count__size__id_,
    required super.row__size,
    required this.rows__count__max,
    required this.table__bytes__base__storage__data__offset,
    required final uu tbl__meta__bytes__base__storage__data__offset,
  }) : rows__count__bytes__base__storage__data__offset = (base__storage__data__position__size + tbl__meta__bytes__base__storage__data__offset);

  final uu //
      rows__count__max,
      table__bytes__base__storage__data__offset,
      rows__count__bytes__base__storage__data__offset;
}

void base__storage__data__tbl__meta__convert__report__info(
  final base__storage__data__tbl__meta__kampa tbl__meta,
) =>
    record__convert__report__info({
      "table__bytes__base__storage__data__offset": tbl__meta.table__bytes__base__storage__data__offset.convert__string(),
      "rows__count__bytes__base__storage__data__offset": tbl__meta.rows__count__bytes__base__storage__data__offset.convert__string(),
    });

uu /*row__id_*/ base__storage__data__tbl__row__add(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tbl__meta__kampa tbl__meta,
  final by__arr bytes /* any `bytes`__count, more than `row__size`, are ignored */,
) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__data__tbl__row__add",
      tbl__meta.debug__label,
    );

    bytes.convert__text__representation().print(
          "bytes",
        );
  }

  base__printing__indentation__increase();

  final row__id_ = tbl__meta.rows__count;

  base__storage__data__table__row__ensure__space(
    rows__count: row__id_,
    rows__count__max: tbl__meta.rows__count__max,
  );

  base__storage__data__write(
    ds___meta,
    bytes: bytes,
    bytes__count: tbl__meta.row__size,
    base__storage__data__offset: base__storage__data__table__row__bytes__base__storage__data__offset(
      row__id_: row__id_,
      row__size: tbl__meta.row__size,
      table__bytes__base__storage__data__offset: tbl__meta.table__bytes__base__storage__data__offset,
    ),
  );

  tbl__meta.rows__count += 1;

  base__printing__indentation__decrease();

  return row__id_;
}

void base__storage__data__tbl__rows__count__update(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tbl__meta__kampa tbl__meta, {
  required final uu rows__count__base__storage__data__offset,
}) =>
    base__storage__data__table__rows__count__update(
      ds___meta,
      tbl__meta,
      rows__count__bytes__base__storage__data__offset: tbl__meta.rows__count__bytes__base__storage__data__offset,
    );

base__storage__data__table__row__kampa base__storage__data__tbl__row(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tbl__meta__kampa tbl__meta, {
  required final uu row__id_,
  required final by__arr? bytes /* write(or mod) | read */,
  uu? count /* un-check for correct-ness; use with care */,
  final uu rows__count /* ignored if `count` is non-null */ = 1,
  final uu row__offset = 0,
}) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__data__tbl__row",
      tbl__meta.debug__label,
    );

    row__id_.convert__text__representation().print("row__id");
  }

  base__printing__indentation__increase();

  base__storage__data__table__row__ensure__exists(
    row__id_: ((rows__count < 2) /* `!(rows__count > 1)` */ //
        ? row__id_
        : (row__id_ + (rows__count - 1))),
    rows__count: tbl__meta.rows__count,
  );

  count ??= base__storage__data__table__row__bytes__count(
    row__size: tbl__meta.row__size,
    rows__count: rows__count,
    row__offset: row__offset,
  );

  final offset = base__storage__data__table__row__bytes__base__storage__data__offset(
    row__id_: row__id_,
    row__size: tbl__meta.row__size,
    table__bytes__base__storage__data__offset: tbl__meta.table__bytes__base__storage__data__offset,
    row__offset: row__offset,
  );

  if (bytes == null) {
    final bytes = base__storage__data__read(
      ds___meta,
      count: count,
      base__storage__data__offset: offset,
    );

    base__printing__indentation__decrease();

    return (
      bytes: bytes,
      bytes__base__storage__data__offset: offset,
    );
  } else {
    base__storage__data__write__replace(
      ds___meta,
      bytes: bytes,
      bytes__count: count,
      base__storage__data__offset: offset,
    );

    base__printing__indentation__decrease();

    return (
      bytes: bytes,
      bytes__base__storage__data__offset: offset,
    );
  }
}

base__storage__data__table__row__column__kampa base__storage__data__tbl__row__column(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tbl__meta__kampa tbl__meta, {
  required final uu row__id_,
  required final by__arr? bytes,
  required final base__storage__data__table__column__kampa table__column,
}) /* macro */ =>
    base__storage__data__tbl__row(
      ds___meta,
      tbl__meta,
      row__id_: row__id_,
      bytes: bytes,
      count: base__storage__data__table__column__size(
        table__column,
      ),
      row__offset: table__column.meta.offset,
    );

by__arr base__storage__data__tbl__rows__all(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tbl__meta__kampa tbl__meta,
) /*
  read all the rows, in one op
  most time efficient
    even if, a single column need to be access-ed; but, of each row, of the table
    despite the presence of `base__storage__file__fast` layer, above `storage__persistent`
      because direct access, is always faster, than in-direct access, even in-memory
  least space efficient */
    =>
    base__storage__data__tbl__row(
      ds___meta,
      tbl__meta,
      row__id_: 0,
      bytes: NIL,
      rows__count: tbl__meta.rows__count,
    ).bytes;
