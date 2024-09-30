part of "_.dart";

class base__widget__build__periodic__depository //
    extends base__event__channel__unicast__depository {
  factory base__widget__build__periodic__depository({
    required final uu time__unit__count,
    final uu time__interval /* in milli-seconds */ = Duration.millisecondsPerSecond,
    required final procedure__empty__format time__finish__handle,
  }) {
    late final base__widget__build__periodic__depository result;

    result = base__widget__build__periodic__depository._(
      timer: asyn___delay.periodic(
        Duration(
          milliseconds: time__interval,
        ),
        (final timer_1) {
          result.time__unit__count__current += 1;
          if (result.time__unit__count__current < time__unit__count) {
            result.event__announce();
          } else {
            timer_1.cancel();
            time__finish__handle();
          }
        },
      ),
      time__unit__count__current: 0,
    );

    return result;
  }

  base__widget__build__periodic__depository._({
    required this.timer,
    required this.time__unit__count__current,
  });

  final asyn___delay timer;

  uu time__unit__count__current;

  @override
  void dispose() {
    timer.cancel();
  }
}

base__widget base__widget__build__periodic({
  required final base__widget__build__periodic__depository depository,
  required final base__widget Function(
    base__widget__tree__node context,
    uu count,
  ) build,
}) {
  return base__event__channel__unicast__handling__widget(
    depository: depository,
    build: (final context) {
      return build(
        context,
        depository.time__unit__count__current,
      );
    },
  );
}

class base__asyn___value__handling__depository //
    <data__type extends Object> //
    extends base__asyn___value__handling__depository__raw<data__type> {
  base__asyn___value__handling__depository(
    super.value,
  );

  base__asyn___value__handling__depository.data(
    final data__type data,
  ) : super.data(
          data,
        );
}

extension base__asyn___value__handling__depository__extension //
    <data__type extends Object> //
    on base__asyn___value__handling__depository<data__type> {
  data__type? //
      data() {
    if (_value__data__ok().not) {
      return NIL;
    }

    return _value__data();
  }
}

class base__asyn___value__handling__depository__raw /*
adding `re_fresh`[`__data`] wont be good 
  ,because it would have almost-same effect as {replace future/data ,then re-build} 
    ,which the user can do ,by independently replacing the `future__handling__depository` ,then re-build-ing
`base__error__handle` is not called ,because its external */ //
    <
        data__type /*
must not be `_future__listen_ing__state<data__type>` ,nor `base__issue__simple`
can be nil-able */
        > extends base__depository__base {
  base__asyn___value__handling__depository__raw(
    final asyn___value<data__type> value,
  ) : _value = _asyn___value__handling__state<data__type>(
          value,
        ) {
    value.handle(
      (final data) {
        final handling = _value__handling();

        _value = data;

        handling.event__announce();
      },
      (final error, final trace) {
        final handling = _value__handling();

        _value = _error__state(
          error,
          trace,
        );

        handling.event__announce();
      },
    );
  }

  base__asyn___value__handling__depository__raw.data(
    final data__type data,
  ) : _value = data; /*
if `.future = asyn___value.value( ... )` 
  ,`future__handling__widget.activity__indicate` is invoked ,at-least once 
    ,hence not instant ,while `store.data( ... )` is most efficient */

  dynamic /* union ( data , error , union ( future | listening | identity ) ) */ _value;

  bool _value__data__ok() {
    return (_value is data__type);
  }

  data__type //
      _value__data() {
    return (_value as data__type);
  }

  bool _value__error__ok() {
    return (_value is _error__state);
  }

  _error__state //
      _value__error() {
    return (_value as _error__state);
  }

  bool _value__handling__ok() {
    return (_value is _asyn___value__handling__state<data__type>);
  }

  _asyn___value__handling__state<data__type> //
      _value__handling() {
    return (_value as _asyn___value__handling__state<data__type>);
  }

  /*bool _de_init___ok()
    { return (_value == NIL); }*/

  @override
  void dispose() {
    if (_value__handling__ok()) {
      _value__handling().dispose();
    }

    _value = NIL; /* un-necessary */
  }
}

class _error__state {
  const _error__state(
    this.error,
    this.trace,
  );

  final Object error;
  final StackTrace trace;
}

class _asyn___value__handling__state<data__type> //
    extends base__event__channel__unicast__depository {
  _asyn___value__handling__state(
    this.future,
  ) /*: identity = Object()*/;

  final asyn___value<data__type> future /*
prefer creating the `future` as soon as possible, to shorten the time taken, to resolve */
      ;
  //final Object identity;/* no need */
}

typedef base__asyn___value__handling__widget__success__indicate__function__format<data__type> //
    = base__widget Function(base__widget__tree__node, data__type);

typedef base__asyn___value__handling__widget__failure__indicate__function__format //
    = base__widget Function(
  base__widget__tree__node,
  Object error,
  StackTrace trace,
);

base__widget base__failure__indicate__widget(
  final base__widget__tree__node context,
  final Object error,
  final StackTrace trace,
) {
  return ErrorWidget(
    "${error.convert__string()}\n\n\n${trace.convert__string()}",
  );
}

base__widget base__asyn___value__handling__widget<data__type>(
  final base__widget__tree__node context,
  final base__asyn___value__handling__depository__raw<data__type> depository, {
  required final base__asyn___value__handling__widget__success__indicate__function__format<data__type> success__indicate,
  required final base__asyn___value__handling__widget__failure__indicate__function__format failure__indicate,
  required final base__widget__build__function__format activity__indicate,
  /*
`success__indicate` ,`error__indicate` ,`activity__indicate` ,are called, only if ,the widget is mounted in the tree */
}) /*
*`__indicate` can be called any number of times ,like `widget.build`
on failure ,auto.-handles the issue
to achieve {`success`|`failure`}`__handle` ,like for navigat-ion ,on success/failure
  ,prefer `.future.then` ,which has equal effect
    ,although `procedure:schedule` can also be used ,but should be avoided ,unless necessary
handles `asyn___value.value( ... )` ,but should be avoided ,instead `.store = future__handling__depository.data ( ... )` should be prefer-ed
`flutter/widgets/async.dart:asyn___valueBuilder<T>` should not be used ,because :
  - it requires the `data__type` to be non-nil (although not doc.ed)
    ,because ,`snapshot.data` is also nil-able ,hence the the data can be nil ,silently
    ,hence nil-able types need to be wrapped ,as `({data__type? data})`(`Record`)
  - does not have ,a fast-path ,for already-completed ,futures */
{
  if (depository._value__data__ok()) {
    return success__indicate(
      context,
      depository._value__data(),
    );
  }

  if (depository._value__error__ok()) {
    final value = depository._value__error();

    return failure__indicate(
      context,
      value.error,
      value.trace,
    );
  }

  if (depository._value__handling__ok().not) {
    throw Exception();
  }

  return base__event__channel__unicast__handling__widget(
    depository: depository._value__handling(),
    build: (final context_1) {
      if (depository._value__data__ok()) {
        return success__indicate(
          context_1,
          depository._value__data(),
        );
      }

      if (depository._value__handling__ok()) {
        return activity__indicate(
          context_1,
        );
      }

      if (depository._value__error__ok().not) {
        throw Exception();
      }

      final value = depository._value__error();

      return failure__indicate(
        context_1,
        value.error,
        value.trace,
      );
    },
  );
}

/*@immutable
class future__handling__widget<data__type> /*
navigate ,on success ,can be achiev-ed ,through `procedure:schedule` ,like `
future__handling__widget(
  future: future,
  success__indicate__build: (final context, final data) {
    procedure__schedule(() {
      context.navigate(
        page__build: (final _) => page(),
      );
    });
    return empty__widget;
  },
);`
inspired ,from `flutter/widgets/async.dart:asyn___valueBuilder<T>` 
  ,which required the `data__type` to be non-`null`(hence marked `extends Object`)
    ,because "data__type?" has issues ,with "snapshot.data" ,which is also  null-able
    ,hence `null`-able types needed to be wrapped ,as `({data__type? data})`(`Record`) */ //
    extends StatefulWidget {
  const future__handling__widget({
    super.key,
    required this.future,
    required this.success__indicate__build,
    this.error__indicate__build,
    this.activity__indicate__build,
  });

  final asyn___value<data__type> future /*
refrain creating the `future` in {`StatelessWidget`|`State`}`.build`(which are expected to be nullipotent) 
  ,unless always-{real-time|un-cached} data is required 
    ,either in ,event-emitted proc.s ,like `press__handle` 
    ,or as a member of `State`-derived class
prefer creating the `future` as soon as possible, to shorten the time taken, to resolve */
      ;

  final Widget Function(base__widget__tree__node, data__type) success__indicate__build;
  final Widget Function(base__widget__tree__node, Object, StackTrace?)? error__indicate__build;
  final Widget Function(base__widget__tree__node)? activity__indicate__build; /*
`success__indicate` ,`error__indicate` ,`activity__indicate` ,are called, only if ,the widget is mounted in the tree */

  @override
  State<future__handling__widget<data__type>> createState() => //
      _future__handling__widget__state<data__type>();
}

class _future__handling__widget__state<data__type> /*
forked ,from `flutter/widgets/async.dart:_asyn___valueBuilderState<T>` */ //
    extends State<future__handling__widget<data__type>> {
  Object? _identity;

  late data__type _data;
  base__error? _other;
  var future__complete__ok = NO;

  @override
  void initState() {
    super.initState();

    _subscribe();
  }

  @override
  void didUpdateWidget(
    final future__handling__widget<data__type> widget__old,
  ) {
    super.didUpdateWidget(widget__old);

    if (widget.future == widget__old.future) {
      return;
    }

    if (_identity != null) {
      _de_subscribe();
    }

    _subscribe();
  }

  @override
  Widget build(final BuildContext context) {
    if (future__complete__ok) {
      final _other_ = _other;
      if (_other_ == null) {
        return widget.success__indicate__build(
          context,
          _data,
        );
      }

      final error__indicate = widget.error__indicate__build;
      if (error__indicate != null) {
        return error__indicate(
          context,
          _other_.error,
          _other_.trace,
        );
      } else {
        final trace = _other_.trace;

        if (trace != null) {
          return ErrorWidget(
            "${_other_.error}\n\n\n$trace",
          );
        }

        return ErrorWidget(
          _other_.error,
        );
      }
    }

    final activity__indicate = widget.activity__indicate__build;
    if (activity__indicate != null) {
      return activity__indicate(
        context,
      );
    } else {
      return base__indicate__activity__fragment();
    }
  }

  @override
  void dispose() {
    _de_subscribe();

    super.dispose();
  }

  void _subscribe() {
    final _identity1 = (_identity = Object());

    widget.future.then<void>(
      (final data__type data) {
        if (_identity == _identity1) {
          _data = data;

          future__complete__ok = OK;

          re_build();
        }
      },
      onError: (
        final Object error,
        final StackTrace trace,
      ) {
        if (_identity == _identity1) {
          _other = base__error(
            error,
            trace,
          );

          future__complete__ok = OK;

          re_build();
        }
      },
    );
  }

  void _de_subscribe() {
    _identity = NIL;

    if (future__complete__ok) {
      _other = NIL;
      future__complete__ok = NO;
    }
  }
}*/

/*class future__widget<
        message__type extends Object /*
to prevent  null-able types
  because "data_type?" has issues ,with "snapshot.data" ,which is also  null-able
  prefer wrapped ,as "({data_type? data})"("Record") */
        > /*
inspired from "flutter/widgets/async.dart:asyn___valueBuilder<T>" */ //
    extends StatelessWidget {
  const future__widget({
    super.key,
    required this.future,
    required this.success__indicate,
    required this.error__indicate,
    required this.activity__indicate,
  });

  final asyn___value<message__type> future /*
prefer creating the `future`, as soon as possible, to shorten the time taken, to resolve */
      ;
  final Widget Function(base__widget__tree__node, message__type) success__indicate /*
called, if the widget is mounted in the tree */
      ;
  final Widget Function(base__widget__tree__node, Object, StackTrace?)? error__indicate;
  final Widget Function(base__widget__tree__node)? activity__indicate;

  @override
  Widget build(final context) {
    return asyn___valueBuilder(
      future: future,
      builder: (final context, final snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (error__indicate != null) {
              return error__indicate!(
                context,
                snapshot.error!,
                snapshot.stackTrace,
              );
            } else {
              final trace = snapshot.stackTrace;

              return ErrorWidget(
                (snapshot.error!.toString() + //
                    ((trace != null) ? "\n\n\n$trace" : empty__string)),
              );
            }
          } else {
            if (snapshot.data == null) {
              throw "exception :\"(future_build.asyn___valueBuilder.builder.snapshot.data ==  null)\"";
            }

            return success__indicate(
              context,
              snapshot.data!,
            );
          }
        } else {
          if (activity__indicate != null) {
            return activity__indicate!(
              context,
            );
          } else {
            return base__indicate__activity__fragment();
          }
        }
      },
    );
  }
}*/
