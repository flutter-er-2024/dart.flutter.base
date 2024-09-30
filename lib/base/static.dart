part of "_.dart";

const wch //
    ch__unicode__bullet = 8226,
    ch__unicode__currency__rupee = 8377 /* symbol of Indian National Rupee */;

final string //
    char__bullet = string.fromCharCode(ch__unicode__bullet),
    char__currency__rupee = string.fromCharCode(ch__unicode__currency__rupee);

const //
    number__ordinal__static__sting__arr = <string>[
      "First",
      "Second",
      "Third",
      "Fourth",
      "Fifth",
      "Sixth",
      "Seventh",
      "Eighth",
      "Ninth",
      "Tenth",
      "Eleventh",
      "Twelfth",
      "Thirteenth",
      "Fourteenth",
      "Fifteenth",
      "Sixteenth",
      "Seventeenth",
      "Eighteenth",
      "Nineteenth",
      "Twentieth",
      "Twenty-first",
      "Twenty-second",
      "Twenty-third",
      "Twenty-fourth",
      "Twenty-fifth",
      "Twenty-sixth",
      "Twenty-seventh",
      "Twenty-eighth",
      "Twenty-ninth",
      "Thirtieth",
      "Thirty-first",
      "Thirty-second",
      "Thirty-third",
    ],
//
    calendar__gregorian__month__static__string__arr = <string>[
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ],
    calendar__gregorian__week__day__static__string__arr = <string>[
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ],
//
    file__type__array__count__size = u16__size,
    file__type__static__string__graphic__image = "image",
    file__type__static__string__graphic__symbol = "symbol",
    file__type__static__string__arr = <string>[
      (file__type__static__string__graphic__image + char__colon + "png"),
      (file__type__static__string__graphic__symbol + char__colon + "svg"),
    ];

final //
    currencies = <({
  uu code,
  string char,
  string title,
})>[
  (
    code: ch__unicode__currency__rupee,
    char: char__currency__rupee,
    title: "Indian Rupees",
  ),
];

const //
    char__s = 's',
    chars__es = ('e' + char__s),
//
    static__string__english__arr = [
      "Add",
      "All",
    ],
    static__string__arr = //
        static__string__english__arr;

string get static__string__add => static__string__arr[0];
string get static__string__all => static__string__arr[1];
