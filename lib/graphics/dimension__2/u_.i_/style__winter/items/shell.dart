part of "../_.dart";

base__widget base__list_ing__shell__title({
  final base__widget? leading,
  required final string primary__string,
  final string? secondary__string,
  final base__widget? trailing,
}) {
  final base__widget //
      primary__text = box__text__widget(
        primary__string,
        font__size: 20.px,
        font__weight: FontWeight.w700,
        font__family: font__families[font__family__interface__title],
      ),
      texts = ((secondary__string == null)
          ? primary__text
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <base__widget>[
                primary__text,
                box__text__widget(
                  secondary__string,
                  font__color: color__foreground__dim,
                  font__size: 16.px,
                  font__weight: FontWeight.w600,
                  font__family: font__families[font__family__interface__sub_title],
                ),
              ],
            )),
      child;

  if ((leading != null) || ((trailing != null))) {
    child = Row(
      children: <base__widget>[
        Padding(
          padding: EdgeInsets.only(
            left: size__pixel__padding__horizontal,
            right: ((leading == null) //
                ? 0
                : size__pixel__padding__horizontal),
          ),
          child: leading,
        ),
        Expanded(
          child: texts,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.px,
            right: ((trailing == null) //
                ? 0
                : 6.px),
          ),
          child: trailing,
        ),
      ],
    );
  } else {
    child = Padding(
      padding: EdgeInsets.only(
        left: size__pixel__padding__horizontal__double,
      ),
      child: texts,
    );
  }

  return Padding(
    padding: EdgeInsets.only(
      top: 2.px,
      bottom: 4.px,
    ),
    child: child,
  );
}

base__widget base__list_ing__shell({
  final BorderRadius? border__radius,
  required final array<base__widget> items,
}) =>
    base__box__base(
      border__radius: border__radius,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size__pixel__padding__horizontal,
          vertical: size__pixel__padding__vertical,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ),
    );
