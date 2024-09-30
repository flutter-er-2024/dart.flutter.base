import "package:base/base/_.dart";
import "package:base/uu.size.dart";

import "_.dart";
import "_.io.dart";
import "table/_.dart";

class base__storage__data__rbt__meta__kampa {
  const base__storage__data__rbt__meta__kampa({
    required this.bytes__count,
    required this.count__size__id_,
    required this.rbt__bytes__base__storage__data__offset,
    required this.meta__bytes__base__storage__data__offset,
  });

  final uu //
      bytes__count;

  final uu__size__id__enum //
      count__size__id_;

  final uu //
      rbt__bytes__base__storage__data__offset,
      meta__bytes__base__storage__data__offset;
}

base__storage__data__table__row__kampa base__storage__data__rbt__read(
  final base__storage__data__meta__kampa ds___meta,
  final base__storage__data__rbt__meta__kampa rbt__meta,
) =>
    (
      bytes: base__storage__data__read(
        ds___meta,
        count: rbt__meta.bytes__count,
        base__storage__data__offset: rbt__meta.rbt__bytes__base__storage__data__offset,
      ),
      bytes__base__storage__data__offset: rbt__meta.rbt__bytes__base__storage__data__offset,
    );
