part of "_.dart";

typedef navigation__bottom__item__kampa = ({
  IconData icon,
  procedure__empty__format press__handle,
});

/* base__widget navigation__bottom__my_bmw__stored({
  required final array<navigation__bottom__item__kampa> page__arr /*
  prefer, to keep the `(count < 4)`
    to avoid looking bloated, or congested */
  ,
  final uu page__chosen__initial__id_ = 0,
}) /*
  design was copied from "My BMW"(`http://play.google.com/store/apps/details?id=de.bmw.connected.mobile20.row`) app,
    got reference to app, from `flutter.dart`'s web homepage */
{
  final //
      page__array__count = page__arr.elements__count,
      re_build__arr = array__new__fill<procedure__empty__format?>(
        page__array__count,
         null,
      );

  uu page__chosen__id_ = page__chosen__initial__id_;

  late final array<base__widget> items;

  void page__switch(
    final uu page__id_,
  ) {
    items[page__chosen__id_] = _button__un_selected(
      page__arr[page__chosen__id_].icon,
      () => page__switch(page__chosen__id_),
    );
    re_build__arr[page__chosen__id_]!();

    items[page__chosen__id_ = page__id_] = _button__selected(
      page__arr[page__id_].icon,
    );
    re_build__arr[page__id_]!();

    page__arr[page__id_].press__handle();
  }

  items = array<base__widget>.generate(
    page__array__count,
    (final page__id_) {
      return RepaintBoundary(
        child: base__widget__build__definitive(
          init_: (final state) => //
              (re_build__arr[page__id_] = state.re_build__raw),
          de_init_: () => //
              (re_build__arr[page__id_] =  null),
          build: (final _) => //
              ((page__id_ == page__chosen__id_)
                  ? _button__selected(
                      page__arr[page__id_].icon,
                    )
                  : _button__un_selected(
                      page__arr[page__id_].icon,
                      () => page__switch(page__id_),
                    )),
        ),
      );
    },
    growable: NO,
  );

  return base__box__floating(
    border__radius: BorderRadius.zero,
    blur: image__filter__blur__crucial,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <base__widget>[
        ColoredBox(
          color: color__background__base,
          child: SizedBox(
            width: screen__size.width,
            height: size__pixel__1,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: array__new__generate(
            page__array__count,
            (final page__id_) => //
                Expanded(
              child: items[page__id_],
            ),
          ),
        ),
        SizedBox(
          height: screen__padding.bottom,
        ),
      ],
    ),
  );
} */

base__widget _button__un_selected(
  final IconData icon,
  final VoidCallback onPress,
) =>
    GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.px,
        ),
        child: base__icon(
          icon,
          size: 28.px,
          color: color__foreground__dim,
        ),
      ),
      onTap: onPress,
    );

base__widget _button__selected(final IconData icon) => //
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4.px,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <base__widget>[
          base__widget__separat_or__vertical,
          base__icon(
            icon,
            size: 28.px,
          ),
          SizedBox(
            height: 2.px,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: color__foreground__dim,
              borderRadius: BorderRadius.all(Radius.circular(2.px)),
            ),
            child: SizedBox(
              width: 20.px,
              height: 4.px,
            ),
          ),
          base__widget__separat_or__vertical,
        ],
      ),
    );
