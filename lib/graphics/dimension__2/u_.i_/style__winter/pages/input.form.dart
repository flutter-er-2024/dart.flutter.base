part of "../_.dart";

/*class Form extends StatefulWidget {
  static const u8 //
      TYPE_CHOICE_SINGLE = 0,
      TYPE_CHOICE_MULTIPLE = (TYPE_CHOICE_SINGLE + 1),
      TYPE_TEXT = (TYPE_CHOICE_MULTIPLE + 1),
//
      INPUT__TYPE__NUMBER = 0,
      INPUT__TYPE__NUMBER_MATH = (INPUT__TYPE__NUMBER + 1),
      INPUT__TYPE__NUMBER_PHONE = (INPUT__TYPE__NUMBER_MATH + 1),
      INPUT__TYPE__TEXT_WORD_SINGLE = (INPUT__TYPE__NUMBER_PHONE + 1),
      INPUT__TYPE__TEXT_LINE_SINGLE_RESTRICTED = (INPUT__TYPE__TEXT_WORD_SINGLE + 1),
      INPUT__TYPE__TEXT_LINE_SINGLE_UN__RESTRICTED = (INPUT__TYPE__TEXT_LINE_SINGLE_RESTRICTED + 1),
      INPUT__TYPE__TEXT_LINE_MULTI_ASCII = (INPUT__TYPE__TEXT_LINE_SINGLE_UN__RESTRICTED + 1),
      INPUT__TYPE__TEXT_LINE_MULTI_UNICODE = (INPUT__TYPE__TEXT_LINE_MULTI_ASCII + 1);

  const Form({
    super.key,
    required this.bytes,
  });

  final Uint8List bytes;

  @override
  State<Form> createState() {
    return _FormState();
  }
}

class _FormState extends State<Form> {
  late List<bool> requiredFields;
  late base__widget pageTitle;
  late List<base__widget> children;

  @override
  void initState() {
    super.initState();

    final Uint8List bytes = widget.bytes;

    int //
        byteCounter,
        itemCounter = 0,
        firstByte;

    pageTitle = base__page__title__aligned__center(
      primary__string: "Form",
      secondary__string: ascii__convert__str__ascii(widget.bytes.sublist(0, (byteCounter = widget.bytes.indexOf(0))),),
    );

    byteCounter += 1;

    final int //
        itemCount,
        byteCount = bytes.length;

    children = List<base__widget>.filled(itemCount = bytes[byteCounter++], empty__widget);

    requiredFields = List<bool>.filled(itemCount, NO);

    while (byteCounter < byteCount) {
      requiredFields[itemCounter] = (((firstByte = bytes[byteCounter++]) & 1) == 1);

      switch (firstByte >> 4) /* TASK: first 4 bits are free */ {
        case (Form.TYPE_CHOICE_SINGLE):
          {
            firstByte = bytes[byteCounter++]; // TASK: first 2 bits are free

            children[itemCounter++] = ChoiceInputFormItem(
              isMultiChoice: NO,
              title: ascii__convert__str__ascii(bytes.sublist(byteCounter, (byteCounter = bytes.indexOf(0, byteCounter)))),
              infoText: ascii__convert__str__ascii(bytes.sublist((byteCounter += 1), (byteCounter = bytes.indexOf(0, byteCounter)))),
              items: List<string>.generate(
                (firstByte >> 2),
                (final int i) {
                  return ascii__convert__str__ascii(bytes.sublist((byteCounter += 1), (byteCounter = bytes.indexOf(0, byteCounter))));
                },
                growable: NO,
              ),
              result: Pointer<int?>(null),
            );

            byteCounter += 1;
          }
          break;
        case (Form.TYPE_CHOICE_MULTIPLE):
          {
            firstByte = bytes[byteCounter++]; // TASK: first 2 bits are free

            children[itemCounter++] = ChoiceInputFormItem(
              isMultiChoice: OK,
              title: ascii__convert__str__ascii(bytes.sublist(byteCounter, (byteCounter = bytes.indexOf(0, byteCounter)))),
              infoText: ascii__convert__str__ascii(bytes.sublist((byteCounter += 1), (byteCounter = bytes.indexOf(0, byteCounter)))),
              items: List<string>.generate(
                (firstByte >> 2),
                (final int i) {
                  return ascii__convert__str__ascii(bytes.sublist((byteCounter += 1), (byteCounter = bytes.indexOf(0, byteCounter))));
                },
                growable: NO,
              ),
              result: Pointer<List<int>>(<int>[]),
            );

            byteCounter += 1;
          }
          break;
        case (Form.TYPE_TEXT):
          {
            final TextInputType inputType;
            final TextCapitalization textCapitalization;

            final int maxLength;

            final TextInputFormatter inputFormatter;

            switch ((firstByte = bytes[byteCounter++]) >> 5) {
              case (TextInputFormItem.TYPE_TEXT_LINE_SINGLE_RESTRICTED):
                {
                  inputType = TextInputType.text;
                  textCapitalization = TextCapitalization.words;

                  maxLength = 100;

                  inputFormatter = TextInputFormItem.selectAsciiChars;

                  break;
                }
              case (TextInputFormItem.TYPE_TEXT_WORD_SINGLE):
                {
                  inputType = TextInputType.text;
                  textCapitalization = TextCapitalization.words;

                  maxLength = 50;

                  inputFormatter = TextInputFormItem.singleWordAsciiChars;

                  break;
                }
              case (TextInputFormItem.TYPE_TEXT_LINE_SINGLE_UN__RESTRICTED):
                {
                  inputType = TextInputType.text; // TASK: add automation for e-mail, if title.lowerCase().contains("mail")
                  textCapitalization = TextCapitalization.words;

                  maxLength = 250;

                  inputFormatter = TextInputFormItem.printableAsciiChars;

                  break;
                }
              case (TextInputFormItem.TYPE_NUMBER):
                {
                  inputType = TextInputType.number;
                  textCapitalization = TextCapitalization.none;

                  maxLength = 50;

                  inputFormatter = TextInputFormItem.asciiNumbersOnly;

                  break;
                }
              case (TextInputFormItem.TYPE_TEXT_LINE_MULTI_ASCII):
                {
                  inputType = TextInputType.multiline;
                  textCapitalization = TextCapitalization.sentences;

                  maxLength = 4000;

                  inputFormatter = TextInputFormItem.printableAsciiChars;

                  break;
                }
              case (TextInputFormItem.TYPE_NUMBER_MATH):
                {
                  inputType = const TextInputType.numberWithOptions(
                    signed: OK,
                    decimal: OK,
                  );

                  textCapitalization = TextCapitalization.none;

                  maxLength = 50;

                  inputFormatter = TextInputFormItem.asciiNumbersWithFloatingPointAndSign;

                  break;
                }
              case (TextInputFormItem.TYPE_TEXT_LINE_MULTI_UNICODE):
                {
                  inputType = TextInputType.multiline;
                  textCapitalization = TextCapitalization.sentences;

                  maxLength = 8000;

                  inputFormatter = TextInputFormItem.nonControlUnicodeChars;

                  break;
                }
              case (TextInputFormItem.TYPE_NUMBER_PHONE):
                {
                  inputType = TextInputType.phone;

                  textCapitalization = TextCapitalization.none;

                  maxLength = 15;

                  inputFormatter = TextInputFormItem.asciiNumbersOnly; // TASK: allow star and hash

                  break;
                }
              default:
                {
                  return; // TASK: handle error
                }
            }

            children[itemCounter++] = TextInputFormItem(
              title: ascii__convert__str__ascii(bytes.sublist(byteCounter, (byteCounter = bytes.indexOf(0, byteCounter)))),
              focusNode: FocusNode(),
              infoText: ascii__convert__str__ascii(bytes.sublist((byteCounter += 1), (byteCounter = bytes.indexOf(0, byteCounter)))),
              hintText: ascii__convert__str__ascii(bytes.sublist((byteCounter += 1), (byteCounter = bytes.indexOf(0, byteCounter)))),
              textController: TextEditingController(
                text: (((firstByte & 16) != 0) //
                    ? ascii__convert__str__ascii(bytes.sublist((byteCounter += 1), (byteCounter = bytes.indexOf(0, byteCounter))))
                    :  null),
              ),
              helpText: (((firstByte & 8) != 0) //
                  ? ascii__convert__str__ascii(bytes.sublist((byteCounter += 1), (byteCounter = bytes.indexOf(0, byteCounter))))
                  :  null),
              inputType: inputType,
              textCapitalization: textCapitalization,
              maxLength: maxLength,
              inputFormatter: inputFormatter,
            );

            // TASK: first 3 bits are free

            byteCounter += 1;
          }
          break;
        default:
          {
            return; // TASK: handle error
          }
      }
    }
  }

  @override
  base__widget build(final BuildContext context) {
    return base__page__background(
      base__list_ing__generat_ed(
        context: context,
        pageTitle: pageTitle,
        itemCount: children.length,
        itemBuilder: (final _, final int childCounter) => children[childCounter],
        floatingwidget__kampa: base__button(
          string: "Submit",
          onSinglePress: () {},
        ),
      ),
    );
  }
}

class ChoiceInputFormItem extends StatefulWidget {
  const ChoiceInputFormItem({
    super.key,
    required this.isMultiChoice,
    required this.title,
    required this.infoText,
    required this.items,
    required this.result,
  });

  final bool isMultiChoice;

  final string title, infoText;
  final List<string> items;

  final Pointer<Object?> result;

  @override
  State<ChoiceInputFormItem> createState() {
    return _ChoiceInputFormItemState();
  }
}

class _ChoiceInputFormItemState extends State<ChoiceInputFormItem> {
  late base__widget _widget, widgetWithoutResult;

  void onSinglePress() {
    setState(() {
      _widget = widgetWithoutResult;
    });
  }

  @override
  void initState() {
    super.initState();

    _widget = widgetWithoutResult = GestureDetector(
      child: base__listing__item(
        body: base__box__text__primary__secondary(
          primary__string: widget.title,
          secondary__string: widget.infoText,
        ),
        trailing: base__icon(icon__navigation__next),
      ),
      onTap: () async {
        widget.result.value = await Navigator.of(context).push<Object>(MaterialPageRoute<Object>(
          builder: (final BuildContext context) {
            return (widget.isMultiChoice
                ? SelectionPage(
                    title: widget.title,
                    items: widget.items,
                  )
                : ChoicePage(
                    title: widget.title,
                    items: widget.items,
                  ));
          },
        ));

        if (widget.result.value !=  null) {
          setState(() {
            if (widget.isMultiChoice) {
              final List<int> selections = (widget.result.value! as List<int>);

              _widget = GestureDetector(
                child: base__listing__item(
                  body: base__box__text__primary__secondary(
                    primary__string: List<string>.generate(selections.length, (final int i) {
                      return widget.items[selections[i]];
                    }, growable: NO)
                        .join('\n'),
                    secondary__string: widget.title,
                  ),
                  trailing: base__icon(icon__navigation__next),
                ),
                onTap: onSinglePress,
              );
            } else {
              _widget = GestureDetector(
                child: base__listing__item(
                  body: base__box__text__primary__secondary(
                    primary__string: widget.items[widget.result.value! as int],
                    secondary__string: widget.title,
                  ),
                  trailing: base__icon(icon__navigation__next),
                ),
                onTap: onSinglePress,
              );
            }
          });
        }
      },
    );
  }

  @override
  base__widget build(final BuildContext context) => _widget;
}

typedef TextInputFormItem = TextInputField;*/
