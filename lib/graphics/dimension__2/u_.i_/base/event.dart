part of "_.dart";

base__widget base__value__alter__event__channel__broadcast__handling__widget<value__type>({
  required final base__value__alter__event__channel__broadcast__dispose__protocol<value__type, base__widget__tree__node> channel,
  final base__widget__attach___proc___format? attach__handle,
  final base__widget__detach___proc___format? detach__handle,
  required final base__widget Function(
    base__widget__tree__node context,
    value__type value,
  ) build,
}) /*
like `ValueListenableBuilder` */
{
  return base__event__channel__broadcast__handling__widget(
    channel: channel,
    build: (final context) {
      return build(
        context,
        channel.value(),
      );
    },
  );
}

class base__event__channel__unicast__depository //
    extends base__depository__base //
    implements
        base__event__channel__protocol {
  base__event__channel__unicast__depository();

  base__widget__tree__node? widget__context__raw;

  @override
  void event__announce() {
    widget__context__raw?.re_build();
  }

  @override
  void dispose() {
    widget__context__raw = NIL;
  }
}

base__widget base__event__channel__unicast__handling__widget({
  required final base__event__channel__unicast__depository depository,
  final base__widget__attach___proc___format? attach__handle,
  final base__widget__detach___proc___format? detach__handle,
  required final base__widget__build__function__format build,
}) {
  return base__widget__build(
    attach__handle: (final context) {
      attach__handle?.call(
        context,
      );

      depository.widget__context__raw = context;
    },
    detach__handle: (final context) {
      if (depository.widget__context__raw == context) {
        depository.widget__context__raw = NIL;
      }

      detach__handle?.call(
        context,
      );
    },
    build: build,
  );
}

base__widget base__event__channel__broadcast__handling__widget({
  required final /*
use `event__channels__broadcast` ,for multiple channels */
      base__event__channel__broadcast__dispose__protocol<base__widget__tree__node>
      channel,
  final base__widget__attach___proc___format? attach__handle,
  final base__widget__detach___proc___format? detach__handle,
  required final base__widget__build__function__format build,
}) /*
like `ListenableBuilder` */
{
  return base__widget__build(
    attach__handle: (final context) {
      attach__handle?.call(
        context,
      );

      channel.descriptors__add(
        context,
      );
    },
    detach__handle: (final context) {
      channel.descriptors__remove(
        context,
      );

      detach__handle?.call(
        context,
      );
    },
    build: build,
  );
}
