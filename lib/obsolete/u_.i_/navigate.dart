import "package:base/base/_.dart";
import "package:base/event.dart";
import "package:base/print.dart";
import "package:base/stack.dart";

import "app.dart";
import "basic.dart";
import "size.dart";

import "components/foundations/build.dart";

late final navigation__kampa app__navigation__kampa;

void navigate__init({
  required final base__widget__build__function__format page__initial__build,
  required final procedure? page__initial__depart_ure__handle,
  final procedure? exit__handle /*
app:exit is non-{determin-istic|definit-ive} */
  ,
}) {
  app__navigation__kampa = navigation__kampa._(
    page__initial__build: app.page__initial__build,
    page__initial__depart_ure__handle: app.page__initial__departure__handle,
    exit__handle: exit__handle,
  );
}

class navigation__kampa /*
  MUST
    `overlay`[`:bottom`] be de-navigat-ed, as soon as, another navigat-ion
      if further `navigation__forward` is needed, prefer `navigate__forward__replace` */
{
  navigation__kampa._({
    required final base__widget__build__function__format page__initial__build,
    required final procedure? page__initial__depart_ure__handle,
    required this.exit__handle,
  })  : history = base__stack<_navigate__element>(),
        channel = message__channel__broadcast<navigation__type>() {
    if (debug__report_ing__verbose__ok) {
      "navigate:record:init".print();

      message__channel__broadcast__listeners__add(
        channel,
        (final navigate__event) {
          navigate__event.name.convert__text__representation().print("navigate:event");
          app__navigation__kampa.navigate__depth.convert__text__representation().print("navigate:depth:before:navigation");
        },
      );
    }

    history.add(
      _navigate__element(
        /*page__initial__build,*/
        page__initial__depart_ure__handle,
        /*not(OK),*/
      ),
    );

    procedure__schedule(() {
      message__channel__broadcast__message__announce(
        app__navigation__kampa.channel,
        navigation__type.init,
      );
    });
  }

  final base__stack<_navigate__element> history;
  final message__channel__broadcast<navigation__type> channel /*
all the events ,`init` ,`forward`-type ,`backward` ,and `exit` ,arrive ,before ,the navigat-ion */
      ;

  final procedure? exit__handle;

  uu get navigate__depth /*
includ-ing `page:initial` */
      => history.elements__count;

  void history__remove() {
    this.history
      ..element__last?.value.de_init_?.call()
      ..remove();
  }
}

class _navigate__element {
  const _navigate__element(
    /*this.widget__build,*/
    this.de_init_,
    /*this.transition__instant__ok,*/
  );

  /*final base__widget__build__function__format widget__build;*/
  final procedure? de_init_ /*
use `procedure__schedule`, to executure, after the build */
      ;
  /*final bool transition__instant__ok /*
not animate, the transition, TO this page */
      ;*/
}

enum navigation__type {
  init,
  forward__overlay /* application :en-large-ing an image */,
  forward__overlay__bottom /* application :(modal) bottom sheet */,
  forward__page /* push ,next */,
  forward__replace__page,
  forward__permanent__page /* pop_all_and_push ,re_set */,
  forward__permanent__partial__page /* pop_until[_and_push] */,
  backward /* pop, back */,
  exit,
}

const _page_route = /*CupertinoPageRoute<void>.new*/ MaterialPageRoute<void>.new;

asyn___value<void> navigate__forward__overlay(
  final base__widget__tree__node context, {
  required final procedure? dismiss__handle,
  required final base__widget__build__function__format overlay__build,
}) {
  app__navigation__kampa.history.add(
    _navigate__element(
      /*overlay__build,*/
      dismiss__handle,
    ),
  );

  message__channel__broadcast__message__announce(
    app__navigation__kampa.channel,
    navigation__type.forward__overlay,
  );

  return _navigate__forward(
    context,
    _page_route(
      builder: overlay__build,
      maintainState: OK,
      fullscreenDialog: OK,
    ),
  );
}

asyn___value<void> navigate__forward__overlay__bottom(
  final base__widget__tree__node context, {
  required final procedure? dismiss__handle,
  required final base__widget__build__function__format overlay__build,
}) {
  app__navigation__kampa.history.add(
    _navigate__element(
      /*overlay__build,*/
      dismiss__handle,
    ),
  );

  message__channel__broadcast__message__announce(
    app__navigation__kampa.channel,
    navigation__type.forward__overlay__bottom,
  );

  return _navigate__forward(
    context,
    ModalBottomSheetRoute<void>(
      builder: overlay__build,
      isScrollControlled: OK,
      backgroundColor: flutter__colors.transparent,
      elevation: 0,
      clipBehavior: Clip.none,
      constraints: BoxConstraints.tight(
        Size(
          page__width,
          screen__size.height,
        ),
      ),
      isDismissible: OK,
      modalBarrierColor: flutter__colors.transparent,
      enableDrag: OK,
      showDragHandle: OK,
      useSafeArea: NO,
    ),
  );
}

asyn___value<void> navigate__forward__page(
  final base__widget__tree__node context, {
  required final procedure? depart_ure__handle,
  required final base__widget__build__function__format page__build,
}) {
  app__navigation__kampa.history.add(
    _navigate__element(
      /*page__build,*/
      depart_ure__handle,
    ),
  );

  message__channel__broadcast__message__announce(
    app__navigation__kampa.channel,
    navigation__type.forward__page,
  );

  return _navigate__forward(
    context,
    _page_route(
      builder: page__build,
      maintainState: NO,
    ),
  );
}

asyn___value<void> navigate__forward__replace__page /*
efficient, than the, first calling `de_navigate`, then calling `navigate` */
    (
  final base__widget__tree__node context, {
  required final procedure? depart_ure__handle,
  required final base__widget__build__function__format page__build,
}) {
  app__navigation__kampa
    ..history__remove()
    ..history.add(
      _navigate__element(
        /*page__build,*/
        depart_ure__handle,
      ),
    );

  message__channel__broadcast__message__announce(
    app__navigation__kampa.channel,
    navigation__type.forward__replace__page,
  );

  return _navigator_state(context).pushReplacement<void, void>(
    _page_route(
      builder: page__build,
      maintainState: NO,
    ),
  );
}

asyn___value<void> navigate__forward__permanent__page(
  final base__widget__tree__node context, {
  final uu? pages__count /*
no issue ,if more than "pages:count" of navigator
appbar's back navigation button is not shown */
  ,
  required final procedure? depart_ure__handle,
  required final base__widget__build__function__format page__build,
}) {
  if (pages__count == null) {
    app__navigation__kampa.history
      ..iterate__basic(
        (final element) {
          element.de_init_?.call();
        },
      )
      ..flush();

    app__navigation__kampa.history.add(
      _navigate__element(
        /*page__build,*/
        depart_ure__handle,
      ),
    );

    message__channel__broadcast__message__announce(
      app__navigation__kampa.channel,
      navigation__type.forward__permanent__page,
    );

    return _navigator_state(context).pushAndRemoveUntil<void>(
      _page_route(
        builder: page__build,
        maintainState: NO,
      ),
      (final _) => NO,
    );
  } else {
    base__iterate__basic(
      pages__count,
      (final _) {
        app__navigation__kampa.history__remove();
      },
    );

    var pages__count_ = pages__count;

    app__navigation__kampa.history.add(
      _navigate__element(
        /*page__build,*/
        depart_ure__handle,
      ),
    );

    message__channel__broadcast__message__announce(
      app__navigation__kampa.channel,
      navigation__type.forward__permanent__partial__page,
    );

    return _navigator_state(context).pushAndRemoveUntil<void>(
      _page_route(
        builder: page__build,
        maintainState: NO,
      ),
      (final _) {
        if /*F*/ (pages__count_ == 0) {
          return OK;
        }

        pages__count_ -= 1;

        return NO;
      },
    );
  }
}

bool _backward__ok() => //
    (app__navigation__kampa.history.elements__count > 1);

bool navigate__backward__ok(
  final base__widget__tree__node context,
) {
  return /*_backward__ok()*/ _navigator_state(context).canPop();
}

void navigate__backward(
  final base__widget__tree__node context,
) {
  if /*F*/ (NOT(_backward__ok()) /*exit:ok*/) {
    app__navigation__kampa.exit__handle?.call();

    message__channel__broadcast__message__announce(
      app__navigation__kampa.channel,
      navigation__type.exit,
    );

    SystemNavigator.pop();
  } else {
    app__navigation__kampa.history__remove();

    message__channel__broadcast__message__announce(
      app__navigation__kampa.channel,
      navigation__type.backward,
    );

    _navigator_state(context).pop<void>();
  }
}

asyn___value<void> /*
completes ,when the `route` is de-navigat-ed */
    _navigate__forward(
  final base__widget__tree__node context,
  final Route<void> route,
) {
  return _navigator_state(
    context,
  ).push<void>(
    route,
  );
}

NavigatorState _navigator_state(
  final base__widget__tree__node context,
) {
  return Navigator.of(
    context,
  );
}
