part of "_.dart";

base__widget _component__page__title({
  required final fp padding__top,
  required final fp padding__horizontal,
  required final fp padding__bottom,
  required final string primary__string,
  required final fp primary__size,
  required final TextAlign primary__alignment,
  final string? secondary__string,
  required final fp secondary__size,
  required final TextAlign secondary__alignment,
  required final CrossAxisAlignment crossAxisAlignment,
}) {
  final title = box__text__widget(
    primary__string,
    font__size: primary__size,
    font__weight: FontWeight.w700,
    font__family: font__families[font__family__interface__title],
    text__align: primary__alignment,
  );

  return Padding(
    padding: EdgeInsets.only(
      top: padding__top,
      left: (padding__horizontal + screen__padding__permanent.left),
      right: (padding__horizontal + screen__padding__permanent.right),
      bottom: padding__bottom,
    ),
    child: ((secondary__string == null) //
        ? title
        : Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: <base__widget>[
              title,
              box__text__widget(
                secondary__string,
                font__color: color__foreground__dim,
                font__size: secondary__size,
                font__weight: FontWeight.w600,
                font__family: font__families[font__family__interface__sub_title],
                text__align: secondary__alignment,
              ),
            ],
          )),
  );
}

base__widget base__page__title__aligned__left__padding__least({
  final fp padding__top = 0,
  required final string primary__string,
  final string? secondary__string,
}) =>
    _component__page__title(
      padding__top: (size__pixel__padding__vertical + padding__top),
      padding__horizontal: size__pixel__padding__horizontal__double,
      padding__bottom: size__pixel__padding__vertical,
      primary__string: primary__string,
      primary__size: 28.px,
      primary__alignment: TextAlign.start,
      secondary__string: secondary__string,
      secondary__size: 20.px,
      secondary__alignment: TextAlign.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );

base__widget base__page__title__aligned__left({
  required final string primary__string,
  final string? secondary__string,
}) =>
    base__page__title__aligned__left__padding__least(
      padding__top: (navigation__top__bubble__button__size__estimated + navigation__top__bubble__padding).px,
      primary__string: primary__string,
      secondary__string: secondary__string,
    );

base__widget base__page__title__aligned__center({
  required final string primary__string,
  final string? secondary__string,
}) {
  final //
      b__secondary__string = (secondary__string != null),
      padding = navigation__top__bubble__padding.px;

  return _component__page__title(
    padding__top: (b__secondary__string //
        ? padding
        : (padding * 1.33)),
    padding__horizontal: (padding + //
        navigation__top__bubble__button__size__estimated.px),
    padding__bottom: (b__secondary__string //
        ? size__pixel__padding__vertical
        : padding),
    primary__string: primary__string,
    primary__size: (b__secondary__string //
        ? 18.px
        : 20.px),
    primary__alignment: TextAlign.center,
    secondary__string: secondary__string,
    secondary__size: 16.px,
    secondary__alignment: TextAlign.center,
    crossAxisAlignment: CrossAxisAlignment.center,
  );
}
