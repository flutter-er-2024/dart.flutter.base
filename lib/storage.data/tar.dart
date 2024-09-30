import "package:base/base/_.dart";
import "package:base/by.arr.dart";
import "package:base/print.dart";
import "package:base/uu.dart";
import "package:base/uu.size.dart";

import "_.dart";
import "_.io.dart";
import "table/_.dart";
import "table/_.io.dart";
import "table/column.dart";

void base__storage__data__tar__create(
  final base__storage__data__meta__kampa ds___meta, {
  required final by__arr column__bytes,
  required final uu__size__id__enum rows__count__size__id_,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__tar__create",
      ds___meta.debug__label,
    );

  base__printing__indentation__increase();

  by__array__fill(
    column__bytes,
    count: base__storage__data__position__size,
    value: 1,
  ); /*
  to mark the column, as definitely, NOT nil
    because garbage can be any value, even nil */

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

typedef base__storage__data__tar__table__meta__kampa = ({
  uu id_,
  uu row__id_,
  uu rows__count,
});

base__storage__data__tar__table__meta__kampa base__storage__data__tar__table__meta(
  final uu row__id_,
  final u8 rows__count__multiplier__initial,
) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__data__tar__table__meta",
    );

    row__id_.convert__text__representation().print(
          "row__id",
        );
  }

  base__printing__indentation__increase();

  uu //
      table__id_ = 0,
      table__row__id_ /* table__row__id__offset__to__row */ = row__id_,
      table__rows__count /* for the table; `rows_per_table`; `table__rows__count__limit` */ = //
          (4 << rows__count__multiplier__initial);

  while (!(table__row__id_ < table__rows__count)) {
    table__id_ += 1;
    table__row__id_ -= table__rows__count;
    table__rows__count <<= 1 /* (i *= 2) */;
  }

  if (debug__report_ing__verbose__ok) {
    record__convert__report__info({
      "table__id": table__id.convert__string(),
      "row__id": table__row__id.convert__string(),
      "rows__count": table__rows__count.convert__string(),
    }).report(
      "result",
      row__id_.convert__string(),
    );
  }

  base__printing__indentation__decrease();

  return (
    id_: table__id_,
    row__id_: table__row__id_,
    rows__count: table__rows__count,
  );
}

uu base__storage__data__tar__bytes__count(final uu table__id_) => //
    ((table__id_ + 1) * base__storage__data__position__size);

class base__storage__data__tar__meta__kampa //
    extends base__storage__data__table__meta__protocol {
  base__storage__data__tar__meta__kampa({
    required super.rows__count,
    required super.rows__count__size__id_,
    required super.row__size,
    required this.tar__meta__bytes__base__storage__data__offset,
    required this.table__array__bytes__base__storage__data__offset /*
  `if(tar__meta.rows__count == 0) b__ignor_ed` */
    ,
    this.table__array__bytes,
    required this.rows__count__multiplier__initial,
  }) : rows__count__max = uu__max(
          uu__size__id__convert(
            rows__count__size__id_,
          ),
        );

  uu //
      rows__count__max,
      table__array__bytes__base__storage__data__offset;

  final uu //
      tar__meta__bytes__base__storage__data__offset;

  by__arr? //
      table__array__bytes;

  final u8 //
      rows__count__multiplier__initial;
}

void base__storage__data__tar__meta__convert__report__info(
  final base__storage__data__tar__meta__kampa tar__meta,
) =>
    record__convert__report__info({
      "table__array__bytes__base__storage__data__offset": tar__meta.table__array__bytes__base__storage__data__offset.convert__string(),
      "tar__meta__bytes__base__storage__data__offset": tar__meta.tar__meta__bytes__base__storage__data__offset.convert__string(),
      "table__array__bytes": tar__meta.table__array__bytes.convert__string(),
      "rows__count__multiplier__initial": tar__meta.rows__count__multiplier__initial.convert__string(),
    });

by__arr base__storage__data__tar__table__array__bytes__read(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tar__meta__kampa tar__meta,
) /* macro */ =>
    base__storage__data__read(
      ds___meta,
      count: base__storage__data__tar__bytes__count(
        base__storage__data__tar__table__meta(
          (tar__meta.rows__count - 1),
          tar__meta.rows__count__multiplier__initial,
        ).id_,
      ),
      base__storage__data__offset: tar__meta.table__array__bytes__base__storage__data__offset,
    );

by__arr base__storage__data__tar__table__array__bytes(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tar__meta__kampa tar__meta,
) /* macro */ =>
    (tar__meta.table__array__bytes ??= //
        base__storage__data__tar__table__array__bytes__read(
      ds___meta,
      tar__meta,
    ));

uu base__storage__data__tar__row__bytes__base__storage__data__offset({
  required final base__storage__data__tar__table__meta__kampa table__meta,
  required final sz row__size,
  required final by__arr table__array__bytes,
  final uu row__offset = 0,
}) /* macro */ =>
    base__storage__data__table__row__bytes__base__storage__data__offset(
      row__id_: table__meta.row__id_,
      row__size: row__size,
      table__bytes__base__storage__data__offset: uu__bys__cast__basic(
        table__array__bytes.view(
          (table__meta.id_ * base__storage__data__position__size),
        ),
        base__storage__data__position__size__id_,
      ),
      row__offset: row__offset,
    );

uu base__storage__data__tar__row__add(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tar__meta__kampa tar__meta,
  final by__arr bytes /* refer to `ds___table__row__add__bytes` */,
) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__data__tar__row__add",
      tar__meta.debug__label,
    );

    bytes.convert__text__representation().print("bytes");
  }

  base__printing__indentation__increase();

  final row__id_ = tar__meta.rows__count++;

  if (debug__report_ing__verbose__ok) {
    row__id_.convert__text__representation().print(
          "row__id",
          tar__meta.debug__label,
        );
  }

  base__storage__data__table__row__ensure__space(
    rows__count: row__id_,
    rows__count__max: tar__meta.rows__count__max,
  );

  final table__meta = base__storage__data__tar__table__meta(
    row__id_,
    tar__meta.rows__count__multiplier__initial,
  );

  if (table__meta.row__id_ != 0) /*
  the table has sufficient space */ //
    base__storage__data__write(
      ds___meta,
      bytes: bytes,
      bytes__count: tar__meta.row__size,
      base__storage__data__offset: base__storage__data__tar__row__bytes__base__storage__data__offset(
        table__meta: table__meta,
        row__size: tar__meta.row__size,
        table__array__bytes: base__storage__data__tar__table__array__bytes__read(
          ds___meta,
          tar__meta,
        ),
      ),
    );
  else {
    base__printing__indentation__increase();

    if (debug__report_ing__verbose__ok) {
      ((table__meta.id_ != 0)
              ? ("current `table` is out-of-space;"
                  " allocating a new `table`;"
                  " also extend-ing the current `table__arr`'s capacity;")
              : "allocating, and populating; the `table`, and `table__arr`")
          .print(tar__meta.debug__label);
    }

    final //
        table__array__new__bytes__count = base__storage__data__tar__bytes__count(
          table__meta.id_,
        ),
        table__array__new__bytes = by__arr(table__array__new__bytes__count),
        base__storage__data__offset__to__table = base__storage__data__write__reserve(
          ds___meta,
          (table__meta.rows__count * tar__meta.row__size),
        );

    if (debug__report_ing__verbose__ok) {
      ("${(table__meta.rows__count * tar__meta.row__size)}"
              "(${table__meta.rows__count}(rows) * ${tar__meta.row__size}(row's size))")
          .convert__report__info()
          .report(
            "table__new__size",
            tar__meta.debug__label,
          );

      base__storage__data__offset__to__table.convert__text__representation().print(
            "base__storage__data__offset__to__table__new",
            tar__meta.debug__label,
          );
    }

    base__copy(
      table__array__new__bytes,
      uu__cast__bys__basic(
        base__storage__data__offset__to__table,
        base__storage__data__position__size__id_,
      ),
      dest__offset: ((row__id_ != 0) //
          ? base__copy(
              table__array__new__bytes,
              (tar__meta.table__array__bytes ??
                  base__storage__data__tar__table__array__bytes__read(
                    ds___meta,
                    tar__meta,
                  )),
            ).dest__offset__new
          : 0),
      count: base__storage__data__position__size,
    );

    ((row__id_ != 0) //
        ? base__storage__data__write__replace
        : base__storage__data__write)(
      ds___meta,
      bytes: uu__cast__bys__basic(
        (tar__meta.table__array__bytes__base__storage__data__offset = //
            base__storage__data__write__append(
          ds___meta,
          (tar__meta.table__array__bytes = table__array__new__bytes),
          table__array__new__bytes__count,
        )),
        base__storage__data__position__size__id_,
      ),
      bytes__count: base__storage__data__position__size,
      base__storage__data__offset: tar__meta.tar__meta__bytes__base__storage__data__offset,
    );

    if (debug__report_ing__verbose__ok) //
      base__storage__data__position(ds___meta).convert__text__representation().print(
            "table__array__new__base__storage__data__offset",
            tar__meta.debug__label,
          );

    base__printing__indentation__decrease();

    base__storage__data__write(
      ds___meta,
      bytes: bytes,
      bytes__count: tar__meta.row__size,
      base__storage__data__offset: base__storage__data__tar__row__bytes__base__storage__data__offset(
        table__meta: table__meta,
        row__size: tar__meta.row__size,
        table__array__bytes: table__array__new__bytes,
      ),
    );
  }

  base__printing__indentation__decrease();

  return row__id_;
}

void base__storage__data__tar__rows__count__update(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tar__meta__kampa tar__meta,
) =>
    base__storage__data__table__rows__count__update(
      ds___meta,
      tar__meta,
      rows__count__bytes__base__storage__data__offset: (base__storage__data__position__size + tar__meta.tar__meta__bytes__base__storage__data__offset),
    );

base__storage__data__table__row__kampa base__storage__data__tar__row(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tar__meta__kampa tar__meta, {
  required final uu row__id_,
  required final by__arr? bytes,
  uu? count,
  final uu row__offset = 0,
}) /* refer to `ds_.tbl.row` */ {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__data__tar__row",
      tar__meta.debug__label,
    );

    row__id_.convert__text__representation().print("row__id");
  }

  base__printing__indentation__increase();

  base__storage__data__table__row__ensure__exists(
    row__id_: row__id_,
    rows__count: tar__meta.rows__count,
  );

  count ??= base__storage__data__table__row__bytes__count(
    row__size: tar__meta.row__size,
    rows__count: 1,
    row__offset: row__offset,
  );

  final //
      table__meta = base__storage__data__tar__table__meta(
        row__id_,
        tar__meta.rows__count__multiplier__initial,
      ),
      offset = base__storage__data__tar__row__bytes__base__storage__data__offset(
        table__meta: table__meta,
        row__size: tar__meta.row__size,
        table__array__bytes: base__storage__data__tar__table__array__bytes(
          ds___meta,
          tar__meta,
        ),
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

base__storage__data__table__row__column__kampa base__storage__data__tar__row__column(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tar__meta__kampa tar__meta, {
  required final uu row__id_,
  required final by__arr? bytes,
  required final base__storage__data__table__column__kampa table__column,
}) /* macro */ =>
    base__storage__data__tar__row(
      ds___meta,
      tar__meta,
      row__id_: row__id_,
      bytes: bytes,
      count: base__storage__data__table__column__size(
        table__column,
      ),
      row__offset: table__column.meta.offset,
    );

by__arr base__storage__data__tar__row__group__bytes(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tar__meta__kampa tar__meta, {
  required final uu group__id_,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__tar__row__group__bytes",
      tar__meta.debug__label,
    );

  base__printing__indentation__increase();

  if (tar__meta.rows__count == 0) {
    "table.empty__ok".print();

    base__printing__indentation__decrease();

    return empty__by__arr;
  }

  const row__group__size = 12 /*
  12 as row__group__size
    8 is quite less, while 16 is too much
    12(or `(4 + 8)`) is also aligned with the `table__arr`'s first two `table`s `rows__count__max`
      hence the most efficient approach, because
        it allows consuming, all of the first 2 `table`'s `rows__count`, fully; while
          8(or `(4 + 4)`) would require accessing 2 `table`(of the `table__arr`)s
            and not consume (hence waste), half the `rows__count`, of the 2nd `table`
          16(or `(4 + 8 + 4)`) would require 3 `table` accesses
            and consume, a mere one-fourth of the `rows__count`, of the 3rd `table`
    12 is also more, than the usual user's expected count of 10, hence the 2 extra rows, feel like a bonus */
      ;

  uu row__id_ /*rows__offset*/ = (group__id_ * row__group__size);

  if (!(row__id_ < tar__meta.rows__count) /*b__exists*/) {
    "table.end".print();

    base__printing__indentation__decrease();

    return empty__by__arr;
  }

  final sink = base__by__array__accumulation();

  uu count = (((row__group__size + row__id_) > tar__meta.rows__count) //
      ? tar__meta.rows__count
      : row__group__size);

  while (count != 0) {
    final //
        table__meta = base__storage__data__tar__table__meta(
          row__id_,
          tar__meta.rows__count__multiplier__initial,
        ),
        rows__count = ((count < table__meta.rows__count) //
            ? count
            : table__meta.rows__count);

    sink.add(
      base__storage__data__read(
        ds___meta,
        count: base__storage__data__table__row__bytes__count(
          row__size: tar__meta.row__size,
          rows__count: rows__count,
        ),
        base__storage__data__offset: base__storage__data__tar__row__bytes__base__storage__data__offset(
          table__meta: table__meta,
          row__size: tar__meta.row__size,
          table__array__bytes: base__storage__data__tar__table__array__bytes(
            ds___meta,
            tar__meta,
          ),
        ),
      ),
    );

    row__id_ += rows__count;
    count -= rows__count;
  }

  final result = sink.convert__by__arr();

  base__printing__indentation__decrease();

  return result;
}

void base__storage__data__tar__rows__all__iterate(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__tar__meta__kampa tar__meta,
  final void Function(
    uu row__id_,
    by__arr row__bytes,
    uu row__bytes__base__storage__data__offset,
  ) row__handle,
) /*
  REFER
    `data__base::table::rows::all` */
{
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__tar__rows__all",
      tar__meta.debug__label,
    );

  base__printing__indentation__increase();

  if (tar__meta.rows__count == 0) {
    base__printing__indentation__decrease();

    throw "tar.table.empty__ok";
  }

  uu row__id__offset = 0;

  while (row__id__offset < tar__meta.rows__count) {
    final //
        table__meta = base__storage__data__tar__table__meta(
          row__id__offset,
          tar__meta.rows__count__multiplier__initial,
        ),
        table__bytes__base__storage__data__offset = base__storage__data__tar__row__bytes__base__storage__data__offset(
          table__meta: table__meta,
          row__size: tar__meta.row__size,
          table__array__bytes: base__storage__data__tar__table__array__bytes(
            ds___meta,
            tar__meta,
          ),
        ),
        table__bytes = base__storage__data__read(
          ds___meta,
          count: base__storage__data__table__row__bytes__count(
            row__size: tar__meta.row__size,
            rows__count: table__meta.rows__count,
          ),
          base__storage__data__offset: table__bytes__base__storage__data__offset,
        );

    uu table__bytes__offset = 0;

    base__iterate__basic(
      (((row__id__offset + table__meta.rows__count) < tar__meta.rows__count) //
          ? table__meta.rows__count
          : (tar__meta.rows__count - row__id__offset) /* once, at last */),
      (final row__id_) {
        row__handle(
          (row__id_ + row__id__offset),
          table__bytes.view__partial(
            table__bytes__offset,
            tar__meta.row__size,
          ),
          (table__bytes__offset + table__bytes__base__storage__data__offset),
        );

        table__bytes__offset += tar__meta.row__size;
      },
    );

    row__id__offset += table__meta.rows__count;
  }

  base__printing__indentation__decrease();
}
