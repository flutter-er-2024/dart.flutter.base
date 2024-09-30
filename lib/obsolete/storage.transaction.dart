import "dart:io" as io;

import "../ascii.dart";
import "../_.dart";
import "../by.arr.dart";
import "../storage.native.dart";
import "../uu.dart";

abstract class Transaction {
  static const int COUNT_COPY_FILE_SAFE = 3;

  static const int //
      OPERATION_TYPE__APPEND = 0,
      OPERATION_TYPE__MODIFY = (OPERATION_TYPE__APPEND + 1),
      OPERATION_TYPE__CREATE = (OPERATION_TYPE__MODIFY + 1),
      OPERATION_TYPE__DELETE = (OPERATION_TYPE__CREATE + 1);

  static const FILE__NAME = '~';

  static RandomAccessFile? file;
  static int fileSize = 0;

  static Map<str, int> appendOperatedFilesPath = <str, int>{};
  static List<string> filesPathDeletionQueue = <string>[];

  static void initialize(final string storageDirPath) {
    //if (file !=  null) throw Exception();

    final string filePath = (storageDirPath + base__storage__file__path__separator + FILE__NAME);

    if (ReadOnlyFile.exists(filePath)) /** needs recovery */ {
      final RandomAccessFile _file = RandomAccessFile.open(filePath, FileOpenMode. /*TRUNCATE_AND_*/ READ_WRITE);

      final int _fileSize;

      final fileBytes = _file.read((_fileSize = _file.getSize()), 0);

      int byteCounter = 0;
      while (byteCounter < _fileSize) {
        final int type = fileBytes[byteCounter++];

        final string filePath = ascii__convert__str__ascii(fileBytes.sublist(byteCounter, fileBytes.indexOf(0, byteCounter)));
        byteCounter += 1;

        switch (type) {
          case OPERATION_TYPE__APPEND:
            RandomAccessFile.open(filePath, FileOpenMode.WRITE_ONLY)
              ..reSize(fileBytes.sublist(byteCounter, (byteCounter += u64__size)).buffer.asUint64List()[0])
              ..close();

            break;
          case OPERATION_TYPE__MODIFY:
            RandomAccessFile.open(filePath, FileOpenMode.WRITE_ONLY)
              ..rePosition(fileBytes.sublist(byteCounter, (byteCounter += u64__size)).buffer.asUint64List()[0])
              ..write(
                  fileBytes.buffer.asUint8List(
                    (byteCounter + u64__size),
                    fileBytes.sublist(byteCounter, (byteCounter += u64__size)).buffer.asUint64List()[0],
                  ),
                   null)
              ..close();

            break;
          case OPERATION_TYPE__CREATE:
            io.File(filePath).deleteSync();

            break;
          default:
            throw Error(/*"UN_KNOWN operation type, $type"*/);
        }
      }

      file = _file;
    } else {
      file = RandomAccessFile.open(filePath, FileOpenMode. /*TRUNCATE_AND_*/ /*WRITE_ONLY*/ READ_WRITE);
    }
  }

  static void _registerFileOperation(
    final string absoluteFilePath,
    final int type, [
    final by__arr? extraInfoBytes,
  ]) {
    final bytes = by__array__array__catinate(<by__arr>[
      str__ascii__convert__ascii(absoluteFilePath),
      (u8__arr(2) /* `..[0] = 0` which is default hence omitted */ ..[1] = type) /** this value could be cached in a static,  nullable variable, but c would anyways solve this */,
      if (extraInfoBytes !=  null) //
        extraInfoBytes,
    ]);

    final uu byteCount = bytes.length;

    //if (file ==  null) throw Exception();

    file!.write(
      bytes,
      fileSize,
      byteCount: byteCount,
    );

    fileSize += byteCount;
  }

  static void registerCreateFileOperation(
    final string absoluteFilePath,
  ) =>
      _registerFileOperation(
        absoluteFilePath,
        OPERATION_TYPE__CREATE,
      );

  static void registerAppendFileOperation(
    final string absoluteFilePath,
    final uu fileSize /** before append operation */,
  ) {
    if (appendOperatedFilesPath.containsKey(absoluteFilePath)) {
      return;
    }

    _registerFileOperation(
      absoluteFilePath,
      OPERATION_TYPE__APPEND,
      uu__convert__by__array__little_endian(fileSize, u64__size),
    );

    appendOperatedFilesPath.putIfAbsent(
      absoluteFilePath,
      () => fileSize,
    );
  }

  static void registerModifyFileOperation(
    final string absoluteFilePath,
    final ReadOnlyFile file,
    final uu position,
    final uu count,
  ) {
    final int? alreadyPresentFileSize = appendOperatedFilesPath[absoluteFilePath];

    final preservedBytes = file.read(
        (((alreadyPresentFileSize !=  null) && ((count + position) /** position after operation */ > alreadyPresentFileSize)) //
            ? (alreadyPresentFileSize - position)
            : count),
        position);

    _registerFileOperation(
      absoluteFilePath,
      OPERATION_TYPE__MODIFY,
      by__array__array__catinate(<by__arr>[
        (u64__arr(2)
              ..[0] = position
              ..[1] = preservedBytes.length)
            .buffer
            .asUint8List(),
        preservedBytes,
      ]),
    );
  }

  static void registerWriteFileOperation /** automatically detects, and switches from modify, to append operation, as required, based on `fileSize` */ (
    final string absoluteFilePath,
    final ReadOnlyFile file,
    final int filePosition,
    final int byteCount, {
    int? fileSize,
    final int byteCounter = 0,
  }) {
    final uu count /** actual count, of bytes (would be) written, to the file */;

    if (filePosition >= (fileSize ??= file.getSize())) /** purely append operation */ {
      registerAppendFileOperation(absoluteFilePath, fileSize);
    } else if (((count = (byteCount - byteCounter)) + filePosition) /** position after operation */ <= fileSize) /** `fileNewPosition` does NOT exceed `fileSize`, hence purely modify operation */ {
      registerModifyFileOperation(absoluteFilePath, file, filePosition, count);
    } else /** mix of modify, and append, operations */ {
      registerModifyFileOperation(absoluteFilePath, file, filePosition, (fileSize - filePosition));
      registerAppendFileOperation(absoluteFilePath, fileSize);
    }
  }

  static void registerDeleteFileOperation(
    final string absoluteFilePath,
  ) =>
      filesPathDeletionQueue.add(absoluteFilePath);

  static void complete() /** MUST be the last execution, of the calling function, else expect to be useless */
  {
    file!.close();
    file =  null;

    filesPathDeletionQueue.forEach((
      final string file__path,
    ) =>
        io.File(file__path).deleteSync());

    filesPathDeletionQueue.clear();
  }
}
