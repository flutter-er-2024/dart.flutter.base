import "package:base/base/_.dart";
import "package:base/broadcast.dart";
import "package:base/reporting.dart";
import "package:base/stack.dart";

import "basic.dart";
import "components/foundations/build.dart";

/*
  TASK
    add support for transitions(FadeUpwardsPageTransitionsBuilder, OpenUpwardsPageTransitionsBuilder, ZoomPageTransitionsBuilder, CupertinoPageTransitionsBuilder) */

const u8 //
    navigation__type__init = 0,
    navigation__type__forward__page /* push, next */ = (1 + navigation__type__init),
    navigation__type__forward__overlay /* application: en-large-ing an image */ = (1 + navigation__type__forward__page),
    navigation__type__forward__overlay__bottom /* application: (modal) bottom sheet */ = (1 + navigation__type__forward__overlay),
    navigation__type__backward /* pop, back */ = (1 + navigation__type__forward__overlay__bottom),
    navigation__type__re_set /* push_and_remove_until, pop_until */ = (1 + navigation__type__backward),
    navigation__type__exit = (1 + navigation__type__re_set);

string navigation__type__convert__string(
  final uu navigation__type,
) {
  switch (navigation__type) {
    case navigation__type__init:
      return "navigation__type__init";

    case navigation__type__forward__page:
      return "navigation__type__forward__page";
    case navigation__type__forward__overlay:
      return "navigation__type__forward__overlay";
    case navigation__type__forward__overlay__bottom:
      return "navigation__type__forward__overlay__bottom";

    case navigation__type__backward:
      return "navigation__type__backward";

    case navigation__type__re_set:
      return "navigation__type__re_set";

    case navigation__type__exit:
      return "navigation__type__exit";

    default:
      throw "un-known navigation type, $navigation__type";
  }
}

class navigation__kampa {
  const navigation__kampa(
    this.widget,
    this.de_init_,
    this.b__transition__instant,
  );

  final base__widget widget;
  final procedure? de_init_ /*
  use `procedure__schedule`, to executure, after the build */
      ;
  final bool b__transition__instant /* do not animate, the transition, TO this page */;
}

navigation__kampa navigation(
  final base__widget__build__function__format widget__build,
  final procedure? de_init_, [
  final bool b__transition__instant = NO,
]) =>
    navigation__kampa(
      base__widget__build(
        widget__build,
        key: base__widget__key__unique,
      ),
      de_init_,
      b__transition__instant,
    );

class navigation__manager__kampa /*
  MUST
    `overlay`[`__bottom`] be de-navigat-ed, as soon as, another navigat-ion
      if further `navigation__forward` is needed, prefer `navigate__forward__replace` */
{
  const navigation__manager__kampa(
    this.history,
    this.broadcast,
    this.app,
    this.exit__handle,
  );

  final base__stack<navigation__kampa> history;
  final broadcast__kampa<u8> broadcast /*
  except `exit`, all the `navigation.type`s arrive after the navigation
    because all non-internal listeners are added after the actual manager */
      ;
  final base__widget__build__definitive app;
  final procedure? exit__handle;
}

navigation__manager__kampa navigation__manager({
  required final base__widget__build__function__format page__initial__build,
  required final procedure? page__initial__departure__handle,
  required final procedure? exit__handle,
}) {
  final //
      history = base__stack<navigation__kampa>(),
      broadcast_ = broadcast<u8>(error__handle);

  u8 navigation__last__type = navigation__type__init;

  return navigation__manager__kampa(
    history,
    broadcast_,
    base__widget__build__definitive(
      init: (final state) {
        broadcast_.listener__add(
          (final navigation__type) {
            if (debug__report_ing__verbose__ok) {
              report__info(navigation__type__convert__string(navigation__type));
              report__uu(history.count, "navigation.history.count");
              report__bool(state.valid__ok(), "navigation.app.b__mounted");
            }

            navigation__last__type = navigation__type;

            state.re_build__if();
          },
        );

        history.add(
          navigation(
            page__initial__build,
            page__initial__departure__handle,
            NO,
          ),
        );
      },
      de_init_: broadcast_.flush,
      build: (final _) {
        if (debug__report_ing__verbose__ok) //
          base__function__call__print__arguments__void(
            "navigation.build",
          );

        if /*un-likely*/ (navigation__last__type == navigation__type__exit) //
          return empty__widget;

        final last = history.last!;
        /*if (last ==  null) //
            throw "(navigation__history.last ==  null)";*/

        if ((navigation__last__type != navigation__type__forward__overlay) && //
            (navigation__last__type != navigation__type__forward__overlay__bottom)) //
          return last.value.widget;

        final last_ = last.previous!;
        /*if (last_ ==  null) //
            throw "(navigation__history.last.previous ==  null)";*/

        return base__stack__widget(
          children: <base__widget>[
            IgnorePointer(
              child: last_.value.widget,
            ),
            last.value.widget,
          ],
        );
      },
    ),
    exit__handle,
  );
}

void navigate__forward__page(
  final navigation__manager__kampa navigation__manager, {
  final bool b__transition__instant = NO,
  required final procedure? departure__handle,
  required final base__widget__build__function__format page__build,
}) {
  navigation__manager
    ..history.add(
      navigation(
        page__build,
        departure__handle,
        b__transition__instant,
      ),
    )
    ..broadcast.message__announce(
      navigation__type__forward__page,
    );
}

void navigate__forward__overlay(
  final navigation__manager__kampa navigation__manager, {
  final bool b__transition__instant = NO,
  required final procedure? close__handle,
  required final base__widget__build__function__format overlay__build,
}) {
  navigation__manager
    ..history.add(
      navigation(
        overlay__build,
        close__handle,
        b__transition__instant,
      ),
    )
    ..broadcast.message__announce(
      navigation__type__forward__overlay,
    );
}

void navigate__forward__overlay__bottom(
  final navigation__manager__kampa navigation__manager, {
  final bool b__transition__instant = NO,
  required final procedure? dismiss__handle,
  required final base__widget__build__function__format overlay__build,
}) {
  navigation__manager
    ..history.add(
      navigation(
        overlay__build,
        dismiss__handle,
        b__transition__instant,
      ),
    )
    ..broadcast.message__announce(
      navigation__type__forward__overlay__bottom,
    );
}

void history__remove(
  final navigation__manager__kampa navigation__manager,
) {
  navigation__manager.history
    ..last?.value.de_init_?.call()
    ..remove();
}

void navigate__forward__replace__page(
  final navigation__manager__kampa navigation__manager, {
  final bool b__transition__instant = NO,
  required final procedure? departure__handle,
  required final base__widget__build__function__format page__build,
}) /*
  equal to, calling `de_navigate`, then calling `navigate`
    without `build`ing the `widget`, `de_navigate`ed to
      hence efficient, than the, just mentioned, sequence */
{
  history__remove(
    navigation__manager,
  );

  navigate__forward__page(
    navigation__manager,
    b__transition__instant: b__transition__instant,
    departure__handle: departure__handle,
    page__build: page__build,
  );
}

void navigate__forward__replace__overlay(
  final navigation__manager__kampa navigation__manager, {
  final bool b__transition__instant = NO,
  required final procedure? close__handle,
  required final base__widget__build__function__format overlay__build,
}) {
  history__remove(
    navigation__manager,
  );

  navigate__forward__overlay(
    navigation__manager,
    b__transition__instant: b__transition__instant,
    close__handle: close__handle,
    overlay__build: overlay__build,
  );
}

void navigate__forward__replace__overlay__bottom(
  final navigation__manager__kampa navigation__manager, {
  final bool b__transition__instant = NO,
  required final procedure? dismiss__handle,
  required final base__widget__build__function__format overlay__build,
}) {
  history__remove(
    navigation__manager,
  );

  navigate__forward__overlay__bottom(
    navigation__manager,
    b__transition__instant: b__transition__instant,
    dismiss__handle: dismiss__handle,
    overlay__build: overlay__build,
  );
}

bool b__navigate__backward(
  final navigation__manager__kampa navigation__manager,
) =>
    (navigation__manager.history.count > 1);

void exit(
  final navigation__manager__kampa navigation__manager,
) {
  navigation__manager
    ..broadcast.message__announce(
      navigation__type__exit,
    )
    ..exit__handle?.call();
}

void navigate__backward(
  final navigation__manager__kampa navigation__manager,
) {
  history__remove(
    navigation__manager,
  );

  if (!navigation__manager.history.empty__ok) //
    navigation__manager.broadcast.message__announce(
      navigation__type__backward,
    );
  else //
    exit(
      navigation__manager,
    );
}

void navigate__back(
  final navigation__manager__kampa navigation__manager,
) =>
    navigate__backward(
      navigation__manager,
    );

void de_navigate(
  final navigation__manager__kampa navigation__manager,
) =>
    navigate__backward(
      navigation__manager,
    );

void history__flush(
  final navigation__manager__kampa navigation__manager,
) {
  navigation__manager.history
    ..iterate__basic((final navigation) => //
        navigation.de_init_?.call())
    ..flush();
}

void navigate__re_set(
  final navigation__manager__kampa navigation__manager, {
  final bool b__transition__instant = NO,
  required final procedure? departure__handle,
  required final base__widget__build__function__format page__build,
}) {
  history__flush(
    navigation__manager,
  );

  navigation__manager
    ..history.add(
      navigation(
        page__build,
        departure__handle,
        b__transition__instant,
      ),
    )
    ..broadcast.message__announce(
      navigation__type__re_set,
    );
}

void navigate__exit(
  final navigation__manager__kampa navigation__manager,
) {
  history__flush(
    navigation__manager,
  );

  exit(
    navigation__manager,
  );
}
