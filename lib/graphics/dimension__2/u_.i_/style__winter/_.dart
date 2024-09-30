import "dart:ui" as ui;

import "package:base/base/_.dart";
import "package:base/graphics/dimension__2/u_.i_/base/_.dart";
import "package:base/graphics/dimension__2/u_.i_/flutter/_.dart";

import "package:base/graphics/dimension__2/u_.i_/google.material/_.dart" //
    show
        TextField,
        TextCapitalization,
        InputBorder,
        InputDecoration,
        OutlineInputBorder;

import "package:base/graphics/dimension__2/u_.i_/apple.cupertino/_.dart" //
    show
        CupertinoActivityIndicator;

part "items/list.dart";
part "items/expandable.dart";
part "items/selectable.dart";
part "items/shell.dart";
part "items/input.text.dart";

part "overlays/bottom.dart";
part "overlays/input.text.keyboard.dart";
part "overlays/bottom.input.text.dart";

part "pages/file.dart";
part "pages/input.choice.dart";
part "pages/data-base.dart";
part "pages/indicators.dart";
part "pages/info.runtime.dart";
part "pages/input.form.dart";
part "pages/info.data-base.dart";
part "pages/input.selection.dart";
part "pages/directory.dart";

part "text.dart";
part "badge.dart";
part "overlays/1.dart";
part "input.counter.dart";
part "button.dart";
part "listing.dart";
part "navigation.top.bubble.dart";
part "page.title.dart";
part "1.dart";
part "page.dart";
part "font.dart";
part "briefing.dart";
part "overlay.bottom.dart";
part "navigation.bottom.my-bmw.dart";

/*
TASK
  - add `button(decoration(gradient(linear(color(255,59,255,149) ,color(255,9,134,61)))))` */

u16 //
    preference__page__background__dark = 0,
    preference__page__background__light = 0;

u16 get preference__page__background => //
    (base__app__theme__colors__ground___back__dark__ok //
        ? preference__page__background__dark
        : preference__page__background__light);

late Color //
    color__foreground__full,
    color__foreground__almost,
    color__foreground__default,
    color__foreground__dim,
    color__foreground__dimmer,
    color__foreground__dimmest /*
  history:
    `List<Color> color__theme = const <Color>[];` was used, single the first theming centralization effort,
      along with `const int`s, such that, that first `color__random__count`(32), values were random colors,
        then red, blue, green, then `color__foreground__`* colors, then `color__background__light`* colors,
      the array was not assigned individually, but single shot assignment to the array,
        like `color__theme = (interface__bDark ? _color__theme__dark : _color__theme__light)`
      this approach was discontinued, beginning from April 3, 2023,
        due to the overhead of array access,
          also because the overhead is for every access, and not the first access,
          and compiler can even optimize the variable access,
            by directly placing the address of the variable's memory location,
              instead of the address of array's first element, and a dynamic calculation
*/
    ,
//
    color__background__base,
    color__background__base__focus_ed,
    color__background__base__select_ed,
//
    color__background__nested,
    color__background__nested__focus_ed,
    color__background__nested__select_ed,
//
    color__border,
    color__border__focus_ed,
    color__border__select_ed,
//
    color__shadow,
    color__shadow__focus_ed,
    color__shadow__select_ed,
//
    color__hyperlink,
//
    color__red,
    color__green,
    color__blue;

final color__random__list = array<Color>.filled(
  colors__random.length,
  base__color__transparent__dark,
  growable: NO,
);

void app__page__background__change() {
  final u16 bg;

  if (base__app__theme__colors__ground___back__dark__ok) {
    preference__page__background__dark = //
        (((bg = (preference__page__background__dark += 1)) < //
                colors__background__page__gradient_contrasts__dark.length) //
            ? bg
            : 0);
  } else {
    preference__page__background__light = //
        (((bg = (preference__page__background__light += 1)) < //
                colors__background__page__gradient_contrasts__light.length) //
            ? bg
            : 0);
  }

  base__app__page__background__set();
  base__app__re_build();
}

late LinearGradient //
    _gradient__linear,
    _gradient__linear__selected;

const u8 _theme__winter__color__interval = 4;

const base__theme__winter = (
  color__set: box__winter__color__set,
  page__background__set: box__winter__page__background__set,
  box__collection: (
    base: base__box__winter__base,
    base__simple: base__box__winter__base__simple,
    non_button: base__box__winter__non_button,
    button: base__box__winter__button,
    floating: base__box__winter__floating,
    button__floating: base__box__winter__button__floating,
  ),
);

Color _color__dark__relative(
  final int intensity, [
  final int interval = _theme__winter__color__interval,
]) /*
  example
    interval 4, intensity 0: Color.fromARGB(3,0,0,0)
    interval 4, intensity 63(max, for `interval`): Color.fromARGB(255,0,0,0) */
    =>
    color__generate(
      intensity: intensity,
      b__dark_mode: OK,
      b__solid: NO,
      interval: interval,
    );

Color _color__light__relative(
  final int intensity, [
  final int interval = _theme__winter__color__interval,
]) /*
  example
    interval 4, intensity 0: Color.fromARGB(255,0,0,0)
    interval 4, intensity 63(max, for `interval`): Color.fromARGB(3,0,0,0) */
    =>
    color__generate(
      intensity: intensity,
      b__dark_mode: NO,
      b__solid: NO,
      interval: interval,
    );

void box__winter__page__background__set() {
  page__background__decoration = (base__app__theme__colors__ground___back__dark__ok
      ? BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors__background__page__gradient_contrasts__dark[preference__page__background__dark],
          ),
        )
      : BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors__background__page__gradient_contrasts__light[preference__page__background__light],
          ),
        ));
}

void box__winter__color__set() {
  const u8 intensity = ((u8__limit ~/ _theme__winter__color__interval) - 1);

  final Color color__background__base__intermediate;

  if (base__app__theme__colors__ground___back__dark__ok) {
    color__foreground__full = _color__light__relative(0);
    color__foreground__almost = _color__light__relative(15);
    color__foreground__default = _color__light__relative(31);
    color__foreground__dim = _color__light__relative(39);
    color__foreground__dimmer = _color__light__relative(47);
    color__foreground__dimmest = _color__light__relative(55);

    color__shadow = //
        color__border = //
            color__background__nested = //
                color__background__base = _color__light__relative(intensity - 1);

    color__shadow__focus_ed = //
        color__border__focus_ed = //
            color__background__nested__focus_ed = _color__light__relative(intensity - 3);

    color__shadow__select_ed = //
        color__border__select_ed = //
            color__background__nested__select_ed = //
                color__background__base__focus_ed = //
                    color__background__base__intermediate = _color__light__relative(intensity - 5);

    color__background__base__select_ed = _color__light__relative(intensity - 7);

    color__hyperlink = colors__hyperlink.dark;

    color__red = colors__rgb.red.dark;
    color__green = colors__rgb.green.dark;
    color__blue = colors__rgb.blue.dark;

    base__iterate__reverse__basic(
      colors__random.elements__count,
      (final i) {
        color__random__list[i] = colors__random[i].dark;
      },
    );
  } else {
    color__foreground__full = _color__dark__relative(intensity);
    color__foreground__almost = _color__dark__relative(intensity - 8);
    color__foreground__default = _color__dark__relative(intensity - 24);
    color__foreground__dim = _color__dark__relative(intensity - 32);
    color__foreground__dimmer = _color__dark__relative(intensity - 40);
    color__foreground__dimmest = _color__dark__relative(intensity - 48);

    color__shadow__focus_ed = //
        color__background__nested = _color__light__relative(intensity - 8);

    color__shadow__select_ed = //
        color__background__nested__focus_ed = //
            color__background__base = _color__light__relative(intensity - 12);
    color__background__base__focus_ed = //
        color__background__nested__select_ed = //
            color__background__base__intermediate = _color__light__relative(intensity - 24);
    color__background__base__select_ed = _color__light__relative(intensity - 36);

    color__shadow = //
        color__border = _color__light__relative(intensity);
    color__border__focus_ed = _color__light__relative(intensity - 2);
    color__border__select_ed = _color__light__relative(intensity - 4);

    color__hyperlink = colors__hyperlink.light;

    color__red = colors__rgb.red.light;
    color__green = colors__rgb.green.light;
    color__blue = colors__rgb.blue.light;

    base__iterate__reverse__basic(
      colors__random.elements__count,
      (final i) {
        color__random__list[i] = colors__random[i].light;
      },
    );
  }

  /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: base__color__transparent__dark,
    statusBarIconBrightness: (interface__bDark //
        ? Brightness.light
        : Brightness.dark),
    systemNavigationBarColor: base__color__transparent__dark,
  ));*/

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: base__color__transparent__dark,
    systemNavigationBarDividerColor: base__color__transparent__dark,
    systemNavigationBarIconBrightness: (base__app__theme__colors__ground___back__dark__ok //
        ? Brightness.light
        : Brightness.dark),
    systemNavigationBarContrastEnforced: NO,
    statusBarColor: base__color__transparent__dark,
    statusBarIconBrightness: (base__app__theme__colors__ground___back__dark__ok //
        ? Brightness.light
        : Brightness.dark),
    systemStatusBarContrastEnforced: NO,
  ));

  _gradient__linear = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      color__background__base__intermediate,
      color__background__base,
    ],
  );

  _gradient__linear__selected = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      color__background__base__select_ed,
      color__background__base__intermediate,
    ],
  );
}

base__widget base__box__winter__base({
  final Key? key,
  final BorderRadius? border__radius,
  final bool b__highlight = NO,
  required final base__widget child,
}) /* frosted */ =>
    DecoratedBox(
      key: key,
      decoration: BoxDecoration(
        border: Border.all(
          color: color__border,
        ),
        borderRadius: (border__radius ?? BorderRadius.all(radius__full())),
        gradient: (b__highlight //
            ? _gradient__linear__selected
            : _gradient__linear),
      ),
      child: child,
    );

base__widget base__box__winter__base__simple({
  final Key? key,
  final BorderRadius? border__radius,
  final bool b__highlight = NO,
  required final base__widget child,
}) =>
    DecoratedBox(
      key: key,
      decoration: BoxDecoration(
        color: (b__highlight //
            ? color__background__base__select_ed
            : color__background__base),
        border: Border.all(
          color: color__border,
        ),
        borderRadius: (border__radius ?? BorderRadius.all(radius__full())),
      ),
      child: child,
    );

base__widget _box__shadowed({
  final Key? key,
  final BorderRadius? border__radius,
  final bool b__highlight = NO,
  required final base__widget child,
}) =>
    DecoratedBox(
      key: key,
      decoration: BoxDecoration(
        borderRadius: (border__radius ?? BorderRadius.all(radius__full(1))),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (b__highlight //
                ? color__shadow__select_ed
                : color__shadow),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 4,
          ),
        ],
      ),
      child: child,
    );

base__widget base__box__winter__non_button({
  final Key? key,
  final bool b__highlight = NO,
  final BorderRadius? border__radius,
  required final base__widget child,
}) /* colored */ =>
    DecoratedBox(
      key: key,
      decoration: (b__highlight //
          ? BoxDecoration(
              color: color__background__nested__select_ed,
              border: Border.all(
                color: color__border__select_ed,
              ),
              borderRadius: (border__radius ?? BorderRadius.all(radius__full(1))),
            )
          : BoxDecoration(
              color: color__background__nested,
              border: Border.all(
                color: color__border,
              ),
              borderRadius: (border__radius ?? BorderRadius.all(radius__full(1))),
            )),
      child: child,
    );

base__widget base__box__winter__button({
  final Key? key,
  final bool b__highlight = NO,
  BorderRadius? border__radius,
  required final base__widget child,
  final VoidCallback? onSinglePress,
  final VoidCallback? onLongPress,
}) /* colored, shadowed */ =>
    _box__shadowed(
      key: key,
      b__highlight: b__highlight,
      border__radius: (border__radius ??= BorderRadius.all(radius__full(1))),
      child: GestureDetector(
        child: base__box__winter__non_button(
          b__highlight: b__highlight,
          border__radius: border__radius,
          child: child,
        ),
        onTap: onSinglePress,
        onLongPress: onLongPress,
      ),
    );

base__widget base__box__winter__floating({
  final Key? key,
  BorderRadius? border__radius,
  final ui.ImageFilter? blur,
  required final base__widget child,
}) /* blurred */ =>
    ClipRRect(
      key: key,
      borderRadius: (border__radius ??= BorderRadius.all(radius__full(1))),
      child: BackdropFilter(
        filter: (blur ?? image__filter__blur__default),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color__background__base,
            border: Border.all(
              color: color__border,
            ),
            borderRadius: border__radius,
          ),
          child: child,
        ),
      ),
    );

base__widget base__box__winter__button__floating({
  final Key? key,
  BorderRadius? border__radius,
  final bool b__highlight = NO,
  final ui.ImageFilter? blur,
  required final base__widget child,
  final VoidCallback? onSinglePress,
  final VoidCallback? onLongPress,
}) /* blurred, shadowed */ =>
    _box__shadowed(
      key: key,
      border__radius: (border__radius ??= BorderRadius.all(radius__full(1))),
      b__highlight: b__highlight,
      child: GestureDetector(
        child: base__box__winter__floating(
          border__radius: border__radius,
          blur: blur,
          child: child,
        ),
        onTap: onSinglePress,
        onLongPress: onLongPress,
      ),
    );
