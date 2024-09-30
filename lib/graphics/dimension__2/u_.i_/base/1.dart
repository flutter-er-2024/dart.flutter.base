part of "_.dart";

const //
    empty__widget = SizedBox.shrink();

base__widget base__gesture__press__handling__widget(
  final procedure__empty__format press__handle,
  final base__widget child, [
  final HitTestBehavior? behavior,
]) /*
separate ,because of usual requirements ,compared to the other gestures */
{
  return GestureDetector(
    onTap: press__handle,
    behavior: behavior,
    child: child,
  );
}

base__widget base__box__widget__max({
  final bool width__ok = OK,
  final bool height__ok = OK,
  final base__widget? child,
}) =>
    SizedBox(
      width: (width__ok //
          ? fp.maxFinite
          : NIL),
      height: (height__ok //
          ? fp.maxFinite
          : NIL),
      child: child,
    );

base__widget base__box__widget__square({
  required final fp dimension,
  final base__widget? child,
}) =>
    SizedBox.square(
      dimension: dimension,
      child: child,
    );

base__widget base__box__widget({
  final fp? width,
  final fp? height,
  final base__widget? child,
}) =>
    SizedBox(
      width: width,
      height: height,
      child: child,
    );

Stack base__stack__widget({
  final Key? key,
  final AlignmentGeometry alignment = AlignmentDirectional.topStart,
  final TextDirection textDirection = TextDirection.ltr,
  final StackFit fit = StackFit.loose,
  final Clip clipBehavior = Clip.hardEdge,
  required final array<base__widget> children,
}) =>
    Stack(
      key: key,
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      clipBehavior: clipBehavior,
      children: children,
    );

base__widget base__widget__rotate__wise___clock(
  final uu rotation,
  final base__widget child,
) {
  return RotatedBox(
    quarterTurns: rotation,
    child: child,
  );
}

base__widget base__widget__rotate__wise___clock__reverse(
  final uu rotation,
  final base__widget child,
) {
  return RotatedBox(
    quarterTurns: (4 - rotation),
    child: child,
  );
}
