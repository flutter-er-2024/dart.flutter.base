import "package:base/base/_.dart";
import "package:base/print.dart";
import "package:base/uu.size.dart";

typedef base__storage__data__table__row__kampa = ({
  by__arr bytes,
  uu bytes__base__storage__data__offset,
});

typedef base__storage__data__table__row__column__kampa = //
    base__storage__data__table__row__kampa;

abstract class base__storage__data__table__meta__protocol /*
  FACT
    `(table == row__arr == struct__arr)`
    `(row == struct)`
    `(row__column == struct__member)`
    `(table__arr` == `row__array__arr)` */
{
  base__storage__data__table__meta__protocol({
    required this.rows__count,
    required this.rows__count__size__id_,
    required this.row__size,
  });

  uu //
      rows__count /* `row_counter`, next `row__id`, always less than `rows__count`(`(rows__count__current + rows__count__current)`) */;

  final uu__size__id__enum //
      rows__count__size__id_;

  final uu //
      row__size /* row__bytes__count */;
}

report__info base__storage__data__table__meta__convert__report__info(
  final base__storage__data__table__meta__protocol table__meta,
) =>
    record__convert__report__info({
      "rows__count": table__meta.rows__count.convert__string(),
      "rows__count__size__id": table__meta.rows__count__size__id.name.convert__string(),
      "row__size": table__meta.row__size.convert__string(),
    });
