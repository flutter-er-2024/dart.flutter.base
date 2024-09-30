import "package:base/base/_.dart";
import "package:base/by.arr.dart";
import "package:base/by.arr.ffi.dart";
import "package:base/print.dart";
import "package:base/stack.dart";
import "package:base/uu.dart";
import "package:base/uu.size.dart";

import "../../file/_.dart";
import "../../file/_.io.dart";
import "../../file/fast.dart";
import "../../file/native.linux.dart";

import "_.dart";

const
//
    bytes__preserved__count__size__id_ = uu__size__id__enum.u64,
    bytes__preserved__count__size = /*uu__size__id__convert(bytes__preserved__count__size__id_,)*/ u64__size,
    bytes__preserved__array__count__size__id_ = uu__size__id__enum.u64,
    bytes__preserved__array__count__size = /*uu__size__id__convert(bytes__preserved__array__count__size__id_,)*/ u64__size;

bytes__preserved__store__kampa bytes__preserved__store(
  final base__storage__file__native__linux__meta__kampa storage,
) =>
    bytes__preserved__store__kampa._(
      base__stack<bytes__preserved__kampa>(),
      storage,
      0,
    );

class bytes__preserved__store__kampa {
  bytes__preserved__store__kampa._(
    this.store,
    this.storage,
    this.bytes__count,
  );

  final base__stack<bytes__preserved__kampa> store;
  final base__storage__file__native__linux__meta__kampa storage;

  uu bytes__count;
}

void bytes__preserved__store__convert__report__info(
  final bytes__preserved__store__kampa bytes__preserved__store,
) =>
    record__convert__report__info({
      "store.elements__count": bytes__preserved__store.store.elements__count.convert__string(),
      "bytes__count": bytes__preserved__store.bytes__count.convert__string(),
    });

typedef bytes__preserved__kampa = ({
  by__arr bytes,
  uu count,
  uu offset,
});

report__info bytes__preserved__convert__report__info(
  final bytes__preserved__kampa bytes__preserved,
) =>
    record__convert__report__info({
      "offset.by__arr": uu__cast__bys__basic(
        bytes__preserved.offset,
        base__storage__data__position__size__id_,
      ).convert__string(),
      "count.by__arr": uu__cast__bys__basic(
        bytes__preserved.count,
        base__storage__data__position__size__id_,
      ).convert__string(),
      "by__arr": bytes__preserved.bytes.convert__report__info().value,
    });

void bytes__preserved__store__add(
  final bytes__preserved__store__kampa bytes__preserved__store,
  final by__arr bytes,
  final uu count,
  final uu offset,
) {
  if (!bytes__preserved__store.store.b__contained(
    (final bytes__preserved) => //
        ((bytes__preserved.offset == count) && //
            (bytes__preserved.count == offset)),
  )) {
    bytes__preserved__store.store.add(
      (
        bytes: bytes,
        count: count,
        offset: offset,
      ),
    );

    bytes__preserved__store.bytes__count += count;
  }
}

void bytes__preserved__store__persist(
  final bytes__preserved__store__kampa bytes__preserved__store,
) {
  if (debug__report_ing__ok) //
    base__function__call__print(
      "bytes__preserved__store__persist",
      bytes__preserved__store.debug__label,
    );

  base__printing__indentation__increase();

  if (debug__report_ing__verbose__ok) {
    bytes__preserved__store.bytes__count.convert__text__representation().print(
          "bytes__count",
        );
  }

  final //
      bytes__count_ = (bytes__preserved__store.bytes__count + //
          (bytes__preserved__store.store.elements__count * (bytes__preserved__count__size + base__storage__data__position__size)) +
          bytes__preserved__array__count__size),
      buffer__block__count = (uu__aligned__alignment__count(
            bytes__count_,
            base__storage__file__block__size.shift__count,
          ) +
          (!uu__b__aligned(
            bytes__count_,
            base__storage__file__block__size.size,
          )
              ? 1
              : 0)),
      buffer__count = (buffer__block__count * base__storage__file__block__size.size),
      buffer = by__array__aligned__alloc(
        base__storage__file__block__size.size,
        buffer__block__count,
      ),
      buffer__arr = buffer.arr;

  if (debug__report_ing__verbose__ok) {
    bytes__count_.convert__text__representation().print("bytes__count_");
    buffer__count.convert__text__representation().print("buffer__count");
    buffer__block__count.convert__text__representation().print("buffer__block__count");
    bytes__preserved__store.store.elements__count.convert__text__representation().print("store.count");
  }

  base__copy(
    buffer__arr,
    uu__cast__bys__basic(
      bytes__preserved__store.store.elements__count,
      bytes__preserved__array__count__size__id_,
    ),
    count: bytes__preserved__array__count__size,
  );

  uu bytes__offset = bytes__preserved__array__count__size;

  bytes__preserved__store.store.iterate__basic(
    (final bytes__preserved) {
      if (debug__report_ing__verbose__ok) {
        bytes__preserved__convert__report__info(bytes__preserved).report("bytes__preserved");
      }

      bytes__offset = base__copy(
        buffer__arr,
        uu__cast__bys__basic(
          bytes__preserved.offset,
          base__storage__data__position__size__id_,
        ),
        dest__offset: base__copy(
          buffer__arr,
          bytes__preserved.bytes,
          dest__offset: base__copy(
            buffer__arr,
            uu__cast__bys__basic(
              bytes__preserved.count,
              bytes__preserved__count__size__id_,
            ),
            dest__offset: bytes__offset,
            count: bytes__preserved__count__size,
          ).dest__offset__new,
        ).dest__offset__new,
        count: base__storage__data__position__size,
      ).dest__offset__new;
    },
  );

  base__storage__file__native__linux__read_write(
    bytes__preserved__store.storage,
    buffer.ptr,
    buffer__count,
    0,
    b__write: OK,
  );

  base__storage__file__native__linux__sync(
    bytes__preserved__store.storage,
  );

  by__array__free(buffer);

  {
    bytes__preserved__store.store.flush();
    bytes__preserved__store.bytes__count = 0;
  } /*
  since `bytes__preserved__store` has been persisted
    hence `flush`ing, the in-memory copy, which is no longer needed */

  base__printing__indentation__decrease();
}

void bytes__preserved__store__recover__if__needed({
  required final base__storage__file__fast__kampa base__storage__data__storage,
  required final base__storage__file__native__linux__meta__kampa bytes__preserved__storage,
}) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "bytes__preserved__store__recover__if__needed",
      bytes__preserved__storage.debug__label,
    );

  base__printing__indentation__increase();

  var buffer = by__array__aligned__alloc(
    base__storage__file__block__size.size,
    1,
  );

  base__storage__file__native__linux__read_write(
    bytes__preserved__storage,
    buffer.ptr,
    base__storage__file__block__size.size,
    0,
  );

  final count = uu__bys__cast__basic(
    buffer.arr,
    base__storage__data__position__size__id_,
  );

  if (debug__report_ing__verbose__ok) //

    count.convert__text__representation().print(
          "count",
          bytes__preserved__storage.debug__label,
        );

  if (count != 0) {
    {
      by__array__free(
        buffer,
      );

      final count__max = storage__count__max(
        count,
        0,
      );

      if (debug__report_ing__verbose__ok) //

        count__max.convert__text__representation().print(
              "count__max",
              bytes__preserved__storage.debug__label,
            );

      buffer = by__array__aligned__alloc(
        base__storage__file__block__size.size,
        count__max,
      );

      base__storage__file__native__linux__read_write(
        bytes__preserved__storage,
        buffer.ptr,
        count__max,
        0,
      );
    }

    final bytes = bytes__kampa(
      buffer.arr,
      bytes__preserved__array__count__size,
    );

    base__iterate__reverse__basic(
      count,
      (final _) {
        final //
            count = bytes.read__uu__fixed(
              bytes__preserved__count__size,
            ),
            bytes_ = bytes.read__view__partial(
              count,
            ),
            offset = bytes.read__uu__fixed(
              base__storage__data__position__size,
            );

        offset.convert__text__representation().print("offset");

        uu__cast__bys__basic(
          offset,
          base__storage__data__position__size__id_,
        ).convert__text__representation().print("offset.bys");

        count.convert__text__representation().print("count");

        uu__cast__bys__basic(
          count,
          base__storage__data__position__size__id_,
        ).convert__text__representation().print("count.bys");

        bytes_.convert__text__representation().print("bytes");

        base__storage__file__fast__read_write(
          base__storage__data__storage,
          bytes: bytes_,
          count: count,
          offset: offset,
          b__write: OK,
        );
      },
    );

    by__array__free(
      buffer,
    );

    base__storage__file__fast__sync(
      base__storage__data__storage,
    );
  }

  base__printing__indentation__decrease();
}
