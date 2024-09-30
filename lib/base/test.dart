part of "_.dart";

/*
TASK :
  add support for :
    goodies ,from `lang_:enchanted` :
      intentionally-failing test-cases
    `test:name` param. to `base:test` ,also used as `test:case:name:prefix`
    `test:result:report:summary:ok` param. to `base:test`
    `array<test:case:convert:variation:proc_\transform\>` param. to `base:test` */

array<base__test__result__defective<case__type>> //
    base__test //
    <case__type extends base__test__case__protocol>({
  required final array<case__type> cases,
  required final base__test__function__format<case__type> test,
}) {
  final issues = base__accumulation<base__test__result__defective<case__type>>();

  cases.iterate__basic(
    (final i, final c) {
      final result = test(c);

      if (result is base__test__result__success) {
        return;
      }

      issues.add__element(
        base__test__result__defective<case__type>(
          c,
          result,
        ),
      );
    },
  );

  final result = (issues.empty__not() //
      ? issues.convert__array()
      : array__new__empty<base__test__result__defective<case__type>>());

  issues.dispose();

  return result;
}

typedef base__test__function__format //
    <case__type extends base__test__case__protocol> //
    = base__test__result Function(case__type);

class base__test__result__defective /* FIX :change name ,to more accurate */ //
    <case__type extends base__test__case__protocol> {
  const base__test__result__defective(
    this.test__case,
    this.test__result,
  );

  final case__type test__case;
  final base__test__result test__result;
}

abstract class base__test__case__protocol {
  const base__test__case__protocol(
    this.name,
  );

  final string name;
}

//

class base__test__result__success__un_expected //
    extends base__test__result {
  const base__test__result__success__un_expected();
}

class base__test__result__success //
    extends base__test__result {
  const base__test__result__success();
}

class base__test__result__failure //
    extends base__test__result {
  const base__test__result__failure(
    this.error, [
    this.trace,
  ]);

  final string error;
  final StackTrace? trace;
}

abstract class base__test__result {
  const base__test__result();
}
