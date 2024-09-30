part of "../_.dart";

/*
result :
  run-time efficiency :
    - sync./`value` proc.s :~3 ticks
    - async./`asyn___value<value>` proc.s :~30 ticks (sync. x10)
    - possibly-async./`FutureOr<value>` proc.s :~40 ticks (sync. x13)
  `FutureOr` is possibly conditional ,based on ,sync. vs. async. */
asyn___value<void> _test__call__overhead() async {
  const count = (1 + 1000);

  final watch = Stopwatch();

  var total = 0;

  for (var i = 0; i < count; i += 1) {
    watch.start();

    final r = /*_syn_(i) await _asyn___or__syn_(i) await _asyn___or__asyn_(i) await _asyn_(i)*/;

    watch.stop();

    print("${(r?'T':'F')/* to prevent the compiler ,from optimizing `r` ,away */}  ${watch.elapsedTicks}");

    if (i != 0) /* to ingore the first warm-up run ,especially for j.i.t. compilation */ {
      total += watch.elapsedTicks;
    }

    watch.reset();
  }

  print(total / count);
}

@pragma(_inline__never)
bool _syn_(
  final int i,
) {
  return _base(i);
}

@pragma(_inline__never)
FutureOr<bool> _asyn___or__syn_(
  final int i,
) {
  return _base(i);
}

@pragma(_inline__never)
FutureOr<bool> _asyn___or__asyn_(
  final int i,
) async {
  return _base(i);
}

@pragma(_inline__never)
asyn___value<bool> _asyn_(
  final int i,
) async {
  return _base(i);
}

const _inline__never = "vm:never-inline";

@pragma("vm:always-inline")
bool _base(
  final int i,
) {
  return i.isOdd;
}
