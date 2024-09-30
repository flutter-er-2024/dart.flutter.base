part of "../_.dart";

base__widget overlay__bottom__alert({
  required final base__widget__tree__node context,
  required final string title,
  required final string sub_title,
  final string dismiss__button__title = "OK",
}) =>
    base__overlay__bottom__menu(
      context,
      title: title,
      sub_title: sub_title,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <base__widget>[
          base__overlay__bottom__button__dismiss(
            context: context,
            title: dismiss__button__title,
          ),
          SizedBox(height: 64.px),
        ],
      ),
    );

base__widget overlay__bottom__confirm__item({
  final BorderRadius? border__radius,
  final bool action__destructive__ok = NO,
  required final string title,
  final string? sub_title,
  final base__widget? trailing,
}) =>
    base__listing__item(
      border__radius: border__radius,
      body: base__box__text__primary__secondary__auto(
        primary__string: title,
        primary__color: (action__destructive__ok //
            ? color__red
            : color__foreground__default),
        secondary__string: sub_title,
      ),
      trailing: trailing,
    );

base__widget overlay__bottom__confirm({
  required final base__widget__tree__node context,
  required final bool action__destructive__ok,
  required final string title,
  required final string sub_title,
  required final procedure__empty__format proceed__handle,
  final string proceed__title = "OK",
  final string? proceed__sub_title,
  final string cancel__title = "Cancel",
  final string? cancel__sub_title,
}) =>
    base__overlay__bottom__menu(
      context,
      dismiss__swipe__indication__ok: NO,
      button__close__ok: NO,
      title: title,
      sub_title: sub_title,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size__pixel__padding__horizontal__double,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <base__widget>[
            base__gesture__press__handling__widget(
              () {
                context.navigate__backward();
                proceed__handle();
              },
              overlay__bottom__confirm__item(
                border__radius: base__listing__item__position__top__border__radius(),
                action__destructive__ok: action__destructive__ok,
                title: proceed__title,
                sub_title: proceed__sub_title,
                trailing: base__icon(
                  base__icon__press_able,
                ),
              ),
            ),
            base__widget__separat_or__vertical,
            base__gesture__press__handling__widget(
              () => context.navigate__backward(),
              base__listing__item(
                border__radius: base__listing__item__position__bottom__border__radius(),
                selected__ok: OK,
                body: base__box__text__primary__secondary__auto(
                  primary__string: cancel__title,
                  secondary__string: cancel__sub_title,
                ),
                trailing: base__icon(
                  base__icon__press_able,
                ),
              ),
            ),
            SizedBox(height: 64.px),
          ],
        ),
      ),
    );

base__widget overlay__bottom__options({
  required final base__widget__tree__node context,
  required final string title,
  final string? sub_title,
  required final array<base__widget> option__arr /*
prefer `base__listing__item`
  with position-based `border__radius`, and in-between `base__widget__separat_or__vertical`
  suggestion: prefer removing sub_title, if space is (almost) exceeded, because the list is non-scrollable */
  ,
}) =>
    base__overlay__bottom__menu(
      context,
      back_ground__filter: image__filter__blur__default,
      title: title,
      sub_title: sub_title,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size__pixel__padding__horizontal,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: option__arr,
        ),
      ),
    );

/* base__widget overlay__bottom__input__number({
  required final base__widget__tree__node context,
  required final string title,
  final string? sub_title,
  required final uu input__max,
  required final void Function(uu input) submit__handle,
}) {
  uu number = 0;
  void number__update(
    final uu number__new,
  ) {
    if (number__new > input__max) //
      return;

    number = number__new;
  }

  procedure__empty__format re_build = empty__procedure__empty;

  const //
      rows__count = 3,
      columns__count = 3;

  return base__overlay__bottom__menu(
    context,
    title: title,
    sub_title: sub_title,
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size__pixel__padding__horizontal,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <base__widget>[
          Center(
            child: base__widget__build__definitive(
              init_: (final state) => //
                  (re_build = state.re_build__raw),
              de_init_: () => //
                  (re_build = empty__procedure__empty),
              build: (final _) => //
                  box__text__widget(
                number.toString(),
                font__size: 28.px,
              ),
            ),
          ),
          SizedBox(
            height: size__pixel__padding__vertical__double,
          ),
          SizedBox(
            height: (screen__size.height * 0.3),
            child: Column(
              children: <base__widget>[
                for (uu row__id_ = 0; row__id_ < rows__count; row__id_ += 1) //
                  Expanded(
                    child: Row(
                      children: array__new__generate(
                        columns__count,
                        (final column__id_) {
                          final number_ = (((row__id_ * rows__count) + 1) + column__id_);

                          return _input__number__button(
                            child: box__text__widget(
                              number_.toString(),
                              font__size: 24.px,
                            ),
                            press__handle: () {
                              number__update((number * 10) + number_);
                              re_build();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                Expanded(
                  child: Row(
                    children: [
                      _input__number__button(
                        child: box__text__widget(
                          "CLR",
                          font__size: 18.px,
                        ),
                        press__handle: () {
                          if (number > 9) //
                            number ~/= 10;
                          else //
                            number = 0;

                          re_build();
                        },
                        press__long__handle: () {
                          number = 0;

                          re_build();
                        },
                      ),
                      _input__number__button(
                        child: box__text__widget(
                          0.toString(),
                          font__size: 24.px,
                        ),
                        press__handle: () {
                          number__update(number * 10);
                          re_build();
                        },
                      ),
                      _input__number__button(
                        selected__ok: OK,
                        child: base__icon(
                          base__icon__done,
                          size: 24.px,
                        ),
                        press__handle: () {
                          submit__handle(number);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size__pixel__padding__vertical__double,
          ),
        ],
      ),
    ),
  );
} */

base__widget _input__number__button({
  final bool selected__ok = NO,
  required final base__widget child,
  required final procedure__empty__format press__handle,
  final procedure__empty__format? press__long__handle,
}) =>
    Expanded(
      child: Padding(
        padding: EdgeInsets.all(2.px),
        child: base__box__button(
          b__highlight: selected__ok,
          child: base__box__widget__max(
            Center(
              child: child,
            ),
          ),
          onSinglePress: press__handle,
          onLongPress: press__long__handle,
        ),
      ),
    );

/*base__widget overlay__bottom__explorer__file_system({
  required final base__widget__tree__node context,
}) =>
    overlay__bottom__menu(
      context: context,
      title: "Choose a directory, to explore",
      items__padding__horizontal: size__pixel__padding__horizontal,
      item__arr: <base__widget>[
        GestureDetector(
          onTap: () {
            final $scroll__manager = scroll__manager__kampa.create();
            context
                .navigate__forward__replace__page(
                  page__build: (final $context) => //
                      pages__directory__page(
                    context: $context,
                    scroll__manager: $scroll__manager,
                    directory__path: '/',
                    choose__handle: (final _) {},
                  ),
                )
                .then__result__ignore(
                  $scroll__manager.de_init_,
                );
          },
          child: base__listing__item(
            body: base__box__text__primary__secondary(
              "Root",
              "'/'",
            ),
            trailing: base__icon(
              base__icon__navigation__forward,
            ),
          ),
        ),
        base__widget__separat_or__vertical,
        GestureDetector(
          onTap: () {
            final $scroll__manager = scroll__manager__kampa.create();
            context
                .navigate__forward__replace__page(
                  page__build: (final $context) => //
                      pages__directory__page(
                    context: $context,
                    scroll__manager: $scroll__manager,
                    directory__path: storage__path,
                    choose__handle: (final _) {},
                  ),
                )
                .then__result__ignore(
                  $scroll__manager.de_init_,
                );
          },
          child: base__listing__item(
            body: base__box__text__primary__secondary(
              "App's files",
              ("\"" + storage__path + '"'),
            ),
            trailing: base__icon(
              base__icon__navigation__forward,
            ),
          ),
        ),
      ],
    );*/
