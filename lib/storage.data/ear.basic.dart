import "package:base/base/_.dart";
import "package:base/by.arr.dart";

import "package:base/uu.size.dart";
import "_.dart";
import "_.io.dart";

({
  by__arr element__bytes,
  uu element__base__storage__data__offset,
}) base__storage__data__ear__element__read__basic(
  final base__storage__data__meta__kampa ds___meta, {
  required final uu element__id_ /* un-check-ed for existence, of element, in arr */,
  required final by__arr meta__bytes /* table's `row__column__bytes` */,
  required final sz element__size,
}) /*
  element(-id_) is NOT checked, for existence */
{
  final base__storage__data__offset = ((element__id_ * element__size) + //
      uu__bys__cast__basic(
        meta__bytes,
        base__storage__data__position__size__id_,
      ));

  return (
    element__bytes: base__storage__data__read(
      ds___meta,
      count: element__size,
      base__storage__data__offset: base__storage__data__offset,
    ),
    element__base__storage__data__offset: base__storage__data__offset,
  );
}

({
  by__arr elements__bytes,
  uu elements__count,
}) base__storage__data__ear__read__basic(
  final base__storage__data__meta__kampa ds___meta, {
  required final by__arr meta__bytes,
  required final uu__size__id__enum elements__count__size__id_,
  required final sz element__size,
}) {
  final elements__count = uu__bys__cast__basic(
    meta__bytes.view(
      base__storage__data__position__size,
    ),
    elements__count__size__id_,
  );

  return (
    elements__bytes: base__storage__data__read(
      ds___meta,
      count: (element__size * elements__count),
      base__storage__data__offset: uu__bys__cast__basic(
        meta__bytes,
        base__storage__data__position__size__id_,
      ),
    ),
    elements__count: elements__count,
  );
}
