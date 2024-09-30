part of "_.dart";

base__error__handle__proc_ base__error__handle = base__error__print;

typedef base__error__handle__proc_ = //
    void Function(
  Object error,
  StackTrace trace/*=StackTrace.current*/ /*
call-sequence of the proc.-calls 
  ,including the code's {library-name ,relative-{file-path} ,line-id.} */
  ,
);

bool //
    base__error__fatal__ok //
    <error__type extends Object> //
        /*exception|error:serious|panic*/ /* un-recoverable ,possible in-valid usage */ (
  final error__type error,
) {
  if (error is Error) {
    return NO;
  }

  if (error is Exception) {
    return OK;
  }

  return OK /* default/most-likely */;
}

string //
    base__error__code(
  final bool error__fatal__ok,
) {
  return (error__fatal__ok //
      ? char__alphabet__case__upper__f /* Fatal */
      : char__alphabet__case__upper__e /* Error */);
}

void base__error__print(
  final Object error,
  final StackTrace? trace, [
  final string? label,
]) {
  base__print__blank(16);

  base__error__print__concise(
    error,
    trace,
    label,
  );

  base__print__blank(16);
}

void base__error__print__concise(
  final Object error,
  final StackTrace? trace, [
  final string? label,
]) {
  error //
      .convert__text__representation()
      .print(
        base__error__code(
          base__error__fatal__ok(error),
        ),
        label,
      );

  (trace ?? StackTrace.current) //
      .convert__string()
      .print(label);
}
