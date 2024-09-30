part of "_.dart";

base__widget base__widget__build__definitive //
    <depository__type extends base__depository__base>({
  final Key? key,
  required final base__widget__attach__definitive___proc___format<depository__type> attach__handle,
  final base__widget__detach__definitive___proc___format<depository__type>? detach__handle,
  required final base__widget__build__function__format build,
}) {
  return _widget__build__definitive<depository__type>(
    key: key,
    attach__handle: attach__handle,
    detach__handle: detach__handle,
    build: build,
  );
}

@immutable
class _widget__build__definitive /*
forked, from `_widget__build` */ //
    <depository__type extends base__depository__base> //
    extends _widget__build__base {
  const _widget__build__definitive({
    super.key,
    required this.attach__handle,
    this.detach__handle,
    required super.build,
  });

  final base__widget__attach__definitive___proc___format<depository__type> attach__handle;
  final base__widget__detach__definitive___proc___format<depository__type>? detach__handle /*
`depository` must not be `::dispose`-ed
  the caller does internally ,auto.ly */
      ;

  @override
  _widget__build__definitive__state<depository__type> //
      createState() {
    return _widget__build__definitive__state<depository__type>();
  }
}

class _widget__build__definitive__state //
    <depository__type extends base__depository__base> //
    extends _widget__build__base__state<_widget__build__definitive<depository__type>> {
  late final depository__type depository;

  @override
  void initState() {
    super.initState();

    depository = widget.attach__handle(
      context,
    );
  }

  @override
  void dispose() {
    widget.detach__handle?.call(
      context,
      depository,
    );

    depository.dispose();

    super.dispose();
  }
}

base__widget base__widget__build({
  final Key? key,
  final base__widget__attach___proc___format? attach__handle,
  final base__widget__detach___proc___format? detach__handle,
  required final base__widget__build__function__format build,
}) {
  if ((attach__handle == null) //
      &&
      (detach__handle == null)) {
    return base__widget__build__basic(
      key: key,
      build: build,
    );
  }

  return _widget__build(
    key: key,
    attach__handle: attach__handle,
    detach__handle: detach__handle,
    build: build,
  );
}

@immutable
class _widget__build //
    extends _widget__build__base {
  const _widget__build({
    super.key,
    this.attach__handle,
    this.detach__handle,
    required super.build,
  });

  final base__widget__attach___proc___format? attach__handle;
  final base__widget__detach___proc___format? detach__handle;

  @override
  _widget__build__state //
      createState() {
    return _widget__build__state();
  }
}

class _widget__build__state //
    extends _widget__build__base__state<_widget__build> {
  @override
  void initState() {
    super.initState();

    widget.attach__handle?.call(
      context,
    );
  }

  /*@override
  void didUpdateWidget /* called on parent re-build */ (
    covariant final _widget__build__definitive<depository__type> oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    widget.update?.call(widget__new: widget, widget__old: oldWidget,);
  }*/ /*
quite useless ,for the meta-framework's architecture ,except the event-call
  ,because `oldWidget` has no relevant data-members */

  @override
  void dispose() {
    widget.detach__handle?.call(
      context,
    );

    super.dispose();
  }
}

@immutable
abstract /*
because `base__widget__build__basic` has same features ,with better efficiency */
    class _widget__build__base /*
prefer wrapping with `RepaintBoundary`
forked, from `flutter/lib/src/widgets/basic.dart`::`StatefulBuilder` */ //
    extends StatefulWidget {
  const _widget__build__base({
    super.key,
    required this.build /*
refer to `base__widget__build__basic.build` */
    ,
  });

  final base__widget__build__function__format build;
}

class _widget__build__base__state //
    <widget__build__base__type extends _widget__build__base> //
    extends State<widget__build__base__type> {
  @override
  base__widget build(
    final _ /*
guaranteed(by the system) to be same ,as `this.context` */
    ,
  ) {
    return widget.build(
      context,
    );
  }
}

base__widget base__widget__build__basic({
  final Key? key,
  required final base__widget__build__function__format build,
}) {
  return _widget__build__basic(
    key: key,
    build: build,
  );
}

@immutable
class _widget__build__basic //
    extends StatelessWidget /*
can be re-build, using `base__widget__tree__node__re_build`
forked, from "flutter/widgets/basic.dart:Builder" */
{
  const _widget__build__basic({
    super.key,
    required final base__widget__build__function__format build,
  }) : build_1 = build;

  final base__widget__build__function__format build_1 /*
must be nullipotent(side-effect free)
  should not contain any other code, than presentation, or UI
    especially io should heappen before any calls to build
  and expect any number of calls */
      ;

  @override
  base__widget build(
    final base__widget__tree__node context,
  ) {
    return build_1(
      context,
    );
  }
}
