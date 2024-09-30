part of "_.dart";

const accumulation__capacity__default = 8;

typedef _accumulation__element<element__type> = ({element__type value})? /*
wrap-ed to allow null-able `element:type` */
    ;

class base__accumulation<element__type> /*
much more efficient(both space, and time) ,than linked-list-ing, because :
  - references to next and/or previous, elements, are not stored
  - effective application of processor's memory caching
  - not introduce/push, (huge) overhead, in the {memory-allocation}-manager's system
  - much simple implementation */ //
    implements
        base__dispose__protocol {
  base__accumulation({
    final uu capacity__initial__multiplier = 0,
  })  : _elements = array__new__fill(
          ((capacity__initial__multiplier != 0) //
              ? (accumulation__capacity__default << capacity__initial__multiplier)
              : accumulation__capacity__default),
          null,
        ),
        _elements__count = 0;

  array<_accumulation__element<element__type>> _elements;

  uu _elements__count;

  uu elements__count() => //
      _elements__count;

  bool empty__ok() => //
      (this._elements__count == 0);

  bool empty__not() => //
      (this._elements__count != 0);

  bool contains__ok(
    final element__type element,
  ) {
    var result = NO;

    iterate(
      (final e) {
        if (e == element) {
          result = OK;
          return NO;
        }

        return OK;
      },
    );

    return result;
  }

  void add__element(
    final element__type element,
  ) {
    if /*F*/ (this._elements__count == this._elements.elements__count) {
      /*if (elements__count == 0);*/ /*
not needed ,because its un-likely ,to be less-than `list:capacity:initial` */

      final elements__old = this._elements;

      this._elements = array__new__fill(
        (2 * this._elements__count /*capacity*/),
        null,
      );

      base__copy(
        this._elements,
        elements__old,
        count: this._elements__count,
      );
    }

    this._elements[this._elements__count++] = (value: element);
  }

  element__type element(
    final uu element__id_,
  ) {
    if (NOT(element__id_ < this._elements__count)) {
      throw "element:$element__id_ is not present in the accumulation";
    }

    return this._elements[element__id_]!.value;
  }

  void _iterate__count__valid__ensure(
    final uu? count,
  ) {
    if ((count != null) && (count > this._elements__count)) {
      throw "$count is more than $_elements__count(`elements:count` of the accumulation)";
    }
  }

  void iterate(
    final bool Function(element__type element) operate, {
    final uu? count,
  }) {
    _iterate__count__valid__ensure(
      count,
    );

    _elements.iterate(
      (final _, final e) => operate(e!.value),
      count: (count ?? _elements__count),
    );
  }

  void iterate__basic(
    final void Function(element__type element) operate, {
    final uu? count /*
must not be more than `elements:count` */
    ,
  }) {
    _iterate__count__valid__ensure(
      count,
    );

    _elements.iterate__basic(
      (final _, final e) => operate(e!.value),
      count: (count ?? _elements__count),
    );
  }

  array<element__type> convert__array() {
    return array__new__generate(
      this._elements__count,
      (final i) => this._elements[i]!.value,
    );
  }

  void flush() /*
  size/memory/space is NOT reduced
    but, merely the data, is flush-ed */
  {
    this._elements.fill(
          null,
        );

    this._elements__count = 0;
  }

  void shrink() /*
size reduction, is not exponent-ional
  hence disturbs the growth formula
    so use, only if required */
  {
    if (this.empty__ok()) {
      this._elements /*.clear()*/ = array__new__fill(
        accumulation__capacity__default,
        null,
      );

      this._elements__count = 0;
    } else {
      this._elements = array__new__generate(
        this._elements__count,
        (final i) => this._elements[i],
      );
    }
  }

  @override
  void dispose() {
    this.flush();
    this.shrink();
  }
}

class base__accumulation__definitive<element__type extends Object> /*
`accumulation` with element-removal capability 
  ,at the cost of ,element-access efficiency (due to additional in-direct-ion ,per element) ,and in-efficient iteration
    ,still more efficient than linked-list-ing */ //
    implements
        base__dispose__protocol {
  base__accumulation__definitive({
    final uu capacity__initial__multiplier = 0,
  })  : _elements = array__new__fill(
          ((capacity__initial__multiplier != 0) //
              ? (accumulation__capacity__default << capacity__initial__multiplier)
              : accumulation__capacity__default),
          null,
        ),
        _elements__count = 0,
        _element__last__id_ = 0;

  array<element__type?> _elements;

  uu //
      _elements__count,
      _element__last__id_ /*
for quick `add:element` */
      ;

  uu elements__count() => //
      _elements__count;

  bool empty__ok() => //
      (this._elements__count == 0);

  bool empty__not() => //
      (this._elements__count != 0);

  void flush() /*
  size/memory/space is NOT reduced
    but, merely the data, is flush-ed */
  {
    this._elements.fill(
          null,
        );

    this._elements__count = 0;
    this._element__last__id_ = 0;
  }

  void shrink() /*
  size reduction, is not exponent-ional
    hence disturbs the growth formula
      so use, only if required */
  {
    if (this.empty__ok()) {
      this._elements /*.clear()*/ = array__new__fill(
        accumulation__capacity__default,
        null,
      );

      this._elements__count = 0;
      this._element__last__id_ = 0;
    } else {
      final iteration = base__accumulation__definitive__iteration(this);

      this._elements = array__new__generate(
        this._elements__count,
        (final _) => iteration.element()! /*
will be non-null ,because `list_.elements__count` is expected to be correct */
        ,
      ) /*
`convert__arr` can also be used */
          ;

      this._element__last__id_ = this._elements__count;
    }
  }

  bool contains__ok(
    final element__type element,
  ) {
    var result = NO;

    _elements.iterate(
      (final _, final e) {
        if (e == element) {
          result = OK;
          return NO;
        }

        return OK;
      },
    );

    return result;
  }

  void add__element(
    final element__type element,
  ) {
    if /*F*/ (this._element__last__id_ == this._elements.elements__count) {
      /*if (elements__count == 0);*/ /*
not needed ,because its un-likely ,to be less-than `list:capacity:initial` */

      final elements__old = this._elements;

      this._elements = array__new__fill(
        (2 * this._element__last__id_ /*capacity*/),
        null,
      );

      base__copy(
        this._elements,
        elements__old,
        count: this._element__last__id_,
      );
    }

    this._elements[this._element__last__id_++] = element;
    this._elements__count += 1;
  }

  void remove__element(
    final element__type element,
    final bool Function(
      element__type element,
      element__type other,
    ) element__equal__ok /*base__value__same__ok*/,
  ) /*
  size is NOT reduced */
  {
    final //
        elements = this._elements,
        element__id_ = elements.search__simple(
          (final element_) => //
              ((element_ != null) && //
                  element__equal__ok(element, element_)),
        ) /*
`list:iterate` can also be used */
        ;

    if (element__id_ != null) /* `element` is NOT present, in `elements` */ {
      elements[element__id_] = NIL;
      this._elements__count -= 1;
    }
  }

  void iterate__basic(
    final void Function(element__type element) operate, {
    final uu? count /*
must not be more than `list_.elements__count` */
    ,
  }) {
    final iteration = base__accumulation__definitive__iteration(this);

    base__iterate__basic(
      (count ?? this._elements__count),
      (final _) => //
          operate(
        iteration.element()!,
      ),
    );
  }

  array<element__type> convert__array() {
    var offset = 0;

    return array__new__generate(
      this._elements__count,
      (final i) {
        var result = this._elements[i + offset];

        while (result == null) {
          result = this._elements[i + (offset += 1)] /*
checks not needed ,because `list_.elements__count` is expected to be correct */
              ;
        }

        return result;
      },
    ) /*
`list:iterate` can also be used */
        ;
  }

  element__type element__first() {
    return element(0);
  }

  element__type element(
    uu element__id_,
  ) /*
more efficient ,than `convert:array` 
  ,but only for a few element-access ,not full iteration 
    ,otherwise `iteration` should be preferred */
  {
    element__type? result;

    this._elements.iterate(
      (final _, final e) {
        if (e == null) {
          return OK;
        }

        if (element__id_ == 0) {
          result = e;

          return NO;
        }

        element__id_ -= 1;

        return OK;
      },
    );

    if (result == null) {
      throw "$element__id_(`element:id`) not present";
    }

    return result!;
  }

  base__accumulation__definitive__iteration iteration() /*
more efficient ,than `element` 
  ,for multiple element-access ,but the iteration can only be first-to-last */
  {
    return base__accumulation__definitive__iteration(
      this,
    );
  }

  @override
  void dispose() {
    this.flush();
    this.shrink();
  }
}

class base__accumulation__definitive__iteration /*:forward*/ <element__type extends Object> /*
`flush` must be called ,after calling `_accumulation::accumulation:remove:element` */ //
    implements
        base__dispose__protocol {
  base__accumulation__definitive__iteration(
    this._accumulation,
  ) : _element__id_ = 0;

  final base__accumulation__definitive<element__type> _accumulation;

  uu _element__id_;

  element__type? element /*:next*/ () {
    element__type? result;

    _accumulation._elements.iterate(
      (final element__id_, final element) {
        if /*F*/ (element != null) {
          result = element;
          _element__id_ = (1 + element__id_);

          return false;
        }

        return true;
      },
      offset: _element__id_,
    );

    return result;
  }

  element__type? iterate() => //
      element();

  void flush() {
    _element__id_ = 0;
  }

  @override
  void dispose() {
    flush();
  }
}

base__accumulation<element__type> //
    array__convert__accumulation<element__type>(
  final array<element__type> arr_,
) {
  final result = base__accumulation<element__type>();

  arr_.iterate__basic(
    (final _, final element) {
      result.add__element(
        element,
      );
    },
  );

  return result;
}

void base__array__accumulation__flush<element__type>(
  final base__array__accumulation<element__type> base__array__accumulation_,
) {
  base__array__accumulation_._elements__list.flush();

  base__array__accumulation_.elements__count = 0;
}

void base__array__accumulation__add__array<element__type>(
  final base__array__accumulation<element__type> base__array__accumulation_,
  final array<element__type> arr_,
) {
  base__array__accumulation_._elements__list.add__element(
    arr_,
  );

  base__array__accumulation_.elements__count += arr_.elements__count;
}

array<element__type> base__array__accumulation__convert__array<element__type>(
  final base__array__accumulation<element__type> base__array__accumulation_,
) {
  final result = array__new__fill<element__type?>(
    base__array__accumulation_.elements__count,
    null,
  );

  var offset = 0;

  base__array__accumulation_._elements__list.iterate__basic(
    (final arr_) {
      offset = base__copy(
        result,
        arr_,
        dest__offset: offset,
      ).dest__offset__new;
    },
  );

  return array__new__generate(
    base__array__accumulation_.elements__count,
    (final i) => result[i]!,
  );
}

class base__array__accumulation<element__type> {
  base__array__accumulation();

  final _elements__list = base__accumulation<array<element__type>>();

  uu elements__count = 0;
}

extension accumulation__test__extension //
    on base__accumulation<string> {
  void test() {
    void report() {
      _elements.convert__text__representation().print("elements(${elements__count()})");
    }

    report();

    add__element("first");
    report();

    add__element("second");
    add__element("third");
    add__element("fourth");
    add__element("fifth");
    report();

    contains__ok("second").convert__text__representation().print("contains__ok(\"second\")");
    report();
    contains__ok("second").convert__text__representation().print("contains__ok(\"second\")");
    report();
    contains__ok("sixth").convert__text__representation().print("contains__ok(\"sixth\")");
    report();

    convert__array().convert__text__representation().print("convert:array");
    report();

    add__element("6th");
    add__element("7th");
    report();

    convert__array().convert__text__representation().print("convert:array");
    report();

    iterate__basic((final element) {
      element.convert__text__representation().print("element");
    });
    report();

    shrink();
    report();

    flush();
    report();

    shrink();
    report();
  }
}

extension base__accumulation__definitive__test__extension //
    on base__accumulation__definitive<string> {
  void test() {
    void report() {
      _elements.convert__text__representation().print("elements(${elements__count()})");
    }

    report();

    add__element("first");
    report();

    add__element("second");
    add__element("third");
    add__element("fourth");
    add__element("fifth");
    report();

    bool string__equal__ok(final string a, final string b) => (a == b);

    remove__element("second", string__equal__ok);
    report();
    remove__element("second", string__equal__ok);
    report();
    remove__element("sixth", string__equal__ok);
    report();

    convert__array().convert__text__representation().print("convert:array");
    report();

    add__element("6th");
    add__element("7th");
    add__element("8th");
    add__element("9th");
    add__element("10th");
    report();

    convert__array().convert__text__representation().print("convert:array");
    report();

    iterate__basic((final element) {
      element.convert__text__representation().print("element");
    });
    report();

    shrink();
    report();

    flush();
    report();

    shrink();
    report();
  }
}
