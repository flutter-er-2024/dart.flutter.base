part of "_.dart";

const //
    screen__width__phone__min = 320,
    screen__width__phone__max = 600; /*
all, copied, from `http://developer.android.com` */

const screen__size__phone__default = Size(400, 888 /* .8... if display is 9:20(portrait 20:9) */) /*
expect to be emulated, almost always
sample
  - phone.apple.flagship :390
  - phone.google.flagship :411 */
    ;

Size screen__size = screen__size__phone__default;

fp page__width = screen__size.width;

var //
    screen__padding__permanent /* always covered, by device's hardware, like camera hole */ = EdgeInsets.zero,
    screen__padding__temporary /* covered temporarily, by some software, like virtual keyboard */ = EdgeInsets.zero,
    screen__padding /* (temporary + permanent) */ = EdgeInsets.zero;

fp get page__padding__left => //
    (size__pixel__padding__horizontal + screen__padding__permanent.left);

fp get page__padding__right => //
    (size__pixel__padding__horizontal + screen__padding__permanent.right);

var size__pixel__1 = 1.0;

extension num__convert__pixel__size__scale__extension on num {
  fp get px => //
      (this * size__pixel__1);
}

extension EdgeInsets__scale__extension on EdgeInsets {
  EdgeInsets get px => //
      (this * size__pixel__1);
}

fp get size__pixel__padding__horizontal => 8.px;
fp get size__pixel__padding__horizontal__double => 16.px;

fp get size__pixel__padding__vertical => 8.px;
fp get size__pixel__padding__vertical__double => 16.px;

Radius _radius(
  final fp value__base,
  final uu nest_ing__depth,
) =>
    Radius.circular(((nest_ing__depth > 0) //
            ? (value__base - (((value__base / 2) / 2) * nest_ing__depth))
            : value__base)
        .px);

Radius radius__full([
  final uu nest_ing__depth = 0,
]) =>
    _radius(16, nest_ing__depth);

Radius radius__half([
  final uu nest_ing__depth = 0,
]) =>
    _radius(8, nest_ing__depth);

final base__app__size__alter__broadcast = base__widget__re_build__event__channel__broadcast();

bool /*
app:re_build:ok */
    base__app__size__set({
  required ui.FlutterView? view,
}) {
  view ??= ui.PlatformDispatcher.instance.implicitView! /*
FIX :prefer updating to a definitive approach */
      ;

  {
    var result = NO;

    if (view.physicalSize.isEmpty /*..convert__text__representation().print("view.physicalSize.isEmpty")*/ .not) {
      final screen__size__new = (view.physicalSize / view.devicePixelRatio);

      if (debug__report_ing__verbose__ok) {
        screen__size__new.convert__text__representation().print("screen:size:new");
      }

      if (screen__size__new != screen__size) {
        screen__size = screen__size__new;
        result = OK;
      }
    } else {
      if (debug__report_ing__verbose__ok) {
        "screen:size:new:empty:ok".print();
      }

      if (screen__size != screen__size__phone__default) {
        screen__size = screen__size__phone__default;
        result = OK;
      }
    }

    {
      final screen__padding__permanent__new = EdgeInsets.fromViewPadding(view.viewPadding, view.devicePixelRatio);

      if (debug__report_ing__verbose__ok) {
        screen__padding__permanent__new.convert__text__representation().print("screen:primary:padding:permanent:new");
      }

      if (screen__padding__permanent__new != screen__padding__permanent) {
        screen__padding__permanent = screen__padding__permanent__new;

        if (NOT(result)) {
          result = OK;
        }
      }
    }

    {
      final screen__padding__temporary__new = EdgeInsets.fromViewPadding(view.viewInsets, view.devicePixelRatio);

      if (debug__report_ing__verbose__ok) {
        screen__padding__temporary__new.convert__text__representation().print("screen:primary:padding:temporary:new");
      }

      if (screen__padding__temporary__new != screen__padding__temporary) {
        screen__padding__temporary = screen__padding__temporary__new;

        if (NOT(result)) {
          result = OK;
        }
      }
    }

    if (NOT(result)) {
      return NO;
    }
  }

  /*if (screen__size.height < (.8 * (2 * screen__width)) /*
  example: for `screen__size__phone__default`(400w * 888h), is 640(800 * 0.8) */
      ) //
    throw "host(or machine, or device)'s screen's height, ${screen__size.height}, is in-sufficient to properly display the app";*/ /*
  throws on desktop systems */

  final screen__width = screen__size.width;

  if (NOT(environment__work_station__ok)) {
    page__width = ((screen__width > screen__width__phone__max) //
        ? screen__width__phone__max.toDouble()
        : screen__width);

    size__pixel__1 = (0.0025 * page__width) /*
4, at 400 `page__width`, 3.2 at 320, 7.2 at 720, ...
same result as `(page__width / screen__size__phone__default.width)` */
        ;
  } else {
    page__width = screen__width__phone__max.toDouble();

    size__pixel__1 = 1;
  }

  page__width.convert__text__representation().print("page:width:new");
  size__pixel__1.convert__text__representation().print("size:pixel:new");

  screen__padding /*      */ = /*(screen__padding__temporary + screen__padding__permanent)*/ EdgeInsets.fromViewPadding(view.padding, view.devicePixelRatio);

  /*{
    screen__size.convert__text__representation().print("screen__size");
    page__width.convert__text__representation().print("page__width");

    size__pixel__1.convert__text__representation().print("size__pixel__1");
    8.px.convert__text__representation().print("8.px");
    16.px.convert__text__representation().print("16.px");
    96.px.convert__text__representation().print("64.px");

    Radius.circular(2.px).convert__text__representation().print("Radius.circular(2.px)");
    Radius.circular(4.px).convert__text__representation().print("Radius.circular(4.px)");
    Radius.circular(8.px).convert__text__representation().print("Radius.circular(8.px)");
    Radius.circular(16.px).convert__text__representation().print("Radius.circular(16.px)");
    Radius.circular(32.px).convert__text__representation().print("Radius.circular(32.px)");
  }*/

  base__app__size__alter__broadcast.event__announce();

  return OK;
}
