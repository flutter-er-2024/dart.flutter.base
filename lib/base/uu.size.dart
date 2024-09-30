part of "_.dart";

enum uu__size__id__enum //
{ u8, u16, u24, u32, u48, u64, u96, u128 }

uu__size__id__enum uu__size__convert__id_(
  final sz size,
) {
  switch (size) {
    case u8__size:   return uu__size__id__enum.u8;
    case u16__size:  return uu__size__id__enum.u16;
    case u24__size:  return uu__size__id__enum.u24;
    case u32__size:  return uu__size__id__enum.u32;
    case u48__size:  return uu__size__id__enum.u48;
    case u64__size:  return uu__size__id__enum.u64;
    case u96__size:  return uu__size__id__enum.u96;
    case u128__size: return uu__size__id__enum.u128;

    default: throw "$size(size), is too large, than the limit $u128__size(u128__size)";
  }
}

sz uu__size__id__convert(
  final uu__size__id__enum size__id_,
) {
  switch (size__id_) {
    case uu__size__id__enum.u8:   return u8__size;
    case uu__size__id__enum.u16:  return u16__size;
    case uu__size__id__enum.u24:  return u24__size;
    case uu__size__id__enum.u32:  return u32__size;
    case uu__size__id__enum.u48:  return u48__size;
    case uu__size__id__enum.u64:  return u64__size;
    case uu__size__id__enum.u96:  return u96__size;
    case uu__size__id__enum.u128: return u128__size;

    //default: throw "un-known $size__id_(size:id_)";
  }
}

by__arr uu__cast__bys__basic(
  final uu value,
  final uu__size__id__enum size__id_,
) {
  switch (size__id_) {
    case uu__size__id__enum.u8:   return uu__convert__by__array__little_endian(value, u8__size,);
    case uu__size__id__enum.u16:  return uu__convert__by__array__little_endian(value, u16__size,);
    case uu__size__id__enum.u24:  return uu__convert__by__array__little_endian(value, u24__size,);
    case uu__size__id__enum.u32:  return uu__convert__by__array__little_endian(value, u32__size,);
    case uu__size__id__enum.u48:  return uu__convert__by__array__little_endian(value, u48__size,);
    case uu__size__id__enum.u64:  return uu__convert__by__array__little_endian(value, u64__size,);
    case uu__size__id__enum.u96:  return uu__convert__by__array__little_endian(value, u96__size,);
    case uu__size__id__enum.u128: return uu__convert__by__array__little_endian(value, u128__size,);

    //default: throw "un-known $size__id_(size:id_)";
  }
}

({by__arr bys, sz size,}) uu__cast__bys(
  final uu value,
  final uu__size__id__enum size__id_,
) {
  switch (size__id_) {
    case uu__size__id__enum.u8:   return (bys: uu__convert__by__array__little_endian(value, u8__size,),   size: u8__size,);
    case uu__size__id__enum.u16:  return (bys: uu__convert__by__array__little_endian(value, u16__size,),  size: u16__size,);
    case uu__size__id__enum.u24:  return (bys: uu__convert__by__array__little_endian(value, u24__size,),  size: u24__size,);
    case uu__size__id__enum.u32:  return (bys: uu__convert__by__array__little_endian(value, u32__size,),  size: u32__size,);
    case uu__size__id__enum.u48:  return (bys: uu__convert__by__array__little_endian(value, u48__size,),  size: u48__size,);
    case uu__size__id__enum.u64:  return (bys: uu__convert__by__array__little_endian(value, u64__size,),  size: u64__size,);
    case uu__size__id__enum.u96:  return (bys: uu__convert__by__array__little_endian(value, u96__size,),  size: u96__size,);
    case uu__size__id__enum.u128: return (bys: uu__convert__by__array__little_endian(value, u128__size,), size: u128__size,);

    //default: throw "un-known $size__id_(size:id_)";
  }
}

uu uu__bys__cast__basic(
  final by__arr bys,
  final uu__size__id__enum size__id_,
) {
  switch (size__id_) {
    case uu__size__id__enum.u8:   return by__array__convert__uu__little_endian(bys, u8__size,);
    case uu__size__id__enum.u16:  return by__array__convert__uu__little_endian(bys, u16__size,);
    case uu__size__id__enum.u24:  return by__array__convert__uu__little_endian(bys, u24__size,);
    case uu__size__id__enum.u32:  return by__array__convert__uu__little_endian(bys, u32__size,);
    case uu__size__id__enum.u48:  return by__array__convert__uu__little_endian(bys, u48__size,);
    case uu__size__id__enum.u64:  return by__array__convert__uu__little_endian(bys, u64__size,);
    case uu__size__id__enum.u96:  return by__array__convert__uu__little_endian(bys, u96__size,);
    case uu__size__id__enum.u128: return by__array__convert__uu__little_endian(bys, u128__size,);

    //default: throw "un-known $size__id_(size:id_)";
  }
}

({uu value, sz size,}) uu__bys__cast(
  final by__arr bys,
  final uu__size__id__enum size__id_,
) {
  switch (size__id_) {
    case uu__size__id__enum.u8:   return (value: by__array__convert__uu__little_endian(bys, u8__size,),   size: u8__size,);
    case uu__size__id__enum.u16:  return (value: by__array__convert__uu__little_endian(bys, u16__size,),  size: u16__size,);
    case uu__size__id__enum.u24:  return (value: by__array__convert__uu__little_endian(bys, u24__size,),  size: u24__size,);
    case uu__size__id__enum.u32:  return (value: by__array__convert__uu__little_endian(bys, u32__size,),  size: u32__size,);
    case uu__size__id__enum.u48:  return (value: by__array__convert__uu__little_endian(bys, u48__size,),  size: u48__size,);
    case uu__size__id__enum.u64:  return (value: by__array__convert__uu__little_endian(bys, u64__size,),  size: u64__size,);
    case uu__size__id__enum.u96:  return (value: by__array__convert__uu__little_endian(bys, u96__size,),  size: u96__size,);
    case uu__size__id__enum.u128: return (value: by__array__convert__uu__little_endian(bys, u128__size,), size: u128__size,);

    //default: throw "un-known $size__id_(size:id_)";
  }
}
