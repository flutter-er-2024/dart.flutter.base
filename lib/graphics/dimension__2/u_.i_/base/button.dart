part of "_.dart";

class base__button__asyn___depository //
    extends base__depository__base {
  var waiting__ok = NO;

  @override
  void dispose() {}
}

base__widget base__button__asyn_(
  final base__button__asyn___depository depository, {
  required final base__widget Function(
    base__widget__tree__node context,
    bool waiting__ok,
  ) child,
  required final asyn___value<void> Function() press__handle,
}) {
  return base__widget__build__basic(
    build: (final context) => //
        base__gesture__press__handling__widget(
      () async {
        if (depository.waiting__ok.not) {
          depository.waiting__ok = OK;
          context.re_build__raw();

          void revert() {
            depository.waiting__ok = NO;
            context.re_build();
          }

          press__handle().handle(
            (final _) {
              revert();
            },
            (final _, final __) {
              revert();
            },
          );
        }
      },
      child(
        context,
        depository.waiting__ok,
      ),
    ),
  );
}
