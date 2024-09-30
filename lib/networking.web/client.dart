part of "_.dart";

const //
    base__net___web__method__get = "GET",
    base__net___web__method__post = "POST",
    base__net___web__scheme__fix___pre = "http",
    base__net___web__scheme__secure__fix___pre = (base__net___web__scheme__fix___pre + "s");

typedef base__net___request__results = base__results__basic;

base__net___request__results? base__net___web__status__code__convert__summary(
  final uu status__code,
) {
  if ((status__code == /*HttpStatus.ok*/ 200) || ((status__code > 200) && (status__code < 300))) {
    return base__net___request__results.success;
  } else if ((status__code == 400) || ((status__code > 400) && (status__code < 500))) {
    return base__net___request__results.failure;
  } else if ((status__code == 500) || ((status__code > 500) && (status__code < 600))) {
    return base__net___request__results.failure__internal;
  } else {
    return NIL;
  }
}

class base__net___web__response<response__type> {
  const base__net___web__response(
    this.status__code,
    this.response,
  );

  final uu status__code;
  final response__type response;

  base__net___request__results? //
      status__code__summary() => //
          base__net___web__status__code__convert__summary(
            status__code,
          );
}

asyn___value<http_.StreamedResponse> //
    base__net___reliable__web__client__communicate__basic(
  final string path, [
  final by__arr? request__body,
  final dictionary<string, string>? headers,
]) /*
throws `SocketException` */
{
  final uri = Uri.parse(path..convert__text__representation().print("request:path"));

  final http_.Request request;
  if (request__body != null) {
    request = (http_.Request("POST", uri)
      ..headers[/*HttpHeaders.contentTypeHeader*/ "content-type"] = "application/json"
      ..headers[/*HttpHeaders.contentLengthHeader*/ "content-length"] = (request__body.elements__count..convert__text__representation().print("request:body:size")).toString()
      ..bodyBytes = request__body);
  } else {
    request = http_.Request("GET", uri);
  }

  if (headers != null) {
    request.headers.addAll(headers);
  }

  return request.send();
}

asyn___value<base__net___web__response<java_script__type? /*if(result.string.empty:not) java_script__type else NUL*/ >> //
    base__net___reliable__web__client__communicate__type__post(
  final string path,
  final java_script__type request__body,
  final dictionary<string, string>? headers,
) async {
  final //
      response = await base__net___reliable__web__client__communicate__basic(
        path,
        string__convert__utf_8__bytes(
          java_script__object__convert__string(
            request__body,
          )..convert__text__representation().print("request:body:java_script:object"),
        )..elements__count.convert__text__representation().print("request:body:size"),
        headers,
      ),
      response__string = await utf_8__u8__array__Stream__convert__string(
        response.stream,
      );

  return base__net___web__response(
    response.statusCode..convert__text__representation().print("response:status:code"),
    (response__string.empty__not()
        ? string__convert__java_script__object(
            response__string..convert__text__representation().print("response:string"),
          )
        : NIL),
  );
}
