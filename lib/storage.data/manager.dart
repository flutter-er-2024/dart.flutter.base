import "package:base/arr.dart";
import "package:base/base/_.dart";

import "_.dart";
import "main.tbl.dart";
import "table/_.dart";
import "table/column.dart";

class base__storage__data__column__tree__element__kampa {
  const base__storage__data__column__tree__element__kampa(
    this.column,
  );

  final base__storage__data__table__column__kampa column;
}

class base__storage__data__column__tree__element__super__kampa //
    extends base__storage__data__column__tree__element__kampa {
  const base__storage__data__column__tree__element__super__kampa(
    super.column,
    this.row__bytes__fetch,
    this.columns,
  );

  final array<
      ({
        base__storage__data__column__tree__element__kampa element,
        void Function(
          void Function(
            Object? data,
          ),
        )? fetch,
      })> columns;

  final void Function(
    void Function(
      array<Object?> data__arr,
    ) submit,
  ) row__bytes__fetch;
}

class base__storage__data__manager__kampa {
  base__storage__data__manager__kampa(
    this.ds___meta,
    this.column__tree,
  );

  final base__storage__data__meta__kampa ds___meta;
  final array<base__storage__data__column__tree__element__super__kampa> column__tree;

  array<string> table__main__name__arr() {
    return array__new__generate(
      column__tree.elements__count,
      (final i) => column__tree[i].column.meta.name,
    );
  }

  base__storage__data__table__meta__protocol table__main(
    final uu table__main__id_,
  ) {
    return base__storage__data__table__main__open(
      ds___meta,
      table__main__arr: array__new__generate(
        column__tree.elements__count,
        (final i) => column__tree[i].column,
      ),
      table__main__id_: table__main__id_,
    );
  }
}
