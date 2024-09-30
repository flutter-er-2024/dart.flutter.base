part of "_.dart";

base__widget base__button__structure({
  final fp scale = 1,
  final IconData? icon,
  final bool icon__trailing__ok = NO,
  required final string string,
}) {
  final //
      b__icon__available = (icon != null),
      padding__vertical = (8 * scale).px;

  var child = box__text__widget(
    string,
    font__size: (16 * scale).px,
    font__weight: FontWeight.w600,
    text__align: TextAlign.center,
  );

  if (b__icon__available) //
    child = Row(
      mainAxisSize: MainAxisSize.min,
      children: (!icon__trailing__ok
          ? <base__widget>[
              base__icon(
                icon,
              ),
              SizedBox(
                width: (6 * scale).px,
              ),
              child,
            ]
          : <base__widget>[
              child,
              SizedBox(
                width: (6 * scale).px,
              ),
              base__icon(
                icon,
              ),
            ]),
    );

  return Padding(
    padding: EdgeInsets.only(
      top: padding__vertical,
      left: (((b__icon__available && !icon__trailing__ok) //
                  ? 12
                  : 16) *
              scale)
          .px,
      right: (((b__icon__available && icon__trailing__ok) //
                  ? 12
                  : 16) *
              scale)
          .px,
      bottom: padding__vertical,
    ),
    child: child,
  );
}

typedef base__button__kampa = base__widget Function({
  Key? key,
  fp scale,
  BorderRadius? border__radius,
  bool selected__ok,
  IconData? icon,
  bool iconAtEnding,
  required string string,
  fp? font__size,
  procedure__empty__format? press__handle,
  procedure__empty__format? press__long__handle,
});

base__widget base__button({
  final Key? key,
  final fp scale = 1,
  final BorderRadius? border__radius,
  final bool selected__ok = NO,
  final IconData? icon,
  final bool iconAtEnding = NO,
  required final string string,
  final procedure__empty__format? press__handle,
  final procedure__empty__format? press__long__handle,
}) =>
    base__box__button(
      key: key,
      border__radius: (border__radius ?? BorderRadius.all(Radius.circular(12.px) * scale)),
      b__highlight: selected__ok,
      child: base__button__structure(
        scale: scale,
        icon: icon,
        icon__trailing__ok: iconAtEnding,
        string: string,
      ),
      onSinglePress: press__handle,
      onLongPress: press__long__handle,
    );

base__widget base__button__floating({
  final Key? key,
  final fp scale = 1,
  final BorderRadius? border__radius,
  final bool selected__ok = NO,
  final IconData? icon,
  final bool iconAtEnding = NO,
  required final string string,
  final procedure__empty__format? press__handle,
  final procedure__empty__format? press__long__handle,
}) =>
    base__box__button__floating(
      key: key,
      border__radius: (border__radius ?? //
          BorderRadius.all(
            (Radius.circular(12.px) * scale),
          )),
      b__highlight: selected__ok,
      child: base__button__structure(
        scale: scale,
        icon: icon,
        icon__trailing__ok: iconAtEnding,
        string: string,
      ),
      onSinglePress: press__handle,
      onLongPress: press__long__handle,
    );

base__widget base__button__floating__basic({
  required final base__widget body,
  final procedure__empty__format? press__handle,
  final procedure__empty__format? press__long__handle,
}) =>
    base__box__button__floating(
      border__radius: BorderRadius.all(
        Radius.circular(32.px),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.px,
          vertical: 8.px,
        ),
        child: body,
      ),
      onSinglePress: press__handle,
      onLongPress: press__long__handle,
    );

base__widget base__button__selectable({
  final Key? key,
  final fp scale = 1,
  final BorderRadius? border__radius,
  final IconData? icon,
  final bool iconAtEnding = NO,
  required final string string,
  final bool selected__ok = NO,
  required final base__selectable__switch__handle__function__format selection__handle,
  required final base__selectable__switch__handle__function__format de_selection__handle,
}) =>
    base__select_able(
      key: key,
      selected__ok: selected__ok,
      child__un_selected__build: () => //
          base__button(
        scale: scale,
        border__radius: border__radius,
        selected__ok: NO,
        icon: icon,
        iconAtEnding: iconAtEnding,
        string: string,
      ),
      child__selected__build: () => //
          base__button(
        scale: scale,
        border__radius: border__radius,
        selected__ok: OK,
        icon: icon,
        iconAtEnding: iconAtEnding,
        string: string,
      ),
      selection__handle: selection__handle,
      de_selection__handle: de_selection__handle,
    );
