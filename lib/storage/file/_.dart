part of "../_.dart";

const //
    base__storage__file__path__separator /* must not change ,because ,is universal and heavily hard-coded */ = char__slash__forward;

abstract class base__storage__file__protocol {
  asyn___value<
          by__arr /*
can be partical(less-than `count`) ,if end-of-file */
          > //
      read(
    final uu count,
    final uu offset,
  );

  asyn___value<void> //
      write(
    final by__arr data,
    final uu count /* of `data` */,
    final uu offset /* in `file` */,
  );

  asyn___value<void> //
      syn_(
    final uu count,
    final uu offset,
  );
}

string file__path__convert__name(
  final string file__path,
) {
  final char__id_ = string__search(
    file__path,
    base__storage__file__path__separator,
    reverse__ok: OK,
  );

  if (char__id_ == null) {
    throw "'$base__storage__file__path__separator' is not present in \"$file__path\"(file:path)";
  }

  return file__path.substring(
    (1 + char__id_),
  );
}

string file__name__convert__extension(
  final string file__name,
) {
  final char__id_ = string__search(
    file__name,
    char__dot,
    reverse__ok: OK,
  );

  if (char__id_ == null) {
    return empty__string;
  }

  return file__name.substring(
    (1 + char__id_),
  );
}

typedef base__storage__file__alignment__kampa = ({
  uu shift__count,
  uu size,
});

const base__storage__file__alignment__kampa //
    alignment__mem = (shift__count: 3, size: u64__size),
    alignment__disk = (shift__count: 9, size: 512),
    alignment__flash = (shift__count: 12, size /* alignment */ : 4096),
    base__storage__file__block__size /*
  `.size`
    SHOULD NOT change
    SHOULD be `>= (2 * data__base__position__size)`
    MUST be `>= data__base__position__size` */
    = alignment__flash;

typedef io__operation__read_write__function__format = void Function(
  by__arr buffer,
  uu count,
  uu offset,
);

({
  uu offset__aligned,
  uu buffer__offset /* `__un_aligned` */,
}) base__storage__file__offset__aligned(
  final uu offset, [
  final base__storage__file__alignment__kampa block__size__shift = base__storage__file__block__size,
]) {
  final offset__aligned = uu__aligned(
    offset,
    block__size__shift.size,
    block__size__shift.shift__count,
  );

  return (
    offset__aligned: offset__aligned.value__aligned,
    buffer__offset: offset__aligned.remainder__un_aligned,
  );
}

uu base__storage__file__count__max /*
  equivalent of `storage__offset__aligned`, despite the in-appropriate name
  not `__aligned` because `count` is not aligned, but `(count +1)`, to get upper-limit, which is max, actually necessary */
    (
  final uu count,
  final uu buffer__offset, [
  final base__storage__file__alignment__kampa block__size = base__storage__file__block__size,
]) {
  if (count == 0) //
    return 0;

  if (uu__b__aligned(
    count,
    block__size.size,
  )) {
    return count;
  }

  return uu__aligned__basic(
    ((count + buffer__offset) /* reasoning available */ /* TASK: understand, then FIX, if any */ + block__size.size),
    block__size.shift__count,
  );
} /*
  reasons:
    `(count += buffer__offset)`:
      let `uu bk_sz/* block__size */ = 4096, count = 7000, offset = 14000;`
        hence `uu offset__aligned = (3 * bk_sz), count__max = (2 * bk_sz), offset__new = (5 * bk_sz)/* (count__max + offset__aligned) */;`
          which is in-correct; because `offset__new` should be `21000`, instead of `20480`(5 * bk_sz) */

void base__storage__file__io__check__aligned(
  final uu count,
  final uu offset,
  final base__storage__file__alignment__kampa alignment,
) {
  if (debug__report_ing__ok) {
    base__function__call__print(
      "storage__io__check__aligned",
    );

    count.convert__text__representation().print("count");
    offset.convert__text__representation().print("offset");
    alignment.size.convert__text__representation().print("alignment__size");
  }

  if (uu__b__aligned(count, alignment.size).not) {
    throw "`count` is NOT aligned";
  }

  if (uu__b__aligned(offset, alignment.size).not) {
    throw "`offset` is NOT aligned";
  }
}
