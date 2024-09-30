part of "_.dart";

base__widget base__list_ing({
  required final base__widget__tree__node context,
  required final scroll__manager__kampa scroll__manager,
  final ScrollPhysics? scroll__physics,
  final bool scroll__direction__b__reverse = NO,
  required final array<base__widget__sliver> Function(
    fp padding__top,
    fp padding__left,
    fp padding__right,
    fp padding__bottom,
  ) slivers,
  final base__widget? floating,
  final AlignmentGeometry floating__alignment = Alignment.bottomCenter,
  final fp? floating__padding__bottom,
  final base__widget? navigation__top,
  final bool button__scroll__top__ok = NO,
}) {
  /*final base__widget scrollBar = CupertinoScrollbar(
    child: empty__widget,
    controller: scrollController,
    thickness: 4.px,
    thicknessWhileDragging: 8.px,
    radius: Radius.circular(2.px),
    radiusWhileDragging: Theming.radius4,
  );*/

  return base__stack__widget(
    alignment: AlignmentDirectional.topCenter,
    children: <base__widget>[
      SizedBox.expand(
        child: scrollable(
          axis__direction: (!scroll__direction__b__reverse //
              ? scroll__axis__direction__vertical
              : scroll__axis__direction__vertical__reverse),
          controller: scroll__manager.controller,
          physics: (scroll__physics ?? scroll__physics__natural__always),
          extent__cache: base__list_ing__extent__cache__vertical,
          slivers: slivers(
            screen__padding.top,
            page__padding__left,
            page__padding__right,
            (screen__padding.bottom +
                ((floating == null) //
                    ? size__pixel__padding__vertical__double
                    : (64.px /* FIX.long.hard-code */ + size__pixel__padding__vertical__double))),
          ),
        ),
      ),
      if (floating != null)
        Align(
          alignment: floating__alignment,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: (floating__padding__bottom ?? //
                  (size__pixel__padding__vertical__double + screen__padding.bottom)),
            ),
            child: floating,
          ),
        ),
      (navigation__top ??
          Padding(
            padding: navigation__top__bubble__padding__insets(),
            child: base__navigation__top__bubble(
              left: (context.navigate__backward__ok()
                  ? (
                      icon: base__icon__navigation__backward,
                      on_press: () => context.navigate__backward(),
                    )
                  : NIL),
              right: (button__scroll__top__ok //
                  ? (
                      icon: base__icon__navigation__top,
                      on_press: scroll__manager.scroll__to__min__if__possible,
                    )
                  : NIL),
            ),
          )),
      if (screen__padding__permanent != EdgeInsets.zero)
        ClipRect(
          child: BackdropFilter(
            filter: image__filter__blur__crucial,
            child: SizedBox(
              height: screen__padding.top,
              width: screen__size.width,
            ),
          ),
        ) /*
      TASK.long: add linear blur, blurring smoothly (blending), instead of a hard edge, 
        as given at: `https://github.com/flutter/flutter/issues/48212#issuecomment-592166594`
          (from `https://stackoverflow.com/a/62885475`)*/
      ,
    ],
  );
}

base__widget base__list_ing__generat_ed({
  required final base__widget__tree__node context,
  required final scroll__manager__kampa scroll__manager,
  final ScrollPhysics? scroll__physics,
  required final base__widget page__title,
  final base__widget? page__briefing /*
could be used for providing options, tab-bar, or content navigation
prefer padding, `EdgeInsets.only(top: size__pixel__padding__vertical, left: page__padding__left, right: page__padding__right, bottom: 12.px)` */
  ,
  final fp padding__horizontal__additional = 0,
  required final int item__array__count,
  final uu? item__array__lanes__count /* if non-NIL ,`item__array__separator__size` is ignored */,
  required final base__listing__item__build__function__format /* 2nd param. is `item__id` */ item__build,
  final fp? item__array__separator__size,
  final base__widget? floating,
  final AlignmentGeometry floating__alignment = Alignment.bottomCenter,
  final fp? floating__padding__bottom,
  final base__widget? navigation__top,
  final bool button__scroll__top__ok = NO,
}) {
  final base__widget__sliver sliver;
  if (item__array__lanes__count == null) {
    final item__array__separator = SizedBox(
      height: (item__array__separator__size ?? size__pixel__padding__vertical),
    );

    sliver = SliverList(
      delegate: SliverChildBuilderDelegate(
        (
          final context,
          var item__id_,
        ) =>
            ((item__id_.isEven) //
                ? IndexedSemantics(
                    index: (item__id_ ~/= 2),
                    child: RepaintBoundary(
                      child: item__build(
                        context,
                        item__id_,
                      ),
                    ),
                  )
                : item__array__separator),
        childCount: ((item__array__count * 2) - 1),
        addAutomaticKeepAlives: NO,
        addRepaintBoundaries: NO,
        addSemanticIndexes: NO,
      ),
    );
  } else {
    sliver = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: item__array__lanes__count,
      ),
      delegate: SliverChildBuilderDelegate(
        (
          final context,
          final item__id_,
        ) =>
            IndexedSemantics(
          index: item__id_,
          child: RepaintBoundary(
            child: item__build(
              context,
              item__id_,
            ),
          ),
        ),
        childCount: item__array__count,
        addAutomaticKeepAlives: NO,
        addRepaintBoundaries: NO,
        addSemanticIndexes: NO,
      ),
    );
  }

  return base__list_ing(
    context: context,
    scroll__manager: scroll__manager,
    scroll__physics: scroll__physics,
    slivers: (
      final padding__top,
      final padding__left,
      final padding__right,
      final padding__bottom,
    ) =>
        <base__widget__sliver>[
      SliverList(
        delegate: SliverChildListDelegate(
          <base__widget>[
            SizedBox(height: padding__top),
            page__title,
            ((page__briefing == null) //
                ? base__widget__separat_or__vertical
                : page__briefing),
          ],
          addAutomaticKeepAlives: NO,
          addRepaintBoundaries: NO,
          addSemanticIndexes: NO,
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(
            left: (padding__horizontal__additional + padding__left),
            right: (padding__horizontal__additional + padding__right),
            bottom: (button__scroll__top__ok.not //
                ? padding__bottom
                : 0)),
        sliver: sliver,
      ),
      if (button__scroll__top__ok) //
        SliverList(
          delegate: SliverChildListDelegate(
            <base__widget>[
              SizedBox(height: size__pixel__padding__vertical__double),
              Center(
                child: base__button(
                  icon: base__icon__navigation__top,
                  string: (/*"Scroll"*/ "Back" " to Top"),
                  press__handle: scroll__manager.scroll__to__min__if__possible,
                ),
              ),
              SizedBox(height: padding__bottom),
            ],
            addAutomaticKeepAlives: NO,
            addRepaintBoundaries: NO,
            addSemanticIndexes: NO,
          ),
        ),
    ],
    floating: floating,
    navigation__top: navigation__top,
    floating__alignment: floating__alignment,
    floating__padding__bottom: floating__padding__bottom,
    button__scroll__top__ok: button__scroll__top__ok,
  );
}
