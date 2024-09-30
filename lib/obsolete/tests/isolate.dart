part of "../_.dart";

asyn___value<void> process(
  final SendPort port__send,
) async {
  Isolate.current.hashCode.convert__text__representation().print("Isolate.current.hashCode");

  final ReceivePort port__receive = ReceivePort()
    ..listen(
      (final Object? message) async {
        message.convert__text__representation().print("in.port__receive.listen.message");

        if (message is by__arr) {
          final by__array__kampa data = by__array__bytes__convert(message)
            ..convert__text__representation().print(
              "in.data__decoded.original",
               null,
              OK,
            );

          port__send.send(0);
        } else if (message is ss) {
          switch (message) {
            case 1:
              Isolate.current.kill();
              break;
            default:
              throw UnimplementedError();
          }
        } else {
          throw UnimplementedError();
        }
      },
      onDone: () {
        print__info("in: KILL-ing isolate NOW");
        Isolate.current.kill();
      },
    );

  port__send.send(port__receive.sendPort);
}

asyn___value<void> main /*isolate__test*/ () async {
  Isolate.current.hashCode.convert__text__representation().print("Isolate.current.hashCode");

  final by__array__kampa data = by__array__alloc(17) //
    ..convert__text__representation().print("out.data");

  late final SendPort port__send;

  final ReceivePort port__receive = ReceivePort()
    ..listen(
      (final Object? message) async {
        print__info("out.port__receive.listen.message: $message");

        if (message is int) {
          switch (message) {
            case 0:
              data.convert__text__representation().print(
                "out.data.new",
                 null,
                OK,
              );
              break;
            case 1:
              port__send.send(1);
              break;
            default:
              UnimplementedError();
          }
        } else if (message is SendPort) /* should be LAST, as this will only happen one-time */ {
          port__send = message//
          ..send(by__array__convert__bytes(data));
        } else {
          throw UnimplementedError();
        }
      },
      onDone: () {
        print__info("out.port__receive.listen.onDone");
      },
    );

  final Isolate isolate = await Isolate.spawn(
    process,
    port__receive.sendPort,
  );

  mem__free(data.ptr);
}
