#ifndef HEADER__time
#define HEADER__time

#define time__REDUCED__SIZE/* second precision */ u32__SIZE
#define time__OFFSET__YEAR 2022

#define time__SECONDS__OFFSET 1640995200/* manually calculated using the formula `((52 / 4) * (365.25 * 4) * 24 * 60 * 60)`, for specifically for 2022 as `TIME__OFFSET__YEAR` */

#define time__MILLI_SECONDS_PER_SECOND/* milli-seconds per second */ 1000
#define time__MICRO_SECONDS_PER_SECOND 1000000/* (1000 ** 2) */
#define time__NANO_SECONDS_PER_SECOND  1000000000/* (1000 ** 3) */

#define time__NANO_SECONDS_PER_MICRO_SECOND/* nano-seconds per micro-second */ 1000
#define time__NANO_SECONDS_PER_MILLI_SECOND/* nano-seconds per milli-second */ 1000000/* (1000 ** 3) */

#define _time__SPEC(\
	spec__time__SPEC_) \
	struct timespec spec__time__SPEC_; \
	clock_gettime(CLOCK_REALTIME/* `CLOCK_MONOTONIC`[`_RAW`] for stop-watch like functionality */, \
		&spec__time__SPEC_);
/*
	id spec */

#define _time__SPEC__SECONDS(\
	time__spec__time__SPEC__SECONDS_) \
	time__spec__time__SPEC__SECONDS_.tv_sec

#define _time__SPEC__SECONDS__REDUCED(\
	time__spec__time__SPEC__SECONDS_) \
	(_time__SPEC__SECONDS(time__spec__time__SPEC__SECONDS_) - time__SECONDS__OFFSET)

#define _time__SPEC__NANO_SECONDS(\
	time__spec__time__SPEC__NANO_SECONDS_) \
	time__spec__time__SPEC__NANO_SECONDS_.tv_nsec

#define _time__SPEC__MICRO_SECONDS(\
	time__spec__time__SPEC__MICRO_SECONDS_) \
	(_time__SPEC__NANO_SECONDS(time__spec__time__SPEC__MICRO_SECONDS_) / time__NANO_SECONDS_PER_MICRO_SECOND)

#define _time__SPEC__MILLI_SECONDS(\
	time__spec__time__SPEC__MILLI_SECONDS_) \
	(_time__SPEC__NANO_SECONDS(time__spec__time__SPEC__MILLI_SECONDS_) / time__NANO_SECONDS_PER_MILLI_SECOND)

#define time__SECONDS__REDUCED__NANO_SECONDS(\
	secs__time__SECONDS__REDUCED__NANO_SECONDS, \
	nano_secs__time__SECONDS__REDUCED__NANO_SECONDS) {\
	_time__SPEC(spec__time__SECONDS__REDUCED__NANO_SECONDS) \
	secs__time__SECONDS__REDUCED__NANO_SECONDS = _time__SPEC__SECONDS__REDUCED(spec__time__SECONDS__REDUCED__NANO_SECONDS);\
	nano_secs__time__SECONDS__REDUCED__NANO_SECONDS = _time__SPEC__NANO_SECONDS(spec__time__SECONDS__REDUCED__NANO_SECONDS); }
/*
	uu|u32 secs: ret, mod
	u32 nano_secs: ret, mod */

#define time__SECONDS ({\
	_time__SPEC(spec) \
	_time__SPEC__SECONDS(spec); })
/*
	uu

	`uu time__unix__current__seconds`
	current, unix-epoch time, in seconds

	`time(NULL)` internally use `clock_gettime(`, as check in "gnu-glibc"'s src
		so we use it directly */

#define time__SECONDS__REDUCED ({\
	_time__SPEC(spec) \
	_time__SPEC__SECONDS__REDUCED(spec); })
/*
	uu|u32

	unix time in seconds, beginning from the year `TIME__OFFSET__YEAR`, instead of 1970
		is containable in `u32`, currently,
			and whenever the value seems to exceed, the limits of `u32__MAX`,
			`TIME__OFFSET__YEAR` can always be updated */

#define time__NANO_SECONDS ({\
	_time__SPEC(spec) \
	((_time__SPEC__SECONDS(spec) * time__NANO_SECONDS_PER_SECOND) + _time__SPEC__NANO_SECONDS(spec)); })

#endif
