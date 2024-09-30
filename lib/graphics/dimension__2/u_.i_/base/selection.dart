part of "_.dart";

typedef widget__select_able__build__function__format = base__widget Function();

typedef base__selectable__switch__handle__function__format = //
    asyn___value<bool> Function(procedure__empty__format switch_);

base__widget base__select_able({
  final Key? key,
  bool selected__ok = NO,
  required final widget__select_able__build__function__format child__un_selected__build,
  required final widget__select_able__build__function__format child__selected__build,
  /*widget__select_able__build__function__format? de_selected,
  widget__select_able__build__function__format? re_selected,*/
  required final base__selectable__switch__handle__function__format selection__handle,
  required final base__selectable__switch__handle__function__format de_selection__handle,
}) =>
    base__widget__build__basic(
      key: key,
      build: (final state) => //
          base__gesture__press__handling__widget(
        () async {
          void switch_() {
            selected__ok = NOT(selected__ok);
            state.re_build();
          }

          if (await (selected__ok //
              ? de_selection__handle
              : selection__handle)(switch_)) //
            switch_();
        },
        (selected__ok //
            ? child__selected__build()
            : child__un_selected__build()),
      ),
    );
