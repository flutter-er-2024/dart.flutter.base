part of "_.dart";

const u16 date_time__offset__year = 2022;

const sz //
    date_time__year__reduced__size = u8__size,
    date_time__seconds__reduced__size = u32__size;

final //
    date_time__offset__micro_seconds = DateTime(date_time__offset__year).microsecondsSinceEpoch,
    date_time__offset__seconds = (date_time__offset__micro_seconds ~/ Duration.microsecondsPerSecond);

const //
    date_time__duration__minute__seconds__count = 60,
    date_time__duration__hour__minutes__count = 60,
    date_time__duration__hour__seconds__count = (date_time__duration__hour__minutes__count * date_time__duration__minute__seconds__count),
    date_time__duration__day__hours__count = 24,
    date_time__duration__day__seconds__count = (date_time__duration__day__hours__count * date_time__duration__hour__seconds__count),
    date_time__duration__week__days__count = 7,
    date_time__duration__week__seconds__count = (date_time__duration__week__days__count * date_time__duration__day__seconds__count),
    date_time__duration__month__weeks__count__simple = 4,
    date_time__duration__month__days__count__simple = 30,
    date_time__duration__month__seconds__count__simple = (date_time__duration__month__weeks__count__simple * date_time__duration__week__seconds__count),
    date_time__duration__yearquartermonths_count = 3,
    date_time__duration__yearmonthscount = (4 * date_time__duration__yearquartermonths_count),
    date_time__duration__yearweekscount = (4 /*quarters*/ * 13 /*((durationyearquartermonthscount * durationmonthweekscount_simple) + 1)*/),
    date_time__duration__year__days__count__simple = 365 /*((durationyearquartermonthscount * durationmonthdayscount_simple) + 1)*/,
    date_time__duration__year__seconds__count__simple = (date_time__duration__yearmonthscount * date_time__duration__month__seconds__count__simple),
    date_time__duration__decade__years___count = 10,
    date_time__duration__year__cycle__years__count = 4,
    date_time__duration__year__cycle__days__count = ((date_time__duration__year__cycle__years__count * date_time__duration__year__days__count__simple) + 1);

DateTime date_time__current() => //
    DateTime.now();

uu date_time__micro_seconds__reduced([
  final DateTime? date_time,
]) =>
    ((date_time ?? date_time__current()).microsecondsSinceEpoch - date_time__offset__micro_seconds);

DateTime date_time__micro_seconds__reduced__convert(
  final uu micro_seconds__reduced,
) =>
    DateTime.fromMicrosecondsSinceEpoch((micro_seconds__reduced + date_time__offset__micro_seconds), isUtc: true);

uu date_time__milli_seconds__reduced([
  final DateTime? date_time,
]) =>
    (date_time__micro_seconds__reduced(date_time) ~/ Duration.microsecondsPerMillisecond);

DateTime date_time__milli_seconds__reduced__convert(
  final uu milli_seconds__reduced,
) =>
    date_time__micro_seconds__reduced__convert((milli_seconds__reduced * Duration.microsecondsPerMillisecond));

uu date_time__seconds__reduced([
  final DateTime? date_time,
]) =>
    (date_time__micro_seconds__reduced(date_time) ~/ Duration.microsecondsPerSecond);

DateTime date_time__seconds__reduced__convert(
  final uu seconds__reduced,
) =>
    date_time__micro_seconds__reduced__convert((seconds__reduced * Duration.microsecondsPerSecond));

uu date_time__minutes__reduced([
  final DateTime? date_time,
]) =>
    (date_time__micro_seconds__reduced(date_time) ~/ Duration.microsecondsPerMinute);

DateTime date_time__minutes__reduced__convert(final uu minutes__reduced) => date_time__micro_seconds__reduced__convert((minutes__reduced * Duration.microsecondsPerMinute));

uu date_time__hours__reduced([
  final DateTime? date_time,
]) =>
    (date_time__micro_seconds__reduced(date_time) ~/ Duration.microsecondsPerHour);

DateTime date_time__hours__reduced__convert(
  final uu hours__reduced,
) =>
    date_time__micro_seconds__reduced__convert((hours__reduced * Duration.microsecondsPerHour));

uu date_time__days__reduced([
  final DateTime? date_time,
]) =>
    (date_time__micro_seconds__reduced(date_time) ~/ Duration.microsecondsPerDay);

DateTime date_time__days__reduced__convert(
  final uu days__reduced,
) =>
    date_time__micro_seconds__reduced__convert((days__reduced * Duration.microsecondsPerDay));

uu date_time__seconds__convert__minutes(
  final uu seconds,
) =>
    (seconds ~/ date_time__duration__minute__seconds__count);

uu date_time__minute__convert__seconds(
  final uu minutes,
) =>
    (minutes * date_time__duration__minute__seconds__count);

({
  uu hours,
  uu minutes,
  uu seconds,
}) date_time__seconds__convert__time({
  required final uu seconds,
}) {
  final //
      hours = (seconds ~/ Duration.secondsPerHour),
      _seconds = (seconds - (hours * Duration.secondsPerHour)),
      minutes = (_seconds ~/ Duration.secondsPerMinute),
      __seconds = (_seconds - (minutes * Duration.secondsPerMinute)),
      ___seconds = (__seconds % 60);

  return (
    hours: hours,
    minutes: minutes,
    seconds: ___seconds,
  );
}

extension date_time__print__extension //
    on DateTime {
  base__text__representation //
      convert__text__representation() {
    return base__kampa__convert__text__representation(
      "date_time",
      {
        "value": toUtc().toIso8601String(),
        "time:zone": timeZoneName,
      },
    );
  }
}

string date_time__relative(
  final DateTime date_time,
) {
  final //
      current = (date_time.isUtc //
          ? date_time__current().toUtc()
          : date_time__current()),
      year__same__ok = (date_time.year == current.year),
      month__same__ok = (date_time.month == current.month),
      buffer = StringBuffer();

  buffer
    ..write(calendar__gregorian__month__static__string__arr[date_time.month - 1].substring(0, 3))
    ..write(char__space)
    ..write(date_time.day)
    ..write(" (")
    ..write(calendar__gregorian__week__day__static__string__arr[date_time.weekday - 1].substring(0, 2))
    ..write(')');

  if (!year__same__ok) //
    buffer
      ..write(", ")
      ..write(date_time.year);

  buffer
    ..write("; ")
    ..write(date_time.hour)
    ..write(char__colon)
    ..write(date_time.minute)
    ..write(char__colon)
    ..write(date_time.second);

  return buffer.toString();
}

string date_time__convert__relative__simple /*
months and minutes ,are visually ambiguous ,for `concise__ok` */
    (
  final uu seconds, {
  final bool concise__ok = NO,
}) {
  final result = date_time__convert__relative(
    seconds,
  );

  if (concise__ok.not) {
    return "${result.value} ${result.duration.name} ago";
  } else {
    return "${result.value}${result.duration.name[0]} ago";
  }
}

({
  uu value,
  date_time__relative__durations duration,
}) date_time__convert__relative(
  final uu seconds,
) {
  final uu result;
  final date_time__relative__durations duration;

  if (seconds > date_time__duration__minute__seconds__count) {
    final uu seconds__count;

    if (seconds > date_time__duration__hour__seconds__count) {
      if (seconds > date_time__duration__day__seconds__count) {
        if /*F*/ (seconds > date_time__duration__week__seconds__count) {
          if /*F*/ (seconds > date_time__duration__month__seconds__count__simple) {
            if /*F*/ (seconds > date_time__duration__year__seconds__count__simple) {
              seconds__count = date_time__duration__year__seconds__count__simple;
              duration = date_time__relative__durations.years;
            } else {
              seconds__count = date_time__duration__month__seconds__count__simple;
              duration = date_time__relative__durations.months;
            }
          } else {
            seconds__count = date_time__duration__week__seconds__count;
            duration = date_time__relative__durations.weeks;
          }
        } else {
          seconds__count = date_time__duration__day__seconds__count;
          duration = date_time__relative__durations.days;
        }
      } else {
        seconds__count = date_time__duration__hour__seconds__count;
        duration = date_time__relative__durations.hours;
      }
    } else {
      seconds__count = date_time__duration__minute__seconds__count;
      duration = date_time__relative__durations.minutes;
    }

    result = (seconds ~/ seconds__count);
  } else {
    result = seconds;
    duration = date_time__relative__durations.seconds;
  }

  return (
    value: result,
    duration: duration,
  );
}

enum date_time__relative__durations //
{ years, months, weeks, days, hours, minutes, seconds }
