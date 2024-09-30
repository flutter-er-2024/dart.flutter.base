part of "_.dart";

/*
class Briefing extends Statelesswidget__kampa {
  const Briefing({
    final Key? key,
    required this.texts,
    this.title = "Now",
  }) : super(key: key);

  final List<String> texts;
  final String title;

  @override
  base__widget build(final BuildContext context) {
    final base__widget separator = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.px,
      ),
      child: Text(
        String.fromCharCode(bulletCharCode),
        style: TextStyle(
          color: color__foreground__dimmer,
          font__weight: FontWeight.w600,
        ),
      ),
    );

    final int widgetCount = ((texts.length * 2) - 1);

    final List<base__widget> children = List<base__widget>.filled(
      widgetCount,
      separator,
      growable: NO,
    );

    int widgetCounter = 0;

    final TextStyle briefingTextStyle = TextStyle(
      font__size: 18.px,
      font__weight: FontWeight.w600,
    );

    final EdgeInsets briefingTextPadding = EdgeInsets.all(4.px);

    while (OK) {
      children[widgetCounter++] = Padding(
        padding: briefingTextPadding,
        child: Text(
          texts[(widgetCounter ~/ 2)],
          style: briefingTextStyle,
        ),
      );

      if (widgetCounter < widgetCount) {
        children[widgetCounter++] = separator;
      } else {
        break;
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color__theme[color__background__light],
        borderRadius: BorderRadius.all(Radius.circular(12.px)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.px,
          vertical: 4.px,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <base__widget>[
            Padding(
              padding: EdgeInsets.only(
                right: 16.px,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color__theme[color__background__lighter],
                  borderRadius: BorderRadius.all(Radius.circular(8.px)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 4.px,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: color__foreground__default,
                    ),
                  ),
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}
*/
