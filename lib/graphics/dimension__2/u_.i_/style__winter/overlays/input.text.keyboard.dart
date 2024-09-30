part of "../_.dart";

base__widget input__text__overlay__bottom__keyboard({
/*
`if(listing.size.height < (view.size.height + keyboard.size.height/*(view.size.height /2)*/))`
  the list is too short, hence the keyboard will overlap(and hide, partially, or fully) the input-field
  `listing.item.arr.count` can also heap determine the threshold/limit */
  required final base__widget page__widget,
}) /*
  the bottom row's work is in-complete
  the caps-lock key should have a small dot, at key's top-right corner, with padding from edge, which lights-up on activation
  shift, and caps-lock, keys should update all the alphabetic keys to change their case
  enter key, and done, keys, should be different, and enter is disabled/grey-ed, which input is single-line
  `_button` should have more more abstracted functions, for alphabets, numbers, specials, etc
  all the keys, available in ASCII, should be available
  all the keys should be present on the same pane
    hence no separate panes, for alphabets, symbols, and numbers
  emojis are not allowed, due to no-BS policy */
{
  const //
      row__numbers__key__array__count = language__hindi__numbers__count,
      row__numbers__key__value__offset = ch__ascii__number__zero,
//
      row__alphabets__key__array__count = row__numbers__key__array__count,
      row__alphabets__key__value__offset = ch__ascii__alphabet__case__lower__a,
      row__alphabets__1__key__array__count = row__alphabets__key__array__count,
      row__alphabets__1__key__value__offset = (row__alphabets__key__array__count + row__alphabets__key__value__offset),
      row__alphabets__2__key__array__count = (language__latin__english__alphabets__count - row__alphabets__1__key__array__count - row__alphabets__key__array__count),
      row__alphabets__2__key__value__offset = (row__alphabets__1__key__array__count + row__alphabets__1__key__value__offset),
//
      icon__key__backspace = flutter__icons.backspace_sharp,
      icon__key__capslock = flutter__icons.keyboard_capslock_sharp,
      icon__key__shift = flutter__icons.keyboard_arrow_up,
      icon__key__enter = flutter__icons.keyboard_return_sharp,
      icon__key__spacebar = flutter__icons.space_bar_sharp;

  base__widget _button({
    final bool b__highlight = NO,
    required final base__widget child,
    required final procedure__empty__format press__handle,
  }) {
    return Padding(
      padding: EdgeInsets.all(
        2.px,
      ),
      child: base__box__button(
        b__highlight: b__highlight,
        border__radius: BorderRadius.all(
          Radius.circular(6.px),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.px,
            ),
            child: child,
          ),
        ),
        onSinglePress: press__handle,
      ),
    );
  }

  return base__stack__widget(
    children: [
      page__widget,
      Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: page__width,
          child: ClipRect(
            child: BackdropFilter(
              filter: image__filter__blur__sensitive,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size__pixel__padding__horizontal,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    base__widget__separat_or__vertical,
                    Row(
                      children: array__new__generate(
                        row__numbers__key__array__count,
                        (final i) {
                          return Expanded(
                            child: _button(
                              child: box__text__widget(
                                string.fromCharCode(
                                  (i + row__numbers__key__value__offset),
                                ),
                              ),
                              press__handle: empty__procedure__empty,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 4.px,
                    ),
                    Row(
                      children: array__new__generate(
                        row__alphabets__key__array__count,
                        (final i) {
                          return Expanded(
                            child: _button(
                              child: box__text__widget(
                                string.fromCharCode(
                                  (i + row__alphabets__key__value__offset),
                                ),
                              ),
                              press__handle: empty__procedure__empty,
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: array__new__generate(
                        row__alphabets__1__key__array__count,
                        (final i) {
                          return Expanded(
                            child: _button(
                              child: box__text__widget(
                                string.fromCharCode(
                                  (i + row__alphabets__1__key__value__offset),
                                ),
                              ),
                              press__handle: empty__procedure__empty,
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _button(
                            b__highlight: OK,
                            child: base__icon(
                              icon__key__capslock,
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            b__highlight: OK,
                            child: base__icon(
                              icon__key__shift,
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        ...array__new__generate(
                          row__alphabets__2__key__array__count,
                          (final i) {
                            return Expanded(
                              child: _button(
                                child: box__text__widget(
                                  string.fromCharCode(
                                    (i + row__alphabets__2__key__value__offset),
                                  ),
                                ),
                                press__handle: empty__procedure__empty,
                              ),
                            );
                          },
                        ),
                        Expanded(
                          flex: 2,
                          child: _button(
                            b__highlight: OK,
                            child: base__icon(
                              icon__key__backspace,
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__bracket__round__open,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__bracket__round__close,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__comma,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: _button(
                            child: base__icon(
                              icon__key__spacebar,
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__question,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__dot,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            b__highlight: OK,
                            child: base__icon(
                              icon__key__enter,
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__dash,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__exclamation,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__question,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__bracket__round__open,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__bracket__round__close,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__colon,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__comma,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__colon__semi,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                        Expanded(
                          child: _button(
                            child: box__text__widget(
                              string.fromCharCode(
                                ch__ascii__dot,
                              ),
                            ),
                            press__handle: empty__procedure__empty,
                          ),
                        ),
                      ],
                    ),
                    base__widget__separat_or__vertical,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
