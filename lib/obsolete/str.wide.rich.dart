part of "_.dart";

const ch //
    str__wide__rich__ch__escape = ch__slash__backward,
//
    str__wide__rich__type__text__un_styl_ed /*
  short-cut, for `str__wide__rich__text__style__not` */
    = 0,
    str__wide__rich__type__text = (1 + str__wide__rich__type__text__un_styl_ed),
    str__wide__rich__type__break = (1 + str__wide__rich__type__text),
    str__wide__rich__type__media = (1 + str__wide__rich__type__break),
    str__wide__rich__type__table = (1 + str__wide__rich__type__media),
//
    str__wide__rich__text__style__not /*
  un-styl-ed */
    = 0,
    str__wide__rich__text__style__bold = (1 + str__wide__rich__text__style__not),
    str__wide__rich__text__style__heading = (1 + str__wide__rich__text__style__bold),
    str__wide__rich__text__style__title = (1 + str__wide__rich__text__style__heading),
    str__wide__rich__text__style__sub_heading = (1 + str__wide__rich__text__style__title),
    str__wide__rich__text__style__sub_title = (1 + str__wide__rich__text__style__sub_heading),
    str__wide__rich__text__style__link = (1 + str__wide__rich__text__style__sub_title),
    str__wide__rich__text__style__fade = (1 + str__wide__rich__text__style__link),
    str__wide__rich__text__style__code = (1 + str__wide__rich__text__style__fade),
    str__wide__rich__text__style__color /*
  background color, not font color, like highlight-ing
  intended, as a color-ful `text__style__bold`
  intitally, merely red was intended to be added, but to not constrain the user, all colors were supported */
    = (1 + str__wide__rich__text__style__code),
    str__wide__rich__text__style__super_script = (1 + str__wide__rich__text__style__color),
    str__wide__rich__text__style__sub_script = (1 + str__wide__rich__text__style__super_script),
    str__wide__rich__text__style__italic = (1 + str__wide__rich__text__style__sub_script),
    str__wide__rich__text__style__strike_through = (1 + str__wide__rich__text__style__italic),
//
    str__wide__rich__text__style__link__protocol__web /*__http*/ = 0,
    str__wide__rich__text__style__link__protocol__web__secure /*__https*/ = (1 + str__wide__rich__text__style__link__protocol__web),
//
    str__wide__rich__type__break__soft = 0,
    str__wide__rich__type__break__hard /* solid line */
    = (1 + str__wide__rich__type__break__soft),
//
    str__wide__rich__text__alignment__left = 0,
    str__wide__rich__text__alignment__center = (1 + str__wide__rich__text__alignment__left),
    str__wide__rich__text__alignment__right = (1 + str__wide__rich__text__alignment__center),
//
    str__wide__rich__text__indentation__same /* indentation un-chang-ed */ = 0,
    str__wide__rich__text__indentation__increase /* increase indentation */ = (1 + str__wide__rich__text__indentation__same),
    str__wide__rich__text__indentation__decrease /* decrease indentation */ = (1 + str__wide__rich__text__indentation__increase),
//
    str__wide__rich__indentation__bullet__none = 0,
    str__wide__rich__indentation__bullet__type__number = (1 + str__wide__rich__indentation__bullet__none),
    str__wide__rich__indentation__bullet__type__alphabet = (1 + str__wide__rich__indentation__bullet__type__number),
    str__wide__rich__indentation__bullet__type__number__roman = (1 + str__wide__rich__indentation__bullet__type__alphabet),
    str__wide__rich__indentation__bullet__type__circle__filled /* disc */ = (1 + str__wide__rich__indentation__bullet__type__number__roman),
//
    str__wide__rich__media__symbol /*
  symbols, un-available in unicode
    like complex mathematical formulas
  concept, also used, by `www.wikipedia.org` */
    = 0,
    str__wide__rich__media__picture /*
    non-inline graphics */
    = (1 + str__wide__rich__media__symbol),
    str__wide__rich__media__video = (1 + str__wide__rich__media__picture);

string str__wide__rich__text__style__convert__string(
  final u16 text__style,
) {
  const style__arr = [
    "not",
    "bold",
    "heading",
    "title",
    "sub_heading",
    "sub_title",
    "link",
    "fade",
    "code",
    "color",
    "super_script",
    "sub_script",
    "italic",
    "strike_through",
  ];

  if (text__style < style__arr.elements__count) //
    return style__arr[text__style];

  throw "un-known text.style, $text__style";
}

typedef str__wide__rich__text__segment__kampa = ({
  uu offset,
  uu count,
});

by__arr str__wide__rich__convert__bytes(
  final wstr
      str__wide__rich /*
  special insert-ion chars
    \{.|bld|ti|hd|sbt|shd|ln{address.de_limited.quote}|fd|cd|num|{clr|hlg}{RGB.hexa-decimal}|{sup|sub}|ita|skt}\
      text__{normal|bold|title|heading|sub_title|sub_heading|link__web|fade|code|number|{color|highlight}|{super|sub}_script|italic|strike_through}

    \-{s|h}{l{.|+{.|1|a|i|o}|-}|c|r}\
      break__{soft|hard}__alignment__{left__{indentation__un_changed|indent__increase__{none|number|alphabet|number__roman|circle__filled}|decrease}|center|right}

    \{sym|pic|vid}\{file.id};
      {symbol|picture|video}

    \tbl\
      table
        column are de-limit-ed through `ch__pipe`
          which MUST not exist in-column, unless escaped
        NOT rich-text

  UN-DEFINED
    `str__wide__rich__ch__escape` be escaped, like c
      prefix-ed, with, another `str__wide__rich__ch__escape`

  MUST
    text be insert(or flush)-ed(using `\.\`), before insert-ing, any, of, break, media, or table
      else handle `throw`

  TASK
    support latex and ascii-math, using the `\formula\` keyword */
  ,
) {
  if (debug__report_ing__verbose__ok) {
    base__function__call__print(
      "str__wide__rich__convert__bytes",
    );

    str__wide__rich.convert__text__representation().print("str__wide__rich");

    wstr__convert__string(str__wide__rich).convert__text__representation().print("str__wide__rich");
  }

  base__printing__indentation__increase();

  final //
      chars___count = str__wide__rich.elements__count,
      sink = base__by__array__accumulation__size__dynamic(),
      text__segment__accumulation__accumulation /* `(offset == count == 0)` indicates '\' */ = base__accumulation<accumulation<str__wide__rich__text__segment__kampa>>();

  uu str__search(
    final ch c,
    final uu offset,
  ) =>
      str__wide__rich.indexOf(
        c,
        offset,
      );

  uu //
      str__iter = 0,
      buffer__str__offset = str__iter;

  void report__str__context(
    final string? path, [
    final uu? id_,
  ]) =>
      report__array__element__context(
        str__wide__rich,
        chars___count,
        (id ?? str__iter),
        path,
      );

  uu str__read__integer(final ch c) {
    final id_ = str__search(
          c,
          str__iter,
        ),
        result = uu.parse(
          wstr__convert__string(
            str__wide__rich.view__partial(
              str__iter,
              (id - str__iter),
            ),
          ),
        );

    str__iter = (id + 1);

    return result;
  }

  void media__add(
    final ch type,
  ) {
    sink
      ..add(by__arr(2)
        ..[0] = str__wide__rich__type__media
        ..[1] = type)
      ..add__uu(
        str__read__integer(
          ch__colon__semi,
        ),
      );

    buffer__str__offset = str__iter;
  }

  var text__segment__list = base__accumulation<str__wide__rich__text__segment__kampa>();
  list__add__element(
    text__segment__list__list,
    text__segment__list,
  );

  void text__segment__list__check__empty(final uu str__iter_) {
    if (list__empty__not(text__segment__list)) {
      throw "un-inserted text, before $str__iter_";
    }
  }

  void text__segment__add(final uu str__iter_) => //
      list__add__element(text__segment__list, (
        offset: buffer__str__offset,
        count: (str__iter_ - buffer__str__offset),
      ));

  void text__add(
    final ch text__style,
    final sz escape__sequence__size,
  ) {
    text__segment__add(
      (str__iter - (escape__sequence__size + 2)),
    );

    uu count = 0;
    {
      list__iterate__basic(
        text__segment__list,
        (final _, final text__segment) => //
            (count += text__segment.count),
      );

      list__add__element(
        text__segment__list__list,
        (text__segment__list = list<str__wide__rich__text__segment__kampa>()),
      );
    }
    report__uu(
      count,
      "text__count",
    );

    if (text__style == str__wide__rich__text__style__not) //
      sink.add__byte(
        str__wide__rich__type__text__un_styl_ed,
      );
    else //
      sink.add(
        (by__arr(2)
          ..[0] = str__wide__rich__type__text
          ..[1] = text__style),
      );

    sink.add__uu(
      count,
    );
  }

  uu str__text__count(final ch c) {
    uu count = 0;

    bool b__continutation = NO;

    while (OK) {
      final str__offset = //
          (!b__continutation //
              ? str__iter
              : (str__iter - 1));

      str__iter = str__search(
        c,
        str__iter,
      );

      if (str__wide__rich[str__iter - 1] != str__wide__rich__ch__escape) {
        final count_ = (str__iter - str__offset);

        if /* un-likely */ (!((count_ == 0) /*
  un-known possibility, of condition, mere pre-caution */
            )) {
          list__add__element(text__segment__list, (
            offset: str__offset,
            count: count_,
          ));

          report__arr(
            str__wide__rich.view__partial(str__offset, count_),
            "break.segment",
            uu__report,
          );

          count += count_;
        }

        str__iter += 1;

        break;
      }

      if (!b__continutation) //
        b__continutation = OK;

      final count_ = ((str__iter - 1) - str__offset);

      if /* un-likely */ (!((count_ == 0) /*
  OK, when escap-ed `c`, is the first char */
          )) {
        list__add__element(text__segment__list, (
          offset: str__offset,
          count: count_,
        ));

        report__arr(
          str__wide__rich.view__partial(
            str__offset,
            count_,
          ),
          "segment",
          uu__report,
        );

        count += count_;
      }

      str__iter += 1;
    }

    return count;
  }

/*
  abc\.\
  abc\cd\
  \pic\123;
  \sym\0 */
  while (str__iter < chars___count) //
    if /* un-likely */ (str__wide__rich[str__iter++] == str__wide__rich__ch__escape) //
      switch (str__wide__rich[str__iter++]) {
        case ch__alphabet__case__lower__c:
          switch (str__wide__rich[str__iter++]) {
            case ch__alphabet__case__lower__d:
              switch (str__wide__rich[str__iter++]) {
                case str__wide__rich__ch__escape:
                  report__str__context("code", (str__iter - 4));
                  text__add(str__wide__rich__text__style__code, 2);
                  buffer__str__offset = str__iter;
                  break;
              }
              break;
          }
          break;

        case ch__alphabet__case__lower__p:
          switch (str__wide__rich[str__iter++]) {
            case ch__alphabet__case__lower__i:
              switch (str__wide__rich[str__iter++]) {
                case ch__alphabet__case__lower__c:
                  switch (str__wide__rich[str__iter++]) {
                    case str__wide__rich__ch__escape:
                      report__str__context("picture", (str__iter - 5));
                      text__segment__list__check__empty((str__iter - (3 + 2)));
                      media__add(str__wide__rich__media__picture);
                      break;
                  }
                  break;
              }
              break;
          }
          break;

        case ch__alphabet__case__lower__s:
          switch (str__wide__rich[str__iter++]) {
            case ch__alphabet__case__lower__y:
              switch (str__wide__rich[str__iter++]) {
                case ch__alphabet__case__lower__m:
                  switch (str__wide__rich[str__iter++]) {
                    case str__wide__rich__ch__escape:
                      report__str__context("symbol", (str__iter - 5));
                      text__segment__list__check__empty((str__iter - (3 + 2)));
                      media__add(str__wide__rich__media__symbol);
                      break;
                  }
                  break;
              }
              break;
          }
          break;

        case ch__alphabet__case__lower__t:
          switch (str__wide__rich[str__iter++]) {
            case ch__alphabet__case__lower__b:
              switch (str__wide__rich[str__iter++]) {
                case ch__alphabet__case__lower__l:
                  switch (str__wide__rich[str__iter++]) {
                    case str__wide__rich__ch__escape:
                      report__str__context("table", (str__iter - 5));
                      text__segment__list__check__empty((str__iter - (3 + 2)));
                      {
                        sink.add__byte(
                          str__wide__rich__type__table,
                        );

                        final u8 column__array__count;
                        {
                          final //
                              id_ = str__search(
                                ch__colon,
                                str__iter,
                              ),
                              column__b__number__arr = str__wide__rich.view__partial(
                                str__iter,
                                (id - str__iter),
                              );

                          sink.add__uu(
                            (column__array__count = column__b__number__arr.elements__count),
                          );

                          sink.add(by__array__new__generate(
                              column__array__count,
                              (final column__iter) => //
                                  ((column__b__number__arr[column__iter] != ch__number__one) /* b__not__number */
                                      ? 0
                                      : 1)));

                          str__iter = (id + 1);
                        } /* forked, from `str__read__integer` */

                        final row__array__count = str__read__integer(
                          ch__colon__semi,
                        );

                        sink.add__uu(
                          row__array__count,
                        );

                        base__iterate__basic(
                            row__array__count,
                            (final _) => //
                                base__iterate__basic(
                                    column__array__count,
                                    (final _) => //
                                        sink.add__uu(str__text__count(
                                          ch__pipe,
                                        ))));

                        buffer__str__offset = str__iter;
                      }
                      break;
                  }
                  break;
              }
              break;
          }
          break;

        case ch__dot:
          switch (str__wide__rich[str__iter++]) {
            case str__wide__rich__ch__escape:
              report__str__context("normal", (str__iter - 3));
              text__add(str__wide__rich__text__style__not, 1);
              buffer__str__offset = str__iter;
              break;
          }
          break;

        case ch__dash:
          switch (str__wide__rich[str__iter++]) {
            case str__wide__rich__ch__escape:
              report__str__context("break.soft", (str__iter - 3));
              text__segment__list__check__empty(str__iter - (1 + 2));
              sink.add__byte(str__wide__rich__type__break__soft);
              buffer__str__offset = str__iter;
              break;
          }
          break;

        case str__wide__rich__ch__escape:
          report__str__context("escape", (str__iter - 1));
          text__segment__add(str__iter - 1);
          buffer__str__offset = str__iter;
          break;
      }

  final //
      sink__size = sink.bytes__count,
      text__section = base__array__accumulation<wch>();

  list__iterate__basic(text__segment__list__list, (final _, final text__segment__list) {
    list__iterate__basic(
        text__segment__list,
        (final _, final text__segment) => //
            base__array__accumulation__add__arr(
              text__section,
              str__wide__rich.view__partial(
                text__segment.offset,
                text__segment.count,
              ),
            ));
    list__flush(text__segment__list);
  });
  list__flush(text__segment__list__list);

  final result = by__array__array__catinate([
    uu__convert__bytes(
      sink__size,
    ),
    sink.convert__by__arr(),
    if (text__section.elements__count != 0) //
      wstr__convert__bytes(
        base__array__accumulation__convert__array(text__section),
      ),
  ]);

  base__printing__indentation__decrease();

  return result;
}

void str__wide__rich__bytes__convert__report(
  final by__arr bytes,
) {
  if (debug__report_ing__verbose__ok) //
    base__function__call__print(
      "str__wide__rich__bytes__convert",
      () {
        report__kampa__member__type__value(
          bytes,
          "bytes",
          by__array__report,
        );
      },
    );

  base__printing__indentation__increase();

  final //
      section__control__count = uu__bytes__convert(
        bytes,
      ),
      section__control = bytes__kampa(
        bytes.view__partial(
          section__control__count.count,
          section__control__count.value,
        ),
      ),
      section__text__offset = (section__control__count.value + section__control__count.count),
      section__text = ((section__text__offset != bytes.elements__count) //
          ? wstr__bytes__convert(
              bytes.view(
                section__text__offset,
              ),
            )
          : wstr(0));

  report__bys(
    section__control.bytes,
    "section.control",
  );

  report__arr(
    section__text,
    "section.text",
    uu__report,
  );

  uu section__text__offset_ = 0;

  wstr text__segment__read() {
    final //
        segment__count = section__control.read__uu().value,
        result = section__text.view__partial(
          section__text__offset_,
          segment__count,
        );
    section__text__offset_ += segment__count;

    return result;
  }

  while (section__control.bytes__offset < section__control__count.value) //
    switch (section__control.read__byte()) {
      case str__wide__rich__type__text:
        final //
            segment__style = section__control.read__byte(),
            segment = text__segment__read();

        report__wstr(
          segment,
          ("text." +
              str__wide__rich__text__style__convert__string(
                segment__style,
              )),
        );

        break;
      case str__wide__rich__type__media:
        switch (section__control.read__byte()) {
          case str__wide__rich__media__symbol:
            report__uu(
              section__control.read__uu().value,
              "symbol.file__id",
            );
            break;
          case str__wide__rich__media__picture:
            report__uu(
              section__control.read__uu().value,
              "media.picture.file__id",
            );
            break;
        }
        break;
      case str__wide__rich__type__table:
        final //
            column__array__count = section__control.read__uu().value,
            column__b__number__arr = array__new__generate(
                column__array__count,
                (final _) => //
                    section__control.read__byte()),
            row__array__count = section__control.read__uu().value;

        report__uu(
          column__array__count,
          "column__array__count",
        );

        report__arr(
          array__new__generate(
              column__array__count,
              (final column__id_) => //
                  (column__b__number__arr[column__id_] != 0)),
          "column__b__number__arr",
          bool__report,
        );

        report__uu(
          row__array__count,
          "row__array__count",
        );

        base__iterate__basic(row__array__count, (final row__id_) {
          base__printing__indentation__increase();
          report__info("row__arr[$row__id_]");
          base__iterate__basic(
            column__array__count,
            (final column__id_) => //
                report__wstr(
              text__segment__read(),
              "column__arr[$column__id_]",
            ),
          );
          base__printing__indentation__decrease();
        });
        break;
    }

  base__printing__indentation__decrease();
}
