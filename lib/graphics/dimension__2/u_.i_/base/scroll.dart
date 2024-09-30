part of "_.dart";

typedef base__widget__sliver = base__widget;

typedef scroll__axis__direction__kampa = ({
  AxisDirection main,
  AxisDirection cross,
});

class _scroll__behavior__kampa extends ScrollBehavior {
  const _scroll__behavior__kampa();

  @override
  Set<ui.PointerDeviceKind> get dragDevices => //
      <ui.PointerDeviceKind>{
        ui.PointerDeviceKind.touch,
        ui.PointerDeviceKind.stylus,
        ui.PointerDeviceKind.trackpad,
        ui.PointerDeviceKind.mouse,
      };

  @override
  base__widget buildScrollbar(
    final BuildContext context,
    final base__widget child,
    final ScrollableDetails details,
  ) =>
      (/*kDebugMode //
          ? RawScrollbar(
              controller: details.controller,
              child: child,
            )
          :*/
          child);

  @override
  base__widget buildOverscrollIndicator(
    final BuildContext context,
    final base__widget child,
    final ScrollableDetails details,
  ) =>
      StretchingOverscrollIndicator(
        axisDirection: details.direction,
        child: child,
      );

  @override
  GestureVelocityTrackerBuilder velocityTrackerBuilder(final BuildContext context) => //
      (final PointerEvent event) => //
          IOSScrollViewFlingVelocityTracker(event.kind);

  @override
  ScrollPhysics getScrollPhysics(final BuildContext context) => //
      scroll__physics__natural;
}

const //
    app__scroll__behavior = _scroll__behavior__kampa(),
//
    scroll__physics__clamping = ClampingScrollPhysics(
      parent: RangeMaintainingScrollPhysics(),
    ),
    scroll__physics__natural = BouncingScrollPhysics(
      parent: RangeMaintainingScrollPhysics(),
    ),
    scroll__physics__natural__fast = BouncingScrollPhysics(
      decelerationRate: ScrollDecelerationRate.fast,
      parent: RangeMaintainingScrollPhysics(),
    ),
    scroll__physics__natural__always = BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
//
    scroll__axis__direction__vertical = (
      main: AxisDirection.down,
      cross: AxisDirection.right,
    ),
    scroll__axis__direction__vertical__reverse = (
      main: AxisDirection.up,
      cross: AxisDirection.right,
    ),
    scroll__axis__direction__horizontal = (
      main: AxisDirection.right,
      cross: AxisDirection.down,
    ),
    scroll__axis__direction__horizontal__reverse = (
      main: AxisDirection.left,
      cross: AxisDirection.down,
    );

Scrollable scrollable({
  required final scroll__axis__direction__kampa axis__direction,
  required final ScrollController controller,
  required final ScrollPhysics physics,
  final fp extent__cache = 0,
  required final array<base__widget__sliver> slivers,
}) =>
    Scrollable(
      axisDirection: axis__direction.main,
      controller: controller,
      physics: physics,
      scrollBehavior: app__scroll__behavior,
      viewportBuilder: (final _, final offset) => //
          Viewport(
        axisDirection: axis__direction.main,
        crossAxisDirection: axis__direction.cross,
        offset: offset,
        cacheExtent: extent__cache,
        slivers: slivers,
      ),
    );

class scroll__manager__kampa //
    extends base__depository__base {
  scroll__manager__kampa._(
    this.controller,
    this.offset__cached,
  );

  factory scroll__manager__kampa([
    final fp offset__init_ial = 0,
  ]) {
    late final scroll__manager__kampa manager;

    manager = scroll__manager__kampa._(
      ScrollController(
          initialScrollOffset: offset__init_ial,
          keepScrollOffset: NO,
          onAttach: (final position) => //
              position. /*jumpTo*/ correctPixels(manager.offset__cached),
          onDetach: (final position) => //
              (manager.offset__cached = position.pixels)),
      offset__init_ial,
    );

    return manager;
  }

  final ScrollController controller;

  fp offset__cached;

  ScrollPosition? get position => //
      controller.positions.empty__not__else__null?.first;

  ({
    fp current,
    fp min,
    fp max,
  })? offset__range() {
    final $position = position;
    return (($position != null)
        ? (
            current: $position.pixels,
            min: $position.minScrollExtent,
            max: $position.maxScrollExtent,
          )
        : NIL);
  }

  bool scroll__if__possible({
    required final fp offset,
  }) {
    final $position = position;
    if ($position == null) {
      return NO;
    }

    $position.jumpTo(offset);
    return OK;
  }

  bool scroll__to__min__if__possible({
    final uu duration__seconds__milli = /*(1000 ~/ 3)*/ 96,
    final Curve curve = Curves.ease,
  }) {
    final $position = position;
    if ($position == null) {
      return NO;
    }

    if ($position.pixels > $position.minScrollExtent) {
      $position.jumpTo($position.minScrollExtent);
    } else {
      $position.animateTo(
        ($position.minScrollExtent - 16),
        duration: Duration(
          milliseconds: duration__seconds__milli,
        ),
        curve: curve,
      );
    }

    return OK;
  }

  string offset__convert__string() => //
      ("offset__range" ": " + offset__range().toString());

  @override
  void dispose() {
    controller.dispose();
  }
}
