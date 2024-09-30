part of "_.dart";

class base__navigation__bottom__widget__depository //
    extends base__depository__base {
  base__navigation__bottom__widget__depository(
    final uu chosen__id_,
  ) : chosen__id___channel = base__value__alter__widget__re_build__event__channel__broadcast(
          chosen__id_,
        );

  final base__value__alter__widget__re_build__event__channel__broadcast<uu> chosen__id___channel;

  @override
  void dispose() {
    chosen__id___channel.dispose();
  }
}

base__widget base__navigation__bottom__widget({
  required final base__navigation__bottom__widget__depository depository,
  required final array<base__navigation__bottom__item> items,
}) {
  final chosen__id___channel = depository.chosen__id___channel;

  return base__event__channel__broadcast__handling__widget(
    channel: chosen__id___channel,
    build: (final context) {
      final chosen__id_ = chosen__id___channel.value();

      return Row(
        /*mainAxisAlignment: MainAxisAlignment.spaceAround,*/ /*
non-functional ,with `GestureDetector.behavior` ,being `HitTestBehavior.translucent` 
  ,while wrap-ing each `children`'s element ,with `Expanded` ,has equal effect */
        children: array__new__generate(
          items.elements__count,
          (final item__id_) {
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  final //
                      press__handle = items[item__id_].press__handle,
                      switch__ok = ((press__handle == null) //
                          ? OK
                          : await press__handle() /* TASK :indicate:activity while waiting */);

                  if (switch__ok.not) {
                    return;
                  }

                  chosen__id___channel.value__alter__and__announce__safe(
                    item__id_,
                  );
                },
                child: items[item__id_].build(
                  context,
                  (item__id_ == chosen__id_),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

class base__navigation__bottom__item {
  const base__navigation__bottom__item(
    this.build, [
    this.press__handle,
  ]);

  final base__widget Function(base__widget__tree__node context, bool chosen__ok) build;
  final asyn___value<bool /*switch:ok*/ > Function()? press__handle /*
called before chang-ing `item__chosen__id__channel` */
      ;
}
