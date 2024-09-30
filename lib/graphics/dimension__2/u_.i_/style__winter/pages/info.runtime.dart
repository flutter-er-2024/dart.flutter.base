part of "../_.dart";

string Size__convert__string(final Size size) => //
    ("Width: ${size.width}"
        "\n"
        "Height: ${size.height}");

string EdgeInsets__convert__string(final EdgeInsets edgeInsets) => //
    (((edgeInsets.top == 0) &&
            (edgeInsets.left == 0) && //
            (edgeInsets.right == 0) &&
            (edgeInsets.bottom == 0)) //
        ? "EdgeInsets.zero"
        : ("EdgeInsets("
            "top: ${edgeInsets.top.toStringAsFixed(1)}, "
            "left: ${edgeInsets.left.toStringAsFixed(1)}, "
            "right: ${edgeInsets.right.toStringAsFixed(1)}, "
            "bottom: ${edgeInsets.bottom.toStringAsFixed(1)})"));

class base__program__info__page__depository //
    extends base__widget__depository__base {
  base__program__info__page__depository() //
      : scroll__manager = scroll__manager__kampa();

  final scroll__manager__kampa scroll__manager;

  @override
  base__widget widget(
    final base__widget__tree__node context,
  ) {
    final //
        border__radius = BorderRadius.all(Radius.circular(12.px)),
        mediaQueryData = MediaQuery.of(context),
        title_body__separator = SizedBox(
          height: 4.px,
        ),
        items = <base__widget>[
          base__list_ing__shell(
            items: <base__widget>[
              base__list_ing__shell__title(
                primary__string: "Primary view's Sizes",
                secondary__string: "NOTE: All values, are wrong, due to, our low-level mods",
              ),
              title_body__separator,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  mediaQueryData.devicePixelRatio.toString(),
                  "Screen's (Physical to Virtual) Pixel ratio",
                ),
              ),
              base__widget__separat_or__vertical,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  Size__convert__string(mediaQueryData.size),
                  "Emulated (or virtual) screen estate",
                ),
              ),
              base__widget__separat_or__vertical,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  Size__convert__string(mediaQueryData.size * mediaQueryData.devicePixelRatio),
                  "Real screen estate",
                ),
              ),
            ],
          ),
          base__list_ing__shell(
            items: <base__widget>[
              base__list_ing__shell__title(
                primary__string: "Primary view's Paddings",
              ),
              title_body__separator,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  mediaQueryData.viewPadding.toString(),
                  "Permanent",
                ),
              ),
              base__widget__separat_or__vertical,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  mediaQueryData.viewInsets.toString(),
                  "Temporary",
                ),
              ),
              base__widget__separat_or__vertical,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  mediaQueryData.padding.toString(),
                  "Combined",
                ),
              ),
            ],
          ),
          base__list_ing__shell(
            items: <base__widget>[
              base__list_ing__shell__title(
                primary__string: "Platform preferences",
                secondary__string: "Completely ignored by our system",
              ),
              title_body__separator,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  mediaQueryData.platformBrightness.toString().substring(11),
                  "Brightness",
                ),
              ),
              base__widget__separat_or__vertical,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  mediaQueryData.textScaler.scale(1).toString(),
                  "Text scale(or zoom) factor",
                ),
              ),
              base__widget__separat_or__vertical,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  mediaQueryData.boldText.toString(),
                  "Bold text",
                ),
              ),
              base__widget__separat_or__vertical,
              base__listing__item(
                border__radius: border__radius,
                body: base__box__text__primary__secondary(
                  mediaQueryData.alwaysUse24HourFormat.toString(),
                  "Always use \"24 Hour\" format (instead of AM/PM)",
                ),
              ),
            ],
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              program__compile__platform.convert__string(),
              "Platform",
            ),
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              program__compile__mode.convert__string(),
              "Build",
            ),
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              base__app__theme__colors__ground___back__dark__ok.toString(),
              "Dark interface switch\n"
              "Based on system time-of-day,\n"
              "And independent of user's preference",
            ),
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              app__interface__b__simple.toString(),
              "Simple interface switch\n"
              "(Accessibility optimized,\n"
              "For elder people, and\n"
              "Not \"Divyang Jan\"(Hindi lang))",
            ),
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              page__width.toString(),
              "Page width (value based on Screen's virtual width)",
            ),
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              size__pixel__1.toString(),
              "1 pixel(size) equivalent",
            ),
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              ('"' + storage__directory__permanent__path() + '"'),
              "Permanent-storage directory",
            ),
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              ('"' + storage__directory__cache__path() + '"'),
              "Cache-storage directory",
            ),
          ),
          base__listing__item(
            body: base__box__text__primary__secondary(
              ('"' + storage__directory__temporary__path() + '"'),
              "Temporary-storage directory",
            ),
          ),
          GestureDetector(
            child: base__listing__item(
              body: base__box__text__primary(
                "Explore file-system",
              ),
              trailing: base__icon(
                base__icon__navigation__forward,
              ),
            ),
            onTap: () {
              /*context.navigate__forward__overlay__bottom(
                    overlay__build: (final $context) => //
                        overlay__bottom__explorer__file_system(
                      context: $context,
                    ),
                  );*/ /* FIX */
            },
          ),
        ];

    return page__foundation(
      base__list_ing__generat_ed(
        context: context,
        scroll__manager: scroll__manager,
        page__title: base__page__title__aligned__center(
          primary__string: "Runtime Info.",
        ),
        item__array__count: items.length,
        item__build: (final _, final uu i) => //
            items[i],
      ),
    );
  }

  @override
  void dispose() {
    scroll__manager.dispose();
  }
}
