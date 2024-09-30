part of "_.dart";

class base__overlay__persistent__management //
    <data__type extends Object> {
  base__overlay__persistent__management(
    this.channel /*base__app__overlay__persistent__channel*/,
    this.overlay__build,
  );

  final base__value__alter__widget__re_build__event__channel__broadcast<base__widget__build__function__format?> channel;

  final base__widget Function(
    base__widget__tree__node,
    data__type,
  ) overlay__build;

  data__type? overlay__current__data__raw = NIL;

  void overlay__re_place(
    final data__type data, [
    final Duration? dismiss__duration,
  ]) {
    overlay__re_place__raw(
      data,
    );

    if (dismiss__duration == null) {
      return;
    }

    asyn___delay(
      dismiss__duration,
      () {
        if (overlay__current__data__raw == data) {
          overlay__re_move__raw();
        }
      },
    );
  }

  void overlay__re_place__raw(
    final data__type data,
  ) {
    overlay__current__data__raw = data;
    channel.value__alter__and__announce__raw(
      (final context) => overlay__build(context, data),
    );
  }

  void overlay__re_move__safe() {
    if (overlay__current__data__raw == NIL) {
      return;
    }

    overlay__re_move__raw();
  }

  void overlay__re_move__raw() {
    overlay__current__data__raw = NIL;
    channel.value__alter__and__announce__raw(
      NIL,
    );
  }
}
