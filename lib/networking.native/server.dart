part of "_.dart";

asyn___value<void> base__net___reliable__server__socket__close__safe(
  final net_.Socket socket,
) async {
  await socket.flush();
  await socket.close();

  socket.destroy();
}

asyn___value<void> base__net___reliable__server__simple({
  required final net_.InternetAddress address /*io.InternetAddress.fromRawAddress(ip__v4,type:io.InternetAddressType.IPv4)*/,
  required final u16 port,
  required final asyn___value<void> Function(net_.Socket client__socket /* must not be close-ed ,nor dispose-ed */) request__handle,
  final base__error__handle__proc_? request__listen__error__handle,
  final bool latency__low__ok = NO,
}) async {
  (await net_.NetworkInterface.list(
    includeLoopback: OK,
    includeLinkLocal: OK,
  ))
      .iterate__basic(
    (final _, final interface) {
      interface.convert__text__representation().print("NetworkInterface");
    },
  );

  final socket__server__central = await net_.ServerSocket.bind(
    address,
    port,
  )
    ..listen(
      (final client__socket) async {
        final //
            stop_watch = Stopwatch()..start(),
            client__address = base__net___address__port__convert__string(
              client__socket.remoteAddress.address,
              client__socket.remotePort,
            );

        "client.address".print(client__address);

        if (latency__low__ok) {
          if (NOT(client__socket.setOption(net_.SocketOption.tcpNoDelay, OK))) {
            throw "client.socket.option.t_c_p_.no_delay.set";
          }
        }

        await request__handle(
          client__socket,
        );

        stop_watch.stop();

        await base__net___reliable__server__socket__close__safe(
          client__socket,
        );

        "served in ${stop_watch.elapsedMicroseconds} micro-seconds".print(client__address);
      },
      onError: (
        final Object e,
        final StackTrace t,
      ) {
        (request__listen__error__handle ?? base__error__handle)(e, t);
      },
    );

  base__net___address__port__convert__string(
    socket__server__central.address.address,
    socket__server__central.port,
  ).convert__text__representation().print("server.socket.address");
}

asyn___value<void> base__net___reliable__server__simple__file /*
request responses :`base__results__basic` */
    ({
  required final net_.InternetAddress address,
  required final u16 port,
  required final string directory__path,
}) {
  final //
      result__success__code__by__arr = (by__arr(1)..element__first = base__results__basic.success.index),
      result__failure__code__by__arr = (by__arr(1)..element__first = base__results__basic.failure.index),
      result__error__code__by__arr = (by__arr(1)..element__first = base__results__basic.failure__internal.index);

  return base__net___reliable__server__simple(
    address: address,
    port: port,
    request__handle: (final socket) async {
      final by__arr request;
      try {
        request = await by__array__Stream__convert__by__array__asyn___value(
          socket,
        );
      } catch (e, t) {
        base__error__handle(e, t);
        socket.add(result__error__code__by__arr);
        return;
      }

      final string file__path;
      try {
        file__path = str__convert__string(
          request,
        )..convert__text__representation().print("net:server:simple:file:request:file:path");
      } catch (e, t) {
        base__error__handle(e, t);
        socket.add(result__failure__code__by__arr);
        return;
      }

      try {
        final file = io_.File(
          (directory__path + base__storage__file__path__separator + file__path),
        );

        if (file.existsSync().not) {
          socket.add(result__failure__code__by__arr);
        }

        socket
          ..add(result__success__code__by__arr)
          ..addStream(
            file.openRead(),
          );
      } catch (e, t) {
        base__error__handle(e, t);
        socket.add(result__error__code__by__arr);
        return;
      }
    },
  );
}
