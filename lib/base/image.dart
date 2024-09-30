part of "_.dart";

/*
  to compress a raster image (or picture, or photograph)
    convert the bitmap(bytes sequence)
      from `RGBA...RGBA...RGBA`
      to `RRR...GGG...BBB...AAA...`
        then pass through run-length compression
    if has alpha color
      convert 16-bit per-color (hdr)
        to 8-bit per-color (sdr)
          -> 4-bit per-color
            -> 2-bit per-color
    if alpha is absent
      hdr -> sdr
        further reduction will cause byte alignment issues
    if alpha is 0, hence pixel is invisible
      make it empty
      
  `https://compress-or-die.com/Understanding-PNG`
  `https://phoboslab.org/log/2021/11/qoi-fast-lossless-image-compression`
  `https://q-viper.github.io/2021/05/24/coding-run-length-encoding-in-python/` */

const //
    image__dimension__size = u16__size;

by__arr image__convert__bytes(
  final by__arr image, {
  required final u16 width,
  required final u16 height,
  required final bool b__alpha,
}) /*
  `__pixel__sub`
  test
    file.bytes.count: 939_469
    image
      width: 1_024
      height: 1_024
      channel__array__count: 3
      pixel.arr.count: 3_145_728
    result
      channel.red.bytes.count: 1_838_168
      channel.blue.bytes.count: 1_837_872
      channel.green.bytes.count: 1_840_572
      bytes.count: 5_516_621

  testing
    natural(mountains) pictures, video-game textures
      repetition count
        0: easily three-fourth
        <3: hardly one-tenth
        >7: mere single digit */
{
  final //
      dimension = (width * height),
      channel__array__count = (!b__alpha ? 3 : 4),
      channel__arr = array__new__generate(
        channel__array__count,
        (final _) => base__by__array__accumulation__size__dynamic(),
      ),
      channel__rep__count__arr = array__new__fill(
        channel__array__count,
        0,
      ),
      channel__rep__not__count__arr = array__new__fill(
        channel__array__count,
        0,
      ),
      channel__rep__minor__count__arr = array__new__fill(
        channel__array__count,
        0,
      ),
      channel__rep__major__count__arr = array__new__fill(
        channel__array__count,
        0,
      ),
      channel__rep__value__arr = array__new__fill<u8?>(
        channel__array__count,
        null,
      );

  width.convert__text__representation().print("width");
  height.convert__text__representation().print("height");
  dimension.convert__text__representation().print("dimension");
  channel__array__count.convert__text__representation().print("channel__array__count");

  base__iterate__basic(dimension, (final pixel__id_) {
    base__iterate__basic(channel__array__count, (final channel__id_) {
      final //
          id_ = (channel__id_ + (pixel__id_ * channel__array__count)),
          value__rep = channel__rep__value__arr[channel__id_];

      if (value__rep != null) {
        if (value__rep != image[id_]) {
          channel__arr[channel__id_]
            ..add__uu((1 + channel__rep__count__arr[channel__id_]))
            ..add__uu(value__rep);

          if (channel__rep__count__arr[channel__id_] == 0) //
            channel__rep__not__count__arr[channel__id_] += 1;
          else if (channel__rep__count__arr[channel__id_] < 3) //
            channel__rep__minor__count__arr[channel__id_] += 1;
          else if (channel__rep__count__arr[channel__id_] > 7) //
            channel__rep__major__count__arr[channel__id_] += 1;

          channel__rep__count__arr[channel__id_] = 0;
          channel__rep__value__arr[channel__id_] = image[id_];
        } else //
          channel__rep__count__arr[channel__id_] += 1;
      } else //
        channel__rep__value__arr[channel__id_] = image[id_];
    });
  });

  base__iterate__basic(channel__array__count, (final channel__id_) {
    //final id_ = (channel__id_ + ((dimension - 1) * channel__array__count));

    if (channel__rep__value__arr[channel__id_] != null) {
      channel__arr[channel__id_]
        ..add__uu((1 + channel__rep__count__arr[channel__id_]))
        ..add__uu(channel__rep__value__arr[channel__id_]!);

      if (channel__rep__count__arr[channel__id_] == 0) //
        channel__rep__not__count__arr[channel__id_] += 1;
    }
  });

  final sink = base__by__array__accumulation__size__dynamic();

  channel__arr.iterate__basic(
    
    (final channel__id_, final channel) {
      final bys = channel.convert__by__arr();

      bys.convert__text__representation().print(
            "channel__bys",
          );

      bys.bys__count.convert__text__representation().print(
            "channel__bys.count",
          );

      {
        final //
            rep__not__count = channel__rep__not__count__arr[channel__id_],
            effectiveness__percentage = (((dimension - rep__not__count) / dimension) * 100)
            /*,channel__bys__count__optimistic = ((bys.count / effectiveness__percentage) * 100)*/ /*
  blunder
    test returned a value, approx `(8 * dimension)` */
            ;

        rep__not__count.convert__text__representation().print(
              "sub-pixel, un-repetition, count",
            );

        channel__rep__minor__count__arr[channel__id_].convert__text__representation().print(
              "sub-pixel, minor(1-3 inclusive), repetition, count",
            );

        channel__rep__major__count__arr[channel__id_].convert__text__representation().print(
              "sub-pixel, major(7+ inclusive), repetition, count",
            );

        effectiveness__percentage.toStringAsFixed(2).convert__text__representation().print(
              "compression, effectiveness, percentage",
            );
      }

      sink
        ..add__uu(bys.bys__count)
        ..add(bys);
    },
  );

  final result = sink.convert__by__arr();

  result.elements__count.convert__text__representation().print(
        "result.count",
      );

  return result;
}
