part of "_.dart";

abstract class service__authority__base {
  const service__authority__base();

  asyn___value<void> handle();
}

class service__authority //
    extends service__authority__base {
  const service__authority(
    this.sources,
    this.data__handle,
  );

  final array<service__authority__source> sources /*
resolving is 
  ,from begin to end ,but stops if any source denies
    ,simply logical-OR towards denial */
      ;
  final asyn___value<base__widget?> Function(
    by__arr data,
  ) data__handle;

  @override
  asyn___value<void> handle() async {
    await base__iterate__asyn_(
      sources.elements__count,
      (final i) async {
        final //
            source = sources[i],
            data = await source.resolve();

        if (data != null) {
          final widget = await data__handle(
            data,
          );

          if (widget != null) {
            runApp(
              widget,
            );
          }

          return NO;
        }

        return OK;
      },
    );
  }
}

class service__authority__local //
    extends service__authority__base {
  const service__authority__local();

  @override
  asyn___value<void> handle() //
      =>
      empty__asyn___value__void;
}
