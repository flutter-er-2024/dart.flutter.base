import "package:base/base/_.dart";
import "../networking.web/_.dart";

//

/*abstract class service__authority__result {
  const service__authority__result();
}

class service__authority__result__allow //
    extends service__authority__result {
  const service__authority__result__allow();
}

class service__authority__result__deny //
    extends service__authority__result {
  const service__authority__result__deny(
    this.data,
  );

  final by__arr data;
}*/

//

abstract class service__authority__source {
  const service__authority__source();

  asyn___value< /*service__authority__result*/ by__arr? /* {deny|handle} ?? allow */ > //
      resolve() /*
should be conservative ,towards allow-ing 
  ,like on error ,otherwise losing the `service__authority__source` will break the service */
  ;
}

class service__authority__source__dummy //
    extends service__authority__source {
  const service__authority__source__dummy(
    this.data__fetch,
  );

  final by__arr? Function() data__fetch;

  @override
  asyn___value<by__arr?> //
      resolve() {
    return asyn___value.value(
      data__fetch(),
    );
  }
}

class service__authority__source__inet___file //
    extends service__authority__source {
  const service__authority__source__inet___file(
    this.world_wide_web__path,
  );

  final string world_wide_web__path;

  asyn___value<by__arr?> //
      fetch() async {
    final response = await base__net___reliable__web__client__communicate__basic(
      world_wide_web__path,
    );

    if (base__net___web__status__code__convert__summary(
          response.statusCode,
        ) ==
        base__net___request__results.success) {
      final response_1 = (await Stream__convert__data__array__asyn___value(
        response.stream,
      ))
          .merge();

      if (response_1.empty__not()) {
        return uu__array__convert__by__arr(
          response_1,
        );
      }
    }

    return NIL;
  }

  @override
  asyn___value< /*service__authority__result*/ by__arr?> //
      resolve() async {
    return fetch();
  }
}

class service__authority__source__inet___file__git_hub //
    extends service__authority__source__inet___file {
  const service__authority__source__inet___file__git_hub(
    final string user__name,
    final string repository__name,
    final string file__path,
  ) : super(
          "$base__net___web__scheme__fix___pre://raw.githubusercontent.com/$user__name/$repository__name/main/$file__path",
        );
}
