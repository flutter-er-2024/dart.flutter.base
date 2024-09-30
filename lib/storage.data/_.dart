library storage__native;

//

import "package:base/base/_.dart";

//

const
//
    base__storage__data__position__offset = 0,
    base__storage__data__position__size__id_ = uu__size__id__enum.u64,
    base__storage__data__position__size = /*uu__size__id__convert(base__storage__data__position__size__id_,)*/ u64__size,
//
    base__storage__data__wastage__offset = (base__storage__data__position__size + base__storage__data__position__offset),
    base__storage__data__wastage__size__id_ = uu__size__id__enum.u64,
    base__storage__data__wastage__size = /*uu__size__id__convert(base__storage__data__wastage__size__id_,)*/ u64__size,
//
    base__storage__data__main__tbl__offset = (0 /* padding to achieve alignment */ + base__storage__data__wastage__size + base__storage__data__wastage__offset),
    base__storage__data__table__main__rows__count__size /*
  because we do not know the exact requirements, so the maximum is chosen */
    = u64__size,
    base__storage__data__main__tbl__rows__count__max = u8__max; /*
  {max|siz}es are chosen, finely, to keep, `data:base:position`, `data:base:wastage`, and `main:tbl`
    in a single block of `base__storage__file__block__size.alignment__flash`
      hence maintain a(NOT the) perfect-alignment */

class base__storage__data__meta__kampa /*
  called DBMS(DataBase Management System), by others
  TASK
    rename, all `meta_data__bytes`, which are actually `row__column__bytes`, to the latter */
{
  base__storage__data__meta__kampa({
    required this.storage,
    required this.bytes__preserved__store,
    required this.position,
    required this.wastage,
  })  : position__change = 0,
        wastage__change = 0;

  final base__storage__file__fast__kampa //
      storage /* heap */;

  final bytes__preserved__store__kampa? //
      bytes__preserved__store;

  uu //
      position /*
  `base__storage__data__position` is `count`(un-aligned), while `ds___meta.size` is `count__max`(aligned) */
      ,
      position__change /*
  change, in `position`, since the last `:sync(` */
      ,
      wastage /*
  is not, very useful
    was simply added because the space(in data:base), was anyways being wasted, due to padding, to achieve alignment
    block(of storage) is anyways read, before writ-ing, so maintaining a wastage-counter, should not be expensive, maybe some nano-seconds, at most */
      ,
      wastage__change;
}

final //
    base__storage__data__position__initial = (base__storage__data__main__tbl__size(
          base__storage__data__main__tbl__rows__count__max,
        ) +
        base__storage__data__main__tbl__offset);

uu base__storage__data__main__tbl__size(
  final uu rows__count,
) =>
    (rows__count * //
        (base__storage__data__table__main__rows__count__size + base__storage__data__position__size));

report__info base__storage__data__meta__convert__report__info(
  final base__storage__data__meta__kampa ds___meta,
) =>
    record__convert__report__info({
      "position": ds___meta.position.convert__string(),
      "wastage": ds___meta.wastage.convert__string(),
    });

base__storage__data__meta__kampa base__storage__data__create({
  required final base__storage__file__fast__kampa base__storage__data__storage,
  required final base__storage__file__native__linux__meta__kampa? bytes__preserved__storage /*
  is NOT truncated */
  ,
}) /*
  until, the success-ful, execution, of this procedure
    `data:base` is NOT created, and is equal to garbage
      hence, the `:storage`, MUST NOT be passed to `:open`
        because `:storage` has NO indicator of the `data:base`'s correct-ness

  if the proc `throw`s
    the same `base__storage__data__storage`, can be passsed to `base__storage__data__create`, again
      to re-try, the creat-ion */
{
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__create",
      base__storage__data__storage.debug__label,
    );

  base__printing__indentation__increase();

  final buffer = by__array__aligned__alloc(
    base__storage__file__block__size.size,
    1,
  );

  {
    base__copy(
      buffer.arr,
      uu__cast__bys__basic(
        base__storage__data__position__initial,
        base__storage__data__position__size__id_,
      ),
      count: base__storage__data__position__size,
    );

    by__array__fill(
      buffer.arr.view(
        base__storage__data__position__size,
      ),
      count: base__storage__data__wastage__size,
    );

    base__storage__file__native__linux__read_write(
      base__storage__data__storage.storage,
      buffer.ptr,
      base__storage__file__block__size.size,
      base__storage__data__position__offset,
      b__write: OK,
    );

    base__storage__file__native__linux__sync(
      base__storage__data__storage.storage,
    );
  }

  final bytes__preservation__b__needed = (bytes__preserved__storage != null);

  if (bytes__preservation__b__needed) {
    by__array__fill(
      buffer.arr,
      count: bytes__preserved__array__count__size,
    );

    base__storage__file__native__linux__read_write(
      bytes__preserved__storage,
      buffer.ptr,
      base__storage__file__block__size.size,
      0,
      b__write: OK,
    );

    base__storage__file__native__linux__sync(
      bytes__preserved__storage,
    );
  }
  /* {over-write}-ing the garbage */;

  by__array__free(
    buffer,
  );

  final result = base__storage__data__meta__kampa(
    storage: base__storage__data__storage,
    bytes__preserved__store: (bytes__preservation__b__needed
        ? bytes__preserved__store(
            bytes__preserved__storage,
          )
        : NIL),
    position: base__storage__data__position__initial,
    wastage: 0,
  );

  base__printing__indentation__decrease();

  return result;
}

base__storage__data__meta__kampa base__storage__data__open({
  required final base__storage__file__fast__kampa base__storage__data__storage,
  required final base__storage__file__native__linux__meta__kampa? bytes__preserved__storage,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__data__open",
      base__storage__data__storage.debug__label,
    );

  base__printing__indentation__increase();

  final bytes__preservation__b__needed = (bytes__preserved__storage != null);

  if (bytes__preservation__b__needed) //
    bytes__preserved__store__recover__if__needed(
      base__storage__data__storage: base__storage__data__storage,
      bytes__preserved__storage: bytes__preserved__storage,
    );

  final //
      meta__bytes = base__storage__file__fast__read__auto(
        base__storage__data__storage,
        count: (base__storage__data__position__size + base__storage__data__wastage__size),
        offset: base__storage__data__position__offset,
      ),
      position = uu__bys__cast__basic(
        meta__bytes,
        base__storage__data__position__size__id_,
      ),
      wastage = uu__bys__cast__basic(
        meta__bytes.view(
          base__storage__data__position__size,
        ),
        base__storage__data__wastage__size__id_,
      );

  if (debug__report_ing__verbose__ok) {
    position.convert__text__representation().print(
          "data:base:position",
          base__storage__data__storage.debug__label,
        );

    position.convert__text__representation().print(
          "data:base:wastage",
          base__storage__data__storage.debug__label,
        );
  }

  final result = base__storage__data__meta__kampa(
    storage: base__storage__data__storage,
    bytes__preserved__store: (bytes__preservation__b__needed
        ? bytes__preserved__store(
            bytes__preserved__storage,
          )
        : NIL),
    position: position,
    wastage: wastage,
  );

  base__printing__indentation__decrease();

  return result;
}

typedef base__storage__data__linux__auto__result__kampa = ({
  base__storage__file__native__linux__meta__kampa storage,
  base__storage__file__fast__kampa base__storage__file__fast,
  base__storage__file__native__linux__meta__kampa? bytes__preserved__storage,
  base__storage__data__meta__kampa ds___meta,
});

base__storage__data__linux__auto__result__kampa base__storage__data__linux__auto({
  required string directory__path,
  final string file__name = "db",
  required final sz ds___storage__size,
  final bool bytes__b__preserve = OK,
  required final void Function(base__storage__data__linux__auto__result__kampa) create__handle,
}) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print("base__storage__data__linux__auto");

    directory__path.convert__text__representation().print("directory__path");
    file__name.convert__text__representation().print("file__name");
    ds___storage__size.convert__text__representation().print("base__storage__data__storage__size");
  }

  base__printing__indentation__increase();

  const //
      file__type__indicator = ".bin";

  final //
      b__create = (!(base__storage__file__native__linux__b__exists(
        ((directory__path += base__storage__file__path__separator) + file__name + file__type__indicator),
      ))),
      storage = base__storage__file__native__linux(
        (directory__path + file__name + file__type__indicator),
      ),
      base__storage__file__fast_ = base__storage__file__fast(
        storage,
      ),
      bytes__preserved__storage = //
          (bytes__b__preserve
              ? base__storage__file__native__linux(
                  (directory__path + file__name + ".save" + file__type__indicator),
                )
              : NIL),
      ds___meta = (b__create //
          ? base__storage__data__create
          : base__storage__data__open)(
        base__storage__data__storage: base__storage__file__fast_,
        bytes__preserved__storage: bytes__preserved__storage,
      );

  base__storage__file__native__linux__allocate(
    storage,
    ds___storage__size,
  ); /*
   pre-allocat-ing to avoid perf issues, due to fragment-ation */

  final result = (
    storage: storage,
    base__storage__file__fast: base__storage__file__fast_,
    bytes__preserved__storage: bytes__preserved__storage,
    ds___meta: ds___meta,
  );

  if (b__create) //
    create__handle(result);

  base__printing__indentation__decrease();

  return result;
}

/*void base__storage__data__position__update__if__needed(
    final uu position__new,
  ) {
    if (position__new > base__storage__data__position) //
      base__storage__data__position = position__new;
  }*/

uu base__storage__data__position(
  final base__storage__data__meta__kampa ds___meta,
) {
  return (ds___meta.position__change + ds___meta.position);
}

by__arr base__storage__data__read(
  final base__storage__data__meta__kampa ds___meta, {
  required final uu count,
  required final uu base__storage__data__offset,
}) /*
  also applicable for, `bytes`, `str`(non-wide `string`s), and `wstr__bytes` */
    =>
    base__storage__file__fast__read__auto(
      ds___meta.storage,
      count: count,
      offset: base__storage__data__offset,
    );

void base__storage__data__write(
  final base__storage__data__meta__kampa ds___meta, {
  required final by__arr bytes,
  final uu? bytes__count,
  required final uu base__storage__data__offset,
}) /*
  should, be used, only, if the write op
    is on garbage, ir-relevent, or obsolete bytes
    and the op is ir-relevent(or useless), without updat-ing `position`
      example
        append op is useless, if the `position` is not updat-ed, after the op
          because another append op will overwrite the previous append */
    =>
    base__storage__file__fast__read_write(
      ds___meta.storage,
      bytes: bytes,
      count: (bytes__count ?? bytes.bys__count),
      offset: base__storage__data__offset,
      b__write: OK,
    );

void base__storage__data__write__replace /*:preserved*/ (
  final base__storage__data__meta__kampa ds___meta, {
  required final by__arr bytes,
  required final uu bytes__count,
  required final uu base__storage__data__offset,
}) /*
  similar to `transaction`s in other dbms-es; but not as heavy, because, only, the original un-modified bytes, are saved(or preserved)

  `if(count > 96)`, prefer append op, instead of (over-)writing directly
    due to, the increase, in preservation cost, of pre-mod(or un-modified) data */
{
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__data__write__replace",
      ds___meta.debug__label,
    );

    base__storage__data__offset.convert__text__representation().print("base__storage__data__offset");
    bytes__count.convert__text__representation().print("bytes__count");
    bytes.convert__text__representation().print("bytes");
  }

  base__printing__indentation__increase();

  final bytes__preserved__store = ds___meta.bytes__preserved__store;
  if (bytes__preserved__store != null) {
    final bytes__preserved = by__arr(bytes__count);

    base__storage__file__fast__read_write(
      ds___meta.storage,
      bytes: bytes__preserved,
      count: bytes__count,
      offset: base__storage__data__offset,
    );

    if (debug__report_ing__verbose__ok) {
      bytes__preserved.convert__text__representation().print(
            "bytes__preserved",
            ds___meta.debug__label,
          );
    }

    bytes__preserved__store__add(
      bytes__preserved__store,
      bytes__preserved,
      bytes__count,
      base__storage__data__offset,
    );
  }

  base__storage__data__write(
    ds___meta,
    bytes: bytes,
    bytes__count: bytes__count,
    base__storage__data__offset: base__storage__data__offset,
  );

  base__printing__indentation__decrease();
}

uu base__storage__data__write__reserve(
  final base__storage__data__meta__kampa ds___meta,
  final uu count,
) {
  if (debug__report_ing__ok) {
    base__function__call__print(
      "base__storage__data__write__reserve",
      ds___meta.debug__label,
    );

    count.convert__text__representation().print("count");
  }

  final base__storage__data__offset = base__storage__data__position(
    ds___meta,
  );

  ds___meta.position__change += count;

  return base__storage__data__offset;
}

uu /*base__storage__data__offset*/ base__storage__data__write__append(
  final base__storage__data__meta__kampa ds___meta,
  final by__arr bytes, [
  uu? count,
]) /*
  un-preserved write */
{
  final base__storage__data__offset = base__storage__data__write__reserve(
    ds___meta,
    (count ??= bytes.bys__count),
  );

  base__storage__data__write(
    ds___meta,
    bytes: bytes,
    bytes__count: count,
    base__storage__data__offset: base__storage__data__offset,
  );

  return base__storage__data__offset;
}

void base__storage__data__sync(
  final base__storage__data__meta__kampa ds___meta,
) /*
  similar to `commit` in other DBMS */
{
  if (debug__report_ing__ok) //
    base__function__call__print(
      "base__storage__data__sync",
      ds___meta.debug__label,
    );

  base__printing__indentation__increase();

  final //
      bytes__preserved__store = ds___meta.bytes__preserved__store,
      position__change = ds___meta.position__change;

  var b__preserve = (bytes__preserved__store != null);

  if /* likely */ (/*position:update:b:needed*/ (position__change != 0)) {
    base__storage__data__write__replace(
      ds___meta,
      bytes: uu__cast__bys__basic(
        (ds___meta.position += position__change),
        base__storage__data__position__size__id_,
      ),
      bytes__count: base__storage__data__position__size,
      base__storage__data__offset: base__storage__data__position__offset,
    );

    ds___meta.position__change = 0;

    final wastage__change = ds___meta.wastage__change;
    if /* likely */ (/*wastage:update:b:needed*/ (wastage__change != 0)) {
      base__storage__data__write__replace(
        ds___meta,
        bytes: uu__cast__bys__basic(
          (ds___meta.wastage += wastage__change),
          base__storage__data__wastage__size__id_,
        ),
        bytes__count: base__storage__data__wastage__size,
        base__storage__data__offset: base__storage__data__wastage__offset,
      );

      ds___meta.wastage__change = 0;
    }
  } else if (b__preserve) //
    b__preserve = (bytes__preserved__store.bytes__count != 0);

  if (b__preserve) //
    bytes__preserved__store__persist(
      bytes__preserved__store!,
    );

  base__storage__file__fast__sync(
    ds___meta.storage,
  );

  if (b__preserve) {
    final buffer = by__array__aligned__alloc(
      base__storage__file__block__size.size,
      1,
    );

    by__array__fill(
      buffer.arr,
      count: bytes__preserved__array__count__size,
    );

    final bytes__preserved__storage = bytes__preserved__store!.storage;

    base__storage__file__native__linux__read_write(
      bytes__preserved__storage,
      buffer.ptr,
      base__storage__file__block__size.size,
      0,
      b__write: OK,
    );

    base__storage__file__native__linux__sync(
      bytes__preserved__storage,
    );

    by__array__free(
      buffer,
    );
  } /*
  since data-base's modifications(or changes), have already been persisted */

  base__printing__indentation__decrease();
}
