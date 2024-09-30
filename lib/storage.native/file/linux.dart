part of "../_.dart";

const //
    base__storage__file__temporary__directory__path = "/tmp";

const //
    BLKGETSIZE64 = 2148012658,
    BLKPBSZGET = 4731; /*
  evaluated through the following code, compiled using debian.12.gcc.12 ```
#include <stdio.h>
#include <stdlib.h>

#include <linux/fs.h>

int main(void) {
  printf("%zu(BLKGETSIZE64), %d(BLKPBSZGET)\n", BLKGETSIZE64, BLKPBSZGET);

  return EXIT_SUCCESS;
}``` */

void _check(
  final s32 value /* `return`ed value */,
  final u31 error_no /* `ffi__errno__value()` */,
  final string error,
) {
  if (value < 0) {
    value.convert__text__representation().print("value");
    error_no.convert__text__representation().print("errno");

    final desc = ffi__errno__parsable__human(error_no);

    desc.name.convert__text__representation().print("..name");
    desc.desc.convert__text__representation().print("..desc");

    throw error;
  }
}

class base__storage__file__native__linux__meta__kampa {
  base__storage__file__native__linux__meta__kampa(
    this.fd,
  );

  u31 fd;
}

bool base__storage__file__native__linux__b__exists(
  final string file__path,
) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__file__native__linux__b__exists",
    );

    file__path.convert__text__representation().print("file__path");
  }

  base__printing__indentation__increase();

  final //
      file__path_ = ffi__string__convert(file__path),
      result = access(
        file__path_.ptr,
        /*F_OK*/ 0,
      ),
      errno = ffi__errno__value();

  by__array__free(file__path_);

  if (errno == /*ENOENT*/ 2) {
    if (debug__report_ing__verbose__ok) {
      result.convert__text__representation().print(
            "result",
          );
    }

    base__printing__indentation__decrease();

    return NO;
  }

  _check(
    result,
    errno,
    "access",
  );

  if (debug__report_ing__verbose__ok) {
    result.convert__text__representation().print(
          "result",
        );
  }

  base__printing__indentation__decrease();

  return (result == 0);
}

base__storage__file__native__linux__meta__kampa base__storage__file__native__linux /*__open__or__create*/ (
  final string file__path,
) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "base__storage__file__native__linux__open",
    );

    file__path.convert__text__representation().print(
          "file__path",
        );
  }

  base__printing__indentation__increase();

  final s32 fd;
  {
    final file__path_ = ffi__string__convert(file__path);

    fd = open64(
      file__path_.ptr,
      1069122,
      384,
    ) /* found through: ```
#define _GNU_SOURCE 1
#define _FILE_OFFSET_BITS 64

#include <stdlib.h>
#include <stdio.h>

#include <fcntl.h>

int main(void)
{
  printf(
    "%d(flags), %d(mode)\n",
    (((O_DSYNC | O_LARGEFILE) | O_SYNC | O_DIRECT) | O_CREAT | O_RDWR),
    (S_IRUSR | S_IWUSR));

  return EXIT_SUCCESS;
}``` */
        ;

    _check(
      fd,
      ffi__errno__value(),
      "open",
    );

    by__array__free(file__path_);
  }

  if (debug__report_ing__verbose__ok) {
    fd.convert__text__representation().print(
          "fd",
        );
  }
  final result = base__storage__file__native__linux__meta__kampa(
    fd,
  );

  base__printing__indentation__decrease();

  return result;
}

Stat base__storage__file__native__linux__stat(
  final base__storage__file__native__linux__meta__kampa storage,
) {
  final stat = fstat(storage.fd);

  if (stat == null) //
    throw "(stat ==  null)";

  return stat;
}

void base__storage__file__native__linux__block__size__check(
  final base__storage__file__native__linux__meta__kampa storage,
) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__file__native__linux__block__size__check",
      storage.debug__label,
    );

  base__printing__indentation__increase();

  final stat = base__storage__file__native__linux__stat(storage);

  if (debug__report_ing__verbose__ok) {
    stat.st_blksize.convert__text__representation().print(
          "block__size",
        );
  }
  if (stat.st_blksize != base__storage__file__block__size.size) //
    throw ("block__size != base__storage__file__block__size"
        "; prefer updating `base__storage__file__block__size`"
        ", to ${stat.st_blksize}, in the source code");

  base__printing__indentation__decrease();
}

uu base__storage__file__native__linux__size(
  final base__storage__file__native__linux__meta__kampa storage,
) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__file__native__linux__size",
      storage.debug__label,
    );

  base__printing__indentation__increase();

  final stat = base__storage__file__native__linux__stat(storage);

  if (debug__report_ing__verbose__ok) {
    stat.st_size.convert__text__representation().print(
          "size",
        );
  }
  base__printing__indentation__decrease();

  return stat.st_size;
}

u64 base__storage__file__native__linux__size__block_device(
  final base__storage__file__native__linux__meta__kampa storage,
) /*
  the size of the last (variable) arg, of `ioctl`
    was determined from the source code, of linux itself
      at `linux/block/ioctl.c`, then find-in-page for `BLKGETSIZE64`, or `BLKPBSZGET` */
{
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__file__native__linux__size__block_device",
      storage.debug__label,
    );

  base__printing__indentation__increase();

  final sz_ = ffi__mem__alloc<ffi.Uint64>(u64__size);

  _check(
    ioctl__u64__ptr(
      storage.fd,
      BLKGETSIZE64,
      sz_,
    ),
    ffi__errno__value(),
    "size",
  );

  if (debug__report_ing__verbose__ok) {
    sz_[0].convert__text__representation().print("size");
  }

  base__printing__indentation__decrease();

  return sz_[0];
}

u31 base__storage__file__native__linux__block__size__block_device(
  final base__storage__file__native__linux__meta__kampa storage,
) /*
  forked
    from `https://lists.gnu.org/archive/html/bug-parted/2012-10/msg00018.html`
      from "Yang Bai"
      titled "[PATCH] libparted: use ioctl(BLKPBSZGET) to get phys sector size"
      on "Wed, 17 Oct 2012"
      with relevant part ```
+        int phys_sector_size;
+            ioctl(arch_specific->fd, BLKPBSZGET, &phys_sector_size)``` */
{
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "base__storage__file__native__linux__block__size__block_device",
      storage.debug__label,
    );

  base__printing__indentation__increase();

  final sz_ = ffi__mem__alloc<ffi.Int32>(u32__size);

  _check(
    ioctl__s32__ptr(
      storage.fd,
      BLKPBSZGET,
      sz_,
    ),
    ffi__errno__value(),
    "block__size",
  );

  if (debug__report_ing__verbose__ok) {
    sz_[0].convert__text__representation().print("block__size");
  }

  base__printing__indentation__decrease();

  return sz_[0];
}

void base__storage__file__native__linux__allocate(
  final base__storage__file__native__linux__meta__kampa storage,
  final u64 size,
) =>
    _check(
      fallocate(
        storage.fd,
        0,
        0,
        size,
      ),
      ffi__errno__value(),
      "allocate",
    );

bool /*
  {success | end-of-file(ONLY during `!b__write`)}
    `throw` on failure */
    base__storage__file__native__linux__read_write(
  final base__storage__file__native__linux__meta__kampa storage,
  final ffi.Pointer<ffi.Uint8> buffer__aligned,
  u64 count__aligned,
  u63 offset__aligned, {
  final bool b__write = NO,
}) /*
  `buffer`, `count`, and `offset`, MUST be aligned, to `base__storage__file__block__size`
    `buffer__aligned` can be allocated using `ffi__function__posix_memalign(` */
{
  if (debug__report_ing__ok) {
    base__function__call__print(
      (!b__write //
          ? "base__storage__file__native__linux__read"
          : "base__storage__file__native__linux__write"),
      storage.debug__label,
    );

    count__aligned.convert__text__representation().print("count__aligned");
    offset__aligned.convert__text__representation().print("offset__aligned");
  }

  final operate_ = (!b__write //
      ? pread64
      : pwrite64);

  u64 buffer__address = buffer__aligned.address;
  ss count_;

  do {
    count_ = operate_(
      storage.fd,
      ffi.Pointer<ffi.Uint8>.fromAddress(buffer__address),
      count__aligned,
      offset__aligned,
    );

    if (count_ > 0) {
      if (debug__report_ing__verbose__ok) {
        count_.convert__text__representation().print(
              "operate count",
              storage.debug__label,
            );
      }

      buffer__address += count_;
      offset__aligned += count_;

      count__aligned -= count_;
    } else {
      _check(
        count_,
        ffi__errno__value(),
        "io error",
      );

      return NO;
    }
  } while (count__aligned != 0);

  return OK;
}

void base__storage__file__native__linux__truncate(
  final base__storage__file__native__linux__meta__kampa storage, [
  final u64 size__new = 0,
]) /*de_allocate*/ =>
    _check(
      ftruncate64(
        storage.fd,
        size__new,
      ),
      ffi__errno__value(),
      "truncate",
    );

void base__storage__file__native__linux__sync(
  final base__storage__file__native__linux__meta__kampa storage,
) {
  _check(
    fdatasync(
      storage.fd,
    ),
    ffi__errno__value(),
    "data sync",
  );

  _check(
    fsync(
      storage.fd,
    ),
    ffi__errno__value(),
    "sync",
  );
}

void report__base__storage__file__native__linux(
  final base__storage__file__native__linux__meta__kampa storage,
) {
  final size = base__storage__file__native__linux__size(
    storage,
  );

  size.convert__text__representation().print(
        "size",
      );
}

void base__storage__file__native__linux__close(
  final base__storage__file__native__linux__meta__kampa storage,
) =>
    _check(
      close(
        storage.fd,
      ),
      ffi__errno__value(),
      "close",
    );
