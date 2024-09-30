library storage__data__basic;

//

import "package:base/base/_.dart";

import "../storage/_.dart";

import "dart:io" as io;

import "package:sqlite3/sqlite3.dart" as sqlite3;

//

const //
    base__storage__data__basic__file__name__default = "_.db",
    base__storage__data__basic__table__row__column__id___name = char__underscore;

typedef base__storage__data__basic__creation__handle__procedure__format //
    = base__value__single__procedure__format<base__storage__data__basic>;

base__storage__data__basic //
    base__storage__data__basic__open({
  required final string storage__directory__permanent__path__absolute,
  required final string storage__directory__temporary__path__absolute,
  final string ds___file__name = base__storage__data__basic__file__name__default,
  required final base__storage__data__basic__creation__handle__procedure__format ds___creation__handle,
}) /*
the data-base access ,must be exclusive */
{
  if (debug__report_ing__verbose__ok) {
    sqlite__info().convert__text__representation().print("sqlite__info");
  }

  sqlite3.sqlite3.tempDirectory = storage__directory__temporary__path__absolute;

  final //
      file__path = (storage__directory__permanent__path__absolute + base__storage__file__path__separator + ds___file__name),
      file__exists__ok = io.File(
        file__path,
      ).existsSync();

  if (debug__report_ing__verbose__ok) {
    file__exists__ok.convert__text__representation().print("ds___file__exist__ok");
  }

  final ds___meta = base__storage__data__basic(
    sqlite3.sqlite3.open(
      file__path,
      mode: (file__exists__ok //
          ? sqlite3.OpenMode.readWrite
          : sqlite3.OpenMode.readWriteCreate),
    ),
  );

  if (file__exists__ok.not) {
    ds___creation__handle(
      ds___meta,
    );
  } else if (debug__report_ing__verbose__ok) {
    ds___meta.tables__count().convert__text__representation().print("ds___meta__tables__count");
  }

  return ds___meta;
}

base__storage__data__basic base__storage__data__basic__open__memory({
  required final string storage__directory__temporary__path__absolute,
  required final base__storage__data__basic__creation__handle__procedure__format ds___creation__handle,
}) {
  if (debug__report_ing__verbose__ok) {
    sqlite__info().convert__text__representation().print("sqlite:info");
  }

  sqlite3.sqlite3.tempDirectory = storage__directory__temporary__path__absolute;

  final ds___meta = base__storage__data__basic(
    sqlite3.sqlite3.openInMemory(),
  );

  ds___creation__handle(
    ds___meta,
  );

  return ds___meta;
}

class base__storage__data__basic /*
based on sqlite3
  sqlite is quite-ok(compared to alternatives) ,for {non-concurrent connections ,and data:file:size less than the file-system's limits} 
    ,otherwise postgresql ,but overall ,S.Q.L.-to-software interface is a non-sensible approach
requires `sqlite3_flutter_libs` pkg. */
{
  const base__storage__data__basic(
    this._db,
  );

  final sqlite3.Database _db;

  string _table__id___convert__name(
    final uu table__id_,
  ) =>
      (char__underscore + table__id_.toString());

  uu _table__rows__count({
    required final string table__name,
    final string suffix = empty__string,
  }) =>
      (raw__statement__execute(
        statement: ("SELECT COUNT(*) FROM " + table__name + suffix),
        result__need_ed__ok: OK,
      )!
          .element__first
          .element__first as uu);

  uu table__rows__count({
    required final uu table__id_,
  }) =>
      _table__rows__count(
        table__name: _table__id___convert__name(
          table__id_,
        ),
      );

  uu tables__count() /*
excluding, the mandatory, ad default, schema table
\refer `https://www.sqlite.org/schematab.html` */
      =>
      _table__rows__count(
        table__name: "sqlite_schema",
        suffix: " WHERE type = 'table'",
      );

  void transaction__begin /*
needed for write op.s ,not for read op.s */
      () {
    raw__statement__execute(
      statement: "BEGIN IMMEDIATE",
    );
  }

  void transaction__end() {
    raw__statement__execute(
      statement: "COMMIT",
    );
  }

  void transaction__revert() {
    raw__statement__execute(
      statement: "ROLLBACK",
    );
  }

  uu table__create({
    required final array<base__storage__data__basic__table__column__meta> columns__meta,
  }) {
    final //
        table__id_ = tables__count(),
        statement__buffer = StringBuffer("CREATE TABLE ")
          ..write(
            _table__id___convert__name(
              table__id_,
            ),
          )
          ..write(" ($base__storage__data__basic__table__row__column__id___name ")
          ..write(
            base__storage__data__basic__table__column__data__type.integer__auto_.convert__sqlite__type__string(),
          )
          ..write(" PRIMARY KEY") /*
avoid `AUTOINCREMENT`
  `http://www.sqlite.org/autoinc.html` */
        ;

    columns__meta.iterate__basic(
      (final column__id_, final column__meta) {
        statement__buffer
          ..write(", _")
          ..write(column__id_)
          ..write(char__space)
          ..write(
            column__meta.type.convert__sqlite__type__string(),
          );

        if (!column__meta.nil_able__ok) {
          statement__buffer
            ..write(char__space)
            ..write("NOT ")
            ..write(
              base__storage__data__basic__table__column__data__type.nil.convert__sqlite__type__string(),
            );
        }
      },
    );

    statement__buffer.write(");");

    raw__statement__execute(
      statement: statement__buffer.toString(),
    );

    statement__buffer.clear();

    return table__id_;
  }

  void table__dispose({
    required final uu table__id_,
    required final array<base__storage__data__basic__table__column__meta> columns__meta,
  }) {
    raw__statement__execute(
      statement: ("DROP TABLE " + _table__id___convert__name(table__id_)),
    );
  }

  /*string by__array__convert__sqlite__data__type__BLOB__string(
    final by__arr bytes,
  ) {
    final buffer = StringBuffer("x'");

    array__iterate__basic(
      bytes,
      (final _, final b) {
        buffer.write(
          b.toRadixString(16),
        );
      },
    );

    buffer.write(
      char__quote__single,
    );

    final result = buffer.toString();

    buffer.clear();

    return result;
  }*/

  uu /*row:id_*/ table__row__add /*
`(column:row:id_:name == base:data:storing:table:row:column:id_:name)` */
      ({
    required final uu table__id_,
    required final array<base__storage__data__basic__table__column__meta> columns__meta,
    required final array<Object?> /*row*/ columns,
  }) {
    final //
        columns__count = columns__meta.elements__count,
        statement__buffer = StringBuffer("INSERT INTO ")
          ..write(
            _table__id___convert__name(
              table__id_,
            ),
          )
          ..write(" (");

    {
      statement__buffer.write(columns__meta.element__first.name());

      base__iterate__basic(
        (columns__count - 1),
        (final column__id_) {
          statement__buffer
            ..write(", ")
            ..write(columns__meta[column__id_].name());
        },
        offset: 1,
      );
    }

    statement__buffer
      ..write(") VALUES (")
      ..write("?," * (columns__count - 1))
      ..write(char__question)
      ..write(char__bracket__round__close)
      ..write(" RETURNING $base__storage__data__basic__table__row__column__id___name");

    final statement = statement__buffer.toString();
    statement__buffer.clear();

    return (raw__statement__execute(
      statement: statement,
      statement__arguments: columns,
      result__need_ed__ok: OK,
    )!
        .element__first
        .element__first as uu);
  }

  void table__row__mutate({
    required final uu table__id_,
    required final uu row__id_,
    required final array<base__storage__data__basic__table__column> columns,
  }) {
    final //
        statement__buffer = StringBuffer("UPDATE ")
          ..write(
            _table__id___convert__name(
              table__id_,
            ),
          )
          ..write(" SET "),
        statement__arguments__list = <Object?>[];

    columns.iterate__basic(
      (final column__id_, final column) {
        if (column__id_ != 0) {
          statement__buffer.write(", ");
        }

        statement__buffer
          ..write(column.meta.name())
          ..write(" = ?");
        statement__arguments__list.add(
          column.value,
        );
      },
    );

    statement__buffer.write(" WHERE $base__storage__data__basic__table__row__column__id___name = ?");
    statement__arguments__list.add(row__id_);

    raw__statement__execute(
      statement: statement__buffer.toString(),
      statement__arguments: statement__arguments__list,
    );

    statement__buffer.clear();
  }

  void table__row__remove({
    required final uu table__id_,
    required final uu row__id_,
  }) {
    final //
        statement__buffer = StringBuffer("DELETE FROM ") //
          ..write(
            _table__id___convert__name(
              table__id_,
            ),
          )
          ..write(" WHERE $base__storage__data__basic__table__row__column__id___name = ?");

    raw__statement__execute(
      statement: statement__buffer.toString(),
      statement__arguments: [row__id_],
    );

    statement__buffer.clear();
  }

  void table__rows__all__remove({
    required final uu table__id_,
  }) {
    final //
        statement__buffer = StringBuffer("DELETE FROM ") //
          ..write(
            _table__id___convert__name(
              table__id_,
            ),
          );

    raw__statement__execute(
      statement: statement__buffer.toString(),
    );

    statement__buffer.clear();
  }

  void _table__columns__id___join(
    final StringBuffer buffer,
    final array<base__storage__data__basic__table__column__meta> columns__meta,
    final bool result__column__id___ok,
  ) {
    if (columns__meta.empty__ok() /* because sqlite mandates non-empty selection-columns */) {
      buffer.write(base__storage__data__basic__table__row__column__id___name);
      return;
    }

    if (result__column__id___ok) {
      buffer
        ..write(base__storage__data__basic__table__row__column__id___name)
        ..write(", ");
    }

    buffer.write(columns__meta.element__first.name());

    columns__meta.iterate__basic(
      (final /*column__id___id_*/ _, final column__meta) {
        buffer
          ..write(", ")
          ..write(column__meta.name());
      },
      offset: 1,
    );
  }

  array<array<Object?>> /*
the first column of each row ,is the unique id_ ,of the row ,its type ,is un-signed integer ,and range 1..s64 */
      table__rows({
    required final uu table__id_,
    required final array<base__storage__data__basic__table__column__meta>? result__columns__meta /*
if NIL ,then all the columns ,but respecting the "conditions" argument
if empty ,then the column-id column ,is implicit */
    ,
    final bool result__column__id___ok /*
ignored if `result__columns__meta == NIL` */
    = NO,
    final bool result__rows__distinct__ok = NO,
    required final string? result__conditions /*
  example: "$(column:name) LIKE ?"
    '?' indicates substitution, from "conditions__arguments" */
    ,
    required final array<Object?>? result__conditions__arguments /*
  example: "Dr%", "%@mail.com" */
    ,
    final array<base__storage__data__basic__table__column__meta>? result__order__columns__meta /*
if NIL ,then resulting rows ,are un-order-ed ,or the order is un-defin-ed ,and "result__order__ascend_ing__ok" is ignored  */
    ,
    final bool result__order__ascend_ing__ok /* otherwise descend-ing */ = OK,
    final uu? result__rows__count__limit,
    final uu? result__rows__id___offset /*
`result__order__columns__meta` should also be passed */
    ,
  }) /*
example
  search
    table__rows ( \arg.s\  result__conditions :"${column__meta.name()} LIKE ?" ,result__conditions__arguments :[ "%@mail.com" ] ) */
  {
    final statement__buffer = StringBuffer("SELECT ");

    if (result__rows__distinct__ok) {
      statement__buffer.write("DISTINCT ");
    }

    if (result__columns__meta != null) {
      _table__columns__id___join(
        statement__buffer,
        result__columns__meta,
        result__column__id___ok,
      );
    } else {
      statement__buffer.write(char__asterisk);
    }

    statement__buffer
      ..write(" FROM ")
      ..write(
        _table__id___convert__name(
          table__id_,
        ),
      );

    if (result__conditions != null) {
      statement__buffer.write(
        (" WHERE " + result__conditions),
      );
    }

    if (result__order__columns__meta != null) {
      statement__buffer.write(" ORDER BY ");

      _table__columns__id___join(
        statement__buffer,
        result__order__columns__meta,
        NO,
      );

      statement__buffer
        ..write(char__space)
        ..write(
          (result__order__ascend_ing__ok //
              ? "ASC"
              : "DESC"),
        );
    }

    if (result__rows__count__limit != null) {
      statement__buffer
        ..write(" LIMIT ")
        ..write(result__rows__count__limit);
    }

    if (result__rows__id___offset != null) {
      statement__buffer
        ..write(" OFFSET ")
        ..write(result__rows__id___offset);
    }

    final statement = statement__buffer.toString();
    statement__buffer.clear();

    return raw__statement__execute(
      statement: statement,
      statement__arguments: result__conditions__arguments,
      result__need_ed__ok: OK,
    )!;
  }

  array<array<Object?>> table__rows__all({
    required final uu table__id_,
    final array<base__storage__data__basic__table__column__meta>? result__columns__meta,
    final bool result__column__id___ok = NO,
  }) {
    return table__rows(
      table__id_: table__id_,
      result__columns__meta: result__columns__meta,
      result__column__id___ok: result__column__id___ok,
      result__conditions: NIL,
      result__conditions__arguments: NIL,
    );
  }

  array<Object?>? table__row({
    required final uu table__id_,
    required final uu row__id_,
    required final array<base__storage__data__basic__table__column__meta>? result__columns__meta,
  }) {
    final rows = table__rows(
      table__id_: table__id_,
      result__columns__meta: result__columns__meta,
      result__conditions: "$base__storage__data__basic__table__row__column__id___name = ?",
      result__conditions__arguments: [row__id_],
    );

    if (rows.empty__ok()) {
      return NIL;
    }

    if /*F*/ (rows.elements__count > 1) {
      throw "exception :`row:id_` is not unique";
    }

    return rows.element__first;
  }

  array<array<Object?>>? raw__statement__execute({
    required final string statement,
    array<Object?>? statement__arguments,
    final bool result__need_ed__ok = NO,
  }) {
    {
      statement.convert__text__representation().print("statement");
      statement__arguments.convert__text__representation(NIL, NO).print("statement:arguments");
    }

    statement__arguments ??= empty__Object__nil_able;

    if (NOT(result__need_ed__ok)) {
      _db.execute(
        statement,
        statement__arguments,
      );

      return NIL;
    }

    return _db
        .select(
          statement,
          statement__arguments,
        )
        .rows;
  }

  /*sqlite3.PreparedStatement raw__statement__prepare({
    required final string statement,
  }) {
    _statement__report(statement, null);

    return _db.prepare(
      statement,
    );
  }*/
}

enum base__storage__data__basic__table__column__data__type {
  nil /*Null*/,
  integer__un_signed /*u64*/,
  integer__signed /*s64*/,
  integer__auto_ /*ss*/,
  bytes /*by:arr*/,
  string /*string*/ /* prefer "bytes", unless search-ing is required */,
  floating_point /*fp*/,
}

extension on base__storage__data__basic__table__column__data__type {
  string convert__sqlite__type__string() => switch (this) {
        base__storage__data__basic__table__column__data__type.nil => "NULL",
        base__storage__data__basic__table__column__data__type.integer__un_signed => "UNSIGNED BIG INT",
        base__storage__data__basic__table__column__data__type.integer__signed => "BIGINT",
        base__storage__data__basic__table__column__data__type.integer__auto_ => "INTEGER",
        base__storage__data__basic__table__column__data__type.bytes => "BLOB",
        base__storage__data__basic__table__column__data__type.string => "TEXT",
        base__storage__data__basic__table__column__data__type.floating_point => "REAL",
      };
}

sqlite3.Version sqlite__info() => //
    sqlite3.sqlite3.version;

class base__storage__data__basic__table__column__meta /*
example :"
typedef _column__meta = base__storage__data__table__column__meta;
typedef _column__data__type = base__storage__data__table__column__data__type;
final //
  _column__abc = _column__meta(null,_column__data__type.integer__un_signed),
  _column__jkl = _column__meta(_column__abc,_column__data__type.integer__auto),
  _column__xyz = _column__meta(_column__jkl,_column__data__type.bytes, nil_able__ok: OK),
  _columns__meta = [_column__abc, _column__jkl, _column__xyz];
" */
{
  base__storage__data__basic__table__column__meta(
    final base__storage__data__basic__table__column__meta? column__previous__meta,
    this.type, {
    this.nil_able__ok = NO,
  }) : id_ = ((column__previous__meta != null) //
            ? (1 + column__previous__meta.id_)
            : 0);

  final uu id_;
  /*final string name;*/
  final base__storage__data__basic__table__column__data__type type;
  final bool nil_able__ok;

  string name() {
    return "$char__underscore$id_";
  }
}

class base__storage__data__basic__table__column {
  const base__storage__data__basic__table__column(
    this.meta,
    this.value,
  );

  final base__storage__data__basic__table__column__meta meta;
  final Object? value;
}
