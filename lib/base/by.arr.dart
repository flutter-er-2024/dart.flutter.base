part of "_.dart";

/*
  primitive (type): fixed size value, like u8, u16, u24, fp16
  object: allocated value, of struct, like of `struct { u8 id_; };`

  {by__arr|bys}: raw representation of an object(or primitive)
  bytes: un-like by__arr, not raw, but encoded(or serialized)

  encode
    bytes, of primitives
    or in other words, primitives need to be encoded
  serialize
    bytes, of objects
    or in other words, primitives need to be serialized */

final by__arr //
    empty__by__arr = by__arr(0),
    empty__bytes = empty__by__arr;

by__arr by__array__new__generate(
  final uu count,
  final u8 Function(uu i) generate,
) {
  final result = by__arr(count);

  base__iterate__basic(
      count,
      (final i) => //
          (result[i] = generate(i)));

  return result;
}

bool by__array__blank__ok(
  final by__arr bys, {
  final uu? count,
}) /*
  `by__array__b__clear_ed`
  test: ```
      final bys = [0,0,0,0,0,0,0,0];
      by__array__blank__ok(by__arr.fromList(bys+([0,0]..convert__text__representation().print("count")))).convert__text__representation().print("blank?");
      by__array__blank__ok(by__arr.fromList(bys+([1,1]..convert__text__representation().print("count")))).convert__text__representation().print("blank?");
      by__array__blank__ok(by__arr.fromList(bys+([0,1]..convert__text__representation().print("count")))).convert__text__representation().print("blank?");
      by__array__blank__ok(by__arr.fromList(bys+([1,0]..convert__text__representation().print("count")))).convert__text__representation().print("blank?");
``` */
{
  var blank__ok = OK;

  bys.iterate(
    (final _, final element) {
      if (element == 0) {
        return OK;
      }

      blank__ok = NO;
      return NO;
    },
    count: (count ?? bys.bys__count),
  );

  return blank__ok;
}

by__arr by__array__blank(
  final uu count,
) {
  final result = by__arr(count);

  by__array__fill(
    result,
    count: count,
  );

  return result;
}

by__arr by__array__create /* actually init, not create */ (
  final array<uu> bytes, {
  uu? count,
  final uu result__offset = 0,
}) {
  final result = by__arr(count ??= bytes.elements__count);

  base__copy(
    result,
    bytes,
    dest__offset: result__offset,
    count: count,
  );

  return result;
}

by__arr by__array__array__catinate(final array<by__arr> a) {
  final uu byteArrayCount = a.length;

  uu //
      i = 0,
      totalByteCount = 0;

  while (i < byteArrayCount) {
    totalByteCount += a[i++].bys__count;
  }

  final result = by__arr(totalByteCount);

  i = 0;
  uu byteOffset = 0;
  while (i < byteArrayCount) {
    byteOffset = base__copy(
      result /*.buffer.asUint8List(byteOffset)*/,
      a[i++],
      dest__offset: byteOffset,
    ).dest__offset__new;
  }

  return result;
}

by__arr base__by__array__accumulation__convert__by__arr(
  final base__accumulation<by__arr> list, {
  final by__arr? buffer,
  final uu? bytes__count,
}) {
  final by__arr bytes;
  if (buffer != null) {
    bytes = buffer;
  } else {
    if (bytes__count != null) {
      bytes = by__arr(bytes__count);
    } else {
      uu bytes__count_ = 0;

      list.iterate__basic(
        (final bys) {
          bytes__count_ += bys.bys__count;
        },
      );

      bytes = by__arr(bytes__count_);
    }
  }

  var bytes__offset = 0;

  list.iterate__basic(
    (final bys) {
      bytes__offset = base__copy(
        bytes,
        bys,
        dest__offset: bytes__offset,
      ).dest__offset__new;
    },
  );

  return bytes;
}

class base__by__array__accumulation__size__dynamic //
    extends base__by__array__accumulation {
  base__by__array__accumulation__size__dynamic();

  void add__uu(
    final uu value,
  ) =>
      add(
        uu__convert__bytes(
          value,
        ),
      );

  void add__uu__nil_able(
    final uu? value,
  ) =>
      ((value != null) //
          ? add__uu(
              (value + 1),
            )
          : add__byte(0));

  void add__ss(
    final ss value,
  ) =>
      add__uu(
        value,
      );

  void add__bytes(
    final by__arr bys,
  ) {
    add__uu(
      bys.bys__count,
    );
    add(bys);
  }
}

class base__by__array__accumulation__size__static //
    extends base__by__array__accumulation {
  base__by__array__accumulation__size__static();

  void add__uu(
    final uu value,
    final sz value__size,
  ) {
    ls.add__element(
      uu__convert__by__array__little_endian(
        value,
        value__size,
      ),
    );

    bytes__count += value__size;
  }

  void add__uu__nil_able(
    final uu? value,
    final sz value__size,
  ) =>
      ((value != null) //
          ? add__uu(
              (value + 1),
              value__size,
            )
          : add__byte(0));

  void add__ss(
    final ss value,
    final sz value__size,
  ) =>
      add__uu(
        value,
        value__size,
      );

  void add__bytes(
    final by__arr bys,
    final uu bys__count__size,
  ) {
    add__uu(
      bys.bys__count,
      bys__count__size,
    );
    add(bys);
  }
}

class base__by__array__accumulation //
    implements
        base__dispose__protocol {
  base__by__array__accumulation();

  final ls = base__accumulation<by__arr>();

  uu bytes__count = 0;

  uu get bytes__offset => //
      bytes__count;

  void flush() {
    ls.flush();
    bytes__count = 0;
  }

  void shrink() {
    ls.shrink();
  }

  void add(
    final by__arr bytes,
  ) {
    ls.add__element(
      bytes,
    );

    bytes__count += bytes.bys__count;
  }

  void add__byte(
    final by b,
  ) {
    ls.add__element(
      b.u8__convert__by__arr,
    );

    bytes__count += 1;
  }

  by__arr convert__by__arr([
    final by__arr? buffer,
  ]) =>
      base__by__array__accumulation__convert__by__arr(
        ls,
        buffer: (buffer ?? by__arr(bytes__count)),
      );

  /* string convert__str([final bool b_verbose = NO]) {
    uu //
        counter = 0,
        byteOffset = 0;

    final buffer = StringBuffer();

    ls.iterate__basic(
      (final by__arr bytes) {
        final uu byteCount = bytes.length;

        buffer
          ..write("id_: ")
          ..write(counter += 1)
          ..write(", offset: ")
          ..write(byteOffset)
          ..write(", count: ")
          ..write(byteCount);

        if (b_verbose) {
          buffer
            ..write(", bytes: ")
            ..write(bytes);
        }

        byteOffset += byteCount;
      },
    );

    return buffer.toString();
  } */

  @override
  void dispose() {
    ls.dispose();
  }
}

class bytes__kampa {
  bytes__kampa(
    this.bytes, [
    this.bytes__offset = 0,
  ]);

  final by__arr bytes;

  uu bytes__offset;

  bool get iterate__ok => //
      (bytes__offset < bytes.bys__count);

  by__arr bytes__view__full() => //
      bytes.view(
        bytes__offset,
      );

  uu read__uu__fixed(
    final sz size,
  ) {
    final value = by__array__convert__uu__little_endian(
      bytes.view(
        bytes__offset,
      ),
      size,
    );

    bytes__offset += size;

    return value;
  }

  uu? read__uu__fixed__nil_able(
    final sz size,
  ) {
    final value = read__uu__fixed(
      size,
    );

    return ((value != 0) //
        ? (value - 1)
        : NIL);
  }

  ss read__ss__fixed(
    final sz size,
  ) =>
      read__ss__fixed(
        size,
      );

  uu__bytes__convert__result__kampa read__uu() {
    final result = uu__bytes__convert(
      bytes.view(
        bytes__offset,
      ),
    );

    bytes__offset += result.count;

    return result;
  }

  ss__bytes__convert__result__kampa read__ss() => //
      read__ss();

  ({
    uu? value,
    sz count,
  }) read__uu__nil_able() {
    final result = read__uu();

    return (
      value: ((result.value != 0) //
          ? (result.value - 1)
          : NIL),
      count: result.count,
    );
  }

  by read__byte__idempotent() => //
      bytes[bytes__offset];

  by read__byte() => //
      bytes[bytes__offset++];

  by__arr read__view__partial(
    final uu count,
  ) {
    final offset = bytes__offset;

    bytes__offset += count;

    return bytes.view__partial(
      offset,
      count,
    );
  }

  by__arr? read__view__partial__auto__nil_able([
    final sz? count__size,
  ]) {
    final count = ((count__size != null) //
        ? read__uu__fixed(
            count__size,
          )
        : read__uu().value);

    return ((count != 0)
        ? read__view__partial(
            count,
          )
        : NIL);
  }

  by__arr read__view__partial__auto([
    final sz? count__size,
  ]) =>
      (read__view__partial__auto__nil_able(
            count__size,
          ) ??
          empty__by__arr);

  by__arr? read__view__partial__auto__definitive__nil_able /*
`:view` including the `bytes:count` ,as well as `bytes` */
      () {
    final //
        bytes__offset_ = bytes__offset,
        count = uu__bytes__convert(
          bytes.view(
            bytes__offset_,
          ),
        ),
        count_ = count.value;

    if (count_ == 0) {
      bytes__offset += count.count;
      return NIL;
    }

    final count__ = (count_ + count.count);

    bytes__offset += count__;

    return bytes.view__partial(
      bytes__offset_,
      count__,
    );
  }

  by__arr read__view__partial__auto__definitive() => //
      (read__view__partial__auto__definitive__nil_able() ?? empty__by__arr);

  /*by__arr read__view__partial__till(
    final by b,
  ) /*
  result is, previous to, 1st occurance
    while, offset__new is, next to, instead of previous
      hence the index, of occurance, is ignored */
  {
    by__arr result = empty__by__arr;

    array__iterate(
      bytes,
      (final element__id_, final element) {
        if (element != b) {
          return OK;
        }

        final count = (element__id_ - bytes__offset);
        if (count != 0) {
          final offset = bytes__offset;

          bytes__offset += (count + 1);

          result = bytes.view__partial(
            offset,
            count,
          );
        }

        return NO;
      },
      offset: bytes__offset,
    );

    return result;
  }*/
}

uu by__array__convert__uu__little_endian(
  final by__arr bytes,
  final u8 value__size,
) {
  uu //
      result = 0,
      bytes__offset = 0;

  do {
    result |= (bytes[bytes__offset] << (bytes__offset * by__width));
  } while ((bytes__offset += 1) < value__size);

  /*while (bytes__offset < value__size) {
    result |= (bytes[bytes__offset] << (bytes__offset++ * by__width));
  }*/ /* EQUAL result as above loop */

  return result;
}

uu by__array__convert__uu__big_endian(
  final by__arr bytes,
  final u8 value__size,
) {
  uu //
      result = 0,
      bytes__offset = 0;

  do {
    result <<= by__width;
    result |= bytes[bytes__offset];
  } while ((bytes__offset += 1) < value__size);

  return result;
}

void by__array__fill(
  final by__arr dest, {
  final uu? count,
  final by value = 0,
}) =>
    dest.fill(
      value,
      count: count,
    );

extension by__array__extension on by__arr {
  uu get bys__count => //
      lengthInBytes;

  by__arr view__partial(final uu offset, final uu count) => //
      buffer.asUint8List((offset + offsetInBytes), count);

  by__arr view(final uu offset) => //
      view__partial(offset, (bys__count - offset));

  by__arr separate(final uu offset, final uu count) => //
      //sublist(offset, (count + offset));
      by__array__create(
        view__partial(offset, count),
        count: count,
      );
}
