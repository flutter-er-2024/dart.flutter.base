part of "../_.dart";

/*const //
    icon__directory__open = flutter__icons.folder_open,
    icon__file__open = flutter__icons.description_outlined;

string file__path__convert__name(final string file_path) => //
    file_path.substring(file_path.lastIndexOf(base__storage__file__path__separator) + 1);

const //
    file__mode__arr = <string>["---", "--x", "-w-", "-wx", "r--", "r-x", "rw-", "rwx"];

string _file__stat__mode__convert__string(
  final uu mode,
) /*
  forked from `dart-sdk/lib/io/file_system_entity.dart`::`FileStat`::`modeString` */
{
  final permissions = (mode & 0xFFF);

  return <string>[
    if ((permissions & 0x800) != 0) "(suid_)",
    if ((permissions & 0x400) != 0) "(guid_)",
    if ((permissions & 0x200) != 0) "(sticky)",
    file__mode__arr[(permissions >> 6) & 0x7],
    file__mode__arr[(permissions >> 3) & 0x7],
    file__mode__arr[permissions & 0x7],
  ].join();
}

base__widget overylays__file_system__in_existence__alert({
  required final base__widget__tree__node context,
  required final string path,
  required final bool type__directory__ok,
}) =>
    overlay__bottom__alert(
      context: context,
      title: path,
      sub_title: ((type__directory__ok ? "Directory" : "File") + " does NOT exist"),
    );

base__widget pages__directory__page({
  required final base__widget__tree__node context,
  required final scroll__manager__kampa scroll__manager,
  final string directory__path /*
  MUST exist
  could be empty */
  = '/',
  final bool choose__b__type__file /*
  user should be allowed to choose a, file, or directory */
  = OK /* file|directory */,
  required final void Function(string path) choose__handle,
}) {
  final dir = io.Directory(directory__path);

  /*if (!dir.existsSync()) //
    return overylays__file_system__in_existence__alert(
      directory__path,
      b__directory: OK,
    );*/

  final //
      file__arr = dir.listSync(
        followLinks: NO,
      ),
      file__array__count = file__arr.elements__count;

  return page__foundation(
    base__list_ing__generat_ed(
      context: context,
      scroll__manager: scroll__manager,
      page__title: base__page__title__aligned__center(
        primary__string: directory__path,
        secondary__string: (file__array__count.toString() + " file" + ((file__array__count > 1) ? 's' : empty__string)),
      ),
      item__array__count: file__array__count,
      item__build: (final _, final file__id_) {
        final //
            file = file__arr[file__id_],
            file__path = file.path,
            stat = file.statSync(),
            b__type__file = (stat.type == io.FileSystemEntityType.file),
            choose__b__allow = ((choose__b__type__file && b__type__file) || //
                (!choose__b__type__file && (stat.type == io.FileSystemEntityType.directory))),
            child = base__listing__item(
              body: base__box__text__primary__secondary(
                file__path__convert__name(file__path),
                (StringBuffer(b__type__file //
                        ? (getSeparatedString(stat.size.toString()) + "  bytes" '\n')
                        : empty__string)
                      ..write(stat.type.toString())
                      ..write("  (type)" '\n')
                      ..write(_file__stat__mode__convert__string(stat.mode))
                      ..write("  (mode)" '\n')
                      ..write(date_time__relative(stat.modified.toUtc()))
                      ..write("  (last mod)" '\n')
                      ..write(date_time__relative(stat.accessed.toUtc()))
                      ..write("  (last access)" '\n')
                      ..write(date_time__relative(stat.changed.toUtc()))
                      ..write("  (last (meta-data) change)"))
                    .toString(),
              ),
              trailing: Row(
                children: <base__widget>[
                  (b__type__file //
                      ? _button(icon__file__open, () {
                          final //
                              file = ReadOnlyFile.open(file__path),
                              $$scroll__manager = scroll__manager__kampa.create();

                          context
                              .navigate__forward__page(
                                page__build: (final $context) => //
                                    pages__file__page(
                                  $context,
                                  scroll__manager: $$scroll__manager,
                                  title: file__path,
                                  fetch: file.read,
                                  count: file.getSize(),
                                ),
                              )
                              .then__result__ignore(
                                $$scroll__manager.de_init_,
                              );
                        })
                      : _button(icon__directory__open, () {
                          final $$scroll__manager = scroll__manager__kampa.create();
                          context
                              .navigate__forward__page(
                                page__build: (final $context) => //
                                    pages__directory__page(
                                  context: $context,
                                  scroll__manager: $$scroll__manager,
                                  directory__path: file__path,
                                  choose__b__type__file: choose__b__type__file,
                                  choose__handle: choose__handle,
                                ),
                              )
                              .then__result__ignore(
                                $$scroll__manager.de_init_,
                              );
                        })),
                  SizedBox(
                    width: 4.px,
                  ),
                  (choose__b__allow //
                      ? base__icon(
                          base__icon__press_able,
                        )
                      : SizedBox.square(
                          dimension: 20.px,
                        ) /* `component__icon`'s size */),
                ],
              ),
            );

        return (!choose__b__allow //
            ? child
            : GestureDetector(
                onTap: () {
                  file__path.convert__text__representation().print(
                        "file__path",
                      );

                  choose__handle(
                    file__path,
                  );
                },
                child: child,
              ));
      },
    ),
  );
}

base__widget _button(
  final IconData icon,
  final procedure__empty__format press__handle,
) =>
    base__box__button(
      border__radius: BorderRadius.all(Radius.circular(8.px)),
      child: Padding(
        padding: EdgeInsets.all(4.px),
        child: base__icon(
          icon,
          size: 32.px,
        ),
      ),
      onSinglePress: press__handle,
    );*/
