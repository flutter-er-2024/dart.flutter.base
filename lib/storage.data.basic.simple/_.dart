library storage__data__basic__simple;

//

import "package:base/base/_.dart";
import "../storage.data.basic/_.dart";

//

const //
    base__storage__data__basic__simple__ds___table__id___default = 0;

final _columns__meta = array__new__elements__single(
  base__storage__data__basic__table__column__meta(
    NIL,
    base__storage__data__basic__table__column__data__type.bytes,
  ),
);

void base__storage__data__basic__simple__ds___creation__handle //
    <value__name__type extends Enum>({
  required final base__storage__data__basic ds_,
  final uu ds___table__id_ = base__storage__data__basic__simple__ds___table__id___default,
  required final uu values__count,
}) {
  {
    final table__id_ = ds_.table__create(
      columns__meta: _columns__meta,
    );

    if (table__id_ != ds___table__id_) {
      throw "`ds___table__id_` is in-valid ,should have been $table__id_";
    }
  }

  _rows__add(
    ds_,
    ds___table__id_,
    values__count,
  );
}

base__storage__data__basic__simple<value__name__type> //
    base__storage__data__basic__simple__open //
    <value__name__type extends Enum>({
  required final base__storage__data__basic ds_ /*
`base__storage__data__basic__simple__ds___creation__handle` must be called ,in `base__storage__data__basic__open.ds___creation__handle` passed to  */
  ,
  final uu ds___table__id_ = base__storage__data__basic__simple__ds___table__id___default,
  required final uu values__count /* values:name:enum.values.elements:count */,
}) {
  {
    final rows__count = ds_.table__rows__count(
      table__id_: ds___table__id_,
    );

    if (values__count > rows__count) {
      _rows__add(
        ds_,
        ds___table__id_,
        (values__count - rows__count),
      );
    }
  }

  return base__storage__data__basic__simple //
      <value__name__type>._(
    ds_,
    ds___table__id_,
  );
}

void _rows__add //
    <value__name__type extends Enum>(
  final base__storage__data__basic storage,
  final uu ds___table__id_,
  final uu count,
) {
  final columns = array__new__elements__single(
    empty__by__arr,
  );

  base__iterate__reverse__basic(
    count,
    (final _) {
      storage.table__row__add(
        table__id_: ds___table__id_,
        columns__meta: _columns__meta,
        columns: columns,
      );
    },
  );
}

class base__storage__data__basic__simple //
    <value__name__type extends Enum> /*
based on `base__storage__data` */
{
  static //
      uu //
      value__name__convert__row__id_ //
      <value__name__type extends Enum>(
    final value__name__type name,
  ) {
    return (1 + name.index);
  }

  base__storage__data__basic__simple._(
    this.$ds_,
    this._db__table__id_,
  );

  final base__storage__data__basic $ds_;
  final uu _db__table__id_;

  by__arr value__raw(
    final value__name__type name,
  ) {
    return ($ds_
        .table__row(
          table__id_: _db__table__id_,
          row__id_: value__name__convert__row__id_(
            name,
          ),
          result__columns__meta: _columns__meta,
        )!
        .element__first as by__arr);
  }

  by__arr? value(
    final value__name__type name,
  ) {
    final result = value__raw(
      name,
    );

    if (result.empty__ok()) {
      return NIL;
    }

    return result;
  }

  void value__set(
    final value__name__type name,
    final by__arr value__new,
  ) {
    $ds_.table__row__mutate(
      table__id_: _db__table__id_,
      row__id_: value__name__convert__row__id_(
        name,
      ),
      columns: array__new__elements__single(
        base__storage__data__basic__table__column(
          _columns__meta.element__first,
          value__new,
        ),
      ),
    );
  }

  void value__set__nil(
    final value__name__type name,
  ) {
    value__set(
      name,
      empty__bytes,
    );
  }

  value__type //
      _value__type__auto_ //
      <value__type extends Object>(
    final value__type? Function(
      value__name__type name,
    ) value__type__proc_,
    final void Function(
      value__name__type name,
      value__type value__new,
    ) value__type__set__proc_,
    final value__name__type name,
    final value__type value__default,
  ) {
    final value = value__type__proc_(
      name,
    );

    if (value != null) {
      return value;
    }

    value__type__set__proc_(
      name,
      value__default,
    );

    return value__default;
  }

  by__arr value__bys__auto_(
    final value__name__type name,
    final by__arr value__default,
  ) {
    return _value__type__auto_(
      value__bys,
      value__bys__set,
      name,
      value__default,
    );
  }

  by__arr? value__bys(
    final value__name__type name,
  ) =>
      value(
        name,
      );

  void value__bys__set(
    final value__name__type name,
    final by__arr value__new,
  ) =>
      value__set(
        name,
        value__new,
      );

  uu value__uu__auto_(
    final value__name__type name, [
    final uu value__default = 0,
  ]) {
    return _value__type__auto_(
      value__uu,
      value__uu__set,
      name,
      value__default,
    );
  }

  uu? value__uu(
    final value__name__type name,
  ) {
    return value(
      name,
    ).convert__if(
      (final bys) {
        return uu__bytes__convert(
          bys,
        ).value;
      },
    );
  }

  void value__uu__set(
    final value__name__type name,
    final uu value__new,
  ) {
    value__set(
      name,
      uu__convert__bytes(
        value__new,
      ),
    );
  }

  bool value__bool__auto_(
    final value__name__type name, [
    final bool value__default = NO,
  ]) {
    return _value__type__auto_(
      value__bool,
      value__bool__set,
      name,
      value__default,
    );
  }

  bool? value__bool(
    final value__name__type name,
  ) {
    return value__uu(
      name,
    ).convert__if(
      (final value) {
        return (value != 0);
      },
    );
  }

  void value__bool__set(
    final value__name__type name,
    final bool value__new,
  ) {
    value__uu__set(
      name,
      (value__new ? 1 : 0),
    );
  }

  ss value__ss__auto_(
    final value__name__type name, [
    final ss value__default = 0,
  ]) {
    return _value__type__auto_(
      value__ss,
      value__ss__set,
      name,
      value__default,
    );
  }

  ss? value__ss(
    final value__name__type name,
  ) {
    return value(
      name,
    ).convert__if(
      (final bys) {
        final result = uu__bytes__convert(
          bys.view(1),
        ).value;

        if (bys.element__first != 0) {
          return -result;
        }

        return result;
      },
    );
  }

  void value__ss__set(
    final value__name__type name,
    final ss value__new,
  ) {
    final //
        negative__ok = value__new.isNegative,
        bytes = uu__convert__bytes(
          (negative__ok //
              ? -value__new
              : value__new),
        ),
        data = by__arr(1 + bytes.bys__count) //
          ..element__first = (negative__ok //
              ? 1
              : 0);

    base__copy(
      data,
      bytes,
      dest__offset: 1,
    );

    value__set(
      name,
      data,
    );
  }

  string value__string__auto_(
    final value__name__type name,
    final string value__default,
  ) {
    return _value__type__auto_(
      value__string,
      value__string__set,
      name,
      value__default,
    );
  }

  string? value__string(
    final value__name__type name,
  ) {
    return value(
      name,
    ).convert__if(
      utf_8__bytes__convert__string,
    );
  }

  void value__string__set(
    final value__name__type name,
    final string value__new,
  ) {
    if /*T*/ (value__new.empty__not()) {
      value__set(
        name,
        string__convert__utf_8__bytes(
          value__new,
        ),
      );
    } else {
      value__set__nil(
        name,
      );
    }
  }

  fp value__fp__auto_(
    final value__name__type name, [
    final fp value__default = 0.0,
  ]) {
    return _value__type__auto_(
      value__fp,
      value__fp__set,
      name,
      value__default,
    );
  }

  fp? value__fp(
    final value__name__type name,
  ) {
    return value__string(
      name,
    ).convert__if(
      fp.parse,
    );
  }

  void value__fp__set(
    final value__name__type name,
    final fp value__new,
  ) {
    value__string__set(
      name,
      value__new.convert__string(),
    );
  }

  void values__flush() {
    $ds_.table__rows__all__remove(
      table__id_: _db__table__id_,
    );
  }
}

void base__storage__data__basic__simple__test({
  required final string storage__directory__temporary__path__absolute,
}) {
  final //
      values__count = _values__name.values.elements__count,
      storage = base__storage__data__basic__simple__open(
        ds_: base__storage__data__basic__open__memory(
          storage__directory__temporary__path__absolute: storage__directory__temporary__path__absolute,
          ds___creation__handle: (final ds_) {
            base__storage__data__basic__simple__ds___creation__handle(
              ds_: ds_,
              values__count: values__count,
            );
          },
        ),
        values__count: values__count,
      );

  {
    storage.value__uu__set(_values__name.abc, 99);
    storage.value__fp__set(_values__name.jkl, 99.99);
    storage.value__ss__set(_values__name.xyz, -99);

    {
      final value = storage.value__uu(
        _values__name.abc,
      )..convert__text__representation().print("value");

      if (value != 99) {
        throw "$value NOT==99";
      }
    }
    {
      final value = storage.value__fp(
        _values__name.jkl,
      )..convert__text__representation().print("value");

      if (value != 99.99) {
        throw "$value NOT==99.99";
      }
    }
    {
      final value = storage.value__ss(
        _values__name.xyz,
      )..convert__text__representation().print("value");

      if (value != -99) {
        throw "$value NOT==-99";
      }
    }
  }

  {
    storage.value__uu__set(_values__name.abc, 999);
    storage.value__fp__set(_values__name.jkl, 999.99);
    storage.value__ss__set(_values__name.xyz, -999);

    {
      final value = storage.value__uu(
        _values__name.abc,
      )..convert__text__representation().print("value");

      if (value != 999) {
        throw "$value NOT==999";
      }
    }
    {
      final value = storage.value__fp(
        _values__name.jkl,
      )..convert__text__representation().print("value");

      if (value != 999.99) {
        throw "$value NOT==999.99";
      }
    }
    {
      final value = storage.value__ss(
        _values__name.xyz,
      )..convert__text__representation().print("value");

      if (value != -999) {
        throw "$value NOT==-999";
      }
    }
  }
}

enum _values__name {
  abc,
  jkl,
  xyz,
}
