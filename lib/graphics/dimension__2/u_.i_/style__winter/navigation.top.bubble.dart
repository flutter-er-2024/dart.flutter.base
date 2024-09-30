part of "_.dart";

typedef IconButtonData = ({
  IconData icon,
  VoidCallback on_press,
});

const //
    navigation__top__bubble__padding = 24.0,
    navigation__top__bubble__button__icon__size = 24.0,
    navigation__top__bubble__button__padding = 12.0,
    navigation__top__bubble__button__size__estimated = //
        (navigation__top__bubble__button__icon__size + //
            (2 * navigation__top__bubble__button__padding));

EdgeInsets //
    navigation__top__bubble__padding__insets() {
  return EdgeInsets.only(
    top: (navigation__top__bubble__padding.px + screen__padding.top),
    left: (navigation__top__bubble__padding.px + screen__padding__permanent.left),
    right: (navigation__top__bubble__padding.px + screen__padding__permanent.right),
  );
}

base__widget base__navigation__top__bubble({
  final IconButtonData? left,
  final IconButtonData? right,
}) {
  final //
      border__radius = BorderRadius.all(Radius.circular(32.px)),
      image__filter = image__filter__blur__crucial,
      button__padding = EdgeInsets.all(navigation__top__bubble__button__padding.px),
      icon__size = navigation__top__bubble__button__icon__size.px;

  base__widget button(final IconButtonData button) => //
      base__box__button__floating(
        border__radius: border__radius,
        blur: image__filter,
        child: Padding(
          padding: button__padding,
          child: base__icon(
            button.icon,
            size: icon__size,
          ),
        ),
        onSinglePress: button.on_press,
      );

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <base__widget>[
      ((left != null) //
          ? button(left)
          : empty__widget),
      Spacer(),
      ((right != null) //
          ? button(right)
          : empty__widget),
    ],
  );
}
