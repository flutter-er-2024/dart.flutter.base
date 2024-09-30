part of "_.dart";

base__widget base__icon(
  final IconData icon, {
  required final fp size,
  required final Color color,
}) /*
fork of `flutter/widgets/icon.dart`::`Icon` */
{
  return base__box__widget__square(
    dimension: size,
    child: Center(
      child: base__icon__basic(
        icon,
        size: size,
        color: color,
      ),
    ),
  );
}

base__widget base__icon__basic(
  final IconData icon, {
  required final fp size,
  required final Color color,
}) {
  return base__box__text__widget(
    TextSpan(
      text: string.fromCharCode(
        icon.codePoint,
      ),
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
      ),
    ) /*
is not `component__text__segment`, because of `style.package` arg. */
    ,
    /*text__align: TextAlign.center,*/ /* replaced, with surrounding `SizedBox` */
    text__overflow: TextOverflow.visible,
  );
}
