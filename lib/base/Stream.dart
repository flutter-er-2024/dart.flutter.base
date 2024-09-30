part of "_.dart";

asyn___value<array<data__type>> Stream__convert__data__array__asyn___value<data__type>(
  final Stream<data__type> Stream_,
) /* forked from "by__array__Stream__convert__by__array__asyn___value" */ {
  final //
      $accumulation = base__accumulation<data__type>(),
      promise = asyn___promise<array<data__type>>();

  Stream_.listen(
    (final data) => $accumulation.add__element(data),
    onError: promise.completeError,
    onDone: () => promise.complete($accumulation.convert__array()),
    cancelOnError: OK,
  );

  return promise.future;
}

const //
    Stream__accumulate = Stream__convert__data__array__asyn___value;

asyn___value<by__arr> by__array__Stream__convert__by__array__asyn___value(
  final Stream<by__arr> Stream_,
) /* forked from core APIs, hence the correct approach, as of "March, 2023" */ {
  final //
      accumulation = base__by__array__accumulation(),
      promise = asyn___promise<by__arr>();

  Stream_.listen(
    (final by__arr data) => accumulation.add(data /*..count.convert__text__representation().print("byteStream.listen.onData.data.count")*/),
    onError: promise.completeError,
    onDone: () => promise.complete(accumulation.convert__by__arr()),
    cancelOnError: OK,
  );

  return promise.future;
}

void by__array__Stream__convert__messages({
  required final Stream<by__arr> Stream_,
  final sz message__size__size = u32__size,
  required final base__message__handle__procedure<by__arr> message__handle,
  required final close__procedure__format channel__close__handle,
  required final base__error__handle__proc_ channel__error__handle,
}) /*
  forked, from `by__array__Stream__convert__by__array__asyn___value` */
{
  final accumulation = base__by__array__accumulation();

  uu //
      count /* `left`, or remaining count */ = 0,
      data__count;

  Stream_.listen(
    (by__arr data) {
      data__count = (data..convert__text__representation().print("\n" "stream__by__arr.listen.onData.data")).bys__count;

      while (OK) {
        count.convert__text__representation().print("count");
        accumulation.bytes__count.convert__text__representation().print("accumulation.bytes__count");

        if (count != 0) {
          "1: (count != 0)".print();

          if (data__count < count) {
            "1.1: (data__count < count)".print();

            accumulation.add(data);
            count -= data__count;

            count.convert__text__representation().print("count.new");
            accumulation.bytes__count.convert__text__representation().print("accumulation.bytes__count.new");

            return;
          } else {
            "1.2".print();

            accumulation.add(data.view__partial(0, count));
            message__handle(accumulation.convert__by__arr()..convert__text__representation().print("reported"));
            accumulation.flush();
            data = data.view(count);
            data__count = (data__count - count);
            count = 0;
          }
        }

        if (count == 0) {
          "2: (count == 0)".print();

          count = (message__size__size - accumulation.bytes__count);

          if (data__count < count) {
            "2.1: (data__count < count)".print();

            accumulation.add(data);
            count = 0;

            count.convert__text__representation().print("count.new");
            accumulation.bytes__count.convert__text__representation().print("accumulation.bytes__count.new");

            return;
          } else {
            "2.2".print();

            accumulation.add(data.view__partial(0, count));
            data = data.view(count);
            data__count -= count;

            count = by__array__convert__uu__little_endian(
              accumulation.convert__by__arr(),
              message__size__size,
            );
            accumulation.flush();
          }

          count.convert__text__representation().print("count.new");
          accumulation.bytes__count.convert__text__representation().print("accumulation.bytes__count.new");
        }
      }
    },
    onError: (final Object e, final StackTrace t) {
      return channel__error__handle(e, t);
    },
    onDone: channel__close__handle,
    cancelOnError: OK,
  );
}
