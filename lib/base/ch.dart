part of "_.dart";

const //
    ch__number__zero = 0,
    ch__number__one = 1,
    ch__number__two = 2,
    ch__number__three = 3,
    ch__number__four = 4,
    ch__number__five = 5,
    ch__number__six = 6,
    ch__number__seven = 7,
    ch__number__eight = 8,
    ch__number__nine = 9,
//
    ch__space = (1 + ch__number__nine),
    ch__comma = (1 + ch__space),
    ch__quote__single = (1 + ch__comma),
    ch__dash = (1 + ch__quote__single),
    ch__under_score = (1 + ch__dash),
    ch__slash__forward = (1 + ch__under_score),
    ch__bracket__round__open = (1 + ch__slash__forward),
    ch__bracket__round__close = (1 + ch__bracket__round__open),
    ch__dot = (1 + ch__bracket__round__close),
    ch__colon__semi = (1 + ch__dot),
    ch__colon = (1 + ch__colon__semi),
    ch__quote__double = (1 + ch__question),
    ch__question = (1 + ch__colon),
    ch__exclamation = (1 + ch__quote__double),
//
    ch__alphabet__case__lower__a = (1 + ch__exclamation),
    ch__alphabet__case__lower__b = (1 + ch__alphabet__case__lower__a),
    ch__alphabet__case__lower__c = (1 + ch__alphabet__case__lower__b),
    ch__alphabet__case__lower__d = (1 + ch__alphabet__case__lower__c),
    ch__alphabet__case__lower__e = (1 + ch__alphabet__case__lower__d),
    ch__alphabet__case__lower__f = (1 + ch__alphabet__case__lower__e),
    ch__alphabet__case__lower__g = (1 + ch__alphabet__case__lower__f),
    ch__alphabet__case__lower__h = (1 + ch__alphabet__case__lower__g),
    ch__alphabet__case__lower__i = (1 + ch__alphabet__case__lower__h),
    ch__alphabet__case__lower__j = (1 + ch__alphabet__case__lower__i),
    ch__alphabet__case__lower__k = (1 + ch__alphabet__case__lower__j),
    ch__alphabet__case__lower__l = (1 + ch__alphabet__case__lower__k),
    ch__alphabet__case__lower__m = (1 + ch__alphabet__case__lower__l),
    ch__alphabet__case__lower__n = (1 + ch__alphabet__case__lower__m),
    ch__alphabet__case__lower__o = (1 + ch__alphabet__case__lower__n),
    ch__alphabet__case__lower__p = (1 + ch__alphabet__case__lower__o),
    ch__alphabet__case__lower__q = (1 + ch__alphabet__case__lower__p),
    ch__alphabet__case__lower__r = (1 + ch__alphabet__case__lower__q),
    ch__alphabet__case__lower__s = (1 + ch__alphabet__case__lower__r),
    ch__alphabet__case__lower__t = (1 + ch__alphabet__case__lower__s),
    ch__alphabet__case__lower__u = (1 + ch__alphabet__case__lower__t),
    ch__alphabet__case__lower__v = (1 + ch__alphabet__case__lower__u),
    ch__alphabet__case__lower__w = (1 + ch__alphabet__case__lower__v),
    ch__alphabet__case__lower__x = (1 + ch__alphabet__case__lower__w),
    ch__alphabet__case__lower__y = (1 + ch__alphabet__case__lower__x),
    ch__alphabet__case__lower__z = (1 + ch__alphabet__case__lower__y),
//
    ch__hash = (1 + ch__alphabet__case__lower__z),
    ch__dollar = (1 + ch__hash),
    ch__percent = (1 + ch__dollar),
    ch__ampersand = (1 + ch__percent),
    ch__asterisk = (1 + ch__ampersand),
    ch__addition = (1 + ch__asterisk),
    ch__bracket__angle__open = (1 + ch__addition),
    ch__bracket__angle__close = (1 + ch__bracket__angle__open),
    ch__equal = (1 + ch__bracket__angle__close),
    ch__at = (1 + ch__equal),
    ch__bracket__square__open = (1 + ch__at),
    ch__bracket__square__close = (1 + ch__bracket__square__open),
    ch__slash__backward = (1 + ch__bracket__square__close),
    ch__caret__up = (1 + ch__slash__backward),
    ch__caret__down /*
also called `caret:reverse`
falls back to `⋁`(logical-or ,unicode char-code/code-point 0x22C1) 
  ,if the target view-er ,has no-support */
    = (1 + ch__caret__up),
    ch__tilde = (1 + ch__caret__down),
    ch__bracket__curly__open = (1 + ch__tilde),
    ch__bracket__curly__close = (1 + ch__bracket__curly__open),
    ch__pipe = (1 + ch__bracket__curly__close),
    ch__quote__back = (1 + ch__pipe),
//
    ch__alphabet__case__upper__a = (1 + ch__quote__back),
    ch__alphabet__case__upper__b = (1 + ch__alphabet__case__upper__a),
    ch__alphabet__case__upper__c = (1 + ch__alphabet__case__upper__b),
    ch__alphabet__case__upper__d = (1 + ch__alphabet__case__upper__c),
    ch__alphabet__case__upper__e = (1 + ch__alphabet__case__upper__d),
    ch__alphabet__case__upper__f = (1 + ch__alphabet__case__upper__e),
    ch__alphabet__case__upper__g = (1 + ch__alphabet__case__upper__f),
    ch__alphabet__case__upper__h = (1 + ch__alphabet__case__upper__g),
    ch__alphabet__case__upper__i = (1 + ch__alphabet__case__upper__h),
    ch__alphabet__case__upper__j = (1 + ch__alphabet__case__upper__i),
    ch__alphabet__case__upper__k = (1 + ch__alphabet__case__upper__j),
    ch__alphabet__case__upper__l = (1 + ch__alphabet__case__upper__k),
    ch__alphabet__case__upper__m = (1 + ch__alphabet__case__upper__l),
    ch__alphabet__case__upper__n = (1 + ch__alphabet__case__upper__m),
    ch__alphabet__case__upper__o = (1 + ch__alphabet__case__upper__n),
    ch__alphabet__case__upper__p = (1 + ch__alphabet__case__upper__o),
    ch__alphabet__case__upper__q = (1 + ch__alphabet__case__upper__p),
    ch__alphabet__case__upper__r = (1 + ch__alphabet__case__upper__q),
    ch__alphabet__case__upper__s = (1 + ch__alphabet__case__upper__r),
    ch__alphabet__case__upper__t = (1 + ch__alphabet__case__upper__s),
    ch__alphabet__case__upper__u = (1 + ch__alphabet__case__upper__t),
    ch__alphabet__case__upper__v = (1 + ch__alphabet__case__upper__u),
    ch__alphabet__case__upper__w = (1 + ch__alphabet__case__upper__v),
    ch__alphabet__case__upper__x = (1 + ch__alphabet__case__upper__w),
    ch__alphabet__case__upper__y = (1 + ch__alphabet__case__upper__x),
    ch__alphabet__case__upper__z = (1 + ch__alphabet__case__upper__y),
//
    ch__non_printable__line__break /* new-line */ = (1 + ch__alphabet__case__upper__z),
    ch__non_printable__switch__alternate /*tab:horizontal*/ = (1 + ch__non_printable__line__break),
    ch__non_printable__escape = (1 +
        ch__non_printable__switch__alternate); /*
BTE/basic-text-encoding
  "basic" means(here) single-byte
vis-ual/graph-ical/pic-torial represent-ation is called character
numerical(integer-number) represent-ation is called char-code
  ,like code-point in unicode
inspired by ASCII
0..9(10) :
  numbers/numerical-digits (0-9)
10..23 (14) :
  - most used char.s 
    ,like space char.
  - usually all from english-lang. 
    ,except under-score 
      ,which is omni-present ,in program-ing
24..49 (26) :
  lower-case alphabets (a-z)
50..69 (20) :
  all the ,remain-ing ,visible/print-able symbols 
    ,which are present in ASCII 
      ,except `caret:down` ,which was ,usually ,imitat-ed ,through `v`-char.(a lower-case alphabet) 
      ,although ,with changed ,order
70..95 (26) :
  upper-case alphabets (A-Z)
96..98 (3):
  not-always needed char.s 
    ,like :
      - `escape`
      - `switch:alternate` 
        ,to instruct the {view|render}-er ,to prefer ,the alternate edition/version ,of the next char. 
          ,like fixed-width/`tab:horizontal` for `space` char. 
            ,useful in command-line based programs
          ,source-code manipulat-ion programs ,should avoid it 
            ,instead ,interpret ,all the ,first ,space-char.s ,of the line ,for indent-ation control
      - `line:break` 
        ,like ASCII's line-feed char.
        ,less useful ,for graphical user-interfaces
99..127 (29) :
  - free ,available for general use 
    ,like de-limit-ers ,control-codes ,escape-codes ,...
128..255 (128) :
  - reserved for multi-byte chain-ing 
    ,otherwise free */

const //
    ch__pointer__ch__ascii__arr = [
      ch__ascii__number__zero,
      ch__ascii__number__one,
      ch__ascii__number__two,
      ch__ascii__number__three,
      ch__ascii__number__four,
      ch__ascii__number__five,
      ch__ascii__number__six,
      ch__ascii__number__seven,
      ch__ascii__number__eight,
      ch__ascii__number__nine,
//
      ch__ascii__space,
      ch__ascii__comma,
      ch__ascii__quote__single,
      ch__ascii__dash,
      ch__ascii__under_score,
      ch__ascii__slash__forward,
      ch__ascii__bracket__round__open,
      ch__ascii__bracket__round__close,
      ch__ascii__dot,
      ch__ascii__colon__semi,
      ch__ascii__colon,
      ch__ascii__quote__double,
      ch__ascii__question,
      ch__ascii__exclamation,
//
      ch__ascii__alphabet__case__lower__a,
      ch__ascii__alphabet__case__lower__b,
      ch__ascii__alphabet__case__lower__c,
      ch__ascii__alphabet__case__lower__d,
      ch__ascii__alphabet__case__lower__e,
      ch__ascii__alphabet__case__lower__f,
      ch__ascii__alphabet__case__lower__g,
      ch__ascii__alphabet__case__lower__h,
      ch__ascii__alphabet__case__lower__i,
      ch__ascii__alphabet__case__lower__j,
      ch__ascii__alphabet__case__lower__k,
      ch__ascii__alphabet__case__lower__l,
      ch__ascii__alphabet__case__lower__m,
      ch__ascii__alphabet__case__lower__n,
      ch__ascii__alphabet__case__lower__o,
      ch__ascii__alphabet__case__lower__p,
      ch__ascii__alphabet__case__lower__q,
      ch__ascii__alphabet__case__lower__r,
      ch__ascii__alphabet__case__lower__s,
      ch__ascii__alphabet__case__lower__t,
      ch__ascii__alphabet__case__lower__u,
      ch__ascii__alphabet__case__lower__v,
      ch__ascii__alphabet__case__lower__w,
      ch__ascii__alphabet__case__lower__x,
      ch__ascii__alphabet__case__lower__y,
      ch__ascii__alphabet__case__lower__z,
//
      ch__ascii__hash,
      ch__ascii__dollar,
      ch__ascii__percent,
      ch__ascii__ampersand,
      ch__ascii__asterisk,
      ch__ascii__plus,
      ch__ascii__bracket__angle__open,
      ch__ascii__bracket__angle__close,
      ch__ascii__equal,
      ch__ascii__at,
      ch__ascii__bracket__square__open,
      ch__ascii__bracket__square__close,
      ch__ascii__slash__backward,
      ch__ascii__caret,
      ch__ascii__non_printable__tab__vertical /* in-correct */,
      ch__ascii__tilde,
      ch__ascii__bracket__curly__open,
      ch__ascii__bracket__curly__close,
      ch__ascii__pipe,
      ch__ascii__quote__back,
//
      ch__ascii__alphabet__case__upper__a,
      ch__ascii__alphabet__case__upper__b,
      ch__ascii__alphabet__case__upper__c,
      ch__ascii__alphabet__case__upper__d,
      ch__ascii__alphabet__case__upper__e,
      ch__ascii__alphabet__case__upper__f,
      ch__ascii__alphabet__case__upper__g,
      ch__ascii__alphabet__case__upper__h,
      ch__ascii__alphabet__case__upper__i,
      ch__ascii__alphabet__case__upper__j,
      ch__ascii__alphabet__case__upper__k,
      ch__ascii__alphabet__case__upper__l,
      ch__ascii__alphabet__case__upper__m,
      ch__ascii__alphabet__case__upper__n,
      ch__ascii__alphabet__case__upper__o,
      ch__ascii__alphabet__case__upper__p,
      ch__ascii__alphabet__case__upper__q,
      ch__ascii__alphabet__case__upper__r,
      ch__ascii__alphabet__case__upper__s,
      ch__ascii__alphabet__case__upper__t,
      ch__ascii__alphabet__case__upper__u,
      ch__ascii__alphabet__case__upper__v,
      ch__ascii__alphabet__case__upper__w,
      ch__ascii__alphabet__case__upper__x,
      ch__ascii__alphabet__case__upper__y,
      ch__ascii__alphabet__case__upper__z,
//
      ch__ascii__non_printable__line_feed,
      ch__ascii__non_printable__tab__horizontal,
      ch__ascii__non_printable__escape,
    ],
//
    ch__ascii__pointer__ch__arr = [
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__non_printable__line__break,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
      ch__non_printable__escape,
      ch__max,
      ch__max,
      ch__max,
      ch__max,
//
      ch__space,
      ch__exclamation,
      ch__quote__double,
      ch__hash,
      ch__dollar,
      ch__percent,
      ch__ampersand,
      ch__quote__single,
      ch__bracket__round__open,
      ch__bracket__round__close,
      ch__asterisk,
      ch__addition,
      ch__comma,
      ch__dash,
      ch__dot,
      ch__slash__forward,
//
      ch__number__zero,
      ch__number__one,
      ch__number__two,
      ch__number__three,
      ch__number__four,
      ch__number__five,
      ch__number__six,
      ch__number__seven,
      ch__number__eight,
      ch__number__nine,
//
      ch__colon,
      ch__colon__semi,
      ch__bracket__angle__open,
      ch__equal,
      ch__bracket__angle__close,
      ch__question,
      ch__at,
//
      ch__alphabet__case__upper__a,
      ch__alphabet__case__upper__b,
      ch__alphabet__case__upper__c,
      ch__alphabet__case__upper__d,
      ch__alphabet__case__upper__e,
      ch__alphabet__case__upper__f,
      ch__alphabet__case__upper__g,
      ch__alphabet__case__upper__h,
      ch__alphabet__case__upper__i,
      ch__alphabet__case__upper__j,
      ch__alphabet__case__upper__k,
      ch__alphabet__case__upper__l,
      ch__alphabet__case__upper__m,
      ch__alphabet__case__upper__n,
      ch__alphabet__case__upper__o,
      ch__alphabet__case__upper__p,
      ch__alphabet__case__upper__q,
      ch__alphabet__case__upper__r,
      ch__alphabet__case__upper__s,
      ch__alphabet__case__upper__t,
      ch__alphabet__case__upper__u,
      ch__alphabet__case__upper__v,
      ch__alphabet__case__upper__w,
      ch__alphabet__case__upper__x,
      ch__alphabet__case__upper__y,
      ch__alphabet__case__upper__z,
//
      ch__bracket__square__open,
      ch__slash__backward,
      ch__bracket__square__close,
      ch__caret__up,
      ch__under_score,
      ch__quote__back,
//
      ch__alphabet__case__lower__a,
      ch__alphabet__case__lower__b,
      ch__alphabet__case__lower__c,
      ch__alphabet__case__lower__d,
      ch__alphabet__case__lower__e,
      ch__alphabet__case__lower__f,
      ch__alphabet__case__lower__g,
      ch__alphabet__case__lower__h,
      ch__alphabet__case__lower__i,
      ch__alphabet__case__lower__j,
      ch__alphabet__case__lower__k,
      ch__alphabet__case__lower__l,
      ch__alphabet__case__lower__m,
      ch__alphabet__case__lower__n,
      ch__alphabet__case__lower__o,
      ch__alphabet__case__lower__p,
      ch__alphabet__case__lower__q,
      ch__alphabet__case__lower__r,
      ch__alphabet__case__lower__s,
      ch__alphabet__case__lower__t,
      ch__alphabet__case__lower__u,
      ch__alphabet__case__lower__v,
      ch__alphabet__case__lower__w,
      ch__alphabet__case__lower__x,
      ch__alphabet__case__lower__y,
      ch__alphabet__case__lower__z,
//
      ch__bracket__curly__open,
      ch__pipe,
      ch__bracket__curly__close,
      ch__tilde,
//
      ch__max,
    ];

bool ch__b__not__valid(final ch c) => //
    (c > ch__non_printable__escape);

bool ch__b__valid(final ch c) => //
    !ch__b__not__valid(c);

bool ch__b__not__printable(final ch c) => //
    (c > ch__alphabet__case__upper__z);

bool ch__b__printable(final ch c) => //
    !ch__b__not__printable(c);

bool ch__b__not__number(final ch c) => //
    (c > ch__number__nine);

bool ch__b__number(final ch c) => //
    !ch__b__not__number(c);

bool ch__alphabet__case__b__lower(final ch c) => //
    (c < ch__alphabet__case__upper__a);

bool ch__alphabet__case__b__upper(final ch c) => //
    (c > ch__alphabet__case__lower__z);

const ch //
    _ch__alphabet__case__convertion__value = (23 /* count, of `ch`es, between `low` and `up`, `case`, `alphabet`s */ + language__latin__english__alphabets__count);

ch ch__alphabet__case__lower__convert__upper(final ch c) => //
    (c - _ch__alphabet__case__convertion__value);

ch ch__alphabet__case__upper__convert__lower(final ch c) => //
    (c + _ch__alphabet__case__convertion__value);

bool ch__array__b__valid(
  final array<ch> s,
) {
  var count = s.elements__count;

  do {
    if (ch__b__valid(s[count -= 1])) {
      return NO;
    }
  } while (count != 0);

  return OK;
}

ch ch__convert__ch__ascii(final ch c) => //
    ch__pointer__ch__ascii__arr[c];

ch ch__ascii__convert__ch(final ch c) => //
    ch__ascii__pointer__ch__arr[c];
