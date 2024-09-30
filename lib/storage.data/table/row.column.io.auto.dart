import "package:base/base/_.dart";
import "package:base/by.arr.dart";

import "../_.dart";
import "../ear.dart";
import "../rbt.dart";
import "../tar.dart";
import "../tbl.dart";

import "column.dart";
import "row.column.io.dart";

void base__storage__data__table__row__column__bytes__auto({
  required final base__storage__data__meta__kampa ds___meta,
  required final base__storage__data__table__column__kampa table__column,
  required final by__arr column__bytes,
  required final Object? /*
  uit: `uu`
  irb|rbt: `by__arr`(by[te]s)
  ear: `base__storage__data__ear__result__kampa`
  tar|tbl: `Object`(prefer `1`) */
      data,
  required final bool b__initial,
}) /* macro */ {
  if (table__column.type == base__storage__data__table__column__type__enum.uit) {
    final column__meta = (table__column.meta as base__storage__data__table__column__type__uit__meta__kampa);

    if (!column__meta.b__nil_able) //
      base__storage__data__table__row__column__type__uit__write(
        column__bytes: column__bytes,
        size__id_: column__meta.size__id_,
        value: (data as uu),
      );
    else //
      base__storage__data__table__row__column__type__uit__write__nil_able(
        column__bytes: column__bytes,
        size__id_: column__meta.size__id_,
        data: (data as uu?),
      );
  } else if /* un-likely */ (table__column.meta.b__nil_able && //
      (data ==  null)) //
    base__storage__data__table__row__column__type__in_direct__write__nil(
      column__bytes: column__bytes,
    );
  else //
    switch (table__column.type) {
      case base__storage__data__table__column__type__enum.rbt:
        final column__meta = (table__column.meta as base__storage__data__table__column__type__rbt__meta__kampa);
        base__storage__data__table__row__column__type__rbt__write(
          ds___meta: ds___meta,
          count__size__id_: column__meta.count__size__id_,
          column__bytes: column__bytes,
          data: (data as by__arr),
          b__replace: !b__initial,
        );
        break;

      case base__storage__data__table__column__type__enum.tar:
        final column__meta = (table__column.meta as base__storage__data__table__column__type__tar__meta__kampa);
        base__storage__data__table__row__column__type__tar__write(
          ds___meta: ds___meta,
          rows__count__size__id_: column__meta.rows__count__size__id_,
          column__bytes: column__bytes,
        );
        break;

      case base__storage__data__table__column__type__enum.ear:
        final //
            column__meta = (table__column.meta as base__storage__data__table__column__type__ear__meta__kampa),
            data_ = (data as base__storage__data__ear__result__kampa);

        base__storage__data__table__row__column__type__ear__write(
          ds___meta: ds___meta,
          elements__count__size__id_: column__meta.elements__count__size__id_,
          column__bytes: column__bytes,
          elements__count: data_.elements__count,
          elements__bys: data_.elements__bys,
        );
        break;

      case base__storage__data__table__column__type__enum.irb:
        final column__meta = (table__column.meta as base__storage__data__table__column__type__irb__meta__kampa);
        base__storage__data__table__row__column__type__irb__write(
          column__bytes: column__bytes,
          size: column__meta.size,
          data: (data as by__arr),
        );
        break;

      case base__storage__data__table__column__type__enum.tbl:
        final column__meta = (table__column.meta as base__storage__data__table__column__type__tbl__meta__kampa);
        base__storage__data__table__row__column__type__tbl__write(
          ds___meta: ds___meta,
          rows__count__size__id_: column__meta.rows__count__size__id_,
          rows__count__max: column__meta.rows__count__max,
          row__size: column__meta.row__size,
          column__bytes: column__bytes,
        );
        break;

      default:
        throw "${table__column.type}(base__storage__data__table__column__type__enum) is un-known";
    }
}

Object? base__storage__data__table__row__column__data__auto({
  required final base__storage__data__meta__kampa ds___meta,
  required final base__storage__data__table__column__kampa table__column,
  required final by__arr column__bytes,
  required final uu column__bytes__base__storage__data__offset,
}) /*
  instead of multiple [consecutive] calls
    prefer calling `base__storage__data__table__row__data__array__auto`
      because storage:fast:io, is although efficient, but NOT free */
{
  if (table__column.type == base__storage__data__table__column__type__enum.uit) {
    final column__meta = (table__column.meta as base__storage__data__table__column__type__uit__meta__kampa);

    return (!column__meta.b__nil_able //
        ? base__storage__data__table__row__column__type__uit__read
        : base__storage__data__table__row__column__type__uit__read__nil_able)(
      column__bytes: column__bytes,
      size__id_: column__meta.size__id_,
    );
  }

  if (table__column.type == base__storage__data__table__column__type__enum.irb) //
    return by__array__create(
      column__bytes,
      count: (table__column.meta as base__storage__data__table__column__type__irb__meta__kampa).size,
    );

  if (table__column.meta.b__nil_able &&
      by__array__blank__ok(
        column__bytes,
        count: base__storage__data__position__size,
      )) //
    return  null;

  switch (table__column.type) {
    case base__storage__data__table__column__type__enum.rbt:
      final //
          column__meta = (table__column.meta as base__storage__data__table__column__type__rbt__meta__kampa),
          details = base__storage__data__table__row__column__type__in_direct__bytes__read(
            column__meta: column__meta,
            column__bytes: column__bytes,
          );

      return base__storage__data__rbt__meta__kampa(
        bytes__count: details.count,
        count__size__id_: column__meta.count__size__id_,
        rbt__bytes__base__storage__data__offset: details.base__storage__data__offset,
        meta__bytes__base__storage__data__offset: column__bytes__base__storage__data__offset,
      );

    case base__storage__data__table__column__type__enum.tar:
      final //
          column__meta = (table__column.meta as base__storage__data__table__column__type__tar__meta__kampa),
          details = base__storage__data__table__row__column__type__in_direct__bytes__read(
            column__meta: column__meta,
            column__bytes: column__bytes,
          );

      return base__storage__data__tar__meta__kampa(
        rows__count: details.count,
        rows__count__size__id_: column__meta.rows__count__size__id_,
        row__size: column__meta.row__size,
        tar__meta__bytes__base__storage__data__offset: column__bytes__base__storage__data__offset,
        table__array__bytes__base__storage__data__offset: details.base__storage__data__offset,
        rows__count__multiplier__initial: column__meta.rows__count__multiplier__initial,
      );

    case base__storage__data__table__column__type__enum.ear:
      final //
          column__meta = (table__column.meta as base__storage__data__table__column__type__ear__meta__kampa),
          details = base__storage__data__table__row__column__type__in_direct__bytes__read(
            column__meta: column__meta,
            column__bytes: column__bytes,
          );

      return base__storage__data__ear__meta__kampa(
        elements__count: details.count,
        elements__count__size__id_: column__meta.elements__count__size__id_,
        element__size: column__meta.row__size,
        elements__bytes__base__storage__data__offset: details.base__storage__data__offset,
        meta__bytes__base__storage__data__offset: column__bytes__base__storage__data__offset,
      );

    case base__storage__data__table__column__type__enum.tbl:
      final //
          column__meta = (table__column.meta as base__storage__data__table__column__type__tbl__meta__kampa),
          details = base__storage__data__table__row__column__type__in_direct__bytes__read(
            column__meta: column__meta,
            column__bytes: column__bytes,
          );

      return base__storage__data__tbl__meta__kampa(
        rows__count: details.count,
        rows__count__size__id_: column__meta.rows__count__size__id_,
        row__size: column__meta.row__size,
        rows__count__max: column__meta.rows__count__max,
        table__bytes__base__storage__data__offset: details.base__storage__data__offset,
        tbl__meta__bytes__base__storage__data__offset: column__bytes__base__storage__data__offset,
      );

    default:
      throw "${table__column.type}(base__storage__data__table__column__type__enum), ${table__column.meta.runtimeType}(column__meta.type), are un-known";
  }
}
