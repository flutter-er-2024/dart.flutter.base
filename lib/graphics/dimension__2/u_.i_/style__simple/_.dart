import "package:base/base/_.dart";
import "package:base/graphics/dimension__2/u_.i_/_.dart";
import "package:base/graphics/dimension__2/u_.i_/external.flutter/_.dart";

const u8 _color__interval = 4;

Color _color__dark__solid(
  final int intensity, [
  final int interval = _color__interval,
]) =>
    color__generate(
      intensity: intensity,
      b__dark_mode: OK,
      b__solid: OK,
      interval: interval,
    );

Color _color__light__solid(
  final int intensity, [
  final int interval = _color__interval,
]) =>
    color__generate(
      intensity: intensity,
      b__dark_mode: NO,
      b__solid: OK,
      interval: interval,
    );

base__widget base__box__outlined /* ONLY good for solid-color backgrounds, and not gradient, or picture */ ({
  final Key? key,
  final BorderRadius? borderRadius,
  final LinearGradient? gradient,
  required final base__widget child,
}) =>
    DecoratedBox(
      key: key,
      decoration: BoxDecoration(
        border: Border.all(
          color: color__foreground__dim,
        ),
        borderRadius: (borderRadius ?? BorderRadius.all(radius__full())),
      ),
      child: child,
    );
