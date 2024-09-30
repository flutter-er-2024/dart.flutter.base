part of "../_.dart";

const //
    base__overlay__width__factor__default__phone = (3 * (1 / 4)),
    base__overlay__height__factor__default__phone = (1 / 3),
//
    base__overlay__width__factor__default__tablet = (1 / 3),
    base__overlay__height__factor__default__tablet = (2 * base__overlay__width__factor__default__tablet);

base__widget base__overlay__base({
  required final fp width__factor,
  required final fp height__factor,
  required final base__widget child,
}) {
  return Center(
    child: SizedBox(
      width: (width__factor * screen__size.width),
      height: (height__factor * screen__size.height),
      child: child,
    ),
  );
}

base__widget base__overlay__notice__basic({
  final IconData? icon = flutter__icons.info_outlined,
  required final string title,
  final string? body,
  final Color background__color = const Color(0xFFDDDDDD),
}) {
  final //
      separat_ion = SizedBox(height: 4.px),
      body__ok = (body != null);

  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 32.px,
      vertical: 64.px,
    ),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: background__color,
        borderRadius: BorderRadius.all(
          Radius.circular(24.px),
        ),
      ),
      child: SizedBox(
        width: fp.maxFinite,
        child: Padding(
          padding: EdgeInsets.all(16.px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              separat_ion,
              if (icon != null) //
                ...[
                base__icon(
                  icon,
                  size: 64.px,
                  color: color__foreground__dim,
                ),
                SizedBox(height: 12.px),
              ],
              box__text__widget(
                title,
                font__size: 16.px,
                font__weight: (body__ok //
                    ? FontWeight.w600
                    : FontWeight.w400),
              ),
              if (body__ok) //
                ...[
                SizedBox(height: 8.px),
                box__text__widget(
                  body,
                  font__size: 16.px,
                  font__color: color__foreground__dim,
                ),
              ],
              separat_ion,
            ],
          ),
        ),
      ),
    ),
  );
}

base__widget base__overlay__issue({
  final string title = "Issue found",
  required final string issue,
}) {
  return base__overlay__notice__basic(
    icon: flutter__icons. /*report_outlined*/ warning_amber_outlined,
    title: title,
    body: issue,
  );
}
