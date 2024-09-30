part of "../_.dart";

/*const file__segment__size = 8;

base__widget pages__file__page(
  final base__widget__tree__node context, {
  required final scroll__manager__kampa scroll__manager,
  required final string title,
  required final by__arr Function(
    uu count,
    uu position,
  ) fetch,
  required final uu count,
  final uu offset = 0,
}) /*
  file is a collection of bytes, so the page is actually general purpose
  TASK: currently, limited, to `io__buffer__size__default` */
{
  final by__arr file__bytes;

  final uu //
      segments__count,
      bytes__un_aligned__count;

  if (count > io__buffer__size__default) {
    file__bytes = fetch(io__buffer__size__default, offset);

    segments__count = (io__buffer__size__default ~/ file__segment__size);
    bytes__un_aligned__count = 0;
  } else {
    file__bytes = fetch(count, offset);

    segments__count = (count ~/ file__segment__size);
    bytes__un_aligned__count = ((count != io__buffer__size__default) //
        ? (count % file__segment__size)
        : 0);
  }

  bool b__aligned(final uu segment__counter) => //
      ((bytes__un_aligned__count == 0) || (segment__counter < segments__count));

  return page__foundation(
    base__list_ing__generat_ed(
      context: context,
      scroll__manager: scroll__manager,
      page__title: base__page__title__aligned__center(
        primary__string: file__path__convert__name(title),
        secondary__string: (count.toString() + " bytes"),
      ),
      page__briefing: Padding(
        padding: EdgeInsets.only(
          left: size__pixel__padding__horizontal,
          right: size__pixel__padding__horizontal,
          bottom: size__pixel__padding__vertical,
        ),
        child: base__listing__item__info(
          body: base__box__text__primary("Press to switch, between, raw, and ASCII encoding"),
        ),
      ),
      item__array__count: ((bytes__un_aligned__count > 0) //
          ? (segments__count + 1)
          : segments__count),
      item__build: (final _, final segment__counter) {
        final //
            b__aligned_ = b__aligned(segment__counter);

        final by__arr bytes;
        final array<string> string__binary;

        if (b__aligned_) {
          bytes = file__bytes.view__partial(
            (file__segment__size * segment__counter),
            file__segment__size,
          );

          string__binary = array<string>.generate(
            file__segment__size,
            (final i) => //
                bytes[i].toString(),
            growable: NO,
          );
        } else {
          bytes = file__bytes.view__partial(
            (file__segment__size * segment__counter),
            bytes__un_aligned__count,
          );

          string__binary = array<string>.filled(
            file__segment__size,
            empty__string,
            growable: NO,
          );

          base__iterate__basic(
              bytes__un_aligned__count,
              (final i) => //
                  (string__binary[i] = bytes[i].toString()));
        }

        array<string> string__current = string__binary;

        bool b__binary = OK;

        array<string>? string__ascii;

        return Row(
          children: <base__widget>[
            Expanded(
              flex: 2,
              child: base__box__non_button(
                border__radius: BorderRadius.all(Radius.circular(8.px)),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8.px,
                    left: size__pixel__1,
                    right: 2.px,
                    bottom: 8.px,
                  ),
                  child: box__text__widget(
                    (segment__counter + 1).toString(),
                    font__weight: FontWeight.w700,
                    text__align: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 4.px,
            ),
            Expanded(
              flex: file__segment__size,
              child: base__widget__build__definitive(
                build: (final state) {
                  final array<base__widget> row__children;

                  if (b__aligned_) //
                    row__children = array<base__widget>.generate(
                      file__segment__size,
                      (final i) => //
                          Expanded(
                        child: box__text__widget(
                          string__current[i],
                          font__size: 14.px,
                          text__align: TextAlign.end,
                        ),
                      ),
                      growable: NO,
                    );
                  else {
                    row__children = array<base__widget>.filled(
                      file__segment__size,
                      const Expanded(
                        child: empty__widget,
                      ),
                      growable: NO,
                    );

                    base__iterate__basic(
                        bytes__un_aligned__count,
                        (final i) => //
                            (row__children[i] = Expanded(
                              child: box__text__widget(
                                string__current[i],
                                font__size: 14.px,
                                text__align: TextAlign.end,
                              ),
                            )));
                  }

                  return GestureDetector(
                    child: base__listing__item(
                      padding__leading: size__pixel__padding__horizontal,
                      body: Row(
                        children: row__children,
                      ),
                      padding__trailing: size__pixel__padding__horizontal,
                    ),
                    onTap: () {
                      if (b__binary) {
                        string__current = //
                            (string__ascii ??= //
                                array<string>.generate(
                          (b__aligned_ //
                              ? file__segment__size
                              : bytes__un_aligned__count),
                          (final i) {
                            final c = bytes[i];

                            return (ch__ascii__valid__ok__and__printable(c) //
                                ? string.fromCharCode(c)
                                : ((c == ch__ascii__non_printable__line_feed) //
                                    ? r"\n"
                                    : string__binary[i]));
                          },
                          growable: NO,
                        ));

                        b__binary = NO;
                      } else {
                        string__current = string__binary;

                        b__binary = OK;
                      }

                      state.re_build();
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}*/
