part of "../_.dart";

const base__storage__file__memory__size__initial = (4 * u8__limit);

base__storage__file__memory //
    base__storage__file__memory__new([
  final uu size__initial = base__storage__file__memory__size__initial,
]) {
  return base__storage__file__memory._(
    storage: by__arr(
      size__initial,
    ),
  );
}

class base__storage__file__memory {
  base__storage__file__memory._({
    required this.storage,
  });

  by__arr storage;

  uu //
      size /* similar to file__size */ = 0,
      offset__implicit /* NOTE: un-used */ = 0;

  void _extend_capacity__if__needed(
    final uu size__required /* required capacity */,
  ) {
    uu size__current /* capacity */ = storage.bys__count;

    while (size__current < size__required) {
      size__current *= 2;
    }

    if (size__current > storage.bys__count) {
      final storage__old = storage;

      base__copy(
        (storage = by__arr(size__current)),
        storage__old,
        count: size,
      );

      //storage__old.mem_:free()

      base__printing__indentation__increase();
      if (debug__report_ing__verbose__ok) {
        "storage__memory._extend_capacity: extended `storage`'s capacity, from ${storage__old.bys__count}, to $size__current".print(debug__label);
      }
      base__printing__indentation__decrease();
    }
  }

  void write(
    final by__arr buffer,
    final uu count,
    final uu offset,
  ) {
    if (debug__report_ing__ok) {
      base__function__call__print(
        "storage__memory.write",
        debug__label,
      );

      count.convert__text__representation().print("count");
      offset.convert__text__representation().print("offset");
    }

    base__printing__indentation__increase();

    _extend_capacity__if__needed(
      (count + offset),
    );

    final offset__new = base__copy(
      storage,
      buffer,
      count: count,
      dest__offset: offset,
    ).dest__offset__new;

    if ((offset__implicit = offset__new) > size) {
      size = offset__new; /* _size__update */
    }

    base__printing__indentation__decrease();
  }

  uu write__append(
    final by__arr buffer,
    final uu count,
  ) {
    final offset = size;

    write(
      buffer,
      count,
      offset,
    );

    return offset;
  }

  /*void write__fill(
    final uu count,
    final uu offset, [
    final by? value,
  ]) {
    if (value !=  null) {
      _check__aligned__if__needed(count, offset);
    }

    final offset__new = (count + offset);

    _storage__memory__extend_capacity__if__needed(offset__new);

    if (value !=  null) {
      by__array__fill(
        storage.arr,
        count: count,
        offset: offset,
        value: value,
      );
    }

    _size__update__if__needed(offset__new);
  }*/

  /*uu write__append__fill(final uu count, [final by? value]) {
    final offset = size;
    write__fill(count, size, value);
    return offset;
  }*/

  by__arr read__view(
    final uu count,
    final uu offset,
  ) {
    offset__implicit = (count + offset);

    return storage.view__partial(
      offset,
      count,
    );
  }

  void read(
    final by__arr buffer,
    final uu count,
    final uu offset,
  ) {
    if (debug__report_ing__ok) {
      base__function__call__print(
        "storage__memory.read",
        debug__label,
      );

      count.convert__text__representation().print("count");
      offset.convert__text__representation().print("offset");
    }

    base__printing__indentation__increase();

    _extend_capacity__if__needed(
      (count + offset),
    );

    offset__implicit = base__copy(
      buffer,
      storage,
      src__offset: offset,
      count: count,
    ).src__offset__new;

    base__printing__indentation__decrease();
  }

  base__kampa__member__dictionary //
      convert__members() {
    return {
      "size": size.convert__string(),
      "offset__implicit": offset__implicit.convert__string(),
    };
  }

  by__arr convert__bytes() {
    final by__arr bytes = by__arr(size);

    base__copy(
      bytes,
      storage,
      count: size,
    );

    return bytes;
  }

  void truncate(
    final uu size__new,
  ) =>
      (size = size__new);

  void close() {
    if (debug__report_ing__ok) //
      base__function__call__print(
        "storage__memory.close",
        debug__label,
      );

    //storage.mem_:free()
    storage = empty__by__arr;
  }
}
