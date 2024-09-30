part of "_.dart";

const //
    _icon__close = base__icon__close__round;

base__widget base__overlay__bottom__button__dismiss({
  required final base__widget__tree__node context,
  required final string title,
  final procedure__empty__format? dismiss__handle,
}) =>
    base__button__floating__basic(
      body: box__text__widget(
        title,
        font__size: 18.px,
        font__weight: FontWeight.w700,
        text__align: TextAlign.center,
      ),
      press__handle: (dismiss__handle ?? () => context.navigate__backward()),
    );

base__widget base__overlay__bottom__dismiss__swipe__indication() /*
pill at sheet's top */
{
  final //
      height = 8.px,
      width = (4 * height);

  return DecoratedBox(
    decoration: BoxDecoration(
      color: /*color__foreground__dim*/ base__color__transparent__dark /* FIX */,
      borderRadius: BorderRadius.all(Radius.circular(16.px)),
    ),
    child: SizedBox(
      width: width,
      height: height,
    ),
  );
}

base__widget base__overlay__bottom__base({
  final ui.ImageFilter? back_ground__filter,
  final fp? padding__top /*(.25 * (screen__size.height - screen__padding.top))*/,
  final Color? back_ground__color,
  final Radius? border__top__radius,
  required final base__widget child,
}) =>
    Align(
      alignment: Alignment.bottomCenter,
      child: BackdropFilter(
        filter: (back_ground__filter ?? image__filter__blur__default),
        child: Padding(
          padding: EdgeInsets.only(
            top: (padding__top ?? 0),
            left: page__padding__left,
            right: page__padding__right,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: (back_ground__color ?? color__background__base),
              border: Border.all(
                color: color__border,
              ),
              borderRadius: BorderRadius.vertical(
                top: (border__top__radius ?? Radius.circular(32.px)),
              ),
            ),
            child: SizedBox(
              width: page__width,
              child: child,
            ),
          ),
        ),
      ),
    );

base__widget base__overlay__bottom__menu(
  final base__widget__tree__node context, {
  final ui.ImageFilter? back_ground__filter,
  final fp? padding__top,
  final Color? back_ground__color,
  final Radius? border__top__radius,
  final bool dismiss__swipe__indication__ok = OK,
  final bool button__close__ok = OK,
  final bool vertical__expand__ok = NO,
  required final string title,
  final string? sub_title,
  required final base__widget? body /*
if `Column` ,`mainAxisSize` should be `MainAxisSize.min`
`base__overlay__bottom__button__dismiss` can also be used
if input:text is present ,prefer padding items ,through `SizedBox(height: screen__padding.bottom,)` */
  ,
}) =>
    base__overlay__bottom__base(
      back_ground__filter: back_ground__filter,
      padding__top: padding__top,
      back_ground__color: back_ground__color,
      border__top__radius: border__top__radius,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size__pixel__padding__vertical,
          ),
          base__stack__widget(
            alignment: Alignment.topCenter,
            children: [
              if (dismiss__swipe__indication__ok) //
                base__overlay__bottom__dismiss__swipe__indication(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size__pixel__padding__horizontal,
                ),
                child: base__navigation__top__bubble(
                  left: (
                    icon: base__icon__navigation__backward,
                    on_press: () => context.navigate__backward(),
                  ),
                  right: (button__close__ok //
                      ? (
                          icon: _icon__close,
                          on_press: () => context.navigate__backward(),
                        )
                      : NIL),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.px),
          if (vertical__expand__ok) //
            const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size__pixel__padding__horizontal,
              ),
              child: base__page__title__aligned__left__padding__least(
                primary__string: title,
                secondary__string: sub_title,
              ),
            ),
          ),
          SizedBox(
            height: size__pixel__padding__vertical__double,
          ),
          if (body != null) //
            body,
        ],
      ),
    );
