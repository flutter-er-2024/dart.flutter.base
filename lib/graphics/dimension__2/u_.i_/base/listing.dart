part of "_.dart";

typedef base__listing__item__build__function__format = //
    base__widget Function(BuildContext build__context, uu);

SizedBox get base__widget__separat_or__vertical => //
    SizedBox(height: size__pixel__padding__vertical);

SizedBox get base__widget__separat_or__horizontal => //
    SizedBox(width: size__pixel__padding__horizontal);

fp get base__list_ing__extent__cache__vertical => //
    (screen__size.height / 2);

const uu Function(
  uu item__id_,
  uu items__count,
) base__listing__reverse__item__id_ = //
    array__reverse__element__id_;

extension base__array__convert__widget__array__extension<value__type extends Object?> //
    on array<value__type> {
  array<base__widget> convert__widget__array(
    final base__widget separation,
    final base__widget Function(uu, value__type) element__convert,
  ) {
    return base__generate__items(
      elements__count,
      separation,
      (final i) => element__convert(i, element(i)),
    );
  }
}

array<base__widget> base__generate__items /*
if `separation` is not needed ,`convert` associated-fn. should be used */
    (
  final uu count /*
excluding `separation`s */
  ,
  final base__widget separation,
  final base__widget Function(uu i) generate,
) {
  if (count == 0) {
    return array__new__empty<base__widget>();
  }

  return array__new__generate(
    ((count * 2) - 1),
    (final i) {
      if (i.isOdd) {
        return separation;
      }

      return generate(i ~/ 2);
    },
  );
}

array<base__widget> base__generate__items__and__title({
  required final base__widget title,
  final base__widget? separator__title_and_item,
  required final int items__count /*
  excluding `widgetSeparator`, this complexity is abstracted, and is none of user's business */
  ,
  required final base__widget Function(int iter_item) items__generator,
  base__widget? items__separator,
  final bool items__b_growable = NO,
}) {
  items__separator ??= base__widget__separat_or__vertical;

  if (items__count == 0) {
    /* `growable` is NOT respected */
    return <base__widget>[
      title,
      (separator__title_and_item ?? items__separator),
    ];
  }

  final uu itemCount_ /* including the first(maybe title) widget */;

  final items = array<base__widget>.filled(
    (itemCount_ = ((items__count * 2) + 1)),
    empty__widget,
    growable: items__b_growable,
  )
    ..[0] = title
    ..[1] = (separator__title_and_item ?? items__separator);

  for (uu itemCounter = 2; itemCounter < itemCount_; itemCounter += 1) {
    items[itemCounter] = (itemCounter.isEven //
        ? items__generator((itemCounter ~/ 2) - 1)
        : items__separator);
  }

  return items;
}

typedef base__list_ing__grow_able__listing__widget__function__format = base__widget Function(
  base__widget__tree__node context,
  uu items__count,
  base__listing__item__build__function__format item__widget,
);

class base__list_ing__grow_able<element__new__type> //
    extends base__depository__base {
  base__list_ing__grow_able()
      : _elements__new = base__accumulation<element__new__type>(),
        channel = base__widget__re_build__event__channel__broadcast();

  final base__widget__re_build__event__channel__broadcast channel;

  final base__accumulation<element__new__type> _elements__new;

  void add__element(
    final element__new__type element__new,
  ) {
    _elements__new.add__element(
      element__new,
    );

    channel.event__announce();
  }

  /*void remove__element(final uu element__id_) {}*/

  element__new__type element__new(
    final uu id_,
  ) =>
      _elements__new.element(
        id_,
      );

  uu elements__new__count() => //
      _elements__new.elements__count();

  uu _elements__new__count__definitive() => //
      elements__new__count();

  array<element__new__type> elements__new__convert__array() => //
      _elements__new.convert__array();

  @override
  void dispose() {
    _elements__new.dispose();

    channel.dispose();
  }
}

extension base__list_ing__grow_able__widget //
    <element__new__type> //
    on base__list_ing__grow_able<element__new__type> {
  base__widget widget({
    required final base__list_ing__grow_able__listing__widget__function__format listing,
    required final uu items__existing__count,
    required final uu items__new__count__limit,
    required final base__listing__item__build__function__format /* 2nd param. is `item__existing__id_` */ ? item__existing__build /*
not called, if `items__existing__count` is 0 */
    ,
    required final base__listing__item__build__function__format /* 2nd param. is `item__new__id_` */
        item__new__build /*
not called, if `items__new__count` is 0
call to this function, indicates, that the user is interested, in adding, an item, to the list
  similar to press-ing, the "Add" floating button */
    ,
    required final base__listing__item__build__function__format /* 2nd param. is `item__new__id_` */
        item__new__dummy__build /*
invoke `store.control()?.add:item` to add-item
not called, if `items__new__count` is 0
example :
  `GestureDetector(onTap: item__array__count__update, child: base__listing__item(body: base__box__text__primary("Add item ${item__id_ + 1}")))` */
    ,
  }) /*
"element" is datum(singular form ,of data) ,while "item" is the gui form ,of "element"
  naming is simply naming ,nothing much (sense) */
  {
    return base__event__channel__broadcast__handling__widget(
      channel: channel,
      build: (final context) {
        final items__new__count = _elements__new__count__definitive();

        var items__count = (items__new__count + items__existing__count);
        if (items__new__count < items__new__count__limit) {
          items__count += 1;
        }

        return listing(
          context,
          items__count,
          (final build__context, var item__id_) {
/*
(items__new__first__ok /* order ,the new-ly add-ed items ,before exist-ing ones */
    ? ((id_ < items__new__count) //
        ? items__new__arr[base__listing__reverse__item__id_(
            id_,
            items__new__count,
          )]
        : items__exist_ing__arr[base__listing__reverse__item__id_(
            (id - items__new__count),
            items__exist_ing__count,
          )])
    : ((id_ < items__exist_ing__count) //
        ? items__exist_ing__arr[base__listing__reverse__item__id_(
            id_,
            items__exist_ing__count,
          )]
        : items__new__arr[base__listing__reverse__item__id_(
            (id - items__exist_ing__count),
            items__new__count,
          )])) */

            if ((item__id_ = base__listing__reverse__item__id_(
                  item__id_,
                  items__count,
                )) <
                items__existing__count) {
              return (item__existing__build?.call(
                    build__context,
                    item__id_,
                  ) ??
                  empty__widget);
            }

            item__id_ -= items__existing__count;

            return ((item__id_/*<*/ != items__new__count) //
                ? item__new__build(
                    build__context,
                    item__id_,
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      bottom: size__pixel__padding__vertical,
                    ),
                    child: item__new__dummy__build(
                      build__context,
                      item__id_,
                    ),
                  ));
          },
        );
      },
    );
  }
}

class base__list_ing__grow_able__sav_able //
    <element__new__type, element__new__sav_ed__type> /*
`element__new` is `element__new__un_sav_ed` */ //
    extends base__list_ing__grow_able<element__new__type> {
  base__list_ing__grow_able__sav_able() //
      : _elements__new__sav_ed = base__accumulation<element__new__sav_ed__type>();

  final base__accumulation<element__new__sav_ed__type> _elements__new__sav_ed;

  bool? _save__allow__ok;

  void save__elements(
    final array<element__new__sav_ed__type> elements__new__sav_ed__arr /*
must have same elements:count as input/param. */
    ,
  ) /*
`elements:new`[`:array`] should not be cached after this proc. 
  ,because its flush-ed */
  {
    _elements__new.flush();

    elements__new__sav_ed__arr.iterate__basic(
      (final _, final element__new__sav_ed) {
        _elements__new__sav_ed.add__element(
          element__new__sav_ed,
        );
      },
    );

    channel.event__announce();
  }

  uu elements__new__sav_ed__count() => //
      _elements__new__sav_ed.elements__count();

  @override
  uu _elements__new__count__definitive() => //
      (elements__new__sav_ed__count() + super._elements__new__count__definitive());

  element__new__sav_ed__type element__new__sav_ed(
    final uu id_,
  ) =>
      _elements__new__sav_ed.element(
        id_,
      );

  array<element__new__sav_ed__type> elements__new__sav_ed__convert__array() => //
      _elements__new__sav_ed.convert__array();

  bool? save__allow__ok() {
    return _save__allow__ok;
  }

  void save__allow() {
    if (_save__allow__ok == OK) {
      return;
    }

    _save__allow__ok = OK;
    channel.event__announce();
  }

  void save__allow__auto_() {
    if (_save__allow__ok == NIL) {
      return;
    }

    _save__allow__ok = NIL;
    channel.event__announce();
  }

  @override
  void dispose() {
    super.dispose();
    _elements__new__sav_ed.dispose();
  }
}

extension base__list_ing__grow_able__sav_able__widget //
    <element__new__type, element__new__sav_ed__type> //
    on base__list_ing__grow_able__sav_able //
    <element__new__type, element__new__sav_ed__type> {
  base__widget widget //
      <element__new__type, element__new__sav_ed__type>({
    required final base__list_ing__grow_able__listing__widget__function__format listing,
    required final uu items__existing__count,
    required final uu items__new__count__limit,
    required final base__listing__item__build__function__format /* 2nd param. is `item__exist_ing__id` */ ? item__existing__build,
    required final base__listing__item__build__function__format /* 2nd param. is `item__new__sav_ed__id` */ item__new__saved__build,
    required final base__listing__item__build__function__format /* 2nd param. is `item__new__un_sav_ed__id` */
        item__new__un_saved__build,
    required final base__listing__item__build__function__format /* 2nd param. is `item__new__id` */ item__new__dummy__build,
    final base__widget? save__button /*
not visible ,if no elements ,are un-sav-ed */
    ,
  }) {
    return (this as base__list_ing__grow_able<element__new__type>).widget(
      listing: listing,
      items__existing__count: items__existing__count,
      items__new__count__limit: items__new__count__limit,
      item__existing__build: item__existing__build,
      item__new__build: (
        final context,
        final item__new__id_,
      ) {
        final elements__new__saved__count_1 = elements__new__sav_ed__count();

        if (item__new__id_ < elements__new__saved__count_1) {
          return item__new__saved__build(
            context,
            item__new__id_,
          );
        }

        return item__new__un_saved__build(
          context,
          (item__new__id_ - elements__new__saved__count_1),
        );
      },
      item__new__dummy__build: item__new__dummy__build,
      /*floating__button: ((save__button != null)
          ? (final context) {
              if /*F*/ (_save__allow__ok == OK) {
                return save__button;
              }

              if /*F*/ (_save__allow__ok == NO) {
                return empty__widget;
              }

              if /*F*/ (elements__new__count() == 0) {
                return empty__widget;
              }

              return save__button;
            }
          : /*(final context) => //
            base__button__floating(
              icon: flutter__icons.save,
              string: "save",
              press__handle: () {
                if (store.elements__new__count() == 0) {
                  context.navigate__notice(
                    notice__build: (final context) => //
                        notice__basic(
                      context: context,
                      title: "nothing to save",
                      body: "no items available ,to add",
                    ),
                  );
                  return;
                }

                context.navigate__activity(
                  data__base__table__rows__add(
                    depository.elements__new__convert__array(),
                  ),
                  success__handle: depository.save__elements,
                  indicate__activity__build: NIL,
                  $error__handle: NIL,
                );
              },
            )*/
          NIL),*/
    );
  }
}
