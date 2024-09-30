part of "../_.dart";

const IconData //
    base__icon__edit = flutter__icons.edit,
    base__icon__edit__outline = flutter__icons.edit_outlined,
    base__icon__info = flutter__icons.info_outline,
    base__icon__bulb__outline = flutter__icons.lightbulb_outline,
    base__icon__hint = base__icon__bulb__outline,
    base__icon__search = flutter__icons.search_sharp;

class input__text__filter__kampa {
  const input__text__filter__kampa(
    this.reg_ex_, [
    this.allow__ok = OK,
  ]);

  final string reg_ex_;
  final bool allow__ok;
}

const input__text__filter__kampa //
    input__text__filter__basic__numbers__ok = input__text__filter__kampa(r"[0-9]"),
    /*
  prefer `overlay__bottom__input__number` */
    input__text__filter__basic__word__single__ok = input__text__filter__kampa(r"[a-zA-Z'-]"),
    input__text__filter__basic__simple__ok = input__text__filter__kampa(r"[a-zA-Z0-9 ,._'()#\/@-]"),
    input__text__filter__basic__print_able__ok = input__text__filter__kampa(r"[ -~]"),
    input__text__filter__control__not = input__text__filter__kampa(r"[\x00-\x09\x0B-\x1F\x7F\x80-\x9F]",
        NO) /*
ASCII :
  `http://upload.wikimedia.org/wikipedia/commons/d/dd/ASCII-Table.svg`
Unicode :
  `http://en.wikipedia.org/wiki/List_of_Unicode_characters`,
  `http://en.wikipedia.org/wiki/Unicode_control_characters`,
  `http://en.wikipedia.org/wiki/C0_and_C1_control_codes`

NOTE :
  Always warn regarding the security implications of using Unicode,
  as available at `https://www.unicode.org/reports/tr36/` */
    ;

typedef input__text__submit__proc_ = //
    void Function(string input);

class base__input__text__depository //
    extends base__depository__base {
  base__input__text__depository({
    final string value__initial = empty__string,
  })  : _value = value__initial,
        channel = base__widget__re_build__event__channel__broadcast();

  final base__widget__re_build__event__channel__broadcast channel;

  string _value;

  TextEditingController? _control;

  string value() {
    return _value;
  }

  void value__set(
    final string value__new,
  ) {
    _value = value__new;

    _control?.text = value__new; /*
will invoke `channel.event__announce` */
  }

  TextEditingController //
      __control() {
    final $_control = _control;

    if ($_control != null) {
      return $_control;
    }

    final control = TextEditingController(
      text: _value,
    );

    control.addListener(() {
      _value = control.text;

      channel.event__announce();
    });

    return (_control = control);
  }

  @override
  void dispose() {
    _control?.dispose();

    channel.dispose();
  }
}

typedef base__input__text__border = ({
  BorderRadius radius,
  Color color,
  fp width,
});

extension base__input__text__border__convert__InputBorder__extension on base__input__text__border? {
  InputBorder convert__InputBorder() {
    final border = this;

    if (border == null) {
      return InputBorder.none;
    }

    return OutlineInputBorder(
      borderRadius: border.radius,
      borderSide: BorderSide(
        color: border.color,
        width: border.width,
      ),
    );
  }
}

base__widget base__input__text__base({
  required final base__input__text__depository depository,
  required final base__widget__focus__depository focus__depository,
  final EdgeInsets pad_ing = EdgeInsets.zero,
  final base__input__text__border? border,
  final base__input__text__border? border__focus,
  final base__input__text__border? border__error /*
if focus-ed ,otherwise `border` */
  ,
  final string? hint,
  final TextStyle? hint__text__style,
  final TextInputType input__type = TextInputType.text,
  final TextInputAction input__submit__indicat_or = TextInputAction.done,
  final TextCapitalization input__capital_ization__behavior = TextCapitalization.none,
  final uu input__char_s__count__max = u8__max,
  final input__text__filter__kampa input__filter = input__text__filter__basic__print_able__ok,
  final base__widget Function(
    base__widget__tree__node context,
    uu char_s__count,
    uu char_s__count__max,
    bool focus_ed__ok,
  )? char_s__count__indicate__build,
  final procedure__empty__format? submit__handle /*
not `submit:final:handle` */
  ,
  final TextStyle? input__text__style,
  final uu lines__max_ = 10,
  final uu lines__min_ = 1,
}) /*
de-focus-ing is not auto. 
  ,prefer invok-ing `store.focus:remove` ,in `submit:handle`
FIX :
  input, with number(s), as first(of input) char, instead of an alphabet, is receiv-ed through `app__key__broadcast`
    but (strangely) in-between numbers are directly(and correctly) receiv-ed, into input, and NOT through key broadcast
      ,most probably a {flutter-side}-issue */
{
  return base__material__widget(
    child: TextField(
      decoration: InputDecoration(
        contentPadding: pad_ing,
        border: border.convert__InputBorder(),
        enabledBorder: border.convert__InputBorder(),
        disabledBorder: border.convert__InputBorder(),
        focusedBorder: border__focus.convert__InputBorder(),
        focusedErrorBorder: border__error.convert__InputBorder(),
        errorBorder: border.convert__InputBorder(),
        hintText: hint,
        hintStyle: (hint__text__style ?? base__text__style()),
        hintMaxLines: lines__max_,
      ),
      controller: depository.__control(),
      focusNode: focus__depository.focus__node(),
      style: (input__text__style ?? base__text__style()),
      cursorOpacityAnimates: NO,
      cursorColor: color__foreground__dim,
      cursorRadius: Radius.circular(
        1.px,
      ),
      keyboardType: input__type,
      textInputAction: input__submit__indicat_or,
      textCapitalization: input__capital_ization__behavior,
      autofocus: focus__depository.focus_ed__ok(),
      maxLines: lines__max_,
      minLines: lines__min_,
      onEditingComplete: submit__handle /*
as check-ed in the source, of `EditableText`
  `onEditingComplete` provides better control, than `onSubmitted` */
      ,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(
          input__char_s__count__max,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
        ),
        FilteringTextInputFormatter(
          RegExp(input__filter.reg_ex_),
          allow: input__filter.allow__ok,
        ),
      ],
      keyboardAppearance: (base__app__theme__colors__ground___back__dark__ok //
          ? Brightness.dark
          : Brightness.light),
      scrollPhysics: scroll__physics__clamping,
      buildCounter: ((char_s__count__indicate__build == null) //
          ? null
          : (
              final context, {
              required final currentLength,
              required final maxLength,
              required final isFocused,
            }) =>
              char_s__count__indicate__build(
                context,
                currentLength,
                maxLength!,
                isFocused,
              )),
    ),
  );
}

base__widget base__input__text({
  required final string title,
  final string? sub_title,
  final string? info_,
  required final base__widget input__text /*base__input__text__base*/,
}) {
  final //
      border__radius = BorderRadius.all(
    Radius.circular(12.px),
  );

  return base__box__base(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size__pixel__padding__horizontal,
        vertical: size__pixel__padding__vertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <base__widget>[
          Padding(
            padding: EdgeInsets.only(
              top: size__pixel__padding__vertical,
              left: size__pixel__padding__horizontal__double,
            ),
            child: base__box__text__primary__secondary__auto(
              primary__string: title,
              secondary__string: sub_title,
            ),
          ),
          base__widget__separat_or__vertical,
          SizedBox(
            width: fp.maxFinite,
            child: base__box__non_button /* for `color__background__nested` bg */ (
              border__radius: border__radius,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size__pixel__padding__horizontal__double,
                ),
                child: input__text,
              ),
            ),
          ),
          if (info_ != null) ...[
            base__widget__separat_or__vertical,
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <base__widget>[
                SizedBox(
                  width: size__pixel__padding__horizontal,
                ),
                base__icon(
                  base__icon__hint,
                  size: 18.px,
                  color: color__foreground__dimmer,
                ),
                SizedBox(width: 4.px),
                base__box__text__secondary(
                  info_,
                ),
              ],
            ),
          ],
        ],
      ),
    ),
  );
}

base__widget base__input__text__search({
  required final base__widget body /*base__input__text__search__body*/,
}) /*
should be wrap-ed in a `GestureDetector` ,to navigate to a new page(or maybe an overlay)
  which has a `base__input__text__base` */
{
  return base__listing__item(
    border__radius: BorderRadius.all(
      Radius.circular(12.px),
    ),
    padding__vertical: size__pixel__padding__vertical,
    padding__leading: size__pixel__padding__horizontal,
    leading: base__icon(
      base__icon__search,
      color: color__foreground__dim,
    ),
    body: body,
  );
}

base__widget base__input__text__search__body({
  final string hint__title = "Search for",
  required final array<string> hint__items,
}) =>
    Wrap(
      children: <base__widget>[
        box__text__widget(
          hint__title,
          font__color: color__foreground__dim,
        ),
        SizedBox(
          width: 4.px,
        ),
        box__text__widget(
          hint__items.join(", "),
        ),
      ],
    );
