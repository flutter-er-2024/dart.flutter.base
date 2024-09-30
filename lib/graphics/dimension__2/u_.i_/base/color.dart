part of "_.dart";

const //
    base__color__transparent__light = Color(0x00FFFFFF),
    base__color__transparent__dark = /*Color(0x00000000)*/ flutter__colors.transparent,
    base__color__white = Color(0xFFFFFFFF),
    base__color__black = Color(0xFF000000);

const //
    image__filter__blur__sensitive__extra /* as foreground of a random picture */ = 64,
    image__filter__blur__sensitive /* sensitive to the background, expected as foreground of a picture */ = 32,
    image__filter__blur__crucial /* for top-navigation, and status-bar's background */ = 16,
    image__filter__blur__default = 8,
    image__filter__blur__clear /* for quite sexy look */ = 4,
    image__filter__blur__min /* for sexy-est look */ = 1;

ui.ImageFilter base__image__filter__blur(
  final fp value,
) =>
    ui.ImageFilter.blur(
      sigmaX: value,
      sigmaY: value,
    );

Color color__generate({
  required final u8 intensity /*
  throw (lines relative to the offset, of function's body):
    1 */
  ,
  required final bool b__dark_mode /* 3..255 vs 255..3, both inclusive, for `OK`(dark), and `NO`(light) respectively */,
  required final bool b__solid /* or `b__semi_transparent`(with alpha) */,
  required final u8 interval,
}) {
  if ((intensity < (256 ~/ interval)).not) {
    throw "`intensity` MUST be in-range 0...${((256 ~/ interval) - 1)}, inclusive, when `interval` is $interval";
  }

  final ({u8 primary, u8 secondary}) value = (b__dark_mode
      ? (
          primary: (((intensity + 1) * interval) - 1),
          secondary: 0,
        )
      : (
          primary: ((u8__limit - (intensity * interval)) - 1),
          secondary: u8__max,
        ));

  return (b__solid //
      ? Color.fromARGB(value.secondary, value.primary, value.primary, value.primary)
      : Color.fromARGB(value.primary, value.secondary, value.secondary, value.secondary));
}

Color color__value__convert__Color(
  final uu color__value,
) {
  return Color(0xFF000000 | color__value);
}

uu Color__convert__color__value(
  final Color color,
) {
  return (color.value & 0xFFFFFF);
}

Color color__whiten(
  final Color color,
  final u8 intensity,
) {
  final u8 //
      red = (color.red + intensity),
      green = (color.green + intensity),
      blue = (color.blue + intensity);

  return Color.fromARGB(
    color.alpha,
    ((red < u8__limit) ? red : u8__max),
    ((green < u8__limit) ? green : u8__max),
    ((blue < u8__limit) ? blue : u8__max),
  );
}

extension Color$whiten on Color {
  Color whiten(final u8 intensity) => //
      color__whiten(this, intensity);
}

late final _random = math.Random.secure();

u8 get _color__random => //
    _random.nextInt(u8__limit);

/** copied from `https://stackoverflow.com/a/43235` */
Color color__random(
  final Color color,
) =>
    Color.fromARGB(
      u8__max,
      ((_color__random + color.red) ~/ 2),
      ((_color__random + color.green) ~/ 2),
      ((_color__random + color.blue) ~/ 2),
    );

/*
forked
  from `flutter/lib/src/material/theme_data.dart`::`ThemeData`::`static Brightness estimateBrightnessForColor(Color color)`
  on 2023-5-29
  original is copied below, the function */
Color color__contrasted(
  final Color color,
) {
  final fp relativeLuminance = color.computeLuminance();

  return (((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > 0.0525 /* kThreshold */) //
      ? base__color__white
      : base__color__black);
}
/*
  /// Determines whether the given [Color] is [Brightness.light] or
  /// [Brightness.dark].
  ///
  /// This compares the luminosity of the given color to a threshold value that
  /// matches the Material Design specification.
  static Brightness estimateBrightnessForColor(Color color) {
    final fp relativeLuminance = color.computeLuminance();

    // See <https://www.w3.org/TR/WCAG20/#contrast-ratiodef>
    // The spec says to use kThreshold=0.0525, but Material Design appears to bias
    // more towards using light text than WCAG20 recommends. Material Design spec
    // doesn't say what value to use, but 0.15 seemed close to what the Material
    // Design spec shows for its color palette on
    // <https://material.io/go/design-theming#color-color-palette>.
    const fp kThreshold = 0.15;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold) {
      return Brightness.light;
    }
    return Brightness.dark;
  }
*/

Color color__sensitive(
  final Color color,
) =>
    color__contrasted(color);

Color color__high_contrast(
  final Color color,
) =>
    color__contrasted(color);
