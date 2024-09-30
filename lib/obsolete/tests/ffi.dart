part of "../_.dart";

void ffi__test() {
  const u8 size__sector = 512;

  final //
      mem = ffi__mem__alloc<ffi.Uint64>(
        3 * size__sector,
      ),
      mem__aligned = ffi__mem__alloc<ffi.Uint64>(
        3 * size__sector,
        size__sector,
      );

  size__sector.toRadixString(2).convert__text__representation().print("size__sector.bits");

  void mem__print(
    final ffi.Pointer<ffi.NativeType> pointer,
    final string id_,
  ) =>
      pointer
        ..address.convert__text__representation().print("$id.addr")
        ..address.toRadixString(2).convert__text__representation().print("$id.addr.bits")
        ..free
        ..address.convert__text__representation().print("$id.free.addr");

  mem__print(mem, "mem");
  mem__print(mem__aligned, "mem__aligned");
}

void main() => //
    ffi__test();
