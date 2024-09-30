library base;

//

import "dart:core";
import "dart:typed_data" as typed_data;

import "dart:async" as async;
import "dart:convert" as convert;
import "dart:math" as math;

//

part "accumulation.dart";
part "array.dart";
part "asyn_.dart";
part "basic.math.divide.dart";
part "by.arr.dart";
part "ch.arr.generator.dart";
part "ch.ascii.dart";
part "ch.dart";
part "char.dart";
part "kompo.dart";
part "convert.json.dart";
part "data.fetching.dart";
part "data.fetching.simple.dart";
part "date-time.dart";
part "depository.dart";
part "dictionary.dart";
part "error.dart";
part "event.dart";
part "fp.dart";
part "image.dart";
part "input.text.buffer.dart";
part "int.dart";
part "iterable.dart";
part "language.english.dart";
part "language.model.dart";
part "message.dart";
part "num.dart";
part "print.dart";
part "procedure.dart";
part "ss.dart";
part "stack.dart";
part "static.dart";
part "str.dart";
part "str.wide.dart";
part "Stream.dart";
part "string.dart";
part "test.dart";
part "text.dart";
part "Type.dart";
part "union.dart";
part "uu.dart";
part "uu.size.dart";
part "value.dart";

/*
  `(Object? == (Object | Null))`
  `(FutureOr<void> == (asyn___value<void> | void))`
    any function, marked `async`, or using `await` in body, MUST return `Future`, NOT `FutureOr` */

const //
    debug__report_ing__ok = OK,
    debug__report_ing__verbose__ok = (OK && debug__report_ing__ok),
    behavior__correct__ok /* prefer correct-ness, over, efficiency or performance; NO guarentee */ = OK,
//
    environment__phone__ok__android = OK,
    environment__phone__ok__apple = NO,
    environment__phone__ok = (environment__phone__ok__android || environment__phone__ok__apple),
    environment__work_station__ok__unix /*BSD|GNU|Linux*/ = !environment__phone__ok,
    environment__work_station__ok = environment__work_station__ok__unix;

typedef ss = int;
typedef uu = ss;

typedef sz = ss;

typedef by = ss;

typedef u01 = ss;
typedef u04 = ss;
typedef u07 = ss;

typedef u8 = ss;
typedef u16 = ss;
typedef u24 = ss;
typedef u32 = ss;
typedef u31 = u32;
typedef u64 = ss;
typedef u63 = u64;

typedef s8 = ss;
typedef s16 = ss;
typedef s32 = ss;
typedef s64 = ss;

typedef res = u16;

typedef ch = u07;

typedef wch /* ch__wide */ = u24;

typedef fp /* floating-point */ = double;
typedef fp16 = fp;
typedef fp32 = fp;
typedef fp64 = fp;

typedef string = String;

typedef by__arr = typed_data.Uint8List;

typedef u8__arr = typed_data.Uint8List;
typedef u16__arr = typed_data.Uint16List;
typedef u32__arr = typed_data.Uint32List;
typedef u64__arr = typed_data.Uint64List;

typedef u24__arr = u32__arr;
typedef str__wide = u24__arr;
typedef wstr = str__wide;

typedef array<T> = List<T>;

typedef dictionary /*
terminology
  dictionary is preferred over map
    ,because
      the latter feels like a graph-of-points(due to geographical-graph ,of locations) ,or one-to-many relation ,which is completely in-correct
        ,while the former feels like a one-to-one(specifically word-to-sentence) relation ,which are both correct
          ,because an integer(key's hash) is a word ,while a composite(a collection of words) is a sentence
      `map` is an well-established and conventional name for element-conversion function ,in most of the relevant-lang.s
    the name of data-structure can be shortened to `dict_`
  associative-array is fundamentally defective ,due to not being contiguous
  table is in-correct ,because its not merely key-value ,but any number of columns
  object is possibly correct ,but has a very different meaning in relevant lang.s ,and is un-related to the english meaning */
    <key__type, value__type>
    = //
    Map<key__type, value__type>;

typedef dict_<key__type, value__type> = //
    dictionary<key__type, value__type>;

typedef title__strings__kampa = ({
  string title,
  string sub_title,
});

const Null NIL = null;

const //
    Null__value__string = "NIL";

const
//
    OK = true,
    OK__NOT = !OK,
//
    TRUE = OK,
    YES = TRUE,
    FALSE = OK__NOT,
    NO = FALSE;

const //
    bytes__count__decimal__shift__count = 10,
    bytes__count__kibi = /*(1 << bytes__count__decimal__shift__count)*/
        (u8__limit << 2),
    bytes__count__mebi = (bytes__count__kibi << bytes__count__decimal__shift__count),
    bytes__count__gibi = (bytes__count__mebi << bytes__count__decimal__shift__count),
    bytes__count__tebi = (bytes__count__gibi << bytes__count__decimal__shift__count),
    bytes__count__pebi = (bytes__count__tebi << bytes__count__decimal__shift__count),
    bytes__count__exbi = (bytes__count__pebi << bytes__count__decimal__shift__count),
    bytes__count__zebi = (bytes__count__exbi << bytes__count__decimal__shift__count),
    bytes__count__yobi = (bytes__count__zebi << bytes__count__decimal__shift__count);

const sz //
    io__buffer__size__default = (bytes__count__kibi << 2);

const uu //
    by__nibble__width = 4,
    by__BITS_PER_NIBBLE = by__nibble__width,
    by__width = (2 * by__nibble__width),
    by__BITS_PER_BYTE = by__width,
    ch__width = (by__width - 1),
    ch__BITS_PER_CHAR = ch__width,
//
    by__size = 1,
//
    u4__width = 4,
    u4__limit = (1 << u4__width),
    u4__max = (u4__limit - 1),
//
    u8__size = by__size,
    u8__width = (u8__size * by__BITS_PER_BYTE),
    u8__limit = (1 << u8__width),
    u8__max = (u8__limit - 1),
//
    u16__size = (u8__size * 2),
    u16__width = (u16__size * by__BITS_PER_BYTE),
    u16__limit = (1 << u16__width),
    u16__max = (u16__limit - 1),
//
    u24__size = (u8__size * 3),
    u24__width = (u24__size * by__BITS_PER_BYTE),
    u24__limit = (1 << u24__width),
    u24__max = (u24__limit - 1),
//
    u32__size = (u16__size * 2),
    u32__width = (u32__size * by__BITS_PER_BYTE),
    u32__limit = (1 << u32__width),
    u32__max = (u32__limit - 1),
//
    u48__size = (u16__size * 3),
//
    u64__size = (u32__size * 2),
    u64__width = (u64__size * by__BITS_PER_BYTE),
//
    u96__size = (u32__size * 3),
//
    u128__size = (u64__size * 2),
//
    s64__size = u64__size,
    s64__limit = (1 << ((u64__size * by__BITS_PER_BYTE) - 1)),
    s64__max = (s64__limit - 1),
//
    u1__limit = (1 << 1),
    u2__limit = (1 << 2),
    u3__limit = (1 << 3) /* 8 */,
    u5__limit = (1 << 5) /* 32 */,
    u6__limit = (1 << 6),
    u7__limit = (1 << ch__BITS_PER_CHAR),
    u14__limit = (1 << (2 * ch__BITS_PER_CHAR)),
    u21__limit = (1 << (3 * ch__BITS_PER_CHAR)),
//
    u7__size = u8__size,
//
    ch__size = u7__size,
    wch__size = u24__size,
    uu__size = u64__size;

final //
    u64__limit = (BigInt.from(1) << u64__width),
    u64__max = (u64__limit - BigInt.from(1));

const //
    ch__limit = (u8__limit >> 1),
    ch__max = (ch__limit - 1);

const //
    uu__base__16__digits__count = 2 /*
each digit contains 4 bits of info.
  ,hence 2 digits are required to store 1 byte */
    ,
    uu__base__2__digits__count = by__BITS_PER_BYTE,
//
    u64__width__radix__16 = (u64__size * uu__base__16__digits__count),
    u64__width__radix__2 = (u64__size * uu__base__2__digits__count),
//
    fp64__mantissa__max = ((1 << 52) /*-1*/ /* because ,the sign bit ,is stored separat-ly */),
    fp64__exponent__max = ((1 << 10) - 1 /* because ,exponent can also be ,negative */);

sz uu__base__16__digits__count__convert__size(
  final uu digits__count,
) =>
    uu__base__binary__multiple__digits__count__convert__size(
      digits__count,
      uu__base__16__digits__count,
    );

sz uu__base__2__digits__count__convert__size(
  final uu digits__count /*bits__count*/,
) =>
    uu__base__binary__multiple__digits__count__convert__size(
      digits__count,
      uu__base__2__digits__count,
    );

sz uu__base__binary__multiple__digits__count__convert__size(
  final uu digits__count,
  final uu base__binary__multiple__digits__count,
) {
  return (digits__count.toDouble() / base__binary__multiple__digits__count).ceil();
}

bool //
    base__value__nil_able__equal__ok //
    <value__type>(
  final value__type? value,
  final value__type? other,
  final bool Function(
    value__type value,
    value__type other,
  ) value__equal__ok,
) {
  if ((value == null) && (other == null)) {
    return OK;
  }

  if (((value == null) && (other != null)) || ((value != null) && (other == null))) {
    return NO;
  }

  /*((value =~ NIL) && (other =~ NIL))*/

  return value__equal__ok(
    value!,
    other!,
  );
}

extension bool__extension on bool {
  bool get not => //
      !this;
}

extension extension__u32__arr on u32__arr {
  u32__arr view__partial(final uu offset, final uu count) => //
      buffer.asUint32List(((offset * 4) + offsetInBytes), count);
}

enum base__results__basic {
  success /*res:success*/,
  failure /* client-side issue */,
  failure__internal /* non-{client-side} issue ,like communicat-ion ,internal|server-side */,
}

extension base__results__basic__ensurance__extension //
    on base__results__basic {
  void ensure__success /*
`throw`s `base__results__basic.`{`failure`|`error`} */
      () {
    final value = this;

    if (value == base__results__basic.success) {
      return;
    }

    throw value;
  }
}

const //
    result__code__size = u8__size,
//
    zero = '${0}', //
    one = '${1}',
    two = '${2}',
    three = '${3}',
//
    static__indicate__truncat_ion = "....",
    static__indicate__short_en_ing = static__indicate__truncat_ion,
//
    empty__string = '',
    empty__arr = <dynamic>[],
    empty__Object__nil_able = <Object?>[];

const ch //
    checksum__sha__256__size = 32;

const //
    attribute__function__inline = pragma("vm:prefer-inline");

typedef procedure = Function;

typedef procedure__empty__format = void Function();

void empty__procedure__empty() {}

typedef close__procedure__format = procedure__empty__format;

bool NOT(final bool value) => //
    value.not;

bool base__value__same__ok<value__type>(
  final value__type value,
  final value__type other,
) =>
    (value == other);

void base__iterate(
  uu count,
  final bool Function(uu i) operate, {
  uu offset = 0,
}) {
  count += offset;
  while ((offset < count) && operate(offset++));
}

asyn___value<void> base__iterate__asyn_(
  uu count,
  final asyn___value<bool> Function(uu i) operate, {
  uu offset = 0,
}) async {
  count += offset;
  while ((offset < count) && (await operate(offset++)));
}

void base__iterate__basic(
  final uu count,
  final void Function(uu i) operate, {
  final uu offset = 0,
}) =>
    base__iterate(
      count,
      (final i) {
        operate(i);
        return OK;
      },
      offset: offset,
    );

asyn___value<void> base__iterate__basic__asyn_(
  final uu count,
  final asyn___value<void> Function(uu i) operate, {
  final uu offset = 0,
}) =>
    base__iterate__asyn_(
      count,
      (final i) async {
        await operate(i);
        return OK;
      },
      offset: offset,
    );

void base__iterate__reverse /* __high_perf__low_mem */ (
  uu count,
  final bool Function(uu i) operate,
) {
  if /*F*/ (count == 0) {
    return;
  }

  while (operate(count -= 1) && //
      (count /*>*/ != 0)) {}
}

asyn___value<void> base__iterate__reverse__asyn_(
  uu count,
  final asyn___value<bool> Function(uu i) operate,
) async {
  if /*F*/ (count == 0) {
    return;
  }

  while ((await operate(count -= 1)) && //
      (count /*>*/ != 0)) {}
}

void base__iterate__reverse__basic(
  final uu count,
  final void Function(uu i) operate,
) =>
    base__iterate__reverse(
      count,
      (final i) {
        operate(i);
        return OK;
      },
    );

asyn___value<void> base__iterate__reverse__basic__asyn_(
  final uu count,
  final asyn___value<void> Function(uu i) operate,
) =>
    base__iterate__reverse__asyn_(
      count,
      (final i) async {
        await operate(i);
        return OK;
      },
    );

void base__iterate__forever(
  final bool Function(uu i) operate, [
  uu offset = 0,
]) {
  while (operate(offset++));
}

asyn___value<void> base__iterate__forever__asyn_(
  final asyn___value<bool> Function(uu i) operate, [
  uu offset = 0,
]) async {
  while (await operate(offset++));
}

extension nil__conversion__extension<type extends Object> on type? {
  result__type? convert__if<result__type>(
    final result__type Function(type) operate,
  ) {
    final this_1 = this;

    if (this_1 == null) {
      return NIL;
    }

    return operate(
      this_1,
    );
  }
}

late final base__random__safe = math.Random.secure();

const //
    base__delay__duration__none = Duration.zero,
    base__delay__duration__realistic = Duration(milliseconds: (1 ~/ 3));

asyn___value<void> base__delay([
  final Duration? duration,
]) =>
    asyn___value<void>.delayed(
      (duration ?? base__delay__duration__realistic),
    );

/* copied from `~/bin/dart-sdk/lib/_internal/wasm/lib/int.dart`::`_BoxedInt`::`_modulo` */
int _modulo(final int a, final int b) {
  final int remainder = a - (a ~/ b) * b;

  return ((remainder < 0) ? ((b < 0) ? (remainder - b) : (remainder + b)) : remainder);
}

/* copied from `~/bin/dart-sdk/lib/_internal/wasm/lib/int.dart`::`_BoxedInt`::`isEven` */
bool uu__isEven(final uu i) => //
    ((i & 1) == 0);

fp double__truncate__parsable__human(final fp value) => //
    ((value * 100).toInt() / 100);

extension on fp {
  fp get truncate__parsable__human => //
      double__truncate__parsable__human(this);
}

bool base__check__endian__host__little() {
  return ((u16__arr(1)..[0] = 256 /* because we want to check the index 0, not 1 */).buffer.asUint8List()[0] == 0);
}

void base__check__features() {
  if (base__check__endian__host__little().not) {
    throw "host, byte-order, in-compatible: refer `b__endian__host__little`";
  }
}

typedef base__copy__result__kampa = ({
  uu dest__offset__new,
  uu src__offset__new,
});

//@attribute__function__inline
base__copy__result__kampa base__copy<T>(
  final array<T> dest,
  final array<T> src, {
  uu? /*src__*/ count,
  uu dest__offset = 0,
  uu src__offset = 0,
}) {
  count /* end/stop */ = ((count == null) //
      ? (src.elements__count - src__offset)
      : (count + src__offset));

  while (src__offset < count) //
    dest[dest__offset++] = src[src__offset++];

  return (
    dest__offset__new: dest__offset,
    src__offset__new: src__offset,
  );
}

abstract class base__dispose__protocol {
  void dispose();
}

/* copied from `~/bin/dart-sdk/lib/_internal/wasm/lib/double.dart`::`_BoxedDouble`::`_remainder` */
double _remainder(final double a, final double b) {
  return (a - (a / b).truncateToDouble() * b);
}

({
  int result,
  int remainder,
}) _division(
  final int numerator,
  final int denominator,
) {
  final double result = (numerator / denominator);
  final int result_ = result.toInt();

  return (
    result: result_,
    remainder: ((result - result_) * denominator).toInt(),
  );
}

void _division__test() {
  print(_division(19, 9));
  print(_division(17, 16));
  print(_division(37, 16));
  print(_division(27, 8));
}

uu binarySearch(
  final array<uu> list,
  final uu element,
) {
  uu //
      min = 0,
      mid_ = 0 /* un-necessary assignment, to avoid the error, by dart's analyzer */,
      max = list.elements__count;

  while (min < max) {
    final _element = list[mid_ = ((min + max) >>> /* ~/ */ 2)];

    if (element < _element) //
      max = mid_;
    else if (element > _element) //
      min =
          (mid_ += /*
  if the `element` is NOT found,
    the assignment ensures that correct index(for insertion), hence correct `-mid`, is returned
      for all values, without the assignment, the negative-index is correct, for some values, but not all

  mere this trick has been copied from the source code of "gnu classpath",
    which was also, found to be highly in-efficient, than open-jdk's implementation, checkout later */
              1);
    else //
      return mid_;
  }

  return -mid_;
}

string getBits(
  final List<int> list, [
  final uu interval = 4,
]) {
  final StringBuffer buffer = StringBuffer("[");

  final int limit = list.length;
  for (int i = 0; i < limit; i += 1) {
    buffer
      ..write(" ")
      ..write(getSeparatedString(
        list[i].toRadixString(2),
        interval: interval,
        prefixChar: '0',
      ))
      ..write(",");
  }

  buffer.write(" ]");

  return buffer.toString();
}

string getSeparatedString(
  final string string, {
  final string separator = char__space,
  final int interval = 3,
  final string? prefixChar,
}) {
  final uu //
      len = string.length,
      partCount;

  uu offset = (len % interval);

  partCount = ((len - offset) ~/ interval);

  final StringBuffer buffer = StringBuffer();

  if (offset > 0) {
    final uu prefixCharCount = (interval - offset);
    if ((prefixChar != null) && (prefixCharCount > 0)) {
      for (int i = 0; i < prefixCharCount; i += 1) {
        buffer.write(prefixChar);
      }
    }
  }

  buffer.write(string.substring(0, offset));

  for (int partCounter = 0; partCounter < partCount; partCounter += 1) {
    buffer
      ..write(separator)
      ..write(string.substring(offset, (offset += interval)));
  }

  return buffer.toString();
}

array<string> getSeparatedStringAsList(
  final string s, {
  final string separator = char__space,
  final int interval = 3,
}) {
  uu offset;

  final uu //
      len = s.length,
      partCount = ((len - (offset = (len % interval))) ~/ interval);

  uu partCounter = 1;

  final result = array<string>.filled(
    partCount,
    empty__string,
    growable: NO,
  ) //
    ..[partCounter++] = s.substring(0, offset);

  while (partCounter < partCount) {
    result[partCounter++] = s.substring(offset, (offset += interval));
  }

  return result;
}
