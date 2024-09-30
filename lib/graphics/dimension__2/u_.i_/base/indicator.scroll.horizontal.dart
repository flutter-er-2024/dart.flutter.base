part of "_.dart";

/*
const array<Color> //
    _pictures__present__colors = <Color>[
      Color.fromARGB(191 /* ((0.75 * 256) -1) */, 0, 0, 0),
      Color.fromARGB(127, 0, 0, 0),
      Color.fromARGB(63, 0, 0, 0),
      Color.fromARGB(31, 0, 0, 0),
      Color.fromARGB(15, 0, 0, 0),
      Color.fromARGB(7, 0, 0, 0),
      base__color__transparent__dark,
    ],
    _pictures__present__colors__empty = <Color>[
      base__color__transparent__dark,
      base__color__transparent__dark,
    ];

base__widget base__indicator__scroll__horizontal({
  required final ScrollController controller,
  final fp? height /* required for list-view_s */,
  final fp? width /* required to decide the need, for the indicator(a persistent stacked widget) */,
  required final base__widget child /* should be, scrollable, horizontally */,
}) {
  var //
      colors__left = _pictures__present__colors__empty,
      colors__right = _pictures__present__colors,
      observer = empty__procedure__empty;

  final overlay = base__widget__build__definitive(
    init_: (final state) {
      void observer_() {
        final position = controller.position
            /*..pixels.convert__text__representation().print("pos")
                  ..minScrollExtent.convert__text__representation().print("min")
                  ..maxScrollExtent.convert__text__representation().print("max")*/
            ;

/* TASK:
  animate the following `setState`s */

        bool b__re_build = NO;

        if ((position.pixels == position.minScrollExtent) && //
            (colors__left == _pictures__present__colors)) {
          colors__left = _pictures__present__colors__empty;

          //print__info("atMin");

          b__re_build = OK;
        } else if ((position.pixels == position.maxScrollExtent) && //
            (colors__right == _pictures__present__colors)) {
          colors__right = _pictures__present__colors__empty;

          //print__info("atMax");

          b__re_build = OK;
        }

        if ((position.pixels > position.minScrollExtent) && //
            (colors__left != _pictures__present__colors)) {
          colors__left = _pictures__present__colors;

          if (!b__re_build) {
            b__re_build = OK;
          }
        }

        if ((position.pixels < position.maxScrollExtent) && //
            (colors__right != _pictures__present__colors)) {
          colors__right = _pictures__present__colors;

          if (!b__re_build) {
            b__re_build = OK;
          }
        }

        if (b__re_build) {
          state.re_build();
        }
      }

      controller.addListener(observer = observer_);
    },
    de_init_: () => //
        controller.removeListener(observer),
    build: (final state) => //
        Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <base__widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: colors__left,
            ),
          ),
          child: SizedBox(
            width: 64.px,
            height: height,
          ),
        ),
        const Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: colors__right,
            ),
          ),
          child: SizedBox(
            width: 64.px,
            height: height,
          ),
        ),
      ],
    ),
  );

  return ((width !=  null)
      ? LayoutBuilder(
          builder: (
            final context,
            final constraints,
          ) =>
              ((width > constraints.maxWidth)
                  ? base__stack__widget(
                      children: [
                        child,
                        overlay,
                      ],
                    )
                  : child),
        )
      : base__stack__widget(
          children: [
            child,
            overlay,
          ],
        ));
} */
