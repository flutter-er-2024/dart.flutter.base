part of "../_.dart";

/* base__widget pages__input__selection__page({
  required final scroll__manager__kampa scroll__manager,
  required final base__widget page__title,
  required final uu item__array__count,
  final array<uu>? selection__array__initial,
  final ({uu min, uu max}) selection__array__constraints = (min: 1 /* 0, to allow submit-ing anytime, without even a single selection */, max: u8__max),
  required final base__listing__item__build__function__format listing__item__body__build,
  final IconData? submit__button__icon = base__icon__done,
  final string submit__button__title = "Submit",
  required final void Function(array<uu> selection__id__arr) submit__handle,
}) {
  final selection__accumulation = base__accumulation__definitive<uu>();

  if (selection__array__initial != null) {
    selection__array__initial.iterate__basic(
      (final _, final item__id_) {
        selection__accumulation.add__element(
          item__id_,
        );
      },
    );
  }

  var //
      button__flush__show__ok = selection__accumulation.empty__not(),
      button__submit__show__ok = (NOT(selection__accumulation.elements__count() < selection__array__constraints.min) && //
          NOT(selection__accumulation.elements__count() > selection__array__constraints.max));

  procedure__empty__format? //
      listing__re_build,
      button__re_build,
      count__re_build;

  Key listing__key = base__widget__key__unique();

  bool select__ok(
    final uu item__id_,
  ) {
    if (selection__accumulation.elements__count() < selection__array__constraints.max) {
      selection__accumulation.add__element(
        item__id_,
      );

      if ((selection__accumulation.elements__count() < selection__array__constraints.min) || button__submit__show__ok) {
        if (button__flush__show__ok) //
          count__re_build?.call();
        else {
          button__flush__show__ok = OK;

          button__re_build?.call();
        }
      } else {
        if (!button__submit__show__ok) //
          button__submit__show__ok = OK;

        if (!button__flush__show__ok) //
          button__flush__show__ok = OK;

        button__re_build?.call();
      }

      return OK;
    }

    return NO;
  }

  bool de_select__ok(
    final uu item__id_,
  ) {
    selection__accumulation.remove__element(
      item__id_,
      base__value__same__ok,
    );

    bool button__re_build__ok = NO;

    if (selection__accumulation.empty__ok()) {
      button__flush__show__ok = NO;
      button__re_build__ok = OK;
    }

    if ((selection__accumulation.elements__count() < selection__array__constraints.min) && //
        button__submit__show__ok) {
      button__submit__show__ok = NO;

      if (NOT(button__re_build__ok)) {
        button__re_build__ok = OK;
      }
    }

    if ((!(selection__accumulation.elements__count() < selection__array__constraints.min) && //
            !(selection__accumulation.elements__count() > selection__array__constraints.max)) && //
        !button__submit__show__ok) {
      button__submit__show__ok = OK;

      if (!button__re_build__ok) {
        button__re_build__ok = OK;
      }
    }

    if (button__re_build__ok) {
      button__re_build?.call();
    } else {
      count__re_build?.call();
    }

    return OK;
  }

  void flush__handle() {
    selection__accumulation.flush();

    if (selection__array__constraints.min != 0) //
      button__submit__show__ok = NO;

    button__flush__show__ok = NO;

    listing__key = base__widget__key__unique();
    listing__re_build?.call();
  }

  return page__foundation(
    RepaintBoundary(
      child: base__widget__build__definitive(
        init_: (final state) => //
            (listing__re_build = state.re_build),
        de_init_: () => //
            (listing__re_build = NIL),
        build: (final context) => //
            base__list_ing__generat_ed(
          context: context,
          scroll__manager: scroll__manager,
          page__title: page__title,
          item__array__count: item__array__count,
          item__build: (final build__context, final item__id_) => //
              base__listing__item__select_able(
            key: listing__key,
            selected__ok: selection__accumulation.contains__ok(
              item__id_,
            ),
            body: listing__item__body__build(build__context, item__id_),
            selection__handle: (final _) async => select__ok(item__id_),
            de_selection__handle: (final _) async => de_select__ok(item__id_),
          ),
          floating: RepaintBoundary(
            child: base__widget__build__definitive(
              init_: (final state_) => //
                  (button__re_build = state_.re_build),
              de_init_: () => //
                  (button__re_build = NIL),
              build: (final _) => //
                  ((button__submit__show__ok || button__flush__show__ok)
                      ? base__stack__widget(
                          children: <base__widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8.px,
                                right: 8.px,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (button__flush__show__ok) //
                                    base__button__floating(
                                      scale: 1.25,
                                      border__radius: BorderRadius.horizontal(
                                        left: Radius.circular(12.px),
                                        right: (button__submit__show__ok //
                                            ? Radius.circular(4.px)
                                            : Radius.circular(12.px)),
                                      ),
                                      icon: base__icon__clear,
                                      string: "Clear",
                                      press__handle: flush__handle,
                                    ),
                                  if (button__submit__show__ok) //
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 4.px,
                                      ),
                                      child: base__button__floating(
                                        scale: 1.25,
                                        border__radius: BorderRadius.horizontal(
                                          left: Radius.circular(4.px),
                                          right: Radius.circular(12.px),
                                        ),
                                        selected__ok: OK,
                                        icon: submit__button__icon,
                                        string: submit__button__title,
                                        press__handle: () => //
                                            submit__handle(selection__accumulation.convert__array()),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: RepaintBoundary(
                                child: base__widget__build__definitive(
                                  init_: (final state__) => //
                                      (count__re_build = state__.re_build),
                                  de_init_: () => //
                                      (count__re_build = NIL),
                                  build: (final _) => //
                                      base__box__floating(
                                    border__radius: BorderRadius.all(Radius.circular(12.px)),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.px),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: 14.px,
                                          minHeight: 14.px,
                                        ),
                                        child: Center(
                                          child: box__text__widget(
                                            selection__accumulation.elements__count.toString(),
                                            font__size: 12.px,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : empty__widget),
            ),
          ),
        ),
      ),
    ),
  );
} */
