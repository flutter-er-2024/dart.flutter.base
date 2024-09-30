part of "_.dart";

typedef java_script__type = /*dictionary|arr|Object*/ dynamic;

typedef java_script__object = dictionary<string, /*Object?*/ dynamic>;

final string Function(Object?) java_script__object__convert__string = //
    (const convert.JsonEncoder()).convert;

final dynamic Function(string) string__convert__java_script__object = //
    (const convert.JsonDecoder()).convert;
