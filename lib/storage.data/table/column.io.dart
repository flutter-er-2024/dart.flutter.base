import "package:base/base/_.dart";
import "package:base/char.dart";

import "column.dart";

typedef base__storage__data__table__columns__array__kampa = //
    array<base__storage__data__table__columns__kampa>;

string base__storage__data__table__column__meta__convert__string(
  final base__storage__data__table__column__kampa column,
  final base__storage__data__table__columns__array__kampa columns__arr,
) {
  final //
      buffer = StringBuffer(),
      column__meta = column.meta,
      column__type = column.type;

  {
    buffer.write(column__meta.name);

    if (column__meta.b__nil_able) //
      buffer.write(char__question);

    buffer
      ..write("offset")
      ..write(column__meta.offset);
  }

  void buffer__write(
    final string name,
    final Object value,
  ) {
    buffer
      ..write(char__line_feed)
      ..write(value)
      ..write(char__space)
      ..write(char__bracket__round__open)
      ..write(name)
      ..write(char__bracket__round__close);
  }

  {
    final string type;

    switch (column__type) {
      case base__storage__data__table__column__type__enum.uit:
        type = "direct:primitive:uit";
        break;
      case base__storage__data__table__column__type__enum.iid_:
        type = "direct:primitive:uit:iid";
        break;
      case base__storage__data__table__column__type__enum.eid_:
        type = "direct:primitive:uit:eid";
        break;
      case base__storage__data__table__column__type__enum.irb:
        type = "direct:irb";
        break;
      case base__storage__data__table__column__type__enum.rbt:
        type = "in_direct:rbt";
        break;
      case base__storage__data__table__column__type__enum.bst:
        type = "in_direct:rbt:bst";
        break;
      case base__storage__data__table__column__type__enum.wst:
        type = "in_direct:rbt:wst";
        break;
      case base__storage__data__table__column__type__enum.ear:
        type = "in_direct:array:ear";
        break;
      case base__storage__data__table__column__type__enum.tbl:
        type = "in_direct:array[:ear]:table:tbl";
        break;
      case base__storage__data__table__column__type__enum.tar:
        type = "in_direct:array[:ear]:table:tar";
        break;
    }

    buffer__write(
      "type",
      type,
    );
  }

  {
    if ((column__type == base__storage__data__table__column__type__enum.tar) || //
        (column__type == base__storage__data__table__column__type__enum.tbl)) //
      buffer__write(
        "rows:count:size:id",
        (column__meta as base__storage__data__table__column__type__table__meta__protocol).rows__count__size__id_,
      );
    else if (column__type == base__storage__data__table__column__type__enum.ear) //
      buffer__write(
        "elements:count:size:id",
        (column__meta as base__storage__data__table__column__type__ear__meta__kampa).elements__count__size__id_,
      );
    else if ((column__type == base__storage__data__table__column__type__enum.rbt) || //
        (column__type == base__storage__data__table__column__type__enum.bst) || //
        (column__type == base__storage__data__table__column__type__enum.wst)) //
      buffer__write(
        "count:size:id",
        (column__meta as base__storage__data__table__column__type__in_direct__meta__protocol).count__size__id_,
      );
    else if ((column__type == base__storage__data__table__column__type__enum.uit) || //
        (column__type == base__storage__data__table__column__type__enum.iid_) || //
        (column__type == base__storage__data__table__column__type__enum.eid_)) //
      buffer__write(
        "size:id",
        (column__meta as base__storage__data__table__column__type__uit__meta__kampa).size__id_,
      );
    else if (column__type == base__storage__data__table__column__type__enum.irb) //
      buffer__write(
        "size",
        (column__meta as base__storage__data__table__column__type__irb__meta__kampa).size,
      );
  }

  if ((column__type == base__storage__data__table__column__type__enum.tar) || //
      (column__type == base__storage__data__table__column__type__enum.tbl) || //
      (column__type == base__storage__data__table__column__type__enum.ear)) //
    buffer__write(
      "row:size",
      (column__meta as base__storage__data__table__column__type__array__meta__protocol).row__size,
    );

  if (column__type == base__storage__data__table__column__type__enum.tar) //
    buffer__write(
      "rows:count:multiplier:initial",
      (column__meta as base__storage__data__table__column__type__tar__meta__kampa).rows__count__multiplier__initial,
    );
  else if (column__type == base__storage__data__table__column__type__enum.tbl) //
    buffer__write(
      "rows:count:max",
      (column__meta as base__storage__data__table__column__type__tbl__meta__kampa).rows__count__max,
    );

  return buffer.toString();
}
