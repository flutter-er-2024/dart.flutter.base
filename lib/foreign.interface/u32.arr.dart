part of "_.dart";

class u32__array__kampa {
  static final u32__array__kampa empty = //
      u32__array__kampa(ffi_.nullptr, 0);

  const u32__array__kampa(
    this.ptr,
    this.count,
  );

  final ffi_.Pointer<ffi_.Uint32> ptr;
  final uu count;

  u32__arr get arr => //
      ptr.asTypedList(count);
}

u32__array__kampa u32__array__alloc(
  final uu count,
) =>
    u32__array__kampa(
      ffi__mem__alloc<ffi_.Uint32>(
        (count * u32__size),
      ),
      count,
    );

void u32__array__free(
  final u32__array__kampa arr,
) =>
    ffi__mem__free(
      arr.ptr,
    );
