part of "../_.dart";

void sqlite__test() {
  report__Object(
    sqlite__info(),
    "sqlite__info",
  );

  const //
      table__name = "artists",
      column__info__arr = [
        sqlite__column__info__kampa(
          name: "name",
          type: sqlite__data__base__table__column__type.TEXT,
        ),
      ];

  final db = sqlite__data__base__open__memory(
    directory__temporary__path__absolute: storage__directory__temporary__path(),
    table__name: table__name,
    column__info__arr: column__info__arr,
  );

  sqlite__table__row__array__add(
    db: db,
    table__name: table__name,
    column__info__arr: column__info__arr,
    row__arr: [
      ["The Beatles"],
      ["Led Zeppelin"],
      ["The Who"],
      ["Nirvana"],
    ],
  );

  final row__arr = sqlite__table__row__arr(
    db: db,
    table__name: table__name,
    column__info__arr: column__info__arr,
    result__column__info__arr:  null,
    conditions: (column__info__arr[0].name + " LIKE ?"),
    parameter__arr: ["The %"],
  ) //
    ..iterate__basic((final row__id_, final row) {
      report__arr(
        row,
        "row__arr[$row__id_]",
        Object__nil_able__report,
      );
    });

  db.dispose();
}

void data__fetch__manager__test() {
  const //
      data__array__count = 1500,
      data__array__offset = 0;

  [
    data__fetch__manager(
      data__array__initial:  null,
      data__array__fetch: (final block__id_) {
        final data__id__offset__count = data__fetch__block__id__convert__data__id__offset__count(
          block__id..convert__text__representation().print("block__id"),
          data__array__count,
        )..convert__text__representation().print("data__id__offset__count");

        if ((data__id__offset__count.data__array__count + data__id__offset__count.data__id__offset) > data__array__count) //
          throw "il-legal memory access $data__array__count";

        return array__new__generate(
          data__id__offset__count.data__array__count,
          (final i) => (i + data__id__offset__count.data__id__offset),
        );
      },
      data__array__count: data__array__count,
      b__progression__reverse: NO,
    ),
    data__fetch__manager(
      data__array__initial: array__new__generate(
        (data__cluster__data__array__count__max + 1),
        (final i) => i,
      ),
      data__array__fetch: (final block__id_) {
        throw Error();
      },
      data__array__count: data__array__count,
      b__progression__reverse: NO,
    ),
  ].iterate__basic((final _, final fetch_man) {
    report__arr(
      fetch_man.data__block__arr,
      "fetch_man.data__block__arr",
      (final data__block) {
        data__block.cluster__id_.convert__text__representation().print("data__block.cluster__id");
        data__block.block__data__arr.convert__text__representation().print("data__block.block__data__arr");
      },
    );

    base__iterate__basic(
      data__array__count,
      (final data__id_) {
        final data = fetch_man.data(
          data__id_,
        );

        if (data != data__id_) //
          throw "$data != $data__id";

        report__info("$data OK");
      },
      data__array__offset,
    );
  });
}

void image__test() {
  const //
      width = 4,
      height = 3,
      dimension = (width * height);

  [
    (111, 111, b__alpha: OK),
    (55, 222, b__alpha: NO),
  ].iterate__basic((final case__id_, final values) {
    final //
        channel__count = (values.b__alpha ? 4 : 3),
        image = by__array__array__catinate(
          array__new__generate(
            dimension,
            (final _) => //
                by__array__new__generate(
                    channel__count,
                    (final iter) => //
                        (iter + 1)),
          ),
        );

    image
      ..[(channel__count - 1) + ((dimension - 2) * channel__count)] = values.$1
      ..[(channel__count - 1) + ((dimension - 1) * channel__count)] = values.$2;

    report__bys(image, "image");

    image__convert__bytes(
      image,
      width: width,
      height: height,
      b__alpha: values.b__alpha,
    );
  });

  {
    final //
        file__bytes = io.File(
          ("/dev/shm/" /*"p.jpg"*/ "p1.png"),
        ).readAsBytesSync(),
        decoder = image.PngDecoder(),
        b__valid_ = decoder.isValidFile(file__bytes);

    if (!b__valid_) //
      throw "file NOT valid.";

    report__uu(
      file__bytes.count,
      "file__bytes.count",
    );

    final //
        image = decoder.decode(file__bytes)!,
        image__buffer = image.buffer;

    report__Object(
      image.format,
      "image.format",
    );
    report__uu(
      image.width,
      "image.width",
    );
    report__uu(
      image.height,
      "image.height",
    );
    report__uu(
      image.bitsPerChannel,
      "image.bitsPerChannel",
    );
    report__uu(
      image.numChannels,
      "image.numChannels",
    );
    report__uu(
      image__buffer.lengthInBytes,
      "image__buffer.count",
    );

    image__convert__bytes(
      image__buffer.asUint8List(),
      width: image.width,
      height: image.height,
      b__alpha: NO,
    );
  }
}

void str__wide__rich__test() {
  [
    (r"abc\w\"
        r"abc\\`xyz\w\"
        "abc\n123\\cd\\") /* text-style */,
    (r"\sym\156;"
        r"\img\123;78:89;") /* media */,
    (r"\tbl\"
        r"11a:2;"
        r"12\|3\||456|abc|"
        r"\|789|01\|\|\|2|def|") /* table */,
  ].iterate__basic((final _, final s) {
    str__wide__rich__bytes__convert(
      str__wide__rich__convert__bytes(
        string__unicode__convert__wstr(
          s,
        ),
      ),
    );

    base__print__blank(3);
  });
}

void base__storage__file__native__linux__test() {
  final s = base__storage__file__native__linux__open("/tmp/m.c");

  base__storage__file__native__linux__block__size__check(s);
  base__storage__file__native__linux__size(s);

  /*base__storage__file__native__linux__block__size__block_device(s);
  base__storage__file__native__linux__size__block_device(s);*/

  final buf = by__array__alloc(base__storage__file__block__size.size);

  /*by__array__fill(
    buf.arr,
    count: base__storage__file__block__size.size,
    value: ch__ascii__non_printable__line_feed,
  );

  base__copy(
    buf.arr,
    string__ascii__convert__str("#define ABC 123").bytes,
    dest__offset: 2,
  );

  report__bys(buf.arr, "buf");

  report__str(str(buf.arr), "buf.string");*/

  base__storage__file__native__linux__operate(
    s,
    buf.ptr,
    base__storage__file__block__size.size,
    base__storage__file__block__size.size,
    NO,
  );

  report__bys(buf.arr, "buf");

  report__str(str(buf.arr), "buf.string");

  by__array__free(buf);

  base__storage__file__native__linux__sync(s);
  base__storage__file__native__linux__close(s);
}

void wstr__test() {
  const s = "abc123xyz😁";

  s
    ..convert__text__representation().print("string")
    ..codeUnits.convert__text__representation().print("..code_unit_s");

  final //
      ws = string__unicode__convert__wstr(s, 1)..convert__text__representation().print("ws"),
      bys = wstr__convert__bytes(ws)..convert__text__representation().print("bys"),
      chars = wstr__convert__char__unicode__arr(bys)..convert__text__representation().print("chars"),
      bys__fixed = wstr__convert__bytes(ws, u64__size)..convert__text__representation().print("bys__fixed"),
      chars__fixed = wstr__convert__char__unicode__arr(bys__fixed, u64__size)..convert__text__representation().print("chars__fixed"),
      ews = string__unicode__convert__wstr(s, 1, OK)..convert__text__representation().print("ews"),
      ebys = wstr__convert__bytes(ews)..convert__text__representation().print("ebys"),
      echars = wstr__convert__char__unicode__arr(ebys,  null, OK)..convert__text__representation().print("echars");
}

void report__test() {
  report__uu(
    123,
    "uu",
    "label",
  );

  report__fpv(
    123,
    "fpv",
    "label",
  );

  report__string(
    "abc",
    "string",
    "label",
  );

  report__Object(
    "abc",
    "string as Object?",
    "label",
  );

  report__str(
    string__ascii__convert__str("xyz"),
    "str",
    "label",
  );

  {
/*
  `u8__limit` is the threshold, in `report__arr`, to decide the tuncat-ion of, the report of the elements */

    report__arr(
      array<uu>.generate(
        (u8__limit - 1),
        (final iter) => //
            (iter + 1),
        growable: NO,
      ),
      uu__report,
      "small array",
      "label_",
    );

    report__arr(
      array<uu>.generate(
        u8__limit,
        (final iter) => //
            (iter + 1),
        growable: NO,
      ),
      uu__report,
      "perfect array",
      "label_",
    );

    report__arr(
      array<uu>.generate(
        (u8__limit + 1),
        (final iter) => //
            (iter + 1),
        growable: NO,
      ),
      uu__report,
      "just a bit large, array",
      "label_",
    );

    report__arr(
      array<uu>.generate(
        (u8__limit + 10),
        (final iter) => //
            (iter + 1),
        growable: NO,
      ),
      uu__report,
      "large array",
      "label_",
    );

    report__bys(
      by__arr.fromList(array<by>.generate(
        (u8__limit + 10),
        (final iter) => //
            (iter + 1),
        growable: NO,
      )),
      "byte array",
      "label_",
    );
  }

  report__info(
    "info",
    "label___",
  );

  {
    base__function__call__print(
      "none",
       null,
      "label____",
    );

    base__function__call__print(
      "none",
      () {
        report__kampa__member__type__value(
          "arg",
           null,
          Object__report,
        );

        report__kampa__member__type__value(
          "arg_",
          ("arg " * 2),
          string__report,
        );
      },
      "label____",
    );
  }

  base__print__blank();
}

void str__search__de_limiter__arr(
  final by__arr encodedBytes,
  final string encoder_name, {
  final bool b__verbose_output = NO,
}) {
  final List<int> possibleDeLimiters = <int>[];

  final int byteCount = encodedBytes.length;

  if (b__verbose_output) {
    byteCount.convert__text__representation().print("byteCount");
  }

  for (int charCode = 0; charCode < u8__limit; charCode += 1) {
    bool isCharCodeAbsent = OK;

    int byteCounter = 0;
    while (byteCounter < byteCount) {
      if ((encodedBytes[byteCounter++] == charCode) && isCharCodeAbsent) {
        isCharCodeAbsent = NO;

        break;
      }
    }

    if (isCharCodeAbsent) {
      possibleDeLimiters.add(charCode);
    } else {
      final int encounterPosition;
      if (b__verbose_output) {
        report__info("`encodedBytes[${(encounterPosition = (byteCounter - 1))}] == charCode`" +
            char__colon + //
            "\"${encodedBytes[encounterPosition]} == $charCode\"");
      }
    }
  }

  report__info((possibleDeLimiters.isEmpty //
          ? "NO"
          : possibleDeLimiters.join(", ")) + //
      (b__verbose_output //
          ? " charCodes can be used as de-limiter(or separator), in $encoder_name encoded strings"
          : empty__string));
}

void bytes__test() {
  final //
      bys = by__arr.fromList(array<u8>.generate(
        99,
        (final u) => (u + 1),
        growable: NO,
      ))
        ..convert__text__representation().print("bys"),
      offset__ptr = base__value__proxy__kampa<uu>(0);

  bytes__read__view__till(bys, offset__ptr, 95).convert__text__representation().print("bys.new");
  offset__ptr.value.convert__text__representation().print("offset");

  bytes__read__view__till(bys, offset__ptr, 99).convert__text__representation().print("bys.new_");
  offset__ptr.value.convert__text__representation().print("offset_");
}

void list__test() {
  final ls = list<uu>();

  void print_(final string id_) {
    report__arr(ls.elements, "ls.$id", uu__nil_able__report);
    report__uu(ls.elements__count__current, "ls.elements__count__current");
  }

  print_("before");

  ls.add(1);
  print_("add.first");

  ls.add(2);
  print_("add.second");

  base__iterate__basic(5, ls.add, 3);

  print_("add.all");

  void remove(
    final uu value,
    final string print__id_,
  ) {
    ls.remove__value(value);
    print_("removed." + print__id_);
  }

  remove(1, "1 (first element)");
  remove(3, "3 (second element)");
  remove(5, "5 (middle element)");
  remove(6, "6 (second-last element)");
  remove(7, "7 (last element)");
  remove(2, "2"); /* just to reach the next case */
  remove(4, "4 (only element)");
}

void stack__test() {
  final stack = base__stack<uu>();

  void print_() => //
      stack
        ..convert__str(OK).convert__text__representation().print("stack")
        ..iterate((final element) {
          element.convert__text__representation().print("stack.element");

          return OK;
        });

  const uu count = 3;

  print_();

  base__iterate(count, (final iter) {
    stack.add(iter);
    print_();

    return OK;
  });

  base__iterate(count, (final _) {
    stack.remove();
    print_();

    return OK;
  });

  stack.remove();
  print_();
}

void storage__test() {
  void print_(
    final uu i,
    final storage__alignment__kampa alignment,
    final string s,
  ) {
    uu__b__aligned(i, alignment.size).convert__text__representation().print("$s-aligned?");
    uu__aligned__basic__1(i, alignment.shift__count).convert__text__representation().print("$s-aligned.");

    storage__count__max(
      i,
      (storage__offset__aligned(i, alignment)..convert__text__representation().print("offset.$s-aligned.")).buffer__offset,
      alignment,
    ).convert__text__representation().print("count.$s-aligned.");
    print__info(empty__string);
  }

  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 24, 25, 30, 100, 250, 500, 600, 2000, 4000, 5000, 7000, 8000, 9000, 10000].iterate__basic((final _, final element) {
    element.convert__text__representation().print("element");
    print__info(empty__string);

    print_(element, alignment__mem, "mem");
    print_(element, alignment__disk, "disk");
    print_(element, alignment__flash, "flash");

    print__info("\n\n");
  });
}

void base__storage__file__fast__test() {
  if (base__storage__file__block__size.size != alignment__flash.size) {
    print__info("${base__storage__file__block__size.size}(base__storage__file__block__size.size) MUST equal ${alignment__flash.size}");
  }

  final //
      storage__size = (16 * base__storage__file__block__size.size),
      bys = by__arr(storage__size),
      storage = storage__memory__kampa.init() //
        ..write(by__arr(storage__size), storage__size, 0),
      storage__buffer = storage.storage.arr,
      pool = base__storage__file__fast__kampa.init(storage);

  uu _check__value = 0;
  void check(
    final u8 id_,
    final uu count,
    final uu offset,
  ) {
    final uu value = (_check__value += 1)..convert__text__representation().print("value");

    by__array__fill(
      storage__buffer,
      count: storage__size,
    );

    by__array__fill(
      bys,
      count: count,
      value: value,
    );

    pool
      ..write(bys, count, offset)
      ..read(bys, count, offset)
      ..sync()
      ..flush();

    final //
        offset_ = storage__buffer.indexOf(value),
        count_ = ((storage__buffer.lastIndexOf(value) + 1) - offset_);

    if (debug__report_ing__verbose__ok) {
      offset_.convert__text__representation().print("offset_");
      count_.convert__text__representation().print("count_");
    }

    if (count != 0) {
      if (offset_ != offset) {
        throw "offset mis-match, at $id_: ($offset_ != $offset)";
      }

      if (count_ != count) {
        throw "count mis-match, at $id_: ($count_ != $count)";
      }
    }

    if (debug__report_ing__verbose__ok) {
      final //
          b__offset__not__min = (offset > 0),
          b__count__not__max = (count < storage__size);

      storage__buffer
          .view(
            (b__offset__not__min ? (offset - 1) : offset),
            (b__count__not__max ? (count + (b__offset__not__min ? 2 : 1)) : count),
          )
          .convert__text__representation().print("storage__buffer.view("
              "${(b__offset__not__min ? "($offset - 1)" : offset)}"
              ", ${(b__count__not__max ? "($count + 1)" : count)})");
    }

    print__info(empty__string);
  }

  {
    final cases = ( //
        /* blank */ /*[ (count: 0, offset: 0), ] +*/ /* handles the case, throws correctly */
        /* negative offset */ /*[ (count: 1, offset: -1), ] +*/ /* handles correctly, throws */ //
        /* single block */
        [
              (count: 256, offset: 0),
              (count: (512 + 256), offset: 32),
            ] +
            /* spanning multiple blocks */ [
              (count: 1024, offset: (base__storage__file__block__size.size - 256)),
              (count: ((3 * base__storage__file__block__size.size) + 1), offset: (base__storage__file__block__size.size - 512 - 256)),
              (count: ((4 * base__storage__file__block__size.size) + 1), offset: (3 * (base__storage__file__block__size.size - 250))),
            ] +
            /* aligned count */ [
              (count: base__storage__file__block__size.size, offset: 64),
              (count: (3 * base__storage__file__block__size.size), offset: 128),
            ] +
            /* aligned offset */ [
              (count: (base__storage__file__block__size.size + 1), offset: (2 * base__storage__file__block__size.size)),
              (count: 2000, offset: (5 * base__storage__file__block__size.size)),
            ] +
            /* aligned count, and offset */ [
              (count: base__storage__file__block__size.size, offset: 0),
              (count: (3 * base__storage__file__block__size.size), offset: 0),
              (count: (3 * base__storage__file__block__size.size), offset: (2 * base__storage__file__block__size.size)),
            ] +
            /* previous, with equality */ [
              (count: base__storage__file__block__size.size, offset: base__storage__file__block__size.size),
              (count: (2 * base__storage__file__block__size.size), offset: (2 * base__storage__file__block__size.size)),
            ] +
            [
              (count: base__storage__file__block__size.size, offset: 1),
              (count: base__storage__file__block__size.size, offset: 90),
              (count: (base__storage__file__block__size.size + 255), offset: 8),
              (count: (3 * base__storage__file__block__size.size), offset: 120),
              (count: ((2 * base__storage__file__block__size.size) + 1), offset: 8000),
            ]);

    if (cases.length > u8__max) {
      throw "`cases.length` MUST be less than $u8__limit; check `_check__value`'s usage";
    }

    cases.iterate__basic((final id_, final range) => //
        check(id_, range.count, range.offset));
  }

  {
    void pool__print() {
      if (debug__report_ing__verbose__ok) //
        pool
              ..store.iterate__basic((final element) => //
                  element.offset.convert__text__representation().print("store.block.offset"))
              ..mod__list.iterate__basic((final element) => //
                  element.offset.convert__text__representation().print("mod__list.block.offset"))
            /*..free__list.iterate__basic((final element) => //
              element.size.convert__text__representation().print("free__list.by__arr.size"))*/
            ;
    }

    pool__print();
    pool.sync();

    pool__print();
    pool.flush();

    /*pool__print();
    pool.free__if__not__needed();*/

    pool__print();
  }
}

void uu__test() {
  final data = [
    (127 << 7 << 7),
    (255 << 8 << 8),
  ]..convert__text__representation().print("ints");

  data.iterate__basic((final index, final element) {
    final bytes = uu__convert__bytes(element..convert__text__representation().print("int"));
    getBits([element], 7).convert__text__representation().print("int.bits");
    getBits(bytes, 8).convert__text__representation().print("int.bytes.bits");

    uu__bytes__convert(bytes)..convert__text__representation().print("new `int`");
  });
}

void str__test() {
  void _(
    final array<by> data,
    final array<by> data__correct,
  ) {
    wstr(by__arr.fromList(data)..convert__text__representation().print("bytes")).bytes__encrypted().convert__text__representation().print("bytes.encrypted");
    data__correct.convert__text__representation().print("data__correct");
  }

  final //
      data = <by>[126, 127, 128, 129, 127, 126, 125],
      data__correct = <by>[ch__encrypt(data[0]), ch__encrypt(data[1]), 128, 129, 127, ch__encrypt(data[5]), ch__encrypt(data[6])],
      data__1 = <by>[129, 128, 126, 125, 124],
      data__1__correct = <by>[129, 128, 126, ch__encrypt(data__1[3]), ch__encrypt(data__1[4])];

  _(data, data__correct);
  _(data__1, data__1__correct);
}

void stream__by__array__test() {
  final controller = StreamController<by__arr>();

  stream__by__array__convert__message__by__arr(
    controller.stream,
    (final by__arr bys) => //
        bys.convert__text__representation().print("bytes"),
    () => //
        print__info("close("),
    error__handle,
  );

  controller
// empty: []
    ..add(empty__by__arr)
// small payload: [3, 0, 0, 0] + [0, 0, 0]
    ..add(3.u8__convert__by__arr)
    ..add(by__arr(1))
    ..add(by__arr(3))
    ..add(by__arr(2))
    ..add(by__arr.fromList(<by>[2, 0, 0, 0] + <by>[0, 0] + <by>[5, 0, 0, 0] + <by>[0, 0, 0, 0, 0] + <by>[0, 0, 0, 0] + <by>[])) /* mixed payload */
    ..close();
}
