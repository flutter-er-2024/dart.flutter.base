part of "../_.dart";

const IconData //
    icon__status__selected__outlined = flutter__icons.check_circle_outline,
    icon__status__selected__filled = flutter__icons.check_circle,
    icon__status__selected = icon__status__selected__filled,
    icon__status__un_selected = flutter__icons.radio_button_unchecked_outlined,
    icon__status__de_selected = icon__status__un_selected;

base__widget base__listing__item__select_able({
  final Key? key,
  final BorderRadius? border__radius,
  required final base__widget body,
  final bool selected__ok = NO,
  final IconData selected__icon /* select-ion indicator */ = icon__status__selected,
  required final base__selectable__switch__handle__function__format selection__handle,
  required final base__selectable__switch__handle__function__format de_selection__handle,
}) =>
    base__select_able(
      key: key,
      selected__ok: selected__ok,
      child__un_selected__build: () => //
          base__listing__item(
        border__radius: border__radius,
        selected__ok: NO,
        leading: Padding(
          padding: EdgeInsets.all(2.px),
          child: Center(
            child: base__icon(
              icon__status__un_selected,
              size: 16.px,
              color: color__foreground__dimmer,
            ),
          ),
        ),
        body: body,
        trailing: NIL,
      ),
      child__selected__build: () => //
          base__listing__item(
        border__radius: border__radius,
        selected__ok: OK,
        leading: base__icon(
          selected__icon,
        ),
        body: body,
        trailing: NIL,
      ),
      selection__handle: selection__handle,
      de_selection__handle: de_selection__handle,
    );
