part of "_.dart";

class base__value__proxy /*
like c[++]'s pointer */ //
    <value__type extends Object?> {
  base__value__proxy(
    this.value,
  );

  value__type value;
}

typedef base__value__equal__ok__function__format //
    <value__type>
    = bool Function(
  value__type,
  value__type,
);

bool base__value__equal__ok<value__type>(
  final value__type value,
  final value__type other,
) {
  return (value == other);
}

extension base__value__extension //
    <value__type extends Object> //
    on value__type {
  string convert__string() {
    return toString();
  }
}

string //
    base__value__convert__string //
    <value__type extends Object>(
  final value__type value,
) {
  return value.convert__string();
}

extension base__value__nil_able__extension //
    <value__type extends Object?> on value__type {
  string convert__string() {
    return (this?.toString /* not `convert__string` ,due to dart-lang.'s issues */ () ?? Null__value__string);
  }
}

string //
    base__value__nil_able__convert__string //
    <value__type extends Object?>(
  final value__type value,
) {
  return value.convert__string();
}

/*extension base__value__convert__text__representation__extension //
    <value__type extends Object?> on value__type {
  base__text__representation convert__text__representation() {
    final this_1 = this;

    if (this_1 == null) {
      return Null__text;
    }

    return base__value__convert__text__representation(
      this_1,
      value__type.convert__string(),
    );
  }
}*/ /* dart-lang.'s sub-typing bug */

extension base__value__convert__text__representation__extension //
    on Object? {
  base__text__representation convert__text__representation() {
    final this_1 = this;

    if (this_1 == null) {
      return Null__text;
    }

    return base__value__convert__text__representation(
      this_1,
      Type__convert__string(
        runtimeType,
      ),
    );
  }
}

base__text__representation //
    base__value__convert__text__representation //
    <value__type extends Object>(
  final value__type value,
  final string type__name,
) =>
        base__text__representation(
          "<$type__name>$value",
        );

//

abstract class base__value__alter__event__channel__protocol //
    <value__type> //
    implements
        base__event__channel__protocol {
  value__type value();

  void value__alter__raw(
    final value__type value__new,
  );

  void value__alter__and__announce__raw(
    final value__type value__new,
  );

  bool value__alter__safe(
    final value__type value__new,
  );

  bool value__alter__and__announce__safe(
    final value__type value__new,
  );
}

//

abstract class base__value__alter__event__channel__unicast__dispose__protocol //
    <value__type> //
    implements
        base__value__alter__event__channel__protocol<value__type>,
        base__dispose__protocol {}

class base__value__alter__event__channel__unicast<value__type> /*
`observer` management is all direct */ //
    extends base__event__channel__unicast //
    implements
        base__value__alter__event__channel__unicast__dispose__protocol<value__type> {
  base__value__alter__event__channel__unicast(
    this.__value,
  );

  value__type __value;

  @override
  value__type value() {
    return __value;
  }

  @override
  void value__alter__raw(
    final value__type value__new,
  ) {
    __value = value__new;
  }

  @override
  void value__alter__and__announce__raw(
    final value__type value__new,
  ) {
    value__alter__raw(
      value__new,
    );

    event__announce();
  }

  @override
  bool value__alter__safe(
    final value__type value__new,
  ) {
    if (value__new == __value) {
      return NO;
    }

    __value = value__new;

    return OK;
  }

  @override
  bool value__alter__and__announce__safe(
    final value__type value__new,
  ) {
    if (value__alter__safe(
      value__new,
    ).not) {
      return NO;
    }

    event__announce();

    return OK;
  }
}

//

abstract class base__value__alter__event__channel__broadcast__dispose__protocol //
    <value__type, descriptor__type extends Object> //
    implements
        base__value__alter__event__channel__protocol<value__type>,
        base__event__channel__broadcast__dispose__protocol<descriptor__type> {}

class base__value__alter__event__channel__broadcast //
    <value__type, descriptor__type extends Object> /*
like `dart:flutter:ValueNotifier` */ //
    extends base__event__channel__broadcast<descriptor__type> //
    implements
        base__value__alter__event__channel__broadcast__dispose__protocol<value__type, descriptor__type> {
  base__value__alter__event__channel__broadcast(
    this.value__raw,
    final base__event__invoke__procedure__format<descriptor__type> invoke, [
    final base__value__equal__ok__function__format<descriptor__type>? descriptor__equal__ok,
    final string? debug__name,
  ]) : super(
          invoke,
          descriptor__equal__ok,
          debug__name,
        );

  value__type value__raw;

  @override
  value__type value() {
    return value__raw;
  }

  @override
  void value__alter__raw(
    final value__type value__new,
  ) {
    value__raw = value__new;
  }

  @override
  void value__alter__and__announce__raw(
    final value__type value__new,
  ) {
    value__alter__raw(
      value__new,
    );

    event__announce();
  }

  @override
  bool value__alter__safe(
    final value__type value__new,
  ) {
    if (value__new == value__raw) {
      return NO;
    }

    value__raw = value__new;

    return OK;
  }

  @override
  bool value__alter__and__announce__safe(
    final value__type value__new,
  ) {
    final alter__ok = value__alter__safe(
      value__new,
    );

    if (alter__ok.not) {
      return NO;
    }

    event__announce();

    return OK;
  }
}

//

/* extension base__value__alter__event__channel__broadcast__extension //
    on base__value__alter__event__channel__broadcast<string, uu> {
  void test() {
    void announce(
      final string value,
    ) {
      value__alter__and__announce__safe(value);
      "announc-ed $value".print();
    }

    procedure__empty__format proc_(
      final string title,
      final uu id_,
    ) =>
        () => "$title:listen_er :listened ${value()}".print(id_.toString());

    final //
        first__listen_er = procedure__empty__container__definitive(),
        second__listen_er = procedure__empty__container__definitive();

    descriptors__add(first__listen_er);
    descriptors__add(second__listen_er);

    final //
        first__id_ = first__listen_er.re_place(proc_("first", 0)),
        second__id_ = second__listen_er.re_place(proc_("second", 0));

    announce(111);

    final //
        $first__id_ = first__listen_er.re_place(proc_("first", 1)),
        $second__id_ = second__listen_er.re_place(proc_("second", 1));

    announce(333);

    first__listen_er.re_move(first__id_);
    second__listen_er.re_move(second__id_);

    announce(
        666); /*
NOTE :
  listen-ing was working as before ,and the `re_move` had no action
    ,because `*__id_` ,have been expired(become obsolete) ,and replaced with `$*__id_` */

    first__listen_er.re_move($first__id_);
    second__listen_er.re_move($second__id_);

    announce(999);

    descriptors__remove(first__listen_er);
    descriptors__remove(second__listen_er);

    announce(101010);
  }
} */

/*void broadcast__test() {
  final broadcast = broadcast<void>(
    error__handle,
    () => //
        print__info("broadcast.close()"),
  );

  void print_() => //
      broadcast.message__announce(null);

  print_();

  void f(final _) => print__info(0);
  broadcast.observer__add(f);

  print_();

  void f1(final _) => print__info(1);
  broadcast.observer__add(f1);

  void f2(final _) => print__info(2);
  broadcast.observer__add(f2);

  void f3(final _) => print__info(3);
  broadcast.observer__add(f3);

  print_();

  broadcast.observer__remove(f2 /* middle element */);
  print_();

  broadcast.observer__remove(f3 /* last element */);
  print_();

  broadcast.observer__remove(f /* first element */);
  print_();

  broadcast.observer__remove(f1 /* ONLY element */);
  print_();
}*/
