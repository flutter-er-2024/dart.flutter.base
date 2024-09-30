import "package:base/base/_.dart";
import "package:base/uu.size.dart";
import "../_.dart" show base__storage__data__position__size;

/*
  `table:column != table:row:column`
    the former is `base__storage__data__table__column__kampa`
      which is merely a structure of the details, of the column-of-table
        and not a part of any row
    the latter is the actual data of a table's row's column */

enum base__storage__data__table__column__type__enum //
{ /*direct, primitive,*/ uit, iid_, eid_, irb, /*in_direct,*/ rbt, bst, wst, /*array,*/ ear, /*table,*/ tbl, tar }

typedef base__storage__data__table__column__kampa = ({
  base__storage__data__table__column__type__enum type,
  base__storage__data__table__column__meta__protocol /*
  would map to `void ptr` in nc */
  meta,
});

typedef base__storage__data__table__columns__kampa = //
    array<base__storage__data__table__column__kampa>;

sz base__storage__data__table__column__size(
  final base__storage__data__table__column__kampa table__column,
) {
  final type = table__column.type;

  return (((type == base__storage__data__table__column__type__enum.rbt) || //
          (type == base__storage__data__table__column__type__enum.tar) || //
          (type == base__storage__data__table__column__type__enum.bst) || //
          (type == base__storage__data__table__column__type__enum.wst) || //
          (type == base__storage__data__table__column__type__enum.ear) || //
          (type == base__storage__data__table__column__type__enum.tbl)) //
      ? (uu__size__id__convert(
            (table__column.meta as base__storage__data__table__column__type__in_direct__meta__protocol).count__size__id_,
          ) +
          base__storage__data__position__size)
      : (((type == base__storage__data__table__column__type__enum.uit) || //
              (type == base__storage__data__table__column__type__enum.iid_) || //
              (type == base__storage__data__table__column__type__enum.eid_)) //
          ? uu__size__id__convert(
              (table__column.meta as base__storage__data__table__column__type__primitive__meta__protocol).size__id_,
            )
          : ((type == base__storage__data__table__column__type__enum.irb) //
              ? (table__column.meta as base__storage__data__table__column__type__irb__meta__kampa).size
              : throw "${table__column.meta.runtimeType}(column__meta.type) is un-known")));
}

uu base__storage__data__table__column__row__bytes__offset(
  final base__storage__data__table__column__kampa table__column__previous,
) =>
    (base__storage__data__table__column__size(
          table__column__previous,
        ) +
        table__column__previous.meta.offset);

abstract class base__storage__data__table__column__meta__protocol {
  base__storage__data__table__column__meta__protocol(
    this.name /*
  SHOULD
    contain, ONLY, 'a'-'z', 'A'-'Z', '0'-'9', '_', '.', ':' */
    ,
    final base__storage__data__table__column__kampa? table__column__previous,
    this.b__nil_able,
  ) : offset = ((table__column__previous !=  null) //
            ? base__storage__data__table__column__row__bytes__offset(
                table__column__previous,
              )
            : 0);

  /*uu /*column__*/ meta__id_() => //
      ((column__previous__meta !=  null) //
          ? (1 + column__previous__meta.meta__id_)
          : 0);*/

  final string //
      name;

  final bool //
      b__nil_able;

  final uu /*row__bytes__*/ offset /*
  is calculat-able, whenever required
    but based on the usage count, caching would be more efficient */
      ;
}

abstract class base__storage__data__table__column__type__direct__meta__protocol //
    extends base__storage__data__table__column__meta__protocol {
  base__storage__data__table__column__type__direct__meta__protocol(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
  );
}

abstract class base__storage__data__table__column__type__primitive__meta__protocol //
    extends base__storage__data__table__column__type__direct__meta__protocol {
  base__storage__data__table__column__type__primitive__meta__protocol(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    this.size__id_,
  );

  final uu__size__id__enum //
      size__id_;
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__uit(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final uu__size__id__enum size__id_,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.uit,
    meta: base__storage__data__table__column__type__uit__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      size__id_,
    ),
  );
}

class base__storage__data__table__column__type__uit__meta__kampa /*
  integer.un-signed */ //
    extends base__storage__data__table__column__type__primitive__meta__protocol {
  base__storage__data__table__column__type__uit__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able /*
  SIDE-EFFECT|TRADE-OFF
    `(max -= 1)`(decrease the `max`, hence memory capacity, by one unit)
  MUST
    user ensure, that 0, as value, is reserved for  null checking
      write, as `uu value = ((data !=  null) ? (data +1) : 0);`
      read, as `uu data = ((value > 0) ? (value -1) :  null);` */
    ,
    super.size__id_,
  );
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__iid(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final base__storage__data__table__column__type__ear__meta__kampa column,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.iid_,
    meta: base__storage__data__table__column__type__iid__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      column.id__size__id_,
    ),
  );
}

class base__storage__data__table__column__type__iid__meta__kampa /*
  internal-id */ //
    extends base__storage__data__table__column__type__uit__meta__kampa {
  base__storage__data__table__column__type__iid__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.size__id_,
  );
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__eid(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final uu__size__id__enum size__id_,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.eid_,
    meta: base__storage__data__table__column__type__eid__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      size__id_,
    ),
  );
}

class base__storage__data__table__column__type__eid__meta__kampa /*
  external-id */ //
    extends base__storage__data__table__column__type__uit__meta__kampa {
  base__storage__data__table__column__type__eid__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.size__id_,
  );
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__irb(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final sz size,
}) {
  return (
    type: base__storage__data__table__column__type__enum.irb,
    meta: base__storage__data__table__column__type__irb__meta__kampa(
      name,
      table__column__previous,
      NO,
      size,
    ),
  );
}

class base__storage__data__table__column__type__irb__meta__kampa /*
  in-row bytes */ //
    extends base__storage__data__table__column__type__direct__meta__protocol {
  base__storage__data__table__column__type__irb__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    this.size,
  );

  final sz //
      size;
}

abstract class base__storage__data__table__column__type__in_direct__meta__protocol /*
  only the `ds___meta.offset` and `element.arr.count` are written `direct`ly to `table.row.column`
    the actual data, need to be accessed from the `ds___meta.offset`
  contrast to `type.direct`, which is written directly to `table.row.column` */ //
    extends base__storage__data__table__column__meta__protocol {
  base__storage__data__table__column__type__in_direct__meta__protocol(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    this.count__size__id_,
  );

  final uu__size__id__enum //
  count__size__id_;
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__rbt(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final uu__size__id__enum count__size__id_,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.rbt,
    meta: base__storage__data__table__column__type__rbt__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      count__size__id_,
    ),
  );
}

class base__storage__data__table__column__type__rbt__meta__kampa /*
  bytes; `bytes` is reserved, hence named `raw-bytes` */ //
    extends base__storage__data__table__column__type__in_direct__meta__protocol {
  base__storage__data__table__column__type__rbt__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.count__size__id_,
  );
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__bst(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final uu__size__id__enum count__size__id_,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.bst,
    meta: base__storage__data__table__column__type__bst__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      count__size__id_,
    ),
  );
}

class base__storage__data__table__column__type__bst__meta__kampa /*
  basic(non-wide)-string */ //
    extends base__storage__data__table__column__type__rbt__meta__kampa {
  base__storage__data__table__column__type__bst__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.count__size__id_,
  );
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__wst(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final uu__size__id__enum count__size__id_,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.wst,
    meta: base__storage__data__table__column__type__wst__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      count__size__id_,
    ),
  );
}

class base__storage__data__table__column__type__wst__meta__kampa /*
  wide-string bytes */ //
    extends base__storage__data__table__column__type__rbt__meta__kampa {
  base__storage__data__table__column__type__wst__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.count__size__id_,
  );
}

typedef base__storage__data__table__row__convert__string__summary__function__format = //
    title__strings__kampa Function(
  array<Object?> data__arr,
);

typedef base__storage__data__table__row__convert__string__function__format = //
    string Function(
  array<Object?> data__arr,
);

abstract class base__storage__data__table__column__type__array__meta__protocol //
    extends base__storage__data__table__column__type__in_direct__meta__protocol {
  base__storage__data__table__column__type__array__meta__protocol(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.count__size__id_,
    final base__storage__data__table__column__kampa columns__last,
    this.row__convert__string__summary,
    this.row__convert__string,
  ) : row__size = base__storage__data__table__column__row__bytes__offset(
          columns__last,
        );

  final uu row__size;

  final base__storage__data__table__row__convert__string__summary__function__format? row__convert__string__summary;

  final base__storage__data__table__row__convert__string__function__format row__convert__string /*__full*/;

  /*uu columns__meta__id_() => //
      ((columns__meta__previous !=  null) //
          ? (1 + columns__meta__previous.meta__id_())
          : 0);*/
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__ear(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final uu__size__id__enum elements__count__size__id_,
  required final base__storage__data__table__column__kampa columns__last,
  final base__storage__data__table__row__convert__string__summary__function__format? row__convert__string__summary,
  required final base__storage__data__table__row__convert__string__function__format row__convert__string,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.ear,
    meta: base__storage__data__table__column__type__ear__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      elements__count__size__id_,
      columns__last,
      row__convert__string__summary,
      row__convert__string,
    ),
  );
}

class base__storage__data__table__column__type__ear__meta__kampa /*
  array; `arr` is reserved for in-memory(or run-time) array, hence named element-array
  like: fixed size, pre-filled, array
  `elements == arr`
  `element == value` */ //
    extends base__storage__data__table__column__type__array__meta__protocol {
  base__storage__data__table__column__type__ear__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.count__size__id_,
    super.columns__last,
    super.row__convert__string__summary,
    super.row__convert__string,
  );

  uu__size__id__enum get elements__count__size__id_ => //
      count__size__id_;

  uu__size__id__enum get id__size__id_ => //
      elements__count__size__id_;
}

abstract class base__storage__data__table__column__type__table__meta__protocol //
    extends base__storage__data__table__column__type__ear__meta__kampa {
  base__storage__data__table__column__type__table__meta__protocol(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.elements__count__size__id_ /*base__storage__data__table__row__count__size(table__rows__count__max, base__storage__data__position__size)*/,
    super.columns__last,
    super.row__convert__string__summary,
    super.row__convert__string,
  );

  uu__size__id__enum get rows__count__size__id_ => //
      count__size__id_;
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__tbl(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final uu__size__id__enum rows__count__size__id_,
  required final uu rows__count__max,
  required final base__storage__data__table__column__kampa columns__last,
  final base__storage__data__table__row__convert__string__summary__function__format? row__convert__string__summary,
  required final base__storage__data__table__row__convert__string__function__format row__convert__string,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.tbl,
    meta: base__storage__data__table__column__type__tbl__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      rows__count__size__id_,
      rows__count__max,
      columns__last,
      row__convert__string__summary,
      row__convert__string,
    ),
  );
}

class base__storage__data__table__column__type__tbl__meta__kampa /*
  table
  like: initially un-filled, array */ //
    extends base__storage__data__table__column__type__table__meta__protocol {
  base__storage__data__table__column__type__tbl__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.elements__count__size__id_,
    this.rows__count__max,
    super.columns__last,
    super.row__convert__string__summary,
    super.row__convert__string,
  );

  final uu //
      rows__count__max;
}

base__storage__data__table__column__kampa //
    base__storage__data__table__column__type__tar(
  final string name, {
  required final base__storage__data__table__column__kampa? table__column__previous,
  required final uu__size__id__enum rows__count__size__id_,
  final uu rows__count__multiplier__initial = 0,
  required final base__storage__data__table__column__kampa columns__last,
  final base__storage__data__table__row__convert__string__summary__function__format? row__convert__string__summary,
  required final base__storage__data__table__row__convert__string__function__format row__convert__string,
  final bool b__nil_able = NO,
}) {
  return (
    type: base__storage__data__table__column__type__enum.tar,
    meta: base__storage__data__table__column__type__tar__meta__kampa(
      name,
      table__column__previous,
      b__nil_able,
      rows__count__size__id_,
      rows__count__multiplier__initial,
      columns__last,
      row__convert__string__summary,
      row__convert__string,
    ),
  );
}

class base__storage__data__table__column__type__tar__meta__kampa /*
  table.array
  like: auto growing, array */ //
    extends base__storage__data__table__column__type__table__meta__protocol {
  base__storage__data__table__column__type__tar__meta__kampa(
    super.name,
    super.table__column__previous,
    super.b__nil_able,
    super.elements__count__size__id_,
    this.rows__count__multiplier__initial,
    super.columns__last,
    super.row__convert__string__summary,
    super.row__convert__string,
  );

  final uu //
      rows__count__multiplier__initial;
}
