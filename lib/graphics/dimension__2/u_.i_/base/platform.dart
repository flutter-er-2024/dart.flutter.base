part of "_.dart";

void base__platform__web__support__not__throw() {
  switch (base__program__compile__platform) {
    case base__program__compile__platforms.web:
      throw UnsupportedError("web platform not supported");

    default:
      return;
  }
}

asyn___value<void> base__platform__init_() async {
  if (debug__report_ing__verbose__ok) {
    base__program__compile__platform.convert__text__representation().print("base__program__compile__platform");
  }

  switch (base__program__compile__platform) {
    default:
      return;
  }
}
