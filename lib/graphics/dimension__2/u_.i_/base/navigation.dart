part of "_.dart";

extension navigation__extension //
    on base__widget__tree__node /*
{`dismiss`|`depart_ure`|`de_init_`|`dispose`}`:handle` can be achieved by ,`::handle`-ing the `navigate:forward:`* `return`-ed `async_:value` ,then calling the proc. */
{
  asyn___value<void> //
      navigate__forward__overlay /*
application :en-large-ing an image */ //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final Color background__color = _overlay__background__color,
    final bool background__press__dismiss__ok = OK,
    final bool transit_ion__instant__ok = NO,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigate__forward(
        navigation__root__ok,
        _overlay(
          background__color: background__color,
          background__press__dismiss__ok: background__press__dismiss__ok,
          transit_ion__instant__ok: transit_ion__instant__ok,
          route__settings: route__settings,
          depository: depository,
        ),
      ),
    );
  }

  asyn___value<void> //
      navigate__forward__replace__overlay //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final Color background__color = _overlay__background__color,
    final bool background__press__dismiss__ok = OK,
    final bool transit_ion__instant__ok = NO,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigate__forward__replace(
        navigation__root__ok,
        _overlay(
          background__color: background__color,
          background__press__dismiss__ok: background__press__dismiss__ok,
          transit_ion__instant__ok: transit_ion__instant__ok,
          route__settings: route__settings,
          depository: depository,
        ),
      ),
    );
  }

  Route<void> //
      _overlay //
      <depository__type extends base__widget__depository__base>({
    required final Color background__color,
    required final bool background__press__dismiss__ok,
    required final bool transit_ion__instant__ok,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return (/*F*/ transit_ion__instant__ok
        ? RawDialogRoute<void>(
            pageBuilder: (final context, final _, final __) {
              return depository.widget(
                context,
              );
            },
            barrierColor: background__color,
            barrierDismissible: background__press__dismiss__ok,
            barrierLabel: empty__string,
            transitionDuration: Duration.zero,
            transitionBuilder: (final context, final _, final __, final ___) {
              return depository.widget(
                context,
              );
            },
            settings: route__settings,
          )
        : DialogRoute<void>(
            context: this,
            builder: depository.widget,
            barrierColor: background__color,
            barrierDismissible: background__press__dismiss__ok,
            barrierLabel: empty__string,
            useSafeArea: NO,
            settings: route__settings,
          ));
  }

  asyn___value<void> //
      navigate__forward__overlay__bottom /*
application :(modal) bottom sheet */ //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final Color background__color = _overlay__background__color,
    final bool background__press__dismiss__ok = OK,
    final bool drag__bottom__dismiss__ok = OK,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigate__forward(
        navigation__root__ok,
        _overlay__bottom(
          background__color,
          background__press__dismiss__ok,
          drag__bottom__dismiss__ok,
          route__settings,
          NIL,
          depository,
        ),
      ),
    );
  }

  asyn___value<void> //
      navigate__forward__replace__overlay__bottom //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final Color background__color = _overlay__background__color,
    final bool background__press__dismiss__ok = OK,
    final bool drag__bottom__dismiss__ok = OK,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigate__forward__replace(
        navigation__root__ok,
        _overlay__bottom(
          background__color,
          background__press__dismiss__ok,
          drag__bottom__dismiss__ok,
          route__settings,
          NIL,
          depository,
        ),
      ),
    );
  }

  asyn___value<void> //
      navigate__forward__overlay__bottom__transit_ion__instant //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final Color background__color = _overlay__background__color,
    final bool background__press__dismiss__ok = OK,
    final bool drag__bottom__dismiss__ok = OK,
    required final TickerProvider vsync,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigate__instant(
        vsync,
        (final transit_ion__control) {
          return _navigate__forward(
            navigation__root__ok,
            _overlay__bottom(
              background__color,
              background__press__dismiss__ok,
              drag__bottom__dismiss__ok,
              route__settings,
              transit_ion__control,
              depository,
            ),
          );
        },
      ),
    );
  }

  asyn___value<void> //
      navigate__forward__replace__overlay__bottom__transit_ion__instant //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final Color background__color = _overlay__background__color,
    final bool background__press__dismiss__ok = OK,
    final bool drag__bottom__dismiss__ok = OK,
    required final TickerProvider vsync,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigate__instant(
        vsync,
        (final transit_ion__control) {
          return _navigate__forward__replace(
            navigation__root__ok,
            _overlay__bottom(
              background__color,
              background__press__dismiss__ok,
              drag__bottom__dismiss__ok,
              route__settings,
              transit_ion__control,
              depository,
            ),
          );
        },
      ),
    );
  }

  asyn___value<void> //
      _navigate__instant //
      <depository__type extends base__widget__depository__base?>(
    final TickerProvider vsync,
    final asyn___value<void> Function(
      AnimationController transit_ion__control,
    ) asyn___value,
  ) async {
    final transit_ion__control = AnimationController(
      vsync: vsync,
      duration: Duration.zero,
      reverseDuration: Duration.zero,
    );

    await asyn___value(
      transit_ion__control,
    );

    transit_ion__control.dispose();
  }

  Route<void> //
      _overlay__bottom //
      <depository__type extends base__widget__depository__base>(
    final Color background__color,
    final bool background__press__dismiss__ok,
    final bool drag__bottom__dismiss__ok,
    final RouteSettings? route__settings,
    final AnimationController? transit_ion__control,
    final depository__type depository,
  ) {
    return ModalBottomSheetRoute<void>(
      settings: route__settings,
      builder: depository.widget,
      isScrollControlled: OK,
      backgroundColor: (base__app__theme__colors__ground___back__dark__ok //
          ? base__color__transparent__dark
          : base__color__transparent__light),
      elevation: 0,
      clipBehavior: Clip.none,
      constraints: BoxConstraints.tight(
        Size(
          page__width,
          screen__size.height,
        ),
      ),
      isDismissible: background__press__dismiss__ok,
      modalBarrierColor: background__color,
      barrierLabel: empty__string,
      enableDrag: drag__bottom__dismiss__ok,
      showDragHandle: NO,
      transitionAnimationController: transit_ion__control,
      useSafeArea: NO,
    );
  }

  asyn___value<void> //
      navigate__forward__page /*
push ,next */ //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final bool transit_ion__instant__ok = NO,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigate__forward(
        navigation__root__ok,
        _page__route(
          transit_ion__instant__ok,
          route__settings,
          depository.widget,
        ),
      ),
    );
  }

  asyn___value<void> /*
completes ,when the `route` is de-navigat-ed */
      _navigate__forward(
    final bool navigation__root__ok,
    final Route<void> route,
  ) {
    return _navigator_state(
      root__ok: navigation__root__ok,
    ).push<void>(
      route,
    );
  }

  asyn___value<void> //
      navigate__forward__replace__page /*
efficient, than the, first calling `de_navigate`, then calling `navigate` */ //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final bool transit_ion__instant__ok = NO,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigate__forward__replace(
        navigation__root__ok,
        _page__route(
          transit_ion__instant__ok,
          route__settings,
          depository.widget,
        ),
      ),
    );
  }

  asyn___value<void> //
      _navigate__forward__replace(
    final bool navigation__root__ok,
    final Route<void> route,
  ) {
    return _navigator_state(
      root__ok: navigation__root__ok,
    ).pushReplacement<void, void>(
      route,
    );
  }

  asyn___value<void> //
      navigate__forward__replace__full__page /*
{pop_until_and_push|{pop_all_and_push|re_set}} */ //
      <depository__type extends base__widget__depository__base>({
    final bool navigation__root__ok = NO,
    final uu? pages__count,
    final string? page__route__name,
    final bool transit_ion__instant__ok = NO,
    final RouteSettings? route__settings,
    required final depository__type depository,
  }) {
    return _depository__handle(
      depository,
      _navigator_state(
        root__ok: navigation__root__ok,
      ).pushAndRemoveUntil<void>(
        _page__route(
          transit_ion__instant__ok,
          route__settings,
          depository.widget,
        ),
        _route__predicate(
          pages__count,
          page__route__name,
        ),
      ),
    );
  }

  asyn___value<void> //
      _depository__handle //
      <depository__type extends base__widget__depository__base>(
    final depository__type depository,
    final asyn___value<void> future,
  ) async {
    await future;

    depository.dispose();
  }

  bool navigate__backward__ok({
    final bool navigation__root__ok = NO,
  }) {
    return _navigator_state(
      root__ok: navigation__root__ok,
    ).canPop();
  }

  void navigate__backward /*
{{pop|back}|exit}
call-ing multiple times ,would act multiple times 
  ,even exit-ing the app
  ,even on same `context`
    ,on further(than the first) calls ,acts on `context` ,of parent(in hierarchy)[s]  */
      ({
    final bool navigation__root__ok = NO,
  }) {
    if /*F*/ (navigate__backward__ok().not /*exit:ok*/) {
      base__app__exit();
    } else {
      _navigator_state(
        root__ok: navigation__root__ok,
      ).pop<void>();
    }
  }

  /*void navigate__back()
    { return navigate__backward(); }*/

  void navigate__backward__full /*
{pop_until|{pop_all|re_set}} */
      ({
    final bool navigation__root__ok = NO,
    final uu? pages__count,
    final string? page__route__name,
  }) {
    return _navigator_state(
      root__ok: navigation__root__ok,
    ).popUntil(
      _route__predicate(
        pages__count,
        page__route__name,
      ),
    );
  }

  RoutePredicate //
      _route__predicate(
    final uu?
        pages__count /*
cases :
  NUL :remove all previous pages
  0 :remove all previous pages ,until/except/exclud-ing the first page
  >0 :
    remove `pages:count` number ,of previous pages
    no issue ,if `pages:count` exceeds the {navigat-ion}-stack's depth/elements:count */
    ,
    final string? page__route__name /*
if `pages:count` is avail-able ,`page:route:name` is ignored */
    ,
  ) {
    if (pages__count == null) {
      if (page__route__name == null) {
        return (final _) => NO;
      } else {
        return (final route) {
          return (route.settings.name == page__route__name);
        };
      }
    } else if /*F*/ (pages__count == 0) {
      return (final route) => route.isFirst;
    } else {
      var _pages__count = pages__count;

      return (final _) {
        if /*F*/ (_pages__count == 0) {
          return OK;
        }

        _pages__count -= 1;

        return NO;
      };
    }
  }

  NavigatorState //
      _navigator_state({
    final bool root__ok /*
useful for `overlay`s
run-time expensive op. */
    = NO,
  }) {
    return Navigator.of(
      this,
      rootNavigator: root__ok,
    );
  }

  static Route<void> _page__route(
    final bool transit_ion__instant__ok,
    final RouteSettings? route__settings,
    final base__widget__build__function__format page__build,
  ) {
    return (/*iff*/ transit_ion__instant__ok
        ? PageRouteBuilder<void>(
            settings: route__settings,
            pageBuilder: (final context, final _, final __) {
              return page__build(
                context,
              );
            },
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          )
        : /*CupertinoPageRoute<void>*/ MaterialPageRoute<void>(
            settings: route__settings,
            builder: page__build,
            maintainState: NO,
          ));
  }

  static const _overlay__background__color = /*base__color__transparent__dark*/
      Color(0xBB000000);
}

asyn___value<void> base__app__exit() {
  return SystemNavigator.pop();
}

class base__widget__basic__depository__proxy //
    extends base__widget__depository__base {
  const base__widget__basic__depository__proxy({
    required final base__widget__build__function__format build,
  }) : build_1 = build;

  final base__widget__build__function__format build_1;

  @override
  base__widget widget(
    final base__widget__tree__node context,
  ) {
    return build_1(
      context,
    );
  }

  @override
  void dispose() {}
}

abstract class base__widget__depository__base /*
instances must not ,be created in `widget::build`
  ,even if `.dispose` is set to be invoked ,through `base__widget__build.detach`
  ,because attach/detach are not called ,if tree is re-fresh-ed ,without altering
  ,no problem ,in event-emitted proc.s ,like `event___press__handle`
more efficient(run-time and run-memory-space) ,than closures ,due to dart-lang.'s design-choices
flagship(current) examples :
  - `base__list_ing__grow_able__depository`
very similar to `_widget__build__basic` ,but its simply a coincidence */ //
    extends base__depository__base {
  const base__widget__depository__base();

  base__widget widget /*
not named `build`
  because its vague(because its an internal-part ,of the widget)
    ,for a depo.(which contains data ,and UI is merely a part-of-it) */
      (
    final base__widget__tree__node context,
  );
}

extension navigation__indicate__extension //
    on base__widget__tree__node {
  asyn___value<type> navigate__activity<type>(
    final asyn___value<type> future /*
`asyn___value.sync` can be used for sync. actions
handles ,`asyn___value.value` ,and `asyn___value.delayed` ,also */
    , {
    required final base__widget__build__function__format indicate__activity__build,
  }) {
    final promise = asyn___promise<type>();

    base__widget__tree__node? context_1;

    void back() {
      final context_2 = context_1;
      if ((context_2 != null) && context_2.valid__ok()) {
        context_2.navigate__backward();
      }
    }

    var complete__ok /*
needed to handle ,already completed ,and `asyn___value.value`-created ,futures */
        = NO;

    future.handle(
      (final value) {
        complete__ok = OK;

        back();

        promise.complete(value);
      },
      (final e, final t) {
        complete__ok = OK;

        back();

        promise.completeError(e, t);
      },
    );

    navigate__forward__overlay(
      background__press__dismiss__ok: NO,
      depository: base__widget__basic__depository__proxy(
        build: (final context_2) {
          if (complete__ok) {
            asyn___schedule(
              () {
                context_2.navigate__backward();
              },
            );

            return empty__widget;
          }

          context_1 = context_2;

          return PopScope(
            canPop: NO,
            child: indicate__activity__build(
              context_2,
            ),
          );
        },
      ),
    );

    return promise.future;
  }

  asyn___value<void> navigate__notice({
    final Alignment notice__position = Alignment.center,
    final Duration? notice__duration /*
auto.-dismiss duration
values :
  NIL :permanent
  other :temporary */
    = const Duration(
      seconds: 3,
    ),
    required final base__widget__build__function__format notice__build,
  }) {
    return navigate__forward__overlay(
      depository: base__widget__basic__depository__proxy(
        build: (final context) {
          if (notice__duration != null) {
            asyn___delay(
              notice__duration,
              () {
                if (context.valid__ok()) {
                  context.navigate__backward();
                }
              },
            );
          }

          return Align(
            alignment: notice__position,
            child: notice__build(context),
          );
        },
      ),
    );
  }
}
