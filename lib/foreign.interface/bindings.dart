part of "_.dart";

@ffi_.Native<ffi_.Pointer<ffi_.Int32> Function()>()
external ffi_.Pointer<ffi_.Int32> __errno_location();

@ffi_.Native<ffi_.Pointer<ffi_.Int32> Function()>()
external ffi_.Pointer<ffi_.Int32> __errno();

const //
    ffi__binding__errno_location = __errno_location,
    ffi__binding__errno = __errno;

//

@ffi_.Native<
    ffi_.Pointer<ffi_.NativeType> Function(
      ffi_.Size size,
    )>()
external ffi_.Pointer<ffi_.NativeType> malloc(
  final sz size,
);

@ffi_.Native<
    ffi_.Void Function(
      ffi_.Pointer<ffi_.NativeType> ptr,
    )>()
external void free(
  final ffi_.Pointer<ffi_.NativeType> ptr,
);

//

@ffi_.Native<
    ffi_.Int Function(
      ffi_.Int c,
    )>()
external s32 putchar(
  final s32 char__code,
);

@ffi_.Native<
    ffi_.Pointer<ffi_.Uint8> Function(
      ffi_.Int32 errnum,
    )>()
external ffi_.Pointer<ffi_.Uint8> strerrorname_np(
  final s32 errno,
);

@ffi_.Native<
    ffi_.Pointer<ffi_.Uint8> Function(
      ffi_.Int32 errnum,
    )>()
external ffi_.Pointer<ffi_.Uint8> strerrordesc_np(
  final s32 errno,
);

@ffi_.Native<
    ffi_.Int32 Function(
      ffi_.Pointer<ffi_.Pointer<ffi_.NativeType>> memptr,
      ffi_.Uint64 alignment,
      ffi_.Uint64 size,
    )>()
external s32 posix_memalign(
  final ffi_.Pointer<ffi_.Pointer<ffi_.NativeType>> ptr,
  final u64 alignment,
  final u64 size,
) /*
  error-code is NOT available through `ffi__errno(`, but `return`ed */
;

//

@ffi_.Native<
    ffi_.Int32 Function(
      ffi_.Pointer<ffi_.Uint8> pathname,
      ffi_.Int32 mode,
    )>()
external s32 access(
  final ffi_.Pointer<ffi_.Uint8> file__path,
  final u31 mode,
);

@ffi_.Native<
    ffi_.Int32 Function(
      ffi_.Pointer<ffi_.Uint8> pathname,
      ffi_.Int32 flags,
      ffi_.Uint32 mode,
    ) /*
  `int open(const char *pathname, int flags, mode_t mode);`
    $`man 2 open` */
    >()
external s32 open64(
  final ffi_.Pointer<ffi_.Uint8> file__path,
  final u31 flags,
  final u32 mode,
);

@ffi_.Native<
    ffi_.Int32 Function(
      ffi_.Int32 fd,
      ffi_.Int32 mode,
      ffi_.Int64 offset,
      ffi_.Int64 len,
    )>()
external s32 fallocate(
  final u31 fd,
  final u31 mode,
  final u63 offset,
  final u63 len,
);

@ffi_.Native<
    ffi_.Int64 Function(
      ffi_.Int32 fd,
      ffi_.Pointer<ffi_.Uint8> buf,
      ffi_.Uint64 count,
      ffi_.Int64 offset,
    )>()
external u63 pread64(
  final u31 fd,
  final ffi_.Pointer<ffi_.Uint8> buffer,
  final u64 count,
  final u63 offset,
);

@ffi_.Native<
    ffi_.Int64 Function(
      ffi_.Int32 fd,
      ffi_.Pointer<ffi_.Uint8> buf,
      ffi_.Uint64 count,
      ffi_.Int64 offset,
    )>()
external u63 pwrite64(
  final u31 fd,
  final ffi_.Pointer<ffi_.Uint8> buffer,
  final u64 count,
  final u63 offset,
);

@ffi_.Native<
    ffi_.Int32 Function(
      ffi_.Int32 fd,
      ffi_.Int64 length,
    )>()
external s32 ftruncate64(
  final u31 fd,
  final u63 length,
);

@ffi_.Native<
    ffi_.Int32 Function(
      ffi_.Int32 fd,
    )>()
external s32 fdatasync(
  final u31 fd,
);

@ffi_.Native<
    ffi_.Int32 Function(
      ffi_.Int32 fd,
    )>()
external s32 fsync(
  final u31 fd,
);

@ffi_.Native<
    ffi_.Int32 Function(
      ffi_.Int32 fd,
    )>()
external s32 close(
  final u31 fd,
);

final //
    ioctl__name = "ioctl",
    ioctl__u64__ptr = library__global.lookupFunction<
        ffi_.Int32 Function(ffi_.Int32 fd, ffi_.Uint64 request, ffi_.Pointer<ffi_.Uint64>) /*
  `int ioctl(int fd, unsigned long request, ...);`
    $`man 2 ioctl` */
        ,
        s32 Function(u31 fd, u64 request, ffi_.Pointer<ffi_.Uint64>)>(
      ioctl__name,
      isLeaf: false,
    ),
    ioctl__s32__ptr = library__global.lookupFunction<
        ffi_.Int32 Function(ffi_.Int32 fd, ffi_.Uint64 request, ffi_.Pointer<ffi_.Int32>), //
        s32 Function(u31 fd, u64 request, ffi_.Pointer<ffi_.Int32>)>(
      ioctl__name,
      isLeaf: false,
    );
