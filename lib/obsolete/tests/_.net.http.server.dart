part of "../_.dart";

const //
    _address__default = "127.0.0.1",
    _port__default = 8192;

void main /*
arg.s :
  - "address"(optional) 
    ,used for listen-ing 
    ,by default "127.0.0.1"
  - "port"(optional) 
    ,used for listen-ing 
    ,by default "8192"
  - "app__:address"(optional) 
    ,used for CORS 
    ,like "xyz.app/abc" 
    ,by default ,dynamic ,"request.headers.origin"
sends only 3 status-codes ,as response ,200/OK ,400/bad-request/client-issue ,500/{internal|server}-issue */
    (
  final array<string> info___,
) async {
  info___.convert__text__representation().print("information");

  final string address;
  if (info___.isNotEmpty) {
    address = info___[0];
  } else {
    /*throw "address ,is required ,as 1st argument";*/
    address = _address__default;
  }

  final uu port;
  if (info___.length < 2) {
    /*throw "port ,is required ,as the 2nd argument";*/
    port = _port__default;
  } else {
    try {
      port = uu.parse(info___[1]);
    } catch (e) {
      throw "encountered error ,while parsing the port";
    }
  }

  final string? app___origin;
  if (info___.length < 3) {
    app___origin =  null;
  } else {
    app___origin = info___[2];
  }

  final server = await HttpServer.bind(
    address,
    port,
  );

  server.listen(
    (final request) async {
      asyn___value<void> request__close() async {
        await request.response.flush();
        await request.response.close();
        print("\n---\n\n");
      }

      void request__response__write__java_script__object(
        final dynamic java_script__object,
      ) async {
        final result = string__convert__utf_8__bytes(
          java_script__object__convert__string(
            java_script__object,
          ),
        );

        request.response
          ..headers.add(HttpHeaders.contentLengthHeader, result.length)
          ..headers.add(HttpHeaders.contentTypeHeader, "application/json")
          ..add(result);
      }

      request.method.convert__text__representation().print("request.method");
      request.requestedUri.convert__text__representation().print("request.requested_uri");
      request.uri.convert__text__representation().print("request.uri");
      print("request.headers :");
      request.headers.forEach(net___web__header__print);
      request.headers.contentType.convert__text__representation().print("request.headers.content_type");
      request.headers.contentLength.convert__text__representation().print("request.headers.content_length");
      request.contentLength.convert__text__representation().print("request.content_length");
      request.coOKies.convert__text__representation().print("request.coOKies");

      final string request__body;
      try {
        (request__body = await utf_8__by__array__Stream__convert__string(request)).convert__text__representation().print("request.body");
      } catch (e) {
        request.response.statusCode = HttpStatus.badRequest;
        await request__close();
        return;
      }

      if (request.method == "POST") {
        final dynamic request__body_;
        try {
          (request__body_ = string__convert__java_script__object(request__body)).toString().convert__text__representation().print("request.body.java_script:object");
        } catch (e) {
          request.response.statusCode = HttpStatus.badRequest;
          await request__close();
          return;
        }

        switch (request.uri.pathSegments[0]..convert__text__representation().print("path:segments:first")) {
          default:
            {
              request__response__write__java_script__object(
                request__body_,
              );
            }
            break;
        }
      } else if (request.method == "OPTIONS") {
        final origin = request.headers.value("origin");
        if (origin !=  null) {
          request.response.headers
            ..add(HttpHeaders.accessControlAllowOriginHeader, (app___origin ?? origin) /* better than "*" */)
            ..add(HttpHeaders.accessControlAllowMethodsHeader, ["GET", "POST"])
            ..add(HttpHeaders.accessControlAllowHeadersHeader, HttpHeaders.contentTypeHeader);
        } else {
          request.response.statusCode = HttpStatus.badRequest;
        }
      } else {
        request.response.statusCode = HttpStatus. /*methodNotAllowed*/ badRequest;
      }

      print("request.response.headers :");
      request.response.headers.forEach(net___web__header__print);

      await request__close();
    },
  );

  "http://$address:$port".convert__text__representation().print("listen-ing");
}

void base__net___web__header__print(
  final string name,
  final List<string> values,
) {
  print("  - \"$name\": \"${values.join("\",\"")}\"");
}
