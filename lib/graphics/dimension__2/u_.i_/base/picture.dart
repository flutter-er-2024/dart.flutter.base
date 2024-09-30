part of "_.dart";

typedef base__input__media__picture__result //
    <picture__id___type extends Object /* to prevent NIL-able types */, picture__data__type extends Object> //
    = ({
  picture__id___type id_,
  base__asyn___value__handling__depository<picture__data__type> data__future__handling__depository,
});

class base__input__media__picture__depository //
    <picture__id___type extends Object, picture__data__type extends Object> //
    implements
        base__dispose__protocol {
  base__input__media__picture__depository({
    required final picture__id___type id_,
    required final asyn___value<picture__data__type> Function(
      picture__id___type picture__id_,
    ) data__fetch,
  }) : _value = (
          id_: id_,
          data__future__handling__depository: base__asyn___value__handling__depository<picture__data__type>(
            data__fetch(
              id_,
            ),
          ),
        );

  base__input__media__picture__depository.empty() //
      : _value = NIL;

  base__input__media__picture__result<picture__id___type, picture__data__type>? _value;

  base__input__media__picture__result<picture__id___type, picture__data__type>? //
      value() {
    return _value;
  }

  @override
  void dispose() {
    _value = NIL;
  }
}

typedef base__input__media__picture__choose__result //
    <picture__id___type extends Object, picture__data__type extends Object> //
    = ({
  picture__id___type id_,
  picture__data__type data,
});

base__widget base__input__media__picture //
    <picture__id___type extends Object, picture__data__type extends Object>({
  required final base__widget__tree__node context,
  required final base__input__media__picture__depository<picture__id___type, picture__data__type> depository,
  required final asyn___value<base__input__media__picture__choose__result<picture__id___type, picture__data__type>> //
          Function()
      picture__choose__handle /*
no issue ,if [`asyn___promise` is] never completed */
  ,
  required final base__widget Function(
    base__widget__tree__node context,
    base__asyn___value__handling__depository<picture__data__type> depository,
    base__widget Function(
      base__widget__tree__node context,
      picture__data__type data,
    ) success__indicate,
  ) asyn___value__handling__widget,
  required final base__widget Function(
    base__widget__tree__node context,
    picture__data__type data,
  ) picture__indicate,
  required final base__widget__build__function__format place_holder,
}) /*
allows the user to [re-]choose a picture */
{
  base__widget re_choos_able(
    final base__widget__build__function__format child,
  ) {
    return base__widget__build__basic(
      build: (final context) {
        return base__gesture__press__handling__widget(
          () async {
            final pic_ = await picture__choose__handle();

            depository._value = (
              id_: pic_.id_,
              data__future__handling__depository: base__asyn___value__handling__depository<picture__data__type>.data(
                pic_.data,
              ),
            );

            context.re_build();
          },
          child(
            context,
          ),
        );
      },
    );
  }

  final _value = depository._value;

  if (_value == null) {
    return re_choos_able(
      place_holder,
    );
  }

  return asyn___value__handling__widget(
    context,
    _value.data__future__handling__depository,
    (final _, final data) {
      return re_choos_able(
        (final context) {
          return picture__indicate(
            context,
            data,
          );
        },
      );
    },
  );
}
