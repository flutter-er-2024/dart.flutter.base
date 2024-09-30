part of "_.dart";

class by__array__kampa {
  static final by__array__kampa empty = //
      by__array__kampa(ffi_.nullptr, 0);

  const by__array__kampa(
    this.ptr,
    this.count,
  );

  final ffi_.Pointer<ffi_.Uint8> ptr;
  final uu count;

  by__arr get arr => //
      ptr.asTypedList(count);

  /* uu? check__equal(
    final by__array__kampa other,
  ) {
    uu? result /* un-equal id_ */;

    final bys = arr;
    other.arr.iterate((final id_, final b) {
      if (b == bys[id_]) //
        return OK;

      result = id_;
      return NO;
    });

    return result;
  } */

  /* bool b__equal(final by__array__kampa other) => //
      ((other.count == count) && (check__equal(other) ==  null)); */

  bool b__same(final by__array__kampa other) => //
      (other.ptr.address == ptr.value);
}

by__array__kampa by__array__alloc(final uu count) => //
    by__array__kampa(
      ffi__mem__alloc<ffi_.Uint8>(count),
      count,
    );

by__array__kampa by__array__aligned__alloc(
  final sz alignment__size,
  uu count /*
  of `alignment__size`s, or aligned-blocks of memory; not bytes */
  ,
) =>
    by__array__kampa(
      ffi__mem__aligned__alloc<ffi_.Uint8>(
        alignment__size,
        (count *= alignment__size),
      ),
      count,
    );

by__arr by__array__convert__bytes(
  final by__array__kampa by__arr,
) =>
    (u64__arr(2)
          ..[0] = by__arr.ptr.address
          ..[1] = by__arr.count)
        .buffer
        .asUint8List();

by__array__kampa by__array__bytes__convert(
  final by__arr bytes,
) =>
    by__array__kampa(
      ffi_.Pointer<ffi_.Uint8>.fromAddress(
        by__array__convert__uu__little_endian(
          bytes,
          u64__size,
        ),
      ),
      uu__bytes__convert(
        bytes.view(
          u64__size,
        ),
      ).value,
    );

void by__array__free(
  final by__array__kampa arr,
) =>
    ffi__mem__free(arr.ptr);
