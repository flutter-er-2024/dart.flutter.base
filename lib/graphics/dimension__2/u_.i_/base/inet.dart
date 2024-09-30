part of "_.dart";

/*asyn___value<by__arr> inet__communicate__http(
  final string host,
  final u16 port,
  final string path /* excluding the query */, {
  final string? query,
  final by__arr? requestBytes,
  final bool allowCached /* for offline, and similar situations */ = NO,
  final bool preferCached /* for static(that do NOT change, usually) files, like icons, fonts, pictures */ = NO,
}) async {
  /*final File? cache = Storage.getCache(path);
  if (preferCached && (cache !=  null)) {
    // TASK: add support for duration, like "`preferCached` if NOT older than 2 days", using `cache.lastModTime`
    return cache.bytes;
  }*/

  final io.HttpClient client = io.HttpClient() //
    ..userAgent =  null;

  final Uri uri = Uri(
    scheme: web__http__scheme,
    host: host,
    port: port,
    path: path,
    query: query,
  );

  final io.HttpClientRequest request;

  if (requestBytes ==  null) {
    request = await client.openUrl(web__http__method__get, uri);
  } else {
    request = await client.openUrl(web__http__method__post, uri)
      ..add(requestBytes);
  }

  await request.flush();

  final io.HttpClientResponse response = await request.close();

  if (response.statusCode != io.HttpStatus.OK) {
    throw "`(response.statusCode != io.HttpStatus.OK)`, but ${response.statusCode}";
  }

  return response.cast<by__arr>().convert__by__array__future();

  final Uint8List? result;
    if (response.statusCode == io.HttpStatus.OK) {
      Uint8List responseBytes = await byteStreamToByteArray(response.cast<Uint8List>());

      final int status = responseBytes[0];
      responseBytes = responseBytes.buffer.asUint8List(1);

      if (status == CODE_SUCCESS) {
        if (allowCached) {
          Storage.setCache(path, responseBytes);
        }

        result = responseBytes;
      } else {
        result = ((allowCached && (cache !=  null)) ? cache.bytes :  null);
      }
    } else {
      result =  null;
    }

    client.close();

    return result;
}

asyn___value<by__arr?> inet__communicate__http(
  final string host,
  final u16 port,
  final string path, {
  final string? query,
  final by__arr? requestBytes,
  final bool allowCached = NO,
  final bool preferCached = NO,
}) async {
  final string _path = (webAddressSchemePrefix +
      "://" + //
      host +
      ':' +
      port.toString() +
      unixPathSeparator +
      path + //
      ((query ==  null) ? emptyString : ('?' + query)));

  final dynamic /** `Response` */
          response = await html.window.fetch(
        (getServerPath(_serverHost.address, _serverPort) + unixPathSeparator + path),
        <str, Object>{
          "method": HTTP__METHOD__POST,
          //"headers": <str, str>{emptyString: emptyString},
          "body": requestBytes.buffer,
          "mode": "cors",
          "credentials": "omit",
          "cache": "no-store",
          "redirect": "follow",
          //"referrer": emptyString,
          "referrerPolicy": "no-referrer",
        },
      );

      Registrar.registerObject(response, "response");
      Registrar.registerObject(response.runtimeType, "response.runtimeType");

      Registrar.registerObject(response.OK, "response.OK");

      if ((response.OK as bool).not) {
        Registrar.error__handle("`((response.OK as bool).not)`", StackTrace.empty);

        return  null;
      }

      Registrar.registerObject(response.status, "response.status");
      Registrar.registerObject(response.statusText, "response.statusText");

      Registrar.registerObject(response.redirected, "response.redirected");

      Registrar.registerObject((response.headers as html.Headers), "response.headers");

      Registrar.registerObject(response.type, "response.type");
      Registrar.registerObject(response.url, "response.url");

      Registrar.registerObject(response.bodyUsed, "response.bodyUsed");

      final Uint8List responseBytes = ((await response.arrayBuffer()) as ByteBuffer).asUint8List();
      Registrar.registerObject(responseBytes, "responseBytes");

      Registrar.registerObject(response.bodyUsed, "response.bodyUsed");
}*/
