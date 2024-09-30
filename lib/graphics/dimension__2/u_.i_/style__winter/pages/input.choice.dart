part of "../_.dart";

const //
    icon__chosen = flutter__icons.radio_button_checked;

/* base__widget pages__input__choice__page({
  required final scroll__manager__kampa scroll__manager,
  required final string page__title,
  required final uu item__array__count,
  uu? chosen__id_ /* choice__initial */,
  required final base__listing__item__build__function__format listing__item__body__build,
  final IconData? submit__button__icon = base__icon__done,
  final string submit__button__title = "Submit",
  required final void Function(uu chosen__id_) submit__handle,
}) {
  Key listing__key = base__widget__key__unique();

  procedure__empty__format listing__re_build = empty__procedure__empty;

  bool choice__update(final uu? choice) {
    chosen__id_ = choice;

    listing__key = base__widget__key__unique();
    listing__re_build();

    return OK;
  }

  return page__foundation(
    RepaintBoundary(
      child: base__widget__build__definitive(
        init_: (final state) => //
            (listing__re_build = state.re_build),
        de_init_: () => //
            (listing__re_build = empty__procedure__empty),
        build: (final context) => //
            base__list_ing__generat_ed(
          context: context,
          scroll__manager: scroll__manager,
          page__title: base__page__title__aligned__left(
            primary__string: page__title,
            secondary__string: "Choose any one option",
          ),
          item__array__count: item__array__count,
          item__build: (final build__context, final item__id_) => //
              base__listing__item__select_able(
            key: listing__key,
            selected__ok: (chosen__id_ == item__id_),
            body: listing__item__body__build(
              build__context,
              item__id_,
            ),
            selected__icon: icon__chosen,
            selection__handle: (final _) async => choice__update(item__id_),
            de_selection__handle: (final _) async => choice__update(null),
          ),
          floating: ((chosen__id_ != null)
              ? base__button__floating(
                  scale: 1.25,
                  border__radius: BorderRadius.all(Radius.circular(28.px)),
                  icon: submit__button__icon,
                  string: submit__button__title,
                  press__handle: () => submit__handle(chosen__id_!),
                )
              : NIL),
        ),
      ),
    ),
  );
} */

base__widget pages__input__choice__page__simple({
  required final base__widget__tree__node context,
  required final scroll__manager__kampa scroll__manager,
  required final base__widget page__title,
  required final uu item__array__count,
  required final base__listing__item__build__function__format listing__item__body__build,
  required final void Function(uu chosen__id_) submit__handle,
}) =>
    page__foundation(
      base__list_ing__generat_ed(
        context: context,
        scroll__manager: scroll__manager,
        page__title: page__title,
        item__array__count: item__array__count,
        item__build: (final build__context, final item__id_) => //
            GestureDetector(
          onTap: () => submit__handle(item__id_),
          child: base__listing__item(
            body: listing__item__body__build(
              build__context,
              item__id_,
            ),
            trailing: base__icon(
              base__icon__press_able,
            ),
          ),
        ),
      ),
    );
