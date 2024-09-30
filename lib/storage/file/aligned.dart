part of "../_.dart";

/*bool base__storage__file__fast__block__equal__ok(
  final base__storage__file__fast__block block,
  final base__storage__file__fast__block other,
) =>
    (block.offset == other.offset);

class base__storage__file__fast__block {
  const base__storage__file__fast__block({
    required this.offset,
    required this.buffer,
  });

  final uu offset /* aligned */ /* TASK: replace with `__reduced` */;
  final by__arr buffer;
}

/* called buffer-pool, by others */
class base__storage__file__fast__kampa /* `__caching`, `__high__perf__high__mem` */ {
  const base__storage__file__fast__kampa._({
    required this.storage,
    required this.blocks__cach_ed,
    required this.blocks__mod_ed,
    /*required this.free__list,*/
  });

  final base__storage__file__native__linux__meta__kampa storage;
  final base__stack /* TASK: replace with, either a search-able tree, or implement, placing most-frequently accessed block at last(first during iteration) */ <base__storage__file__fast__block> blocks__cach_ed /* called page-table, by others */;
  final base__accumulation<base__storage__file__fast__block> blocks__mod_ed /* modified blocks; need to be sync-ed, with persistent storage */;
  /*final list__kampa<by__array__kampa> free__list;/*
  TASK
    add support, and preference, over `by__array__alloc(`, in `_base__storage__file__fast__block__cache__if__needed(` */*/
}

base__storage__file__fast__kampa //
    base__storage__file__fast__new(
  final base__storage__file__native__linux__meta__kampa storage,
) =>
        base__storage__file__fast__kampa._(
          storage: storage,
          blocks__cach_ed: base__stack<base__storage__file__fast__block>(),
          blocks__mod_ed: base__accumulation<base__storage__file__fast__block>(),
          /*free__list: list__kampa<by__array__kampa>(),*/
        );

/*uu _iterations(final uu count__max) => //
  (count__max >> base__storage__file__block__size.shift__count);*/

base__storage__file__fast__block _base__storage__file__fast__block__cache__if__needed(
  final base__storage__file__fast__kampa storage,
  final uu offset,
) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "_base__storage__file__fast__block__cache__if__needed",
      storage.debug__label,
    );

    offset.convert__text__representation().print(
          "offset",
        );
  }

  base__printing__indentation__increase();

  base__storage__file__fast__block? block = //
      storage.blocks__cach_ed.contained((final block) => //
          (block.offset == offset)) /* if already cached */;

  if (block != null) {
    if (debug__report_ing__verbose__ok) {
      "already cached".print();
    }

    base__printing__indentation__decrease();

    return block;
  } else if (debug__report_ing__verbose__ok) {
    "caching".print();
  }

  final buffer = by__arr(
    base__storage__file__block__size.size,
  );

  base__storage__file__native__linux__read_write(
    storage.storage,
    buffer,
    base__storage__file__block__size.size,
    offset,
  );

  storage.blocks__cach_ed.add(//
      block = base__storage__file__fast__block(
    offset: offset,
    buffer: buffer,
  ));

  base__printing__indentation__decrease();

  return block;
}

void _base__storage__file__fast__block__mod__if__needed(
  final base__storage__file__fast__kampa storage,
  final base__storage__file__fast__block block,
) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "_base__storage__file__fast__block__mod__if__needed",
      storage.debug__label,
    );

    block.offset.convert__text__representation().print(
          "block__offset",
        );
  }

  base__printing__indentation__increase();

  if (storage.blocks__mod_ed.search(
        (final block_) => base__storage__file__fast__block__equal__ok(block, block),
      ) ==
      null) {
    if (debug__report_ing__verbose__ok) {
      "adding".print();
    }

    storage.blocks__mod_ed.add__element(block);
  } else if (debug__report_ing__verbose__ok) {
    "already present".print();
  }

  base__printing__indentation__decrease();
}

void base__storage__file__fast__read_write /* __caching */ (
  final base__storage__file__fast__kampa storage, {
  required final by__arr bytes,
  required uu count,
  required uu offset,
  final bool b__write = NO,
}) /*
  design
    throws `if ((count <= 0) || (offset < 0))`
    first of all, there are 2 choices
      `if(count <= base__storage__file__block__size.size)`
        because most of the ops are less than a block's size
        called fast(or hot) path
        also handles the case where `(count + offset)` makes the op, span over 2 consecutive blocks
      other wise a complex approach
        where the `(count + offset)` is converted into 3 parts, or steps
          all the bys before the next aligned block
            if the offset is perfectly aligned, with `base__storage__file__block__size`
              example: `write(count: 32768, offset: 8192)
              then skips this step
          all bys, from aligned offset, to aligned count
          all remaining bys, if any */
{
  if (debug__report_ing__ok) {
    base__function__call__print(
      ("storage." + (b__write ? "write" : "read")),
      storage.debug__label,
    );

    count.convert__text__representation().print("count");
    offset.convert__text__representation().print("offset");
  }

  base__printing__indentation__increase();

  if /* un-likely */ (!(count > 0)) //
    throw "$count(count) MUST be more than 0";

  if /* un-likely */ (offset < 0) //
    throw "$offset(offset) MUST be positive";

  final offset__aligned = base__storage__file__offset__aligned(offset);

  if (debug__report_ing__verbose__ok) {
    offset__aligned.convert__text__representation().print(
          "offset__aligned",
          storage.debug__label,
        );
  }

  base__printing__indentation__increase();

  if /* likely */ (!(count > base__storage__file__block__size.size)) /* fast-path */ {
    if (debug__report_ing__verbose__ok) {
      "Fast-path".print(storage.debug__label);
    }

    final //
        block = _base__storage__file__fast__block__cache__if__needed(
          storage,
          offset__aligned.offset__aligned,
        ),
        count_ = (((count + offset__aligned.buffer__offset) /* offset__new */ < base__storage__file__block__size.size) //
            ? /* single block op */ count
            : /* multi block op */ (base__storage__file__block__size.size - offset__aligned.buffer__offset));

    if (b__write) {
      base__copy(
        block.buffer,
        bytes,
        dest__offset: offset__aligned.buffer__offset,
        src__offset: 0,
        count: count_,
      );

      _base__storage__file__fast__block__mod__if__needed(
        storage,
        block,
      );
    } else {
      base__copy(
        bytes,
        block.buffer,
        dest__offset: 0,
        src__offset: offset__aligned.buffer__offset,
        count: count_,
      );
    }

    base__printing__indentation__increase();

    if /* un-likely */ ((count -= count_) != 0) /* multi block op */ {
      if (debug__report_ing__verbose__ok) {
        "Multi block op".print(storage.debug__label);
      }

      final block = _base__storage__file__fast__block__cache__if__needed(
        storage,
        (base__storage__file__block__size.size + offset__aligned.offset__aligned),
      );

      if (b__write) {
        base__copy(
          block.buffer,
          bytes,
          dest__offset: 0,
          src__offset: count_,
          count: count,
        );

        _base__storage__file__fast__block__mod__if__needed(
          storage,
          block,
        );
      } else {
        base__copy(
          bytes,
          block.buffer,
          dest__offset: count_,
          src__offset: 0,
          count: count,
        );
      }
    }

    base__printing__indentation__decrease();
  } else {
    if (debug__report_ing__verbose__ok) {
      "Normal-path".print(
        storage.debug__label,
      );
    }

    /*bytes__*/ offset = 0;

    uu offset__diff;

    base__printing__indentation__increase();

    if /* likely */ (offset__aligned.buffer__offset != 0) {
      if (debug__report_ing__verbose__ok) {
        "First step (un-aligned bys Before)".print(
          storage.debug__label,
        );
      }

      final //
          block = _base__storage__file__fast__block__cache__if__needed(
            storage,
            offset__aligned.offset__aligned,
          ),
          count_ = (base__storage__file__block__size.size - offset__aligned.buffer__offset);

      if (b__write) {
        base__copy(
          block.buffer,
          bytes,
          dest__offset: offset__aligned.buffer__offset,
          src__offset: 0,
          count: count_,
        );

        _base__storage__file__fast__block__mod__if__needed(
          storage,
          block,
        );
      } else {
        base__copy(
          bytes,
          block.buffer,
          dest__offset: 0,
          src__offset: offset__aligned.buffer__offset,
          count: count_,
        );
      }

      count -= count_;
      offset += count_;

      offset__diff = 0;
    } else /*
  `offset`(the argument) is already aligned */
    {
      offset__diff = -base__storage__file__block__size.size; /*
  TASK
    consider, removing, this, ugly, statement */
    }

    base__printing__indentation__decrease();

/*
  aligned-offset to aligned-count write
    TASK
      if `b__mod`(or write ops), and any block is not cached; instead of, first caching(actually reading), then writing, behaviour
        directly create the blocks, and add to, `block__cached__list`, and `block__moded__list`
          because the block would anyways be overwritten, so why read
      all the reads(or caches), should happen in a single syscall, instead of, per-block basis
        maybe, before the while loop, because the system alread has the info */

    final count__aligned = uu__aligned(
      count,
      base__storage__file__block__size.size,
      base__storage__file__block__size.shift__count,
    );

    if (debug__report_ing__verbose__ok) {
      count__aligned.convert__text__representation().print(
            "count__aligned",
            storage.debug__label,
          );
    }

    count = count__aligned.value__aligned;

    base__printing__indentation__increase();

    while (count != 0) {
      if (debug__report_ing__verbose__ok) {
        "while ($count != 0)".print(
          storage.debug__label,
        );
      }

      offset__diff += base__storage__file__block__size.size;

      final block = _base__storage__file__fast__block__cache__if__needed(
        storage,
        (offset__diff + offset__aligned.offset__aligned),
      );

      if (b__write) {
        base__copy(
          block.buffer,
          bytes,
          dest__offset: 0,
          src__offset: offset,
          count: base__storage__file__block__size.size,
        );

        _base__storage__file__fast__block__mod__if__needed(
          storage,
          block,
        );
      } else {
        base__copy(
          bytes,
          block.buffer,
          dest__offset: offset,
          src__offset: 0,
          count: base__storage__file__block__size.size,
        );
      }

      count -= base__storage__file__block__size.size;
      offset += base__storage__file__block__size.size;
    }

    if (count__aligned.remainder__un_aligned != 0) {
      if (debug__report_ing__verbose__ok) {
        "Last step (un-aligned bys After)".print(
          storage.debug__label,
        );
      }

      count = count__aligned.remainder__un_aligned;

      final block = _base__storage__file__fast__block__cache__if__needed(
        storage,
        ((offset__diff + base__storage__file__block__size.size) + offset__aligned.offset__aligned),
      );

/* `(count < base__storage__file__block__size.size)` is fact */

      if (b__write) {
        base__copy(
          block.buffer,
          bytes,
          dest__offset: 0,
          src__offset: offset,
          count: count,
        );

        _base__storage__file__fast__block__mod__if__needed(
          storage,
          block,
        );
      } else {
        base__copy(
          bytes,
          block.buffer,
          dest__offset: offset,
          src__offset: 0,
          count: count,
        );
      }
    }

    base__printing__indentation__decrease();
  }

  base__printing__indentation__decrease(2);
}

/*void write__direct /*__un_cached*/ (
    final bool Function(by__arr bytes) b__mod,
    final uu count,
    final uu offset,
  ) {
    if (debug__report_ing__ok) //
      print__info("storage.write__direct(count: $count, offset: $offset)");

    final //
        offset__aligned = base__storage__file__offset__aligned(offset),
        count__max = base__storage__file__count__max(count, offset__aligned.buffer__offset),
        buffer = by__arr(count__max);

    storage.read(
      buffer,
      count__max,
      offset__aligned.offset__aligned,
    );

    if (b__mod(buffer.view(offset__aligned.buffer__offset, count))) {
      storage.write(
        buffer,
        count__max,
        offset__aligned.offset__aligned,
      );
    }
  }*/ /*
  introduces, in-consistencies
    especially calling `storage.read(`
      if the block is already cached, then `sync(` will anyways overwrite the changes made through `write__direct(`, so why call it */

by__arr base__storage__file__fast__read__auto(
  final base__storage__file__fast__kampa storage, {
  required final uu count,
  required final uu offset,
}) {
  final bytes = by__arr(count);
  base__storage__file__fast__read_write(
    storage,
    bytes: bytes,
    count: count,
    offset: offset,
  );
  return bytes;
}

/*by__arr read__direct(
    final uu count,
    final uu offset,
  ) {
    by__arr bytes = empty__by__arr;

    write__direct((final bytes_) {
      bytes = bytes_;
      return NO;
    }, count, offset);

    return bytes;
  }*/ /* in-efficient */

void base__storage__file__fast__sync(
  final base__storage__file__fast__kampa storage,
) {
  if (debug__report_ing__ok) //
    base__function__call__print(
      "base__storage__file__fast__sync",
      storage.debug__label,
    );

  base__printing__indentation__increase();

  if (storage.blocks__mod_ed.empty__not()) {
    storage.blocks__mod_ed.iterate__basic(
      (final element) {
        if (debug__report_ing__verbose__ok) {
          element.offset.convert__text__representation().print(
                "block__moded__list__block__offset",
                storage.debug__label,
              );
        }

        base__storage__file__native__linux__read_write(
          storage.storage,
          element.buffer,
          base__storage__file__block__size.size,
          element.offset,
          b__write: OK,
        );
      },
    );

    storage.blocks__mod_ed.flush();
  }

  base__storage__file__native__linux__sync(
    storage.storage,
  );

  base__printing__indentation__decrease();
}

void base__storage__file__fast__flush(
  final base__storage__file__fast__kampa storage,
) /*
  SHOULD
    prefer calling `sync(`, before */
{
  if (debug__report_ing__ok) //
    base__function__call__print(
      "base__storage__file__fast__flush",
      storage.debug__label,
    );

  base__printing__indentation__increase();

  if (storage.blocks__cach_ed.empty__ok.not) {
    storage.blocks__cach_ed
      ..iterate__basic((final block) {
        /*free__list.add*/ /*block.buffer.mem_:free()*/
      })
      ..flush();
  }

  base__printing__indentation__decrease();
}

/*void base__storage__file__fast__free__if__not__needed() {
  if (debug__report_ing__ok) //
    print__info("storage.free__if__not__needed()");

  if (!(free__list.empty__ok)) //
    free__list.iterate__basic(by__array__free);
}*/*/
