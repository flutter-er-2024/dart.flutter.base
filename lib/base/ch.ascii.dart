part of "_.dart";

const ch //
    ch__ascii__non_printable__null = 0,
    ch__ascii__non_printable__tab__horizontal = 9,
    ch__ascii__non_printable__line_feed = 10,
    ch__ascii__non_printable__tab__vertical = 11,
    ch__ascii__non_printable__carriage_return = 13,
    ch__ascii__non_printable__escape = 27,
    ch__ascii__non_printable__separator__file = 28,
    ch__ascii__non_printable__separator__group = 29,
    ch__ascii__non_printable__separator__kampa = 30,
    ch__ascii__non_printable__separator__unit = 31,
    ch__ascii__non_printable__delete = 127,
//
    ch__ascii__space = 32,
    ch__ascii__exclamation = 33,
    ch__ascii__quote__double = 34,
    ch__ascii__hash = 35,
    ch__ascii__dollar = 36,
    ch__ascii__percent = 37,
    ch__ascii__ampersand = 38,
    ch__ascii__quote__single = 39,
    ch__ascii__bracket__round__open = 40,
    ch__ascii__bracket__round__close = 41,
    ch__ascii__asterisk = 42,
    ch__ascii__plus = 43,
    ch__ascii__comma = 44,
    ch__ascii__dash = 45,
    ch__ascii__dot = 46,
    ch__ascii__slash__forward = 47,
//
    ch__ascii__number__zero = 48,
    ch__ascii__number__one = 49,
    ch__ascii__number__two = 50,
    ch__ascii__number__three = 51,
    ch__ascii__number__four = 52,
    ch__ascii__number__five = 53,
    ch__ascii__number__six = 54,
    ch__ascii__number__seven = 55,
    ch__ascii__number__eight = 56,
    ch__ascii__number__nine = 57,
//
    ch__ascii__colon = 58,
    ch__ascii__colon__semi = 59,
    ch__ascii__bracket__angle__open = 60,
    ch__ascii__equal = 61,
    ch__ascii__bracket__angle__close = 62,
    ch__ascii__question = 63,
    ch__ascii__at = 64,
//
    ch__ascii__alphabet__case__upper__a = 65,
    ch__ascii__alphabet__A = ch__ascii__alphabet__case__upper__a,
    ch__ascii__alphabet__case__upper__b = 66,
    ch__ascii__alphabet__B = ch__ascii__alphabet__case__upper__b,
    ch__ascii__alphabet__case__upper__c = 67,
    ch__ascii__alphabet__C = ch__ascii__alphabet__case__upper__c,
    ch__ascii__alphabet__case__upper__d = 68,
    ch__ascii__alphabet__D = ch__ascii__alphabet__case__upper__d,
    ch__ascii__alphabet__case__upper__e = 69,
    ch__ascii__alphabet__E = ch__ascii__alphabet__case__upper__e,
    ch__ascii__alphabet__case__upper__f = 70,
    ch__ascii__alphabet__F = ch__ascii__alphabet__case__upper__f,
    ch__ascii__alphabet__case__upper__g = 71,
    ch__ascii__alphabet__G = ch__ascii__alphabet__case__upper__g,
    ch__ascii__alphabet__case__upper__h = 72,
    ch__ascii__alphabet__H = ch__ascii__alphabet__case__upper__h,
    ch__ascii__alphabet__case__upper__i = 73,
    ch__ascii__alphabet__I = ch__ascii__alphabet__case__upper__i,
    ch__ascii__alphabet__case__upper__j = 74,
    ch__ascii__alphabet__J = ch__ascii__alphabet__case__upper__j,
    ch__ascii__alphabet__case__upper__k = 75,
    ch__ascii__alphabet__K = ch__ascii__alphabet__case__upper__k,
    ch__ascii__alphabet__case__upper__l = 76,
    ch__ascii__alphabet__L = ch__ascii__alphabet__case__upper__l,
    ch__ascii__alphabet__case__upper__m = 77,
    ch__ascii__alphabet__M = ch__ascii__alphabet__case__upper__m,
    ch__ascii__alphabet__case__upper__n = 78,
    ch__ascii__alphabet__N = ch__ascii__alphabet__case__upper__n,
    ch__ascii__alphabet__case__upper__o = 79,
    ch__ascii__alphabet__O = ch__ascii__alphabet__case__upper__o,
    ch__ascii__alphabet__case__upper__p = 80,
    ch__ascii__alphabet__P = ch__ascii__alphabet__case__upper__p,
    ch__ascii__alphabet__case__upper__q = 81,
    ch__ascii__alphabet__Q = ch__ascii__alphabet__case__upper__q,
    ch__ascii__alphabet__case__upper__r = 82,
    ch__ascii__alphabet__R = ch__ascii__alphabet__case__upper__r,
    ch__ascii__alphabet__case__upper__s = 83,
    ch__ascii__alphabet__S = ch__ascii__alphabet__case__upper__s,
    ch__ascii__alphabet__case__upper__t = 84,
    ch__ascii__alphabet__T = ch__ascii__alphabet__case__upper__t,
    ch__ascii__alphabet__case__upper__u = 85,
    ch__ascii__alphabet__U = ch__ascii__alphabet__case__upper__u,
    ch__ascii__alphabet__case__upper__v = 86,
    ch__ascii__alphabet__V = ch__ascii__alphabet__case__upper__v,
    ch__ascii__alphabet__case__upper__w = 87,
    ch__ascii__alphabet__W = ch__ascii__alphabet__case__upper__w,
    ch__ascii__alphabet__case__upper__x = 88,
    ch__ascii__alphabet__X = ch__ascii__alphabet__case__upper__x,
    ch__ascii__alphabet__case__upper__y = 89,
    ch__ascii__alphabet__Y = ch__ascii__alphabet__case__upper__y,
    ch__ascii__alphabet__case__upper__z = 90,
    ch__ascii__alphabet__Z = ch__ascii__alphabet__case__upper__z,
//
    ch__ascii__bracket__square__open = 91,
    ch__ascii__slash__backward = 92,
    ch__ascii__bracket__square__close = 93,
    ch__ascii__caret = 94,
    ch__ascii__under_score = 95,
    ch__ascii__quote__back = 96,
//
    ch__ascii__alphabet__case__lower__a = 97,
    ch__ascii__alphabet__a = ch__ascii__alphabet__case__lower__a,
    ch__ascii__alphabet__case__lower__b = 98,
    ch__ascii__alphabet__b = ch__ascii__alphabet__case__lower__b,
    ch__ascii__alphabet__case__lower__c = 99,
    ch__ascii__alphabet__c = ch__ascii__alphabet__case__lower__c,
    ch__ascii__alphabet__case__lower__d = 100,
    ch__ascii__alphabet__d = ch__ascii__alphabet__case__lower__d,
    ch__ascii__alphabet__case__lower__e = 101,
    ch__ascii__alphabet__e = ch__ascii__alphabet__case__lower__e,
    ch__ascii__alphabet__case__lower__f = 102,
    ch__ascii__alphabet__f = ch__ascii__alphabet__case__lower__f,
    ch__ascii__alphabet__case__lower__g = 103,
    ch__ascii__alphabet__g = ch__ascii__alphabet__case__lower__g,
    ch__ascii__alphabet__case__lower__h = 104,
    ch__ascii__alphabet__h = ch__ascii__alphabet__case__lower__h,
    ch__ascii__alphabet__case__lower__i = 105,
    ch__ascii__alphabet__i = ch__ascii__alphabet__case__lower__i,
    ch__ascii__alphabet__case__lower__j = 106,
    ch__ascii__alphabet__j = ch__ascii__alphabet__case__lower__j,
    ch__ascii__alphabet__case__lower__k = 107,
    ch__ascii__alphabet__k = ch__ascii__alphabet__case__lower__k,
    ch__ascii__alphabet__case__lower__l = 108,
    ch__ascii__alphabet__l = ch__ascii__alphabet__case__lower__l,
    ch__ascii__alphabet__case__lower__m = 109,
    ch__ascii__alphabet__m = ch__ascii__alphabet__case__lower__m,
    ch__ascii__alphabet__case__lower__n = 110,
    ch__ascii__alphabet__n = ch__ascii__alphabet__case__lower__n,
    ch__ascii__alphabet__case__lower__o = 111,
    ch__ascii__alphabet__o = ch__ascii__alphabet__case__lower__o,
    ch__ascii__alphabet__case__lower__p = 112,
    ch__ascii__alphabet__p = ch__ascii__alphabet__case__lower__p,
    ch__ascii__alphabet__case__lower__q = 113,
    ch__ascii__alphabet__q = ch__ascii__alphabet__case__lower__q,
    ch__ascii__alphabet__case__lower__r = 114,
    ch__ascii__alphabet__r = ch__ascii__alphabet__case__lower__r,
    ch__ascii__alphabet__case__lower__s = 115,
    ch__ascii__alphabet__s = ch__ascii__alphabet__case__lower__s,
    ch__ascii__alphabet__case__lower__t = 116,
    ch__ascii__alphabet__t = ch__ascii__alphabet__case__lower__t,
    ch__ascii__alphabet__case__lower__u = 117,
    ch__ascii__alphabet__u = ch__ascii__alphabet__case__lower__u,
    ch__ascii__alphabet__case__lower__v = 118,
    ch__ascii__alphabet__v = ch__ascii__alphabet__case__lower__v,
    ch__ascii__alphabet__case__lower__w = 119,
    ch__ascii__alphabet__w = ch__ascii__alphabet__case__lower__w,
    ch__ascii__alphabet__case__lower__x = 120,
    ch__ascii__alphabet__x = ch__ascii__alphabet__case__lower__x,
    ch__ascii__alphabet__case__lower__y = 121,
    ch__ascii__alphabet__y = ch__ascii__alphabet__case__lower__y,
    ch__ascii__alphabet__case__lower__z = 122,
    ch__ascii__alphabet__z = ch__ascii__alphabet__case__lower__z,
//
    ch__ascii__bracket__curly__open = 123,
    ch__ascii__pipe = 124,
    ch__ascii__bracket__curly__close = 125,
    ch__ascii__tilde = 126;

const //
    ch__ascii__limit = ch__limit,
    ch__ascii__max = ch__max;

bool ch__ascii__valid__ok(final ch c) => //
    (c < ch__ascii__limit);

bool ch__ascii__valid__ok__and__printable(final ch c) => //
    ((c < ch__ascii__max) && (c < ch__ascii__space).not);

bool ch__ascii__number__non__zero__not(final ch c) => //
    ((c < ch__ascii__number__one) || (c > ch__ascii__number__nine));

bool ch__ascii__number__non__zero__ok(final ch c) => //
    !ch__ascii__number__non__zero__not(c);

bool ch__ascii__number__not(final ch c) => //
    (ch__ascii__number__non__zero__not(c) && (c != ch__ascii__number__zero));

bool ch__ascii__number__ok(final ch c) => //
    (ch__ascii__number__non__zero__ok(c) || (c == ch__ascii__number__zero));

bool ch__ascii__alphabet__case__lower__not(final ch c) => //
    ((c < ch__ascii__alphabet__case__lower__a) || (c > ch__ascii__alphabet__case__lower__z));

bool ch__ascii__alphabet__case__lower__ok(final ch c) => //
    !ch__ascii__alphabet__case__lower__not(c);

bool ch__ascii__alphabet__case__upper__not(final ch c) => //
    ((c < ch__ascii__alphabet__case__upper__a) || (c > ch__ascii__alphabet__case__upper__z));

bool ch__ascii__alphabet__case__upper__ok(final ch c) => //
    !ch__ascii__alphabet__case__upper__not(c);

bool ch__ascii__alphabet__not(final ch c) => //
    (ch__ascii__alphabet__case__lower__not(c) && //
        ch__ascii__alphabet__case__upper__not(c));

bool ch__ascii__alphabet__ok(final ch c) => //
    !ch__ascii__alphabet__not(c);

bool ch__ascii__alphabet__case__upper__ok__basic(final ch c) => //
    (c < ch__ascii__alphabet__case__lower__a);

bool ch__ascii__alphabet__case__lower__ok__basic(final ch c) => //
    (c > ch__ascii__alphabet__case__upper__z);

const ch //
    _convertion__case__value = (ch__limit >> 2);

ch ch__ascii__alphabet__case__upper__convert__lower(final ch c) => //
    (c + _convertion__case__value);

ch ch__ascii__alphabet__case__lower__convert__upper(final ch c) => //
    (c - _convertion__case__value);
