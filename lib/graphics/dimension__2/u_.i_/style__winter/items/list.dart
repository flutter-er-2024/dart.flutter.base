part of "../_.dart";

BorderRadius base__listing__item__position__top__border__radius([
  final bool b__nested = NO,
]) =>
    (!b__nested //
        ? BorderRadius.vertical(
            top: radius__full(),
            bottom: radius__half(),
          )
        : BorderRadius.vertical(
            top: radius__full(1),
            bottom: radius__half(1),
          ));

BorderRadius base__listing__item__position__middle__border__radius([
  final bool b__nested = NO,
]) =>
    (!b__nested //
        ? BorderRadius.all(
            radius__half(),
          )
        : BorderRadius.all(
            radius__half(1),
          ));

BorderRadius base__listing__item__position__bottom__border__radius([
  final bool b__nested = NO,
]) =>
    (!b__nested //
        ? BorderRadius.vertical(
            top: radius__half(),
            bottom: radius__full(),
          )
        : BorderRadius.vertical(
            top: radius__half(1),
            bottom: radius__full(1),
          ));

BorderRadius base__listing__item__border__radius(
  final uu item__id_,
  final uu item__array__count, [
  final bool b__nested = NO,
]) =>
    ((item__id_ == (item__array__count - 1)) /* last item */ //
        ? base__listing__item__position__bottom__border__radius(b__nested)
        : ((item__id_ != 0) /* NOT first item */ //
            ? base__listing__item__position__middle__border__radius(b__nested)
            : base__listing__item__position__top__border__radius(b__nested)));

base__widget base__listing__item__structure({
  final fp? padding__vertical,
  final bool b_expand = OK,
  final fp? padding__leading,
  final base__widget? leading,
  required final base__widget body,
  final base__widget? trailing,
  final fp? padding__trailing,
}) {
  final SizedBox sizedBox = SizedBox(
    width: 8.px,
  );

  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: (padding__vertical ?? size__pixel__padding__vertical__double),
    ),
    child: Row(
      mainAxisAlignment: (b_expand //
          ? MainAxisAlignment.start
          : MainAxisAlignment.center),
      mainAxisSize: (b_expand //
          ? MainAxisSize.max
          : MainAxisSize.min),
      children: <base__widget>[
        SizedBox(
          width: (padding__leading ?? size__pixel__padding__horizontal__double),
        ),
        (leading == null)
            ? sizedBox
            : Padding(
                padding: EdgeInsets.only(
                  right: size__pixel__padding__horizontal,
                ),
                child: leading,
              ),
        Flexible(
          fit: (b_expand //
              ? FlexFit.tight
              : FlexFit.loose),
          child: body,
        ),
        (trailing == null)
            ? sizedBox
            : Padding(
                padding: EdgeInsets.only(
                  left: 2.px,
                ),
                child: trailing,
              ),
        SizedBox(
          width: (padding__trailing ?? size__pixel__padding__horizontal),
        ),
      ],
    ),
  );
}

const //
    listing__item__position__middle = 0,
    listing__item__position__top = 1,
    listing__item__position__bottom = 2;

base__widget base__listing__item({
  final Key? key,
  /*required final u8 position,*/
  final BorderRadius? border__radius,
  final bool selected__ok = NO,
  final bool b__expand = OK,
  final fp? padding__vertical,
  final fp? padding__leading,
  final base__widget? leading,
  required final base__widget body,
  final base__widget? trailing,
  final fp? padding__trailing,
}) =>
    base__box__base(
      key: key,
      border__radius: border__radius,
      b__highlight: selected__ok,
      child: base__listing__item__structure(
        padding__vertical: padding__vertical,
        b_expand: b__expand,
        padding__leading: padding__leading,
        leading: leading,
        body: body,
        trailing: trailing,
        padding__trailing: padding__trailing,
      ),
    );

base__widget base__listing__item__info__summary({
  final Key? key,
  final BorderRadius? border__radius,
  required final base__widget body,
  required final procedure__empty__format press__handle,
}) =>
    GestureDetector(
      key: key,
      onTap: press__handle,
      child: base__box__base(
        border__radius: border__radius,
        b__highlight: NO,
        child: base__listing__item__structure(
          padding__vertical: size__pixel__padding__vertical,
          padding__leading: size__pixel__padding__horizontal,
          leading: base__icon(
            base__icon__info,
          ),
          body: body,
          trailing: base__icon(
            base__icon__press_able,
          ),
          padding__trailing: size__pixel__padding__horizontal,
        ),
      ),
    );

base__widget base__listing__item__info({
  required final base__widget body,
}) =>
    base__listing__item__structure(
      padding__vertical: size__pixel__padding__vertical,
      padding__leading: size__pixel__padding__horizontal,
      leading: base__icon(
        base__icon__info,
      ),
      body: body,
      padding__trailing: size__pixel__padding__horizontal,
    );
