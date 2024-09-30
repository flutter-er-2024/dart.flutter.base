part of "_.dart";

typedef asyn___promise<value__type> //
    = async.Completer<value__type>;

typedef asyn___value<value__type> //
    = Future<value__type>;

typedef asyn___value__basic<value__type> /*
always-succeeding/never-failing edition of asyn.-value
usable in retry-based caching/buffering ,and internal ,or mem.-only APIs */ //
    = asyn___value<value__type>;

typedef asyn___value__hybrid<value__type> /*
like `UNION (asyn_:value<value:type> ,value:type)`
should be avoided ,because mixing asyn. and syn. ,leads to asyn. (just-like math.'s negative and positive signs (respectively)) */ //
    = async.FutureOr<value__type>;

typedef asyn___value__basic__hybrid<value__type> //
    = asyn___value__hybrid<value__type>;

typedef asyn___delay //
    = async.Timer;

final empty__asyn___value__void = asyn___value<void>.value(
  NIL,
);

void asyn___schedule(
  final procedure__empty__format proc_,
) {
  async.scheduleMicrotask(
    proc_,
  );
}

extension asyn___procedure__schedule__extension //
    on procedure__empty__format {
  void schedule__asyn_() {
    asyn___schedule(
      this,
    );
  }
}

typedef asyn___value__value__handle__proc_ //
    <value__type, result__type> //
    = asyn___value__hybrid<result__type> //
        Function(
  value__type value,
);

extension asyn___value__extension //
    <value__type> //
    on asyn___value<value__type> {
  asyn___value<result__type> //
      handle<result__type>(
    final asyn___value__value__handle__proc_<value__type, result__type> value__handle,
    final base__error__handle__proc_? error__handle,
  ) {
    return then<result__type>(
      value__handle,
      onError: /*((error__handle != null) //
          ? (final Object e, final StackTrace t) {
              return error__handle(e, t);
            }
          : NIL)*/
          error__handle,
    );
  }
}

extension asyn___value__void__extension //
    on asyn___value<void> {
  void handle__basic(
    final procedure__empty__format value__handle, [
    final base__error__handle__proc_? error__handle,
  ]) {
    handle(
      (final _) => value__handle(),
      error__handle,
    );
  }
}

/*extension asyn___value__void__extension //
    on asyn___value<void> {
  asyn___value<void> //
      void__then__simple<error__type extends Object>(
    final procedure__empty__format proc_, [
    final base__error__handle__proc_<error__type>? error__handle,
  ]) {
    return then__simple<void, error__type>(
      (final _) {
        return proc_();
      },
      error__handle,
    );
  }
}*/
