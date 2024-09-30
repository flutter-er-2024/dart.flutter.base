import "package:base/arr.dart";
import "package:base/base/_.dart";
import "package:base/by.arr.dart";
import "package:base/print.dart";

import "_.dart";
import "_.io.dart";
import "table/_.dart";
import "table/column.dart";
import "table/row.column.io.dart";
import "tar.dart";
import "tbl.dart";

/*
  `table__main != main__tbl`
    former is a member/element of `main__tbl`
    latter is the persisted(to ds.), representation, of `table__main__arr` */

typedef base__storage__data__table__main__array__kampa = //
    array<base__storage__data__table__column__kampa>;

void base__storage__data__table__main__array__write(
  final base__storage__data__meta__kampa ds___meta, {
  required final base__storage__data__table__main__array__kampa table__main__arr,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__tbl__main__write",
      ds___meta.debug__label,
    );

  base__printing__indentation__increase();

  final //
      table__array__count = table__main__arr.elements__count,
      tbl__size = base__storage__data__main__tbl__size(
        table__array__count,
      ),
      tbl__bytes = by__arr(
        tbl__size,
      );

  base__iterate__reverse__basic(
    table__array__count,
    (final table__id_) {
      final //
          table__column = table__main__arr[table__id_],
          bytes /* macro */ = tbl__bytes.view(
            base__storage__data__main__tbl__size(
              table__id_,
            ),
          );

      switch (table__column.type) {
        case base__storage__data__table__column__type__enum.tar:
          base__storage__data__tar__create(
            ds___meta,
            column__bytes: bytes,
            rows__count__size__id_: (table__column.meta as base__storage__data__table__column__type__tar__meta__kampa).rows__count__size__id_,
          );

          break;

        case base__storage__data__table__column__type__enum.tbl:
          final column__meta = (table__column.meta as base__storage__data__table__column__type__tbl__meta__kampa);

          base__storage__data__tbl__create(
            ds___meta,
            column__bytes: bytes,
            rows__count__size__id_: column__meta.rows__count__size__id_,
            rows__count__max: column__meta.rows__count__max,
            row__size: column__meta.row__size,
          );

          break;

        default:
          throw "ONLY allowed, `type`s are, `tar`, and `tbl`";
      }
    },
  );

  base__storage__data__write(
    ds___meta,
    bytes: tbl__bytes,
    bytes__count: tbl__size,
    base__storage__data__offset: base__storage__data__main__tbl__offset,
  );

  base__printing__indentation__decrease();
}

base__storage__data__table__meta__protocol base__storage__data__table__main__open(
  final base__storage__data__meta__kampa ds___meta, {
  required final base__storage__data__table__main__array__kampa table__main__arr,
  required final uu table__main__id_,
}) {
  if (debug__report_ing__ok) {
    base__function__call__print(
      "base__storage__data__tbl__main__table",
      ds___meta.debug__label,
    );

    table__main__id_.convert__text__representation().print("table__main__id");
  }

  base__printing__indentation__increase();

  final //
      column__bytes__base__storage__data__offset = //
          (base__storage__data__main__tbl__size(
                table__main__id_,
              ) +
              base__storage__data__main__tbl__offset),
      column__bytes = base__storage__data__read(
        ds___meta,
        count: (base__storage__data__table__main__rows__count__size + base__storage__data__position__size),
        base__storage__data__offset: column__bytes__base__storage__data__offset,
      ),
      table__column = table__main__arr[table__main__id_];

  final base__storage__data__table__meta__protocol result;

  switch (table__column.type) {
    case base__storage__data__table__column__type__enum.tar:
      final //
          column__meta = (table__column.meta as base__storage__data__table__column__type__tar__meta__kampa),
          details /* ignored, if `(rows__count == 0)` */ = base__storage__data__table__row__column__type__in_direct__bytes__read(
            column__meta: column__meta,
            column__bytes: column__bytes,
          );

      result = base__storage__data__tar__meta__kampa(
        rows__count: details.count,
        rows__count__size__id_: column__meta.rows__count__size__id_,
        row__size: column__meta.row__size,
        tar__meta__bytes__base__storage__data__offset: column__bytes__base__storage__data__offset,
        table__array__bytes__base__storage__data__offset: details.base__storage__data__offset,
        rows__count__multiplier__initial: column__meta.rows__count__multiplier__initial,
      );

      break;

    case base__storage__data__table__column__type__enum.tbl:
      final //
          column__meta = (table__column.meta as base__storage__data__table__column__type__tbl__meta__kampa),
          details = base__storage__data__table__row__column__type__in_direct__bytes__read(
            column__meta: column__meta,
            column__bytes: column__bytes,
          );

      result = base__storage__data__tbl__meta__kampa(
        rows__count: details.count,
        rows__count__size__id_: column__meta.rows__count__size__id_,
        rows__count__max: column__meta.rows__count__max,
        row__size: column__meta.row__size,
        table__bytes__base__storage__data__offset: details.base__storage__data__offset,
        tbl__meta__bytes__base__storage__data__offset: column__bytes__base__storage__data__offset,
      );

      break;

    default:
      throw Exception();
  }

  base__printing__indentation__decrease();

  return result;
}
