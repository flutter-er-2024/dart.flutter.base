import "dart:io" as io;

import "../_.dart";
import "../print.dart";
import "../print.dart";

abstract class FileOpenMode {
  static const io.FileMode //
      READ_ONLY = io.FileMode.read,
      WRITE_ONLY = io.FileMode.writeOnlyAppend,
      READ_WRITE = io.FileMode.append,
      TRUNCATE_AND_READ_WRITE = io.FileMode.write,
      TRUNCATE_AND_WRITE_ONLY = io.FileMode.writeOnly;

  static const _prefixText = "FileOpenMode.";

  static string getModeText(final io.FileMode mode) {
    switch (mode) {
      case READ_ONLY:
        return (_prefixText + "READ_ONLY");
      case WRITE_ONLY:
        return (_prefixText + "WRITE_ONLY");
      case READ_WRITE:
        return (_prefixText + "READ_WRITE");
      case TRUNCATE_AND_READ_WRITE:
        return (_prefixText + "TRUNCATE_AND_READ_WRITE");
      case TRUNCATE_AND_WRITE_ONLY:
        return (_prefixText + "TRUNCATE_AND_WRITE_ONLY");
      default:
        throw Error(/*"UN_KNOWN `FileOpenMode`: \"$mode\""*/);
    }
  }
}

class ReadOnlyFile {
  static bool exists(final string path) => //
      io.File(path).existsSync()..convert__text__representation().print("ReadOnlyFile.exists(path: \"$path\")");

  static void create(
    final string path, [
    final bool recursive = NO,
  ]) {
    report__info("ReadOnlyFile.create(path: \"$path\", recursive: $recursive)");

    io.File(path).createSync(
      recursive: recursive,
    );
  }

  static ReadOnlyFile open(
    final string path, [
    final io.FileMode mode = FileOpenMode.READ_ONLY,
  ]) {
    report__info("ReadOnlyFile.open(path: \"$path\", mode: ${FileOpenMode.getModeText(mode)})");

    return ReadOnlyFile._(io.File(path).openSync(
      mode: mode,
    ));
  }

  const ReadOnlyFile._(
    this.file,
  );

  final io.RandomAccessFile file;

  string get _filePath => //
      "File(${file.path})";

  by__arr read(
    final int count,
    final int? position,
  ) {
    if (position !=  null) {
      file.setPositionSync(position);
    }

    return file.readSync(count)..convert__text__representation().print("$_filePath.read(count: $count, position: $position)");
  }

  by__arr read__full() {
    file.setPositionSync(0);
    return file.readSync(file.lengthSync());
  }

  int getPosition() => //
      file.positionSync()..convert__text__representation().print("$_filePath.getPosition()");

  void rePosition(final int newPosition) {
    getPosition();
    /** just to print, the current position, of the file */
    report__info("$_filePath.position(newPosition: $newPosition)");

    file.setPositionSync(newPosition);
  }

  void setPosition(final int newPosition) => //
      rePosition(newPosition);

  int getSize() => //
      file.lengthSync()..convert__text__representation().print("$_filePath.getSize()");

  void print([
    final int byteCount = 1024,
  ]) {
    final int size;

    file.setPositionSync(0);

    file
        .readSync(((size = file.lengthSync()) < byteCount) //
            ? size
            : byteCount)
        .convert__text__representation().print("$_filePath.convert__text__representation().print(fileSize: $size)");
  }

  void close() {
    report__info("$_filePath.close()");

    file.closeSync();
  }
}

class RandomAccessFile extends ReadOnlyFile {
  const RandomAccessFile(
    final io.RandomAccessFile file,
  ) : super._(file);

  static RandomAccessFile open(
    final string path, [
    final io.FileMode mode = FileOpenMode.READ_WRITE,
  ]) {
    report__info("RandomAccessFile.open(path: $path, mode: ${FileOpenMode.getModeText(mode)})");

    return RandomAccessFile(io.File(path).openSync(
      mode: mode,
    ));
  }

  void write(
    final by__arr bytes,
    final int? position, {
    final int byteCounter = 0,
    final int? byteCount,
  }) {
    report__info("$_filePath.write(bytes: (${bytes.length})$bytes, position: $position, byteCounter: $byteCounter, byteCount: $byteCount)");

    if (position !=  null) {
      file.setPositionSync(position);
    }

    file.writeFromSync(bytes, byteCounter, byteCount);
  }

  void append(
    final by__arr bytes, [
    final int byteCounter = 0,
    final int? byteCount,
  ]) =>
      write(
        bytes,
        getSize(),
        byteCounter: byteCounter,
        byteCount: byteCount,
      );

  void reSize(final int newSize) {
    getSize();
    /** just to print, the current size, of the file */
    report__info("$_filePath.reSize(newSize: $newSize)");

    file.truncateSync(newSize);
  }

  void setSize(final int newSize) => //
      reSize(newSize);

  void truncate(final int newSize) => //
      reSize(newSize);

  /*void sync() {
    report__info("$_filePath.sync()");

    file.flushSync();
  }*/ /* after the migration of ffi, each write call will automatically `fsync` */
}
