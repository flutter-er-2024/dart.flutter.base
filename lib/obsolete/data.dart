import "dart:async";

import "../accumulation.dart";
import "../arr.dart";
import "../_.dart";
import "../print.dart";

/*
  FIX
    `data__fetch_ing__data__group__level__1__element__array__`, and `data__fetch_ing__data__group__level__2__element__array__`
      are both mixed
        because both are `u4__`, so both worked, which closed the incentive */

const
//
    data__fetch_ing__data__group__level__1__element__array__count__width = u4__width,
    data__fetch_ing__data__group__level__1__element__array__count = u4__limit,
    data__fetch_ing__data__group__level__1__element__array__count__max = u4__max,
//
    data__fetch_ing__data__group__level__2__element__array__count__width = u4__width,
    data__fetch_ing__data__group__level__2__element__array__count = u4__limit,
    data__fetch_ing__data__group__level__2__element__array__count__max = u4__max,
//
    data__fetch_ing__data__groups__element__array__count__width = u8__width,
    data__fetch_ing__data__groups__element__array__count = /*(data__fetch_ing__data__group__level__2__element__array__count * data__fetch_ing__data__group__level__1__element__array__count)*/ u8__limit,
    data__fetch_ing__data__groups__element__array__count__max = u8__max; /*
`data:group:level:1:element:arr:count`(`u4:limit`(16)) :`data:grp_:lvl_:0`(`data`)s per `data:grp_:lvl_:1`
`data:group:level:2:element:arr:count`(`u4:limit`(16)) :`data:grp_:lvl_:1`s per `data:grp_:lvl_:2`
`data:group:level:3:element:arr`(in-finite `count`) :`data:grp_:lvl_:2:arr`
`data:groups:element:arr:count`(`u8:limit`(256)) :total `data`s ,in all(both) the `data:grp_:lvl_`s */

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
  static asyn___value<data__fetch_ing<data__type>> init_<data__type>({
    required final array<data__type> /*
`elements:count`: `data:fetch_ing:group:level:3:element:arr:count` */
        ?
        data__element__array__init_ial /*
should be compliant with `progress_ion__reverse__ok` */
    ,
    required final data__fetch_ing__data__group__level__1__element__array__fetch__function__format<data__type> /*
`count` ,`offset` :`data:fetch_ing:data:group:level:1:element:id_:convert:data:element:id_:offset:count` */
        data__element__array__fetch,
    required final uu data__element__array__count /*
must be `>= data:group:level:3:element:arr:count` 
  ,in which case ,`data:fetch_ing` is overkill ,anyways */
    ,
    //final bool progress_ion__reverse__ok /*{back|for}_ward*/ = NO,
  }) async {
    const //
        data__element__array__offset = 0,
        data__group__level__3__id_ = (data__element__array__offset >> data__fetch_ing__data__groups__element__array__count__width),
        group__level__2__element__array__count = data__fetch_ing__data__group__level__2__element__array__count;

    final array<data__fetch_ing__data__group__level__1__kampa<data__type>> result;

    if (data__element__array__init_ial == null) {
      final $accumulation = base__accumulation<data__fetch_ing__data__group__level__1__kampa<data__type>>(
        capacity__initial__multiplier: /*(data__fetch_ing__data__groups__element__array__count__width - accumulation__capacity__default__width)*/ 5,
      );

      await base__iterate__basic__asyn_(
        group__level__2__element__array__count,
        (final data__group__level__1__element__id_) async {
          $accumulation.add__element(
            data__fetch_ing__data__group__level__1__kampa(
              data__group__level__3__id_: data__group__level__3__id_,
              data__group__level__2__element__arr: await data__element__array__fetch(
                data__group__level__1__element__id_,
              ),
            ),
          );
        },
      );

      result = $accumulation.convert__array();

      $accumulation.dispose();
    } else {
      result = array__new__generate(
        group__level__2__element__array__count,
        (final data__group__level__1__element__id_) {
          final //
              data__element__id__offset__count = data__fetch_ing__data__group__level__1__element__id__convert__data__element__id__offset__count(
                data__group__level__1__element__id_,
                data__element__array__count,
              ),
              data__group__level__2__element__arr = array__new__copy(
                data__element__array__init_ial,
                offset: data__element__id__offset__count.data__element__id__offset,
                count: data__element__id__offset__count.data__element__array__count,
              );

          return data__fetch_ing__data__group__level__1__kampa(
            data__group__level__3__id_: data__group__level__3__id_,
            data__group__level__2__element__arr: data__group__level__2__element__arr,
          );
        },
      );
    }

    return data__fetch_ing<data__type>(
      result,
      data__element__array__count,
      data__element__array__fetch,
    );
  }

  data__fetch_ing(
    this.$_data__group__level__2__element__arr,
    this.data__element__array__count,
    this.$_data__element__array__fetch,
  );

  final array<data__fetch_ing__data__group__level__1__kampa<data__type>> $_data__group__level__2__element__arr /*
  `final array<data__type> data__element__arr; uu data__element__array__count__current/* number of data, already fetch-ed */;`
    would have been sufficient, if the fetch ops were, increasing only
      instead of both, increase, or decrease
      because `data__fetch_ing__data__groups__element__id` could be calculated, from `data__element__array__count__current` */
      ;

  final uu data__element__array__count;

  final data__fetch_ing__data__group__level__1__element__array__fetch__function__format<data__type> $_data__element__array__fetch;

  asyn___value<data__type> data__element(
    final uu data__element__id_,
  ) async /*
the sophisticated engineer-ing, which gave birth to this function
  is mere observation, of patterns, and multiple, quite-random, but logical, trials
    which is actually the real power, powering the whole domain, of computer science
    between different values, in: `print("$i\t${(i & 255) >> 4}\t${i & 255}\t${i >> 8}\t${i & 15}\t${i >> 4}");` */
  {
    final //
        data__group__level__2__element__id_ = ((data__element__id_ >> data__fetch_ing__data__group__level__2__element__array__count__width) & data__fetch_ing__data__group__level__2__element__array__count__max) /*((data:element:id / data:fetch_ing:data:group:level:2:element:arr:count) % data:fetch_ing:data:group:level:2:element:arr:count)*/ ..convert__text__representation().print("data__group__level__2__element__id"),
        data__group__level__1__element__arr = $_data__group__level__2__element__arr[data__group__level__2__element__id_]..data__group__level__3__id_.convert__text__representation().print("data__group__level__1__element__arr:exist_ing.data__group__level__3__id"),
        data__group__level__3__id_ = (data__element__id_ >> data__fetch_ing__data__groups__element__array__count__width) /*(data:element:id / data:fetch_ing:data:groups:element:arr:count)*/ ..convert__text__representation().print("data__group__level__3__id") /*
`data__group__level__3__id`, instead of `data__group__level__1__element__id`, because
  any data will always get the same location in the `data__group__level__2__element__arr`
    despite the sequence of fetch-ing
  and, the former, requires, less-er memory-space */
        ,
        data__group__level__1__element__id_ = (data__element__id_ & data__fetch_ing__data__group__level__1__element__array__count__max)..convert__text__representation().print("block__data__element__id");

    if (data__group__level__1__element__arr.data__group__level__3__id_ == data__group__level__3__id_) {
      "path:fast (cached already)".print();

      return data__group__level__1__element__arr.data__group__level__2__element__arr[data__group__level__1__element__id_];
    }

    final $data__group__level__1__element__id_ = (data__element__id_ >> data__fetch_ing__data__group__level__1__element__array__count__width)..convert__text__representation().print("data__group__level__1__element__id");

    "path:slow (caching now)".print();

    return ($_data__group__level__2__element__arr[data__group__level__2__element__id_] = data__fetch_ing__data__group__level__1__kampa(
      data__group__level__3__id_: data__group__level__3__id_,
      data__group__level__2__element__arr: await $_data__element__array__fetch(
        $data__group__level__1__element__id_,
      ),
    ))
        .data__group__level__2__element__arr[data__group__level__1__element__id_];
  } /*
FIX :doc. ,correct ,flow ,names ,etc. */
}

class data__fetch_ing__data__group__level__1__kampa<data__type> {
  data__fetch_ing__data__group__level__1__kampa({
    required this.data__group__level__3__id_,
    required this.data__group__level__2__element__arr,
    this.future__fetch__buffer,
  });

  final uu data__group__level__3__id_;
  final array<data__type> data__group__level__2__element__arr;
  ({
    uu data__group__level__3__id_,
    asyn___value<array<data__type>> $Future,
  })? future__fetch__buffer; /*
FIX :use ,after improving the names ,and renam-ing */
}

typedef data__fetch_ing__data__group__level__1__element__array__fetch__function__format<data__type> = //
    asyn___value<array<data__type>> Function(
  uu data__group__level__1__element__id_,
);

({
  uu offset,
  uu count,
}) data__fetch__data__group__level__2__element__array__offset__count(
  final uu data__group__level__1__element__id_,
  final uu data__element__array__count,
) {
  final //
      offset = (data__group__level__1__element__id_ << data__fetch_ing__data__group__level__1__element__array__count__width),
      remain_ing__count = (data__element__array__count - offset);

  return (
    offset: offset,
    count: ((remain_ing__count < data__fetch_ing__data__group__level__1__element__array__count) /*block:id_:last:ok*/ //
        ? remain_ing__count
        : data__fetch_ing__data__group__level__1__element__array__count),
  );
}

({
  uu data__element__id__offset,
  uu data__element__array__count,
}) data__fetch_ing__data__group__level__1__element__id__convert__data__element__id__offset__count(
  final uu data__group__level__1__element__id_,
  final uu data__element__array__count,
) {
  final data__element__id__offset = (data__group__level__1__element__id_ /* `*data__group__level__1__element__array__count` */ << data__fetch_ing__data__group__level__1__element__array__count__width);

  return (
    data__element__id__offset: data__element__id__offset,
    data__element__array__count: (((data__fetch_ing__data__group__level__1__element__array__count + data__element__id__offset) < data__element__array__count) /*likely*/ //
        ? data__fetch_ing__data__group__level__1__element__array__count
        : /* will happen, only once, at last/end, if even happens ever */ (data__element__array__count - data__element__id__offset)),
  );
}

asyn___value<void> main() async {
  const data__element__array__count = /*256*/ 257;

  "save.begin".print();

  final fetch_ing = await data__fetch_ing.init_(
    data__element__array__init_ial: NIL,
    data__element__array__fetch: (final data__group__level__1__element__id_) {
      final offset__count = data__fetch_ing__data__group__level__1__element__id__convert__data__element__id__offset__count(
        data__group__level__1__element__id_,
        data__element__array__count,
      );

      if (offset__count.data__element__array__count > data__element__array__count) {
        "(${offset__count.data__element__array__count} > $data__element__array__count)".print();
      }

      return asyn___value.value(
        array__new__generate(
          offset__count.data__element__array__count,
          (final i) => (i + offset__count.data__element__id__offset),
        )..convert__text__representation().print("data__element__array__fetch ($data__group__level__1__element__id_; ${offset__count.data__element__array__count} ,${offset__count.data__element__id__offset})"),
      );
    },
    data__element__array__count: data__element__array__count,
  );

  "save.end".print();

  {
    const count = (data__element__array__count ~/ 8);
    count.convert__text__representation().print("count");

    "load.begin".print();

    await base__iterate__basic__asyn_(
      count,
      (final data__element__id_) async {
        (await fetch_ing.data__element(
          data__element__id_,
        ))
            .convert__text__representation().print("fetch_ing.data__element");
      },
    );

    "...".print();

    const offset = (data__element__array__count - count);
    offset.convert__text__representation().print("offset");

    await base__iterate__basic__asyn_(
      count,
      (final i) async {
        (await fetch_ing.data__element(
          (i + offset),
        ))
            .convert__text__representation().print("fetch_ing.data__element");
      },
    );

    "load.end".print();
  }
}
