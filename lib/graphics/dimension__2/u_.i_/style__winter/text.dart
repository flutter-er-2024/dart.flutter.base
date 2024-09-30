part of "_.dart";

base__widget base__box__text__primary(
  final string s, {
  final Color? color,
}) =>
    box__text__widget(
      s,
      font__color: color,
      font__weight: FontWeight.w600,
    );

base__widget base__box__text__secondary(
  final string s, {
  final Color? color,
}) =>
    box__text__widget(
      s,
      font__color: (color ?? color__foreground__dim),
      font__size: 14.px,
    );

base__widget base__box__text__multi({
  required final base__widget top,
  required final base__widget bottom,
}) => //
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <base__widget>[
        top,
        SizedBox(
          height: 4.px,
        ),
        bottom,
      ],
    );

base__widget base__box__text__primary__secondary(
  final string primary__string,
  final string secondary__string, {
  final Color? primary__color,
  final Color? secondary__color,
}) => //
    base__box__text__multi(
      top: base__box__text__primary(
        primary__string,
        color: primary__color,
      ),
      bottom: base__box__text__secondary(
        secondary__string,
        color: secondary__color,
      ),
    );

base__widget base__box__text__primary__secondary__auto({
  required final string primary__string,
  final Color? primary__color,
  final string? secondary__string,
  final Color? secondary__color,
}) => //
    ((secondary__string == null)
        ? base__box__text__primary(
            primary__string,
            color: primary__color,
          )
        : base__box__text__primary__secondary(
            primary__string,
            secondary__string,
            primary__color: primary__color,
            secondary__color: secondary__color,
          ));

base__widget base__box__text__secondary__primary({
  required final string secondary__string,
  final Color? secondary__color,
  required final string primary__string,
  final Color? primary__color,
}) => //
    base__box__text__multi(
      top: base__box__text__secondary(
        secondary__string,
        color: secondary__color,
      ),
      bottom: base__box__text__primary(
        primary__string,
        color: primary__color,
      ),
    );
