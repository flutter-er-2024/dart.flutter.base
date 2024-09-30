part of "../_.dart";

const IconData //
    icon__expand = flutter__icons.expand_more,
    icon__collapse = flutter__icons.expand_less;

base__widget base__button__icon__circled(
  final IconData icon,
  final VoidCallback on_press,
) =>
    GestureDetector(
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(
              color: color__foreground__dimmest,
              width: size__pixel__1,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(2.px),
          child: base__icon(
            icon,
            color: color__foreground__dim,
          ),
        ),
      ),
      onTap: on_press,
    );

/* base__widget base__listing__item__expandable({
  final BorderRadius? border__radius,
  bool b__expanded = NO,
  final base__widget? collapsed__leading,
  final void Function(procedure__empty collapse)? expand__handle,
  final void Function(procedure__empty expand)? collapse__handle,
  required final base__widget collapsed__body,
  required final base__widget Function(base__widget trailing) expanded__widget,
}) {
  procedure__empty__format? re_build;

  void expand() {
    b__expanded = OK;
    re_build?.call();
  }

  void collapse() {
    b__expanded = NO;
    re_build?.call();
  }

  return base__widget__build__definitive(
    init_: (final context) {
      re_build = context.re_build;
    },
    de_init_: (final context) {
      re_build = NIL;
    },
    build: (final _) {
      return (b__expanded
          ? expanded__widget(
              base__button__icon__circled(
                icon__collapse,
                () {
                  collapse();
                  collapse__handle?.call(expand);
                },
              ),
            )
          : GestureDetector(
              child: base__listing__item(
                border__radius: border__radius,
                leading: collapsed__leading,
                body: collapsed__body,
                trailing: base__icon(icon__expand),
                padding__trailing: size__pixel__padding__horizontal__double,
              ),
              onTap: () {
                expand();
                expand__handle?.call(collapse);
              },
            ));
    },
  );
} */
