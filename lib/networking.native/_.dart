library networking__native;

//

import "package:base/base/_.dart";

import "../storage/_.dart";

import "dart:io" as io_;
import "dart:io" as net_;

//

part "server.dart";
part "client.dart";

const base__net___request__size__size = u32__size;

final base__net___ip___local__v4 = by__arr.fromList(const [127, 0, 0, 1]);

asyn___value<bool> inet__connect_ed__ok({
  final string host = "example.com",
}) async {
  try {
    final result = await net_.InternetAddress.lookup(host);
    if (result.empty__not() && result.element__first.rawAddress.empty__not()) {
      return OK;
    }
  } catch (e) {
    if (e is net_.SocketException) {
    } else {
      rethrow;
    }
  }

  return NO;
}

string base__net___address__port__convert__string(
  final string address,
  final u16 port,
) =>
    (address + char__colon + port.toString());
