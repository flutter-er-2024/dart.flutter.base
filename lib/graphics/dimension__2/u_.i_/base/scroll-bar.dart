part of "_.dart";

/*
  does not work:
  `
    final Pointer<void Function(int)?> scroll_controller = Pointer<void Function(int)?>(null);

    return base__page__background(
      base__page__scroll_bar(
        itemCount: children.length,
        offset_controller: scroll_controller,
        listing: ListView.builder(
          itemCount: children.length,
          itemBuilder: (final _, final int i) {
            final void Function(int)? offset_controller = scroll_controller.value..convert__text__representation().print("scroll_controller.value");
            if (offset_controller !=  null) {
              offset_controller(i);
            }

            return children[i];
          },
        ),
      ),
    );` */
/*class base__page__scroll_bar extends StatefulWidget {
  const base__page__scroll_bar({
    super.key,
    required this.itemCount,
    required this.offset_controller,
    required this.listing,
  });

  final int itemCount;
  final Pointer<void Function(int)?> offset_controller;
  final Widget listing;

  @override
  State<component__page__scroll_bar> createState() => _component__page__scroll_bar__state();
}

class _component__page__scroll_bar__state extends State<component__page__scroll_bar> {
  late final fp indicator__height;
  late final Widget indicator;
  late fp indicator__offset;

  late int previousItemCounter;

  void offsetController(final int itemCounter) {
    itemCounter.convert__text__representation().print("`offsetController()`.`itemCounter`");

    if (itemCounter > previousItemCounter) {
      previousItemCounter = itemCounter;

      setState(() {
        indicator__offset = (itemCounter * indicator__height);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    indicator__offset = 0;
    (widget.offset_controller.value = offsetController)(previousItemCounter = 0);

    indicator = DecoratedBox(
      decoration: BoxDecoration(
        color: color__background__4,
        borderRadius: BorderRadius.all(Radius.circular(4.px)),
      ),
      child: SizedBox(
        width: 8,
        height: (indicator__height = (screen__size.height / widget.itemCount
          ..convert__text__representation().print("itemCount"))
          ..convert__text__representation().print("indicator__height")),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return base__stack__widget(
      children: <Widget>[
        widget.listing,
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: indicator__offset,
              ),
              indicator,
            ],
          ),
        ),
      ],
    );
  }
}*/
