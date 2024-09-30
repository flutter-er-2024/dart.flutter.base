part of "_.dart";

const
//
    wch__list__string__initial__size = u8__max;

uu wch__list__string__size__increased(
  final uu size,
) =>
    ((size << 1) | 1);

input__text__buffer__kampa input__text__buffer({
  required final uu string__bytes__count__max,
  final wstr? string__initial,
}) {
  if (string__initial ==  null) //
    return input__text__buffer__kampa._(
      string: wstr(wch__list__string__initial__size),
      string__size__current: 0,
      string__bytes__count: 0,
      string__bytes__count__max: string__bytes__count__max,
    );

  final string__initial__size = string__initial.elements__count;
  uu string__size = wch__list__string__initial__size;

  while (string__size < string__initial__size) //
    string__size = wch__list__string__size__increased(
      string__size,
    );

  final string = wstr(string__size);

  base__copy(
    string,
    string__initial,
    count: string__initial__size,
  );

  uu string__bytes__count = 0;

  string__initial.iterate__basic(
    
    (final _, final wc) {
      string__bytes__count += wch__bytes__count(wc);
    },
  );

  return input__text__buffer__kampa._(
    string: string,
    string__size__current: string__initial__size,
    string__bytes__count: string__bytes__count,
    string__bytes__count__max: string__bytes__count__max,
  );
}

class input__text__buffer__kampa /*
  TASK
    in-between writ-ing
      whenever the user, moves the caret, using arrow keys; update `string__offset`
        only when, user presses, some key, copy(not view) the `string`, from `string__offset`, to `string__size`; into `string__secondary`, and update the `string__size`
          whenever the caret is moved, back to end, AND some key is pressed, write the `string__secondary`, to `string`, at `string__size` as offset, then assign `null` to `string__secondary` */
{
  input__text__buffer__kampa._({
    required this.string,
    required this.string__size__current,
    required this.string__bytes__count,
    required this.string__bytes__count__max,
  });

  wstr string;

  uu string__size__current;
  uu string__bytes__count;

  final uu string__bytes__count__max;

  /*wstr? string__secondary;
  uu? string__offset;*/

  uu get string__size => //
      string.elements__count;

  bool get empty__ok => //
      (string__size__current == 0);

  bool get b__wide => //
      (string__size__current == string__bytes__count);

  bool $b__write(
    final uu ws__bytes__count,
  ) =>
      ((string__bytes__count + ws__bytes__count) > string__bytes__count__max).not /*
  partially writing `bytes`, until `string__bytes__count__max`'s breach
    could break, unicode's grapheme-cluster-s, and code-point-s
      like, 3-byte char's 2 bytes get written, while the last one is left out
        hence breaking, the whole string */
      ;

  void $grow__if__required(
    uu size__required,
  ) {
    size__required += string__size__current;

    final string__size_ = string__size;
    uu string__size__ = string__size_;

    while /* un-likely */ (string__size__ < size__required) //
      string__size__ = wch__list__string__size__increased(
        string__size__,
      );

    if (string__size__ != string__size_) {
      final string__old = string;

      base__copy(
        (string = wstr(string__size__)),
        string__old,
        count: string__size__current,
      );
    }
  }

  bool write__append__wch(
    final wch wc,
  ) {
    final wc__bytes__count = wch__bytes__count(wc);

    if ($b__write(
      wc__bytes__count,
    )) {
      $grow__if__required(
        1,
      );

      string[string__size__current++] = wc;

      string__bytes__count += wc__bytes__count;

      return OK;
    } else //
      return NO;
  }

  bool write__append__wstr(
    final wstr ws,
  ) {
    var wstr__bytes__count = 0;

    ws.iterate__basic(
      
      (final _, final wc) {
        wstr__bytes__count += wch__bytes__count(wc);
      },
    );

    if ($b__write(
      wstr__bytes__count,
    )) {
      final ws__size = ws.elements__count;

      $grow__if__required(
        ws__size,
      );

      base__copy(
        string,
        ws,
        dest__offset: string__size__current,
        count: ws__size,
      );

      string__size__current += ws__size;

      string__bytes__count += wstr__bytes__count;

      return OK;
    } else //
      return NO;
  }

  bool backspace() {
    if (string__size__current != 0) {
      string__bytes__count -= wch__bytes__count(
        string[(string__size__current -= 1)],
      );

      return OK;
    } else //
      return NO;
  }

  wstr read__full() => //
      (!empty__ok
          ? string.view__partial(
              0,
              string__size__current,
            )
          : wstr(0));

  void clear() /*
  memory efficiency is NOT increased */
  {
    string__size__current = 0;
    string__bytes__count = 0;
  }

  wstr convert__wstr__compact() {
    final result = wstr(string__size__current);

    base__copy(
      result,
      string,
      count: string__size__current,
    );

    return result;
  }

  void free() {
    clear();
    string = wstr(0);
  }
}
