import "package:base/arr.dart";
import "package:base/base/_.dart";
import "package:base/by.arr.dart";
import "package:base/print.dart";

import "../_.dart";

import "column.dart";
import "row.column.io.auto.dart";

void base__storage__data__table__row__bytes__auto({
  required final base__storage__data__meta__kampa ds___meta,
  required final base__storage__data__table__columns__kampa table__columns,
  required final by__arr row__bytes,
  required final array<Object?> /*
  `count` MUST NOT `< table__columns.count` */
      data__arr,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__table__row__bytes__auto",
    );

  base__printing__indentation__increase();

  table__columns.iterate__reverse__basic(
    (final column__id_, final table__column) => //
        base__storage__data__table__row__column__bytes__auto(
      ds___meta: ds___meta,
      table__column: table__column,
      column__bytes: ((column__id_ != 0) //
          ? row__bytes.view(
              table__column.meta.offset,
            )
          : row__bytes),
      data: data__arr[column__id_],
      b__initial: OK,
    ),
  );

  base__printing__indentation__decrease();
}

void base__storage__data__table__row__bytes__mod__auto({
  required final base__storage__data__meta__kampa ds___meta,
  required final base__storage__data__table__columns__kampa table__columns,
  required final array<
          ({
            uu meta__id_,
            Object? data,
          })>
      column__arr,
  required final by__arr row__bytes,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__table__row__bytes__mod__auto",
    );

  base__printing__indentation__increase();

  column__arr.iterate__reverse__basic(
    (final _, final column) {
      final table__column = table__columns[column.meta__id_];

      base__storage__data__table__row__column__bytes__auto(
        ds___meta: ds___meta,
        table__column: table__column,
        column__bytes: row__bytes.view(
          table__column.meta.offset,
        ),
        data: column.data,
        b__initial: NO,
      );
    },
  );

  base__printing__indentation__decrease();
}

array<Object?> base__storage__data__table__row__data__array__auto({
  required final base__storage__data__meta__kampa ds___meta,
  required final base__storage__data__table__columns__kampa table__columns,
  required final array<uu> column__meta__id__arr,
  required final by__arr row__bytes,
  required final uu row__bytes__base__storage__data__offset,
}) /* macro */ {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print("base__storage__data__table__row__data__array__auto");

    row__bytes.convert__text__representation().print("arguments__row__bytes");
  }

  base__printing__indentation__increase();

  final result = array__new__generate(
    column__meta__id__arr.elements__count,
    (final column__id_) {
      final table__column = table__columns[column__meta__id__arr[column__id_]];

      /*if (debug__report_ing__verbose__ok) //
        report__uu(
          table__column.meta.offset,
          "table.column.meta.offset",
        );*/

      return base__storage__data__table__row__column__data__auto(
        ds___meta: ds___meta,
        table__column: table__column,
        column__bytes: row__bytes.view(
          table__column.meta.offset,
        ),
        column__bytes__base__storage__data__offset: (table__column.meta.offset + row__bytes__base__storage__data__offset),
      );
    },
  );

  base__printing__indentation__decrease();

  return result;
}
