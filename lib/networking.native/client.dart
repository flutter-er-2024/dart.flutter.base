part of "_.dart";

asyn___value<bool> base__net___connect_ed__ok({
  final string host = "example.com",
}) async {
  try {
    final result = await net_.InternetAddress.lookup(host);
    if (result.empty__not() && //
        result.element__first.rawAddress.empty__not()) {
      return OK;
    }
  } on net_.SocketException catch (_) {
  } catch (e) {
    rethrow;
  }

  return NO;
}

asyn___value<void> base__net___reliable__client__socket__close__safe(
  final net_.Socket socket,
) async {
  await socket.flush();
  await socket.close();
}

asyn___value<by__arr> base__net___reliable__client__simple__communicate({
  required final net_.InternetAddress address,
  required final u16 port,
  required final by__arr request,
}) async {
  final socket = await net_.Socket.connect(
    address,
    port,
  )
    ..setOption(
      net_.SocketOption.tcpNoDelay,
      OK,
    )
    /*..add(
      uu__convert__by__array__little_endian(
        request.bys__count,
        base__net___request__size__size,
      ),
    )*/
    ..add(
      request,
    );

  await base__net___reliable__client__socket__close__safe(
    socket,
  );

  final result = await by__array__Stream__convert__by__array__asyn___value(
    socket,
  );

  if (debug__report_ing__verbose__ok) {
    result.convert__text__representation().print("net___reliable__client__simple__response");
  }

  return result;
}
