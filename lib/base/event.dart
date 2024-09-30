part of "_.dart";

abstract class base__event__channel__protocol {
  void event__announce();
}

//

class base__event__channel__unicast //
    extends procedure__empty__container__definitive //
    implements
        base__event__channel__protocol {
  @override
  void event__announce() {
    invoke();
  }
}

//

abstract class base__event__channel__broadcast__protocol /*
`descriptor` is needed
  ,because ,otherwise `procedure__empty__format` is the implicit and only `descriptor`
    ,and the channel can invoke only it ,because it does not accept any arg.
  one-of-the-most prominent use-case of descriptor is `widget:tree:node:::base:graphics:dimension:2:u_:i_::build:again` */ //
    <descriptor__type extends Object> //
    implements
        base__event__channel__protocol {
  bool descriptors__contains__ok(
    final descriptor__type descriptor,
  );

  void descriptors__add(
    final descriptor__type descriptor,
  );

  void descriptors__remove(
    final descriptor__type descriptor,
  );

  void descriptors__flush();
}

abstract class base__event__channel__broadcast__dispose__protocol //
    <descriptor__type extends Object> //
    implements
        base__event__channel__broadcast__protocol<descriptor__type>,
        base__dispose__protocol {}

//

typedef base__event__invoke__procedure__format //
    <descriptor__type extends Object>
    = base__value__single__procedure__format<descriptor__type>;

class base__event__channel__broadcast /*
`invoke` and `descriptor__equal__ok` are members ,instead of a protocols
  ,only because of dart-lang.'s limitation ,of not allowing impl.ing protocols ,for external composites */ //
    <descriptor__type extends Object> //
    implements
        base__event__channel__broadcast__dispose__protocol<descriptor__type> {
  base__event__channel__broadcast(
    this.invoke, [
    this.descriptor__equal__ok,
    this.debug__name,
  ]) : raw__descriptors = base__accumulation__definitive<descriptor__type>();

  final base__accumulation__definitive<descriptor__type> raw__descriptors;

  final base__event__invoke__procedure__format<descriptor__type> invoke;
  final base__value__equal__ok__function__format<descriptor__type>? descriptor__equal__ok;

  final string? debug__name;

  void debug__print(
    final string path,
  ) {
    if (debug__name != NIL) {
      base__procedure__call__print(
        "$debug__name::$path",
      );
    }
  }

  @override
  void descriptors__add(
    final descriptor__type descriptor,
  ) {
    debug__print(
      "descriptors:add",
    );

    raw__descriptors.add__element(
      descriptor,
    );
  }

  @override
  bool descriptors__contains__ok(
    final descriptor__type descriptor,
  ) {
    var result = NO;

    raw__descriptors.iterate__basic(
      (final e) {
        if ((descriptor__equal__ok ?? base__value__equal__ok<descriptor__type>)(descriptor, e)) {
          result = OK;
        }
      },
    );

    return result;
  }

  uu descriptors__count__raw() {
    return raw__descriptors.elements__count();
  }

  @override
  void descriptors__remove(
    final descriptor__type descriptor,
  ) {
    debug__print(
      "descriptors:remove",
    );

    raw__descriptors.remove__element(
      descriptor,
      base__value__same__ok,
    );
  }

  @override
  void descriptors__flush() {
    debug__print(
      "descriptors:flush",
    );

    raw__descriptors.flush();
  }

  @override
  void event__announce() {
    raw__descriptors.iterate__basic(
      (final descriptor) => invoke(descriptor),
    );
  }

  @override
  void dispose() {
    debug__print(
      "dispose",
    );

    raw__descriptors.dispose();
  }
}

class base__event__channel__broadcast__procedure__empty //
    extends base__event__channel__broadcast<procedure__empty__format> {
  base__event__channel__broadcast__procedure__empty()
      : super(
          base__procedure__empty__invoke,
        );
}

//

class base__event__channels__un_owned__broadcast //
    <descriptor__type extends Object> //
    implements
        base__event__channel__broadcast__dispose__protocol<descriptor__type> {
  base__event__channels__un_owned__broadcast(
    final array<base__event__channel__broadcast__dispose__protocol<descriptor__type>> channels,
  ) : channels__raw = channels;

  final array<base__event__channel__broadcast__dispose__protocol<descriptor__type>> channels__raw;

  void channels__iterate__raw(
    final void Function(
      base__event__channel__broadcast__dispose__protocol<descriptor__type> channel,
    ) operate,
  ) {
    channels__raw.iterate__reverse__basic(
      (final i, final e) => operate(e),
    );
  }

  @override
  void descriptors__add(
    final descriptor__type descriptor,
  ) {
    channels__iterate__raw(
      (final channel) => channel.descriptors__add(descriptor),
    );
  }

  @override
  bool descriptors__contains__ok(
    final descriptor__type descriptor,
  ) {
    var result = NO;

    channels__iterate__raw(
      (final channel) {
        if (channel.descriptors__contains__ok(descriptor)) {
          result = OK;
        }
      },
    );

    return result;
  }

  @override
  void descriptors__remove(
    final descriptor__type descriptor,
  ) {
    channels__iterate__raw(
      (final channel) => channel.descriptors__remove(descriptor),
    );
  }

  @override
  void descriptors__flush() {
    channels__iterate__raw(
      (final channel) => channel.descriptors__flush(),
    );
  }

  @override
  void event__announce() {
    channels__iterate__raw(
      (final channel) => channel.event__announce(),
    );
  }

  @override
  void dispose() {}
}

class base__event__channels__owned__broadcast //
    <descriptor__type extends Object> //
    extends base__event__channels__un_owned__broadcast<descriptor__type> {
  base__event__channels__owned__broadcast(
    super.channels,
  );

  @override
  void dispose() {
    channels__iterate__raw(
      (final channel) => channel.dispose(),
    );

    super.dispose();
  }
}
