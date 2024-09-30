part of "_.dart";

typedef data__fetch_ing__de_init___procedure<data__type> = //
    void Function(data__type);

class data__fetch_ing<data__type>
/*
behaves like a ring
after ,completely independent ,discovery ,design ,and development 
  ,a chat-bot was asked about any similar existing discovery ,with a description 
    ,which concluded ,that the creation is not first-of-its-kind 
      ,and called "circular buffer"/"rolling"/"sliding window" cach-ing ,in the software industry

the rationale behind ,the difference between groups ,being 16 ,is simple
  its a multiple of 2 ,hence supported ,by binary(bit-wise) op.s
  not a large number, hence memory-efficient, for phones
    but also, not a small number, hence quite-sufficient

value 16 is not recommended, for non-phone systems
  prefer increasing it to much more, may be 32, for a work-station, and 256 for a server, or even more, as required

TASK
  `data:arr:fetch(` a block, in advance
    to avoid the delay, in `data(`, when `data__fetch_ing__data__group__level__2__element__arr` is un-available, at the moment
    a potental issue, is deciding, the block to fetch, previous, or next, to the current
      because the sequence is un-defined
      a solution could be to use historical knowledge
        merely the last event, was it forward, or backward
        because change is less-likely */
{
  data__fetch_ing({
    required this.counts,
    required this.$data__group__level__2__element__arr,
    required this.data__element__array__count,
    required this.$data__group__level__1__element__array__fetch,
    required this.$data__de_init_,
  });

  final data__fetch_ing__counts counts;

  final array<data__fetch_ing__data__group__level__1__kampa<data__type>?> $data__group__level__2__element__arr /*
`final array<data__type> data__element__arr; uu data__element__array__count__current/* number of data, already fetch-ed */;`
  would have been sufficient, if the fetch ops were, increasing only
    instead of both, increase, or decrease
    because `data__group__level__3__element__id` could be calculated, from `data__element__array__count__current` */
      ;

  final uu data__element__array__count;

  final data__fetch_ing__data__group__level__1__element__array__fetch__function__format<data__type> $data__group__level__1__element__array__fetch;

  final data__fetch_ing__de_init___procedure<data__type>? $data__de_init_;

  asyn___value<data__type> data__element(
    final uu data__element__id_,
  ) async /*
the sophisticated engineer-ing, which gave birth to this function
  is mere observation, of patterns, and multiple, quite-random, but logical, trials
    which is actually the real power, powering the whole domain, of computer science
    between different values, in: `print("$i\t${(i & 255) >> 4}\t${i & 255}\t${i >> 8}\t${i & 15}\t${i >> 4}");` */
  {
    final //
        data__group__level__3__id_ = (data__element__id_ >> counts.data__group__level__3__element__array__count__width)..convert__text__representation().print("data__group__level__3.id"),
        data__group__level__2__element__slot__id_ = ((data__element__id_ >> counts.data__group__level__1__element__array__count__width /*
TASK :
  understand ,why `>> counts.data__group__level__1__element__array__count__width` is needed */
            ) &
            counts.data__group__level__2__element__array__count__max),
        data__group__level__1__element__slot__id_ = (data__element__id_ & counts.data__group__level__1__element__array__count__max)..convert__text__representation().print("data__group__level__1.element__slot__id");

    var data__group__level__2__element = $data__group__level__2__element__arr[data__group__level__2__element__slot__id_];

    if /*F*/ ((data__group__level__2__element == null) || //
        (data__group__level__2__element.data__group__level__3__id_ != data__group__level__3__id_)) {
      "path:slow (caching now)".print("#####");

      data__group__level__2__element?.data__group__level__3__id_.convert__text__representation().print("data__group__level__1__element__arr:exist_ing.data__group__level__3__id");

      {
        final $$data__de_init_ = $data__de_init_;
        if ($$data__de_init_ != null) {
          data__group__level__2__element?.data__group__level__1__element__arr.iterate__reverse__basic(
            (final i, final e) => $$data__de_init_(e),
          );
        }
      }

      data__group__level__2__element = //
          $data__group__level__2__element__arr[data__group__level__2__element__slot__id_] = //
              data__fetch_ing__data__group__level__1__kampa(
        data__group__level__3__id_: data__group__level__3__id_,
        data__group__level__1__element__arr: await $data__group__level__1__element__array__fetch(
          (data__element__id_ >> counts.data__group__level__1__element__array__count__width /*
TASK :
  understand ,why `data:group:level:1:element:arr:count:width` works ,instead of `data:group:level:2:element:arr:count:width` */
          )
            ..convert__text__representation().print("data__group__level__2__element__id"),
        ),
      );
    } else {
      "path:fast (cached already)".print("***");
    }

    return data__group__level__2__element.data__group__level__1__element__arr[data__group__level__1__element__slot__id_];
  }
}

data__fetch_ing<data__type> data__fetch_ing__init___simple<data__type>({
  required final data__fetch_ing__counts counts,
  /*required final array<data__type> /*
`elements:count`: `data:fetch_ing:group:level:3:element:arr:count` */
      ?
      data__group__level__3__element__array__init_ial /*
must be compliant with `progress_ion__reverse__ok` 
  ,like if OK ,should contain the ending elements ,otherwise the begin-ing elements */
  ,*/
  required final data__fetch_ing__data__group__level__1__element__array__fetch__function__format<data__type> /*
`count` ,`offset` :`data:fetch_ing:data:group:level:1:element:id_:convert:data:element:id_:offset:count` */
      data__group__level__1__element__array__fetch,
  final data__fetch_ing__de_init___procedure<data__type>? data__de_init_,
  required final uu data__element__array__count /*
must be `>= data:group:level:3:element:arr:count` 
  ,in which case ,`data:fetch_ing` is overkill ,anyways */
  ,
  /*final bool progress_ion__reverse__ok /*{back|for}_ward*/ = NO,*/
}) {
  final //
      /*data__element__array__offset = 0,/* FIX :link with `progress_ion__reverse__ok` */
      data__group__level__3__id_ = (data__element__array__offset >> counts.data__group__level__3__element__array__count__width),*/
      data__group__level__2__element__array__count = (1 + counts.data__group__level__2__element__array__count__max);

  final array<data__fetch_ing__data__group__level__1__kampa<data__type>?> data__group__level__2__element__arr;

  /*if /*T*/ (data__group__level__3__element__array__init_ial == null)*/ /*{
    final $accumulation = base__accumulation<data__fetch_ing__data__group__level__1__kampa<data__type>>(
      capacity__initial__multiplier: /*(data__fetch_ing__data__groups__element__array__count__width - accumulation__capacity__default__width)*/ 5,
    );

    await base__iterate__basic__asyn_(
      data__group__level__2__element__array__count,
      (final data__group__level__1__element__id_) async {
        $accumulation.add__element(
          data__fetch_ing__data__group__level__1__kampa(
            data__group__level__3__id_: data__group__level__3__id_,
            data__group__level__2__element__arr: await data__group__level__1__element__array__fetch(
              data__group__level__1__element__id_,
            ),
          ),
        );
      },
    );

    data__group__level__2__element__arr = $accumulation.convert__array();

    $accumulation.dispose();
  }*/
  {
    data__group__level__2__element__arr = array__new__fill(data__group__level__2__element__array__count, null);
  } /* else {
    data__group__level__2__element__arr = array__new__generate(
      data__group__level__2__element__array__count,
      (final data__group__level__2__element__id_) {
        final //
            data__element__id__offset__count = data__fetch_ing__data__group__level__2__element__id__convert__data__element__id__offset__count(
              data__group__level__2__element__id_,
              data__element__array__count,
              counts,
            ),
            data__group__level__1__element__arr = array__new__copy(
              data__group__level__3__element__array__init_ial,
              offset: data__element__id__offset__count.offset,
              count: data__element__id__offset__count.count,
            );

        return data__fetch_ing__data__group__level__1__kampa(
          data__group__level__3__id_: data__group__level__3__id_,
          data__group__level__1__element__arr: data__group__level__1__element__arr,
        );
      },
    );
  }*/

  return data__fetch_ing<data__type>(
    counts: counts,
    $data__group__level__2__element__arr: data__group__level__2__element__arr,
    data__element__array__count: data__element__array__count,
    $data__group__level__1__element__array__fetch: data__group__level__1__element__array__fetch,
    $data__de_init_: data__de_init_,
  );
}

data__fetch_ing__counts data__fetch_ing__counts__init_({
  final uu data__group__level__3__element__array__count__width = u8__width /*
other values are un-test-ed

`data:group:level:1:element:arr:count`(`u4:limit`(16)) :`data:grp_:lvl_:0`(`data`)s per `data:grp_:lvl_:1`
`data:group:level:2:element:arr:count`(`u4:limit`(16)) :`data:grp_:lvl_:1`s per `data:grp_:lvl_:2`
`data:group:level:3:element:arr`(in-finite `count`) :`data:grp_:lvl_:2:arr`
`data:groups:element:arr:count`(`u8:limit`(256)) :total `data`s ,in all(both) the `data:grp_:lvl_`s */
  ,
  final uu data__group__level__2__element__array__count__bit_wise__shift__right__count = 2 /* 4 parts/divisions */,
}) {
  final //
      data__group__level__2__element__array__count__width = (data__group__level__3__element__array__count__width >> data__group__level__2__element__array__count__bit_wise__shift__right__count),
      data__group__level__2__element__array__count__max = ((1 << data__group__level__2__element__array__count__width) - 1),
      data__group__level__1__element__array__count__width = (data__group__level__3__element__array__count__width - data__group__level__2__element__array__count__width),
      data__group__level__1__element__array__count__max = ((1 << data__group__level__1__element__array__count__width) - 1);

  return (
    data__group__level__3__element__array__count__width: data__group__level__3__element__array__count__width,
    data__group__level__2__element__array__count__width: data__group__level__2__element__array__count__width,
    data__group__level__2__element__array__count__max: data__group__level__2__element__array__count__max,
    data__group__level__1__element__array__count__width: data__group__level__1__element__array__count__width,
    data__group__level__1__element__array__count__max: data__group__level__1__element__array__count__max,
  );
}

typedef data__fetch_ing__counts = ({
  uu data__group__level__3__element__array__count__width,
//
  uu data__group__level__2__element__array__count__width,
  uu data__group__level__2__element__array__count__max,
//
  uu data__group__level__1__element__array__count__width,
  uu data__group__level__1__element__array__count__max,
});

({
  uu offset,
  uu count,
}) data__fetch_ing__data__group__level__2__element__id__convert__data__element__id__offset__count(
  final uu data__group__level__2__element__id_,
  final uu data__element__array__count,
  final data__fetch_ing__counts counts,
) {
  final //
      data__element__id__offset = (data__group__level__2__element__id_ /* `*data__group__level__1__element__array__count` */ << counts.data__group__level__1__element__array__count__width),
      data__group__level__1__element__array__count = (1 + counts.data__group__level__1__element__array__count__max),
      elements__remain_ing__count = (data__element__array__count - data__element__id__offset);

  return (
    offset: data__element__id__offset,
    count: (/*IFN*/ (elements__remain_ing__count < data__group__level__1__element__array__count) /* can happen, only once (at last/end), only if un-align-ed */ //
        ? elements__remain_ing__count
        : data__group__level__1__element__array__count),
  );
}

class data__fetch_ing__data__group__level__1__kampa<data__type> {
  data__fetch_ing__data__group__level__1__kampa({
    required this.data__group__level__3__id_,
    required this.data__group__level__1__element__arr,
    this.future__fetch__buffer,
  });

  final uu data__group__level__3__id_;
  final array<data__type> data__group__level__1__element__arr;
  ({
    uu data__group__level__3__id_,
    asyn___value<array<data__type>> $Future,
  })? future__fetch__buffer; /*
FIX :use ,after improving the names ,and renam-ing */
}

typedef data__fetch_ing__data__group__level__1__element__array__fetch__function__format<data__type> = //
    asyn___value<array<data__type>> Function(
  uu data__group__level__2__element__id_,
) /*
`asyn___value.value` can be used for sync.-fetch */
    ;

asyn___value<void> _data__fetching__test() async {
  const data__element__array__count = /*257*/ 1000000000000 /* 1T */;

  late final data__fetch_ing<uu> $data__fetch_ing;

  {
    "save.begin".print();

    final counts = data__fetch_ing__counts__init_()..convert__text__representation().print("data__fetch_ing.counts");

    $data__fetch_ing = data__fetch_ing__init___simple(
      counts: counts,
      /*data__group__level__3__element__array__init_ial: NIL,*/
      data__group__level__1__element__array__fetch: (final data__group__level__2__element__id_) {
        final offset__count = data__fetch_ing__data__group__level__2__element__id__convert__data__element__id__offset__count(
          data__group__level__2__element__id_,
          data__element__array__count,
          counts,
        );

        if (offset__count.count > data__element__array__count) {
          "(${offset__count.count} > $data__element__array__count)".print();
        }

        return asyn___value.value(
          array__new__generate(
            offset__count.count,
            (final i) => (i + offset__count.offset),
          )..convert__text__representation().print("data__element__array__fetch ($data__group__level__2__element__id_; ${offset__count.count} ,${offset__count.offset})"),
        );
      },
      data__element__array__count: data__element__array__count,
    );

    "save.end".print();
  }

  base__print__blank();

  {
    "load.begin".print();

    if (OK /* full:ok */) {
      await base__iterate__basic__asyn_(
        data__element__array__count,
        (final data__element__id_) async {
          base__print__blank();
          (await $data__fetch_ing.data__element(
            data__element__id_,
          ))
              .convert__text__representation().print("fetch_ing.data__element ($data__element__id_)");
        },
      );
    } else {
      const count = (data__element__array__count ~/ 8);
      count.convert__text__representation().print("count");

      await base__iterate__basic__asyn_(
        count,
        (final data__element__id_) async {
          base__print__blank();
          (await $data__fetch_ing.data__element(
            data__element__id_,
          ))
              .convert__text__representation().print("fetch_ing.data__element ($data__element__id_)");
        },
      );

      "...".print();

      const offset = (data__element__array__count - count);
      offset.convert__text__representation().print("offset");

      await base__iterate__basic__asyn_(
        count,
        (final i) async {
          base__print__blank();
          (await $data__fetch_ing.data__element(
            (i + offset),
          ))
              .convert__text__representation().print("fetch_ing.data__element (${(i + offset)})");
        },
      );
    }

    "load.end".print();
  }
}
