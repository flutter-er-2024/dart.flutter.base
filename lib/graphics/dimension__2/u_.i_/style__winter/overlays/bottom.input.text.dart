part of "../_.dart";

const //
    input__text__work_station__type__ascii = "ASCII",
    input__text__work_station__type__unicode = "Unicode"; /*
  like `input__text__filter__kampa.regex__string` */

/*widget__stored__kampa input__text__overlay__bottom__work_station__stored({
  required final string title,
  final string? sub_title /* info */,
  final string hint /*
  including input__type(`input__text__work_station__type__`*) */
  = input__text__work_station__type__ascii,
  final bool input__b__simple /*
  single-line, not multi-line */
  = OK,
  final uu input__string__bytes__count__max = u8__max,
  final string? input__initial,
  required final void Function(
    wstr input,
    bool b__wide,
  ) input__submit,
}) /*
  using `by:arr`, instead of `wch:arr`, would directly increase the `input`'s memory efficiency, by at-most 4 times
    but would greatly decrease the time efficiency, due to the much needed, conversion, between, wstr, and wstr:bytes
      needed for each offset-caret's move operation
      and for supporting backspace, `char:size:stack` might be needed, else further decrease in time efficiency, on each backspace */
{
  final input__list = input__text__buffer(
    string__bytes__count__max: input__string__bytes__count__max,
    string__initial: ((input__initial != null)
        ? string__unicode__convert__wstr(
            input__initial,
          )
        : NIL),
  );

  bool input__write__char(
    final string s,
  ) {
    final //
        wc = char__unicode__convert__wch(
          s,
        ),
        b__written = input__list.write__append__wch(
          wc,
        );

    if (debug__report_ing__verbose__ok && //
        b__written) //
      report__uu(
        wc,
        "input.new.char",
      );

    return b__written;
  }

  bool input__write__string(
    final string s,
  ) {
    final //
        ws = string__unicode__convert__wstr(
          s,
        ),
        b__written = input__list.write__append__wstr(
          ws,
        );

    if (debug__report_ing__verbose__ok && //
        b__written) //
      report__wstr(
        ws,
        "input.new.string",
      );

    return b__written;
  }

  //uu? input__offset;

  string input__read() => //
      wstr__convert__string(
        input__list.read__full(),
      );

  void input__submit_() {
    final input = input__list.read__full();

    if (debug__report_ing__verbose__ok) //
      report__wstr(
        input,
        "input",
      );

    input__submit(
      input,
      input__list.b__wide,
    );
  }

  void Function(RawKeyEvent)? observer;

  final //
      scroll__manager_ = scroll__manager(),
      widget = overlay__bottom__menu(
        title: title,
        sub_title: sub_title,
        items__padding__horizontal: size__pixel__padding__horizontal,
        item__arr: <base__widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: (24 * 18).px,
            ),
            child: SizedBox(
              width: fp.maxFinite,
              child: base__box__non_button(
                border__radius: BorderRadius.all(Radius.circular(8.px)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size__pixel__padding__horizontal__double,
                    vertical: size__pixel__padding__vertical,
                  ),
                  child: base__widget__build__definitive(
                    init: (final state) {
                      app__key__broadcast.observer__add(
                        (observer = (final RawKeyEvent key) {
                          final //
                              key__data = key.data,
                              key__logical = key__data.logicalKey;

                          if (key__logical == LogicalKeyboardKey.backspace) {
                            if (key is RawKeyDownEvent) {
                              if (input__list.backspace()) //
                                state.re_build__raw();
                            }
                          } else {
                            final key__logical__b__enter = (key__logical == LogicalKeyboardKey.enter);

                            if (input__b__simple && key__logical__b__enter) //
                              input__submit_();
                            else {
                              final c = key.character;

                              if (c != null) {
                                if (key__logical__b__enter) {
                                  if (input__write__char('\n' /*
                `c` is 13(CR or carriage-return). */
                                      )) //
                                    state.re_build__raw();
                                } else if (key__data.isControlPressed) {
                                  switch (key__logical) {
                                    case LogicalKeyboardKey.keyV:
                                      system__clipboard__read__string().then(
                                        (final s) {
                                          if (s != null) {
                                            if (input__write__string(s)) //
                                              state.re_build();
                                          }
                                        },
                                      );
                                      break;
                                    case LogicalKeyboardKey.keyC:
                                      system__clipboard__write__string(
                                        text: input__read(),
                                      );
                                      break;
                                  }
                                } else {
                                  if (input__write__char(c)) //
                                    state.re_build__raw();
                                }
                              }
                            }
                          }
                        }),
                      );
                    },
                    de_init_: () {
                      final observer_ = observer;

                      if (observer_ != null) {
                        app__key__broadcast.observer__remove(
                          observer_,
                        );
                        observer = NIL;
                      }
                    },
                    build: (final state) => //
                        (input__b__simple //
                            ? $text(
                                input__read(),
                              )
                            : scrollable(
                                axis__direction: scroll__axis__direction__vertical__reverse,
                                controller: scroll__manager_.controller,
                                physics: scroll__physics__clamping,
                                extent__cache: base__list_ing__extent__cache__vertical,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: $text(
                                      input__read(),
                                    ),
                                  ),
                                ],
                              )),
                  ),
                ),
              ),
            ),
          ),
          base__widget__separat_or__vertical,
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: <base__widget>[
              SizedBox(
                width: 12.px,
              ),
              base__icon(
                icon__hint,
                color: color__foreground__dimmer,
              ),
              SizedBox(
                width: 4.px,
              ),
              box__text__widget(
                hint,
                font__color: color__foreground__dim,
                font__size: 14.px,
              ),
            ],
          ),
          base__widget__separat_or__vertical,
          Center(
            child: overlay__bottom__component__button__dismiss(
              "Submit",
              input__submit_,
            ),
          ),
          SizedBox(
            height: 16.px,
          ),
        ],
      );

  return widget__stored__kampa(
    de_init_: scroll__manager_.de_init_,
    widget__build: widget,
  );
}

base__widget $text(
  final string s,
) =>
    base__box__text__widget(
      base__box__text__segment(
        null,
        children: [
          base__box__text__segment(
            s,
          ),
          WidgetSpan(
            child: SizedBox(
              width: .5.px,
            ),
          ),
          WidgetSpan(
            child: ColoredBox(
              color: color__foreground__dim,
              child: SizedBox(
                height: 18.px,
                width: 1.5.px,
              ),
            ),
          ),
        ],
      ),
    );

base__widget listing__item__input__text__stored({
  final bool input__b__required /* mandatory field ? */ = NO,
  required final string title,
  final string? sub_title /* info */,
  required final string hint /*
  example, or sample */
  ,
  final string? input__initial,
  /*final bool b__chars___counter__show = NO,*/
  final TextInputType input__type = TextInputType.text,
  final TextInputAction input__submit__indicator = TextInputAction.done,
  final TextCapitalization input__capitalization = TextCapitalization.none,
  final uu input__chars___count__max = u8__max,
  final input__text__filter__kampa input__filter = input__text__filter__basic__print_able__ok,
  required final input__text__function__format input__submit,
  final bool indicator__edit_able__b__show = OK,
}) {
  var input = input__initial;

  final result = base__widget__build(
    (final context) => //
        GestureDetector(
      child: base__listing__item(
        body: (((input != null) && (input != input__initial)) //
            ? base__box__text__secondary__primary(
                secondary__string: title,
                primary__string: input!,
              )
            : (input__b__required
                ? base__box__text__primary__secondary__auto(
                    primary__string: title,
                    secondary__string: sub_title,
                  )
                : ((sub_title != null)
                    ? base__box__text__multi(
                        top: _title__optional(title),
                        bottom: base__box__text__secondary(sub_title),
                      )
                    : _title__optional(title)))),
        trailing: (indicator__edit_able__b__show //
            ? base__icon(icon__edit__outline)
            : NIL),
        padding__trailing: (indicator__edit_able__b__show //
            ? size__pixel__padding__horizontal__double
            : size__pixel__padding__horizontal),
      ),
      onTap: () {
        final overlay = input__text__overlay__bottom__phone__stored(
          title: title,
          sub_title: sub_title,
          hint: hint,
          input__initial: input,
          input__type: input__type,
          input__submit__indicator: input__submit__indicator,
          input__capitalization: input__capitalization,
          input__chars___count__max: input__chars___count__max,
          input__filter: input__filter,
          input__submit: (final input_) {
            input = input_;

            context.re_build__raw();

            context.navigate__backward();

            input__submit(
              input_,
            );
          },
        );

        context
            .navigate__forward__overlay__bottom(
          overlay__build: overlay.widget__build,
        )
            .then__result__ignore(() {
          overlay.dispose();
        });
      },
    ),
  );

  return result;
}

base__widget _title__optional(
  final string title,
) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <base__widget>[
        base__box__text__primary(
          title,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.px,
            right: 4.px,
          ),
          child: base__box__non_button(
            border__radius: BorderRadius.all(Radius.circular(16.px)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.px,
                vertical: 2.px,
              ),
              child: box__text__widget(
                "Optional",
                font__size: 12.px,
              ),
            ),
          ),
        ),
      ],
    );

widget__stored__kampa input__text__overlay__bottom__phone__stored({
  required final string title,
  final string? sub_title /* info */,
  final string? hint /*
  example, or sample */
  ,
  final string? input__initial,
  /*final bool b__chars___counter__show = NO,*/
  final TextInputType input__type = TextInputType.text,
  final TextInputAction input__submit__indicator = TextInputAction.done,
  final TextCapitalization input__capitalization = TextCapitalization.none,
  final uu input__chars___count__max = u8__max,
  final input__text__filter__kampa input__filter = input__text__filter__basic__print_able__ok,
  final bool b__recursive /*
  recursion: `input__text__overlay__bottom__phone__stored(`, in `input__submit` */
  = NO,
  required final input__text__function__format input__submit,
}) /*
  FIX
    when the call the recursive(`b__recursive` is OK)
      the inside(2nd) field's keyboard is NOT visible
        hence `auto_focus` should be not-working correctly */
{
  final //
      text__controller = TextEditingController(
        text: input__initial,
      ),
      focus__controller = FocusNode();

  /*if (!b__recursive) //
    focus__controller.addListener(() {
      if (!focus__controller.hasFocus) {
        input__submit(
          text__controller.text,
        ); /*
    `throw`s, concurrent-access error
      if `input__submit` has `navigate__`* calls, which calls `result.de_init_.focus__controller.dispose`
        hence, calling `observer`s, and `dispose`ing concurrent-ly */
      }
    });*/ /*
  submit op, should be explicit
    especially, backing-out should NOT submit */

  return widget__stored__kampa(
    de_init_: () {
      focus__controller.dispose();
      text__controller.dispose();
    },
    widget__build: (final context) => //
        overlay__bottom__menu(
      context: context,
      title: title,
      sub_title: sub_title,
      padding__bottom: ((0.5 * screen__size.height) /*
  FIX.long
    `overlay__bottom__menu`'s `screen__padding.bottom` as bottom padding, respecting virtual/soft keyboard, is NOT visible in GUI
      `build` is correctly called, with correct padding values, on keyboard visibility change
        but the GUI does not change, and keyboard draws over the input field, hence hiding it
      tried
        `base__widget__build__definitive` with `app__size__broadcast` listening and re-build-ing
          but no change in behavior
  half of screen height, is quite safe value, should not need any change
    the fix would merely increase correct-ness */
          +
          size__pixel__padding__vertical__double),
      vertical__b__expand: NO,
      item__arr: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size__pixel__padding__horizontal,
          ),
          child: SizedBox(
            width: rl.maxFinite,
            child: base__box__non_button(
              border__radius: BorderRadius.all(
                Radius.circular(8.px),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size__pixel__padding__horizontal__double,
                  vertical: size__pixel__padding__vertical,
                ),
                child: Localizations(
                  locale: app__locale,
                  delegates: app__local_izations__delegate,
                  child: base__input__text(
                    text__controller: text__controller,
                    focus__controller: focus__controller,
                    input__type: input__type,
                    input__submit__indicator: input__submit__indicator,
                    input__capitalization: input__capitalization,
                    input__chars___count__max: input__chars___count__max,
                    input__filter: input__filter,
                    input__complete: () {
                      focus__controller.unfocus();

                      final input = text__controller.text;
                      text__controller.clearkompoing();

                      input__submit(
                        input,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        base__widget__separat_or__vertical,
        if (hint != null) //
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: <base__widget>[
              SizedBox(
                width: size__pixel__padding__horizontal__double,
              ),
              base__icon(
                icon__hint,
                size: 18.px,
                color: color__foreground__dimmer,
              ),
              SizedBox(
                width: 4.px,
              ),
              base__box__text__secondary(
                hint,
              ),
            ],
          ),
      ],
    ),
  );
}*/
