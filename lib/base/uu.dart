part of "_.dart";

uu uu__max(
  final sz size,
) {
  final shift__count = ((uu__size - size) * by__width);

  return (((~0 << shift__count) >>> shift__count));
}

by__arr uu__convert__by__array__little_endian(
  uu value,
  sz size,
) /*
`size` must equal `value.size` ,else illegal-access error ,due to `(value != 0)` being the test-condition ,instead of `size` */
{
  final bytes = by__arr(size);

  size /*bytes__iter*/ = 0;
  while (value != /*>*/ 0) {
    bytes[size++] = (value & 255);
    value >>= by__BITS_PER_BYTE;
  }

  return bytes;
}

by__arr uu__convert__by__array__big_endian(
  uu value,
  sz size,
) {
  final by__arr bytes = by__arr(size);

  do {
    bytes[size -= 1] = (value & 255);
    value >>= by__BITS_PER_BYTE;
  } while (size > 0);

  /*while (size-- > 0) {
    bytes[size] = (value & 255);
    value >>= BITS_PER_BYTE;
  }*/ /* EQUAL result as above loop */

  return bytes;
}

/*
  allows encoding integer, of any size (variable-size)

  originally created for `string__convert__by__arr(`(to encode Unicode code-points),
    which had the {en|de}coding process hard-coded, not looped
      because code-points were found to be hard-limited to 3 bytes, to ensure utf-8 compatibility
  discovered independently from "LEB128"
    author did not know about any encoding, other than utf-8; prior to the discovery
      especially NOT LEB128; about which, the author got to know while reading about web-assembly(or wasm)
        ..."integers are encoded using the LEB128 variable-length integer encoding"...(https://webassembly.github.io/spec/core/binary/values.html#integers)

  ..."Protocol Buffers (Protobuf) uses the same encoding"...(https://en.wikipedia.org/wiki/LEB128#Related_encodings)

  function.implementation.initial: June 27, 2023

  forked from `https://en.wikipedia.org/wiki/LEB128#Encode_unsigned_integer`
  original:
```
do {
  byte = low-order 7 bits of value;
  value >>= 7;
  if (value != 0) /* more bytes to come */
    set high-order bit of byte;
  emit byte;
} while (value != 0);
``` */
by__arr uu__convert__bytes(
  uu value,
) {
  final uu size;
  {
    uu size__iter = 0;
    while ((value < (1 << ((size__iter += 1) * ch__BITS_PER_CHAR))).not);

    size = size__iter;
  }

  final bytes = by__arr(size);

  uu bytes__iter = 0;

  do {
    bytes[bytes__iter] = (value & 127 /* (1 << BITS_PER_SEGMENT) */);

    if ((value >>= ch__BITS_PER_CHAR) != 0) /* more data left */ //
      bytes[bytes__iter] |= 128;

    bytes__iter += 1;
  } while (value != 0);

  return bytes;
}

bool uu__b__aligned(final uu value, final uu size) => //
    ((value & (size - 1)) == 0);

uu uu__aligned__alignment__count(final uu value, final uu shift__count) => //
    (value >> shift__count);

uu uu__aligned__basic(final uu value, final uu shift__count) => //
    (uu__aligned__alignment__count(
          value,
          shift__count,
        ) <<
        shift__count) /*
  equal to `(value & ~(size - 1))`, and `(value & (~0 << shift__count))`
    but, slightly more efficient
      because of the number of operations, 3 vs, just 2 */
    ;

({
  uu value__aligned,
  uu remainder__un_aligned /* `` */,
/* `uu get value => (remainder__un_aligned + value__aligned);` */
}) uu__aligned(
  final uu value,
  final uu alignment__size,
  final uu alignment__shift__count,
) {
  /*if (value < block__size__shift.size) {
    return (
      value__aligned: 0,
      remainder__un_aligned: value,
    ); /* output of `_uu__aligned` */

    return (
      value__aligned: block__size__shift.size,
      remainder__un_aligned: -(block__size__shift.size - value),
    ); /* informative, but not intended */
  }*/

  if (uu__b__aligned(value, alignment__size)) //
    return (
      value__aligned: value,
      remainder__un_aligned: 0,
    );

  final value__aligned = uu__aligned__basic(
    value,
    alignment__shift__count,
  );

  return (
    value__aligned: value__aligned,
    remainder__un_aligned: (value - value__aligned),
  );
}

typedef uu__bytes__convert__result__kampa = ({
  uu value,
  sz count /* not `value__size`, but actually `bytes__count` */
});

typedef ss__bytes__convert__result__kampa = ({
  ss value,
  sz count,
});

uu__bytes__convert__result__kampa uu__bytes__convert(
  final by__arr bytes,
)
/*
  although `PrefixVarint` could be 1/3rd times faster, in de-cod-ing, but
    its NOT parallel-able
      because its un-determin-able, which byte contains the bit-sequence info
        while each byte of `uu:bytes` contains the status(of remaining data)
          so the `bytes` can be brOKen into multiple pars and de-cod-ed independently, then joined, to form complete result
    if only a few value(s), need to be de-cod-ed, then there is not-much benefit, of leaving the simplicity of `uu__bytes__convert`
  TASK
    consider moving to `bool iterate(wch)` accepting,
      instead of `return`ing `uu__bytes__convert__result__kampa` */
{
  uu //
      value = 0,
      iter = 1,
      shift__count = 0,
      bytes__iter = 0;

  while (OK) {
    final b = bytes[bytes__iter++];

    value |= (b & 127) << shift__count;

    if ((b & 128) == 0) //
      break;

    iter += 1;
    shift__count += ch__BITS_PER_CHAR;
  }

  return (
    value: value,
    count: iter,
  );
} /*
  reverse of `uu__convert__by__arr(`, also refer, for more info
  similar to, {a|the} historical version of `by__array__convert__string(`
    but automated(looped)
      and uses `shift__count`, instead of directly modifying `value`

  forked from `https://en.wikipedia.org/wiki/LEB128#Decode_unsigned_integer`
  original:
```
result = 0;
shift = 0;
while (OK) {
  byte = next byte in input;
  result |= (low-order 7 bits of byte) << shift;
  if (high-order bit of byte == 0)
    break;
  shift += 7;
}
``` */

extension uu__extension on uu {
  by__arr get u8__convert__by__arr => //
      (by__arr(1)..[0] = this);

  by__arr convert__by__array__little_endian(final sz size) => //
      uu__convert__by__array__little_endian(this, size);

  by__arr get convert__bytes => //
      uu__convert__bytes(this);
}
