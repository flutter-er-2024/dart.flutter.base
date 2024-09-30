part of "_.dart";

void base__procedure__empty__invoke(
  final procedure__empty__format proc_,
) {
  proc_();
}

typedef base__value__single__procedure__format<value__type> //
    = void Function(value__type value);

void base__procedure__value__single__invoke<value__type>(
  final base__value__single__procedure__format<value__type> proc_,
  final value__type value,
) {
  proc_(
    value,
  );
}

class function__container //
    <type extends Function> /*
needed ,because of dart-lang.'s semantics 
  ,regarding to the equality ,of global ,and `class`-methods ,vs. other function-types (`extension`-methods' ,un-named functions ,and closures) */ //
{
  const function__container(
    this.value,
  );

  final type value;
}

abstract class procedure__empty__container__base {
  const procedure__empty__container__base();

  void invoke();
}

class procedure__empty__container //
    extends procedure__empty__container__base {
  const procedure__empty__container(
    this._value,
  );

  final procedure__empty__format _value;

  @override
  void invoke() => //
      _value();

  void call() => //
      invoke();
}

class procedure__empty__container__definitive /*
`procedure__empty__container` 
  ,with `._value`-management ,like [un-]safe remov-al/replac-ment
app.s :widget(of graphical-user-interface)'s [de-]init ,etc. */ //
    extends procedure__empty__container__base //
    implements
        base__dispose__protocol {
  procedure__empty__container__definitive() //
      : _id_ = 0;

  uu _id_ /*
needed for safe remov-al/re-place
should only used for intra-container equality ,not inter-container 
  ,because the id is container-level ,not program-level
`_id_ uu` is better than `_id_ Object` 
  ,because `uu` uses ,the whole u64 space 
    ,while `Object` uses much less than `u48`-bits 
      ,also much more likeliness-of-conflict 
        ,due to memory re-alloc./re-use/re-cycle */
      ;

  ({
    uu id_,
    procedure__empty__format proc_,
  })? _value;

  uu? _value__id_() => //
      _value?.id_;

  procedure__empty__format? proc_() => //
      _value?.proc_;

  uu re_place__un_safe(
    final procedure__empty__format procedure__new,
  ) {
    final $id_ = _id_++;

    _value = (
      id_: $id_,
      proc_: procedure__new,
    );

    return $id_;
  }

  uu? re_place__safe(
    final uu
        procedure__id_ /*
of currently contain-ed proc. ,not `procedure:new` */
    ,
    final procedure__empty__format procedure__new,
  ) {
    if (procedure__id_ != _value__id_()) {
      return NIL;
    }

    return re_place__un_safe(
      procedure__new,
    );
  }

  uu re_place(
    final procedure__empty__format procedure__new,
  ) =>
      re_place__un_safe(
        procedure__new,
      );

  void re_move__un_safe() {
    _value = NIL;
  }

  bool /*
`NO` for `(proc_()==NIL)` */
      re_move__safe(
    final uu procedure__id_,
  ) {
    if (procedure__id_ != _value__id_()) {
      return NO;
    }

    re_move__un_safe();

    return OK;
  }

  bool re_move(
    final uu procedure__id_,
  ) =>
      re_move__safe(
        procedure__id_,
      );

  @override
  bool invoke() /*
calls the `procedure` ,if available */
  {
    final $proc_ = proc_();

    if ($proc_ == null) {
      return NO;
    }

    $proc_();

    return OK;
  }

  @override
  void dispose() {
    re_move__un_safe();
    /* `_id_ = 0;` is not safe */
  }
}

void
    procedure__empty__container__test() /*
latest run's result :`
                                         (empty:procedure:empty == empty:procedure:empty) :YES\
                                         (empty:procedure:empty == empty:procedure:empty) :NO\
                                         (empty:procedure:empty == empty:procedure:empty) :YES\
                                         (empty:procedure:empty == empty:procedure:empty) :NO\
                                         (empty:procedure:empty == empty:procedure:empty) :YES\
                                         first.re_place: <uu|ss>0\
                                         (empty:procedure:empty == empty:procedure:empty) :NO\
                                         second.re_place: <uu|ss>0\
                                         (empty:procedure:empty == empty:procedure:empty) :YES\
                                         1st container\
                                         2nd container\
                                         (empty:procedure:empty == empty:procedure:empty) :YES\` */
{
  void check(
    final bool condition,
    final string title,
  ) =>
      "$title :${(condition ? "YES" : "NO")}".print();

  check(
    (empty__procedure__empty == empty__procedure__empty),
    "(empty:procedure:empty == empty:procedure:empty)",
  );
  check(
    (() {} == () {}),
    "((){} == (){})",
  );

  final //
      first = procedure__empty__container__definitive(),
      second = procedure__empty__container__definitive();

  check(
    (first == first),
    "(first == first)",
  );

  check(
    (first.invoke == first.invoke),
    "(first.invoke == first.invoke)",
  );

  check(
    (first == second),
    "(first == second)",
  );

  check(
    (first.invoke == second.invoke),
    "(first.invoke == second.invoke)",
  );

  final //
      first__id_ = first.re_place(() {
        "1st container".print();
      })
        ..convert__text__representation().print("first.re_place"),
      second__id_ = second.re_place(() {
        "2nd container".print();
      })
        ..convert__text__representation().print("second.re_place");

  first
    ..invoke()
    ..re_move(first__id_)
    ..invoke();
  second
    ..invoke()
    ..re_move(second__id_)
    ..invoke();
}
