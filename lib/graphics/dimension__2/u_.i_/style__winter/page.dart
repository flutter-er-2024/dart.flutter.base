part of "_.dart";

late BoxDecoration page__background__decoration;

base__widget page__foundation(
  final base__widget page,
) =>
    DecoratedBox(
      decoration: page__background__decoration,
      child: Center(
        child: SizedBox(
          width: page__width,
          height: screen__size.height,
          child: page,
        ),
      ),
    );

base__widget page__padded(
  final base__widget child,
) =>
    Padding(
      padding: EdgeInsets.only(
        top: screen__padding.top,
        left: page__padding__left,
        right: page__padding__right,
        bottom: screen__padding.bottom,
      ),
      child: child,
    );
