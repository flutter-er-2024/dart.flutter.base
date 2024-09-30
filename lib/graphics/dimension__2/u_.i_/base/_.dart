import "package:base/base/_.dart";
import "package:base/service.authority/_.dart";

import "package:base/graphics/dimension__2/u_.i_/flutter/_.dart";
import "package:base/graphics/dimension__2/u_.i_/apple.cupertino/_.dart" //
    show
        DefaultCupertinoLocalizations;
import "package:base/graphics/dimension__2/u_.i_/google.material/_.dart" //
    show
        DefaultMaterialLocalizations,
        DialogRoute,
        MaterialApp,
        MaterialPageRoute,
        ModalBottomSheetRoute,
        Typography;

import "dart:math" as math;
import "dart:ui" as ui;

import "package:flutter/foundation.dart" //
    show
        kReleaseMode,
        kProfileMode,
        kIsWeb,
        defaultTargetPlatform,
        TargetPlatform;

import "package:flutter/services.dart" //
    show
        RawKeyDownEvent,
        RawKeyUpEvent,
        PhysicalKeyboardKey,
        LogicalKeyboardKey,
        Clipboard,
//
        SystemChannels,
        MethodChannel,
        MethodCall,
        SystemNavigator,
        rootBundle,
//
        DeviceOrientation,
        Brightness,
        SystemChrome,
        SystemUiOverlayStyle,
        SystemUiMode,
//
        TextInputFormatter,
        FilteringTextInputFormatter,
        LengthLimitingTextInputFormatter,
        TextInputAction,
        MaxLengthEnforcement,
//
        debugPrintKeyboardEvents,
        ApplicationSwitcherDescription;

import "package:flutter/widgets.dart";

import "package:flutter/gestures.dart" //
    show
        GestureRecognizer,
        TapGestureRecognizer,
//
        GestureVelocityTrackerBuilder,
        IOSScrollViewFlingVelocityTracker,
//
        DragStartBehavior,
//
        debugPrintMouseHoverEvents,
        debugPrintHitTestResults;

import "package:flutter/rendering.dart" //
    show
        RendererBinding,
        RenderView,
        ViewConfiguration,
//
        debugPaintSizeEnabled,
        debugPaintPointersEnabled,
        debugRepaintRainbowEnabled,
        debugRepaintTextRainbowEnabled,
        debugPaintLayerBordersEnabled,
        debugDisableClipLayers;

import "package:path_provider/path_provider.dart" as path_provider;

part "1.dart";
part "app.dart";
part "asyn_.dart";
part "build.dart";
part "button.dart";
part "color.dart";
part "colors.dart";
part "event.dart";
part "focus.dart";
part "icon.dart";
part "indicator.scroll.horizontal.dart";
part "inet.dart";
part "list.create.dart";
part "listing.dart";
part "navigation.bottom.dart";
part "navigation.dart";
part "overlay.persistent.dart";
part "picture.dart";
part "platform.dart";
part "scroll-bar.dart";
part "scroll.dart";
part "selection.dart";
part "service.authority.dart";
part "size.dart";
part "storage.dart";
part "text.dart";
part "text.rich.dart";
part "theme.dart";

const //
    base__program__compile__mode = //
    (kReleaseMode //
        ? base__program__compile__modes.release
        : (kProfileMode //
            ? base__program__compile__modes.profile
            : base__program__compile__modes.debug));

final base__program__compile__platform /* should be avoided ,as much as possible */ = //
    (kIsWeb //
        ? base__program__compile__platforms.web
        : switch (defaultTargetPlatform) {
            TargetPlatform.fuchsia => base__program__compile__platforms.fuchsia,
            TargetPlatform.linux => base__program__compile__platforms.linux,
            TargetPlatform.android => base__program__compile__platforms.android,
            TargetPlatform.windows => base__program__compile__platforms.windows,
            TargetPlatform.iOS => base__program__compile__platforms.apple__hand_held,
            TargetPlatform.macOS => base__program__compile__platforms.apple__desktop,
          });

enum base__program__compile__modes {
  release,
  profile,
  debug,
}

enum base__program__compile__platforms {
  fuchsia,
  linux,
  web,
  android,
  windows,
  apple__hand_held /*phone|tablet*/,
  apple__desktop,
}

const
//
    base__locale__latin__english__america = Locale("en", "US"),
    base__app__locale = base__locale__latin__english__america,
//
    base__app__localizations__delegates = <LocalizationsDelegate<Object>>[
      DefaultWidgetsLocalizations.delegate,
      DefaultMaterialLocalizations.delegate,
      DefaultCupertinoLocalizations.delegate,
    ];

typedef base__widget = Widget;

typedef base__widget__tree__node = BuildContext;

/*late base__widget__tree__node _app__context;*/

typedef base__widget__attach___proc___format = //
    void Function(
  base__widget__tree__node context,
);

typedef base__widget__detach___proc___format = //
    base__widget__attach___proc___format;

typedef base__widget__attach__definitive___proc___format<depository__type> = //
    depository__type Function(
  base__widget__tree__node context,
);

typedef base__widget__detach__definitive___proc___format<depository__type> = //
    void Function(
  base__widget__tree__node context,
  depository__type depository,
);

typedef base__widget__build__function__format = //
    base__widget Function(
  base__widget__tree__node context,
);

typedef base__navigation__overlay__build__function__format //
    <depository__type extends base__depository__base> //
    = base__widget__build__with__depository__function__format<depository__type>;

typedef base__navigation__page__build__function__format //
    <depository__type extends base__depository__base> //
    = base__widget__build__with__depository__function__format<depository__type>;

typedef base__widget__build__with__depository__function__format //
    <depository__type extends base__depository__base> //
    = base__widget Function(
  base__widget__tree__node context,
  depository__type depository,
);

void base__app__re_build()
/*{ base__widget__tree__node__re_build__recursive(_app__context); }*/
{
  final //
      binding = WidgetsBinding.instance,
      element__root = binding.rootElement;

  if (element__root != null) //
    binding.buildOwner?.reassemble(element__root);
} /*
forked
  from `flutter/src/widgets/binding.dart`::`mixin WidgetsBinding`::`asyn___value<void> _forceRebuild()` */

Key base__widget__key__unique() /*
needed to prevent the flutter-framework ,from re-using the old widget ,from the tree
  similar to in-validating the cache
should be avoided ,in favor of a reliable (consistently reproducible) value (like `ValueKey("$category:$item")`) ,to not waste resources ,on un-necessary build calls ,and improve efficiency */
    => //
/*/* must not be `const` */ ValueKey(Object())*/ UniqueKey();

asyn___value<string?> //
    base__environment__clipboard__string() async {
  return ((await Clipboard.hasStrings()) //
      ? (await Clipboard.getData(
          Clipboard.kTextPlain,
        ))
          ?.text
      : NIL);
}

asyn___value<void> //
    base__environment__clipboard__set__string({
  required final string text,
}) {
  return Clipboard.setData(
    ClipboardData(
      text: text,
    ),
  );
}

void base__app__focus__primary__remove() /*
de-focus ,ir-respective of the widget */
{
  FocusManager.instance.primaryFocus?.unfocus();
}

void base__environment__set__phone() {
  base__print__handle = debugPrint;
}

asyn___value<void> //
    base__orientation__set__portrait() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void base__widget__tree__rendering__frame__current__post__register(
  final void Function(
    Duration time,
  ) frame__current__post__handle,
) {
  WidgetsBinding.instance.addPostFrameCallback(
    frame__current__post__handle,
  );
}

void base__widget__tree__node__re_build(
  final base__widget__tree__node context,
) {
  context.re_build();
}

void base__widget__tree__node__re_build__raw /*
should not be called ,from non-asyn. proc.s */
    (
  final base__widget__tree__node context,
) {
  context.re_build__raw();
}

extension base__widget__tree__node__extension //
    on base__widget__tree__node {
  void re_build__recursive() {
    (this as Element).visitChildren(
      _element__re_build,
    );
  }

  void re_build() {
    if (valid__ok()) {
      re_build__raw();
    }
  }

  void re_build__raw() {
    (this as Element).markNeedsBuild();
  }

  bool valid__ok() {
    return mounted;
  }
}

void _element__re_build(
  final Element element,
) {
  element.re_build();
}

extension on Element {
  void re_build() {
    markNeedsBuild();
    visitChildren(
      _element__re_build,
    );
  }
}

class base__widget__re_build__event__channel__broadcast //
    extends base__event__channel__broadcast<base__widget__tree__node> {
  base__widget__re_build__event__channel__broadcast([
    final string? debug__name,
  ]) : super(
          base__widget__tree__node__re_build,
          NIL,
          debug__name,
        );
}

class base__value__alter__widget__re_build__event__channel__broadcast<value__type> //
    extends base__value__alter__event__channel__broadcast<value__type, base__widget__tree__node> {
  base__value__alter__widget__re_build__event__channel__broadcast(
    final value__type value__raw, [
    final string? debug__name,
  ]) : super(
          value__raw,
          base__widget__tree__node__re_build,
          NIL,
          debug__name,
        );
}
