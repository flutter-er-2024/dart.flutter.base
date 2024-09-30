part of "_.dart";

late final array<string> base__app__title__segments;

string base__app__title() => //
    base__app__title__segments.join();

bool base__environment__theme__colors__ground___back__dark__ok() {
  return (ui.PlatformDispatcher.instance.platformBrightness == Brightness.dark);
}

final base__app__life_cycle__state__channel = base__value__alter__widget__re_build__event__channel__broadcast(
  AppLifecycleState.detached,
);

bool _PlatformDispatcher__onError(
  final Object error,
  final StackTrace trace,
) {
  base__error__handle(
    error,
    trace,
  );

  return OK;
}

void _FlutterError__onError(
  final FlutterErrorDetails details,
) {
  base__error__handle(
    details.exception,
    (details.stack ?? StackTrace.current),
  );
}

void base__app__run //
    <depository__type extends base__depository__base>({
  required final depository__type Function(
    asyn___value<void> init___status /*
indicates the fully init.ion ,of the meta-framework ,and the flutter-framework */
    ,
  ) init_,
  required final base__widget__build__with__depository__function__format<depository__type> build,
})
/*
abstracts `runApp`
inspired by `flutter/lib/src/material/app.dart`::`MaterialApp` */
{
  {
    ui.PlatformDispatcher.instance.onError = _PlatformDispatcher__onError;

    FlutterError.onError = _FlutterError__onError;
  }

  WidgetsFlutterBinding.ensureInitialized();

  final init___status__promise = asyn___promise<void>();
  {
    var count__raw = 2;
    void success__handle() {
      count__raw -= 1;
      if (count__raw == 0) {
        init___status__promise.complete();
      }
    }

    void failure__handle(
      final Object e,
      final StackTrace t,
    ) {
      init___status__promise.completeError(e, t);
    }

    base__platform__init_().handle__basic(
      success__handle,
      failure__handle,
    );

    base__storage__init_().handle__basic(
      success__handle,
      failure__handle,
    );

    /*SystemChannels.lifecycle.setMessageHandler((final message) async {
      final AppLifecycleState state;

      switch (message) {
        case "AppLifecycleState.resumed":
          state = AppLifecycleState.resumed;
        case "AppLifecycleState.inactive":
          state = AppLifecycleState.inactive;
        case "AppLifecycleState.hidden":
          state = AppLifecycleState.hidden;
        case "AppLifecycleState.paused":
          state = AppLifecycleState.paused;
        case "AppLifecycleState.detached":
          state = AppLifecycleState.detached;

        default:
          throw "un-known `AppLifecycleState`, $message";
      }

      if (debug__report_ing__ok) {
        state.name.convert__text__representation().print("app__state__life_cycle");
      }

      if (state != app__state__life_cycle) {
        app__state__life_cycle__broadcast.message__announce(
          (app__state__life_cycle = state),
        );
      }
    }); /*
  forked
    from `flutter/src/services/binding.dart`::`mixin ServicesBinding`
      ::`asyn___value<String?> _handleLifecycleMessage(String?)`
      ::`void initInstances()` */*/

    /*SystemChannels.keyEvent.setMessageHandler((final message) async {
      final key__raw = RawKeyEvent.fromMessage(message as Map<string, Object?>);

      if (debug__report_ing__ok) {
        report__Object(key__raw, "app__key.key__raw");

        reporting__indent();

        report__string__null_able(key__raw.character, "..character");
        report__Object__null_able(key__raw.character?.codeUnits, "..character.codeUnits");
        report__bool((key__raw is RawKeyDownEvent), "..isRawKeyDownEvent");
        report__bool((key__raw is RawKeyUpEvent), "..isRawKeyUpEvent");

        final data = key__raw.data;

        report__string(data.keyLabel, "..keyLabel");

        report__bool(data.isShiftPressed, "..isShiftPressed");
        report__bool(data.isControlPressed, "..isControlPressed");
        report__bool(data.isAltPressed, "..isAltPressed");
        report__bool(data.isMetaPressed, "..isMetaPressed");

        /*report__bool((data.physicalKey == PhysicalKeyboardKey.keyA), "..physicalKey.isA");
              report__bool((data.logicalKey == LogicalKeyboardKey.keyA), ".logicalKey.isA");*/

        reporting__de_indent();
      }

      if /* un-likely */ ((key__raw is RawKeyDownEvent) && //
          (key__raw.data.logicalKey == LogicalKeyboardKey.goBack)) //
        navigate__back(
          app__navigation__manager,
        );
      else //
        app__key__broadcast.message__announce(
          key__raw,
        );

      return <string, bool>{"handled" /*b__handled*/ : OK};
    }); /*
  forked
    from `flutter/src/services/binding.dart`::`mixin ServicesBinding`
      ::`void _initKeyboard()`
      ::`void initInstances()` */*/

    /*SystemChannels.navigation.setMethodCallHandler((final call) async {
      if (debug__report_ing__ok) //
        base__function__call__print__arguments__void(
          "SystemChannels.navigation",
        );

      switch (call.method) {
        case "popRoute":
          navigate__back(
            app__navigation__manager,
          );

          return;
        case "pushRoute":
          final //
              route = (call.arguments as string),
              route__info = RouteInformation(
                uri: Uri.parse(route),
              );

          reporting__indent();
          if (debug__report_ing__verbose__ok) {
            report__string(route, "route");
            report__Object(route__info, "route__info");
          }
          reporting__de_indent();

          return;
        case "pushRouteInformation":
          final //
              route__args = (call.arguments as Map<Object, Object?>),
              route__info = RouteInformation(
                uri: Uri.parse(route__args["location"] as string),
                state: route__args["state"],
              );

          reporting__indent();
          if (debug__report_ing__verbose__ok) {
            report__Object(route__args, "route__args");
            report__Object(route__info, "route__info");
          }
          reporting__de_indent();

          return;

        default:
          throw "un-known call, $call";
      }
    }); /*
  forked
    from `flutter/src/widgets/binding.dart`::`mixin WidgetsBinding`
      ::`asyn___value<dynamic> _handleNavigationInvocation(MethodCall)`
      ::`void initInstances()` */*/

    /*PlatformDispatcher.instance
      ..onMetricsChanged = () {
        if (debug__report_ing__ok) //
          base__function__call__print__arguments__void(
            "PlatformDispatcher.onMetricsChanged",
          );

        {
          final //
              binding = RendererBinding.instance,
              views = binding.renderViews;

          bool force_frame = NO;

          for (final RenderView view in views) {
            force_frame = (force_frame || (view.child != null));

            final //
                view_ = view.flutterView,
                devicePixelRatio = view_.devicePixelRatio;

            view.configuration = ViewConfiguration(
              constraints: (view_.physicalConstraints / devicePixelRatio),
              devicePixelRatio: devicePixelRatio,
            );
          }

          if (force_frame) //
            binding.scheduleForcedFrame();
        } /*
  forked
    from `flutter/src/rendering/binding.dart`::`mixin RendererBinding`
      ::`ViewConfiguration createViewConfigurationFor(RenderView)`
      ::`void handleMetricsChanged()`
      ::`void initInstances()` */

        reporting__indent();
        if (debug__report_ing__verbose__ok) //
          ui.PlatformDispatcher.instance.views.forEach((final view) {
            report__Object(view, "view");

            reporting__indent();
            report__Object(view.physicalSize, "..physicalSize");
            report__fp(view.devicePixelRatio, "..devicePixelRatio");
            reporting__de_indent();
          });
        reporting__de_indent();

        app__size__set();

        app__re_build();
      }
      ..onPlatformBrightnessChanged = () {
        if (debug__report_ing__ok) //
          base__function__call__print__arguments__void(
            "PlatformDispatcher.onPlatformBrightnessChanged",
          );

        reporting__indent();
        if (debug__report_ing__verbose__ok) //
          report__Object(
            ui.PlatformDispatcher.instance.platformBrightness,
            "PlatformDispatcher.platformBrightness",
          );
        reporting__de_indent();

        app__color__set();
        app__color__broadcast.message__announce(null);
        app__re_build();
      };*/
  }

  final depository = init_(
    init___status__promise.future,
  );

  base__app__size__set(
    view: NIL,
  ); /*
called at last ,to allow ,the slow environments (like android) ,some extra time, for proper init. */

  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Localizations(
        locale: base__app__locale,
        delegates: base__app__localizations__delegates,
        child: base__app__base__widget(
          overlay__persistent__channel: base__app__overlay__persistent__channel,
          build: (final context) {
            return build(
              context,
              depository,
            );
          },
        ),
      ),
    ),
  );
}

void base__app__run__simple /*
config. :
  `environment__phone__ok`
  `behavior__correct__ok`

tasks:long:
  - add app-splash, as black seems bad */ //
    <depository__type extends base__widget__depository__base>({
  required final array<string> app__title__segments /*
example :`["Demo", char:space, "app"]` */
  ,
  required final base__widget__build__function__format splash__build /*
must not depend on the meta-framework */
  ,
  required final service__authority__base service__authority,
  required final asyn___value<depository__type> Function()
      depository /*
`debug`* global properties ,like `debugPaintSizeEnabled` ,`debugPaintPointersEnabled` ,`debugRepaintRainbowEnabled` ,`debugRepaintTextRainbowEnabled` ,`debugPaintLayerBordersEnabled` ,`debugDisableClipLayers` ,`debugPrintRebuildDirtyWidgets` ,`debugPrintMouseHoverEvents` ,`debugPrintHitTestResults` ,`debugPrintKeyboardEvents` ,can be set inside
`theme__colors__set` proc. should be called in the proc.
wrap every page/overlay ,to handle `base__app__theme__change__broadcast__channel`
  ,and preferably the child with `ValueKey(app__theme__id_)`(or simply `ValueKey(base__app__theme__colors__ground___back__dark__ok)` if merely a day/night theme is needed) as `key` (to not re-use ,the tree's existing widgets)
    ,because the framework's `base__app__re_build` is not definitive
  ,because handling above(in tree-node's position or hierarchy) `MaterialApp` ,would re-set the whole app (including navigation[-stack] ,and current page/overlay)
    ,while handling below(as its child) ,would be overridden with page/overlay navigation
`storage` is available at this point
to return non-future value ,prefer using `asyn___value.value` */
  ,
}) {
  service__authority.handle() /*
should not be `await`-ed ,to allow functioning ,normally ,for non-denial cases */
      ;

  base__app__title__segments = app__title__segments;

  base__app__theme__colors__ground___back__follow__system__ok = OK;

  base__app__overlay__persistent__channel = base__value__alter__widget__re_build__event__channel__broadcast<base__widget__build__function__format?>(
    NIL,
  );

  base__app__run(
    init_: (final init___status) {
      final depository__promise = asyn___promise<depository__type>();

      void failure__handle(
        final Object e,
        final StackTrace t,
      ) {
        depository__promise.completeError(e, t);
      }

      init___status.handle__basic(
        () {
          base__app__theme__colors__ground___back__dark__ok = base__environment__theme__colors__ground___back__dark__ok();

          depository().handle(
            (final depository) {
              depository__promise.complete(
                depository,
              );
            },
            failure__handle,
          );
        },
        failure__handle,
      );

      return base__asyn___value__handling__depository<depository__type>(
        depository__promise.future,
      );
    },
    build: (final context, final depository) {
      return base__asyn___value__handling__widget(
        context,
        depository,
        success__indicate: (final context, final depository) {
          return MaterialApp(
            showPerformanceOverlay: NO,
            /*checkerboardRasterCacheImages: OK,
            checkerboardOffscreenLayers: OK,*/
            home: base__widget__build__basic(
              build: depository.widget,
            ),
            title: base__app__title(),
            color: const Color.fromARGB(u8__max, 191, 191, 191),
            locale: base__app__locale,
            localizationsDelegates: base__app__localizations__delegates,
            supportedLocales: const <Locale>[base__app__locale],
            scrollBehavior: app__scroll__behavior,
            themeAnimationStyle: AnimationStyle.noAnimation,
          );
        },
        activity__indicate: splash__build,
        failure__indicate: base__failure__indicate__widget,
      );
    },
  );
}

late bool
    base__app__theme__colors__ground___back__follow__system__ok; /*
disabl-ing `app:size:follow:system` would be non-sense ,because the whole sub-system depends on it ,for dynamic siz-ing 
  ,static siz-ing is the default ,hence can be imitated ,simply ,by avoid-ing `fp.px` */

base__value__alter__widget__re_build__event__channel__broadcast<base__widget__build__function__format?>? base__app__overlay__persistent__channel;

class base__app__base__widget extends StatefulWidget {
  const base__app__base__widget({
    super.key,
    required this.overlay__persistent__channel,
    required this.build,
  });

  final base__value__alter__widget__re_build__event__channel__broadcast<base__widget__build__function__format?>? overlay__persistent__channel /* not `dispose`-ed */;
  final base__widget__build__function__format build;

  @override
  _app__base__widget__state createState() {
    return _app__base__widget__state();
  }
}

class _app__base__widget__state //
    extends State<base__app__base__widget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(
      this,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(
      this,
    );

    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (debug__report_ing__verbose__ok) {
      base__printing__indentation__increase();
      for (final view in ui.PlatformDispatcher.instance.views) {
        view.convert__text__representation().print("view");

        base__printing__indentation__increase();
        view.physicalSize.convert__text__representation().print("..physicalSize");
        view.devicePixelRatio.convert__text__representation().print("..devicePixelRatio");
        base__printing__indentation__decrease();
      }
      base__printing__indentation__decrease();
    }

    if (base__app__size__set(
      view: NIL,
    )) {
      if (debug__report_ing__verbose__ok) {
        "app:size:set:re_fresh:ok".print();
      }

      context.re_build();
    }
  }

  @override
  void didChangePlatformBrightness() {
    if (debug__report_ing__verbose__ok) {
      "app:colors:change".print();
    }

    if (base__app__theme__colors__ground___back__follow__system__ok.not) {
      return;
    }

    base__app__theme__colors__ground___back__dark__ok = base__environment__theme__colors__ground___back__dark__ok();

    base__app__theme__change__broadcast__channel.event__announce();

    if (debug__report_ing__ok) {
      "app:colors:set:re_fresh:ok".print();
    }

    context.re_build();
  }

  @override
  void didChangeAppLifecycleState(
    final AppLifecycleState state,
  ) {
    if (debug__report_ing__verbose__ok) {
      state.convert__text__representation().print("app:life_cycle:state:new");
    }

    base__app__life_cycle__state__channel.value__alter__and__announce__safe(state);

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(
    final base__widget__tree__node context,
  ) {
    final //
        overlay__channel = widget.overlay__persistent__channel,
        child = widget.build(
          context,
        );

    if (overlay__channel == null) {
      return child;
    }

    return base__stack__widget(
      clipBehavior: Clip.none,
      children: [
        child,
        base__event__channel__broadcast__handling__widget(
          channel: overlay__channel,
          build: (final context) {
            final overlay = overlay__channel.value();

            if (overlay == null) {
              return empty__widget;
            }

            return overlay(
              context,
            );
          },
        ),
      ],
    );
  }
}

extension FlutterErrorDetails__extension on FlutterErrorDetails {
  ({
    string error__string,
    StackTrace? trace,
  }) convert__string() {
    final //
        buffer = (StringBuffer()
          ..write("library" ":\"")
          ..write(library)
          ..write("\"," "context" ":\"")
          ..write(context)
          ..write("\"," "exception" ":\"")
          ..write(exception)
          ..write("\"," "silent" ":\"")
          ..write(silent));

    if (base__program__compile__mode == base__program__compile__modes.release) {
      buffer
        ..write("\"," "informationCollector" ":\"")
        ..write(informationCollector);
    }

    final result = (buffer..write("\"")).toString();

    buffer.clear();

    return (
      error__string: result,
      trace: stack,
    );
  }
}
