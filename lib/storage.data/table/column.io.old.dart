
/*void report__base__storage__data__table__main__meta(
  final base__storage__data__table__columns__array__kampa table__columns__arr,
  final base__storage__data__table__main__kampa table__main,
) =>
    report__base__storage__data__table__columns__meta__recursive__fancy(
      table__columns__arr,
      table__main,
    );

void report__base__storage__data__table__columns__meta__recursive__fancy(
  final base__storage__data__table__columns__array__kampa table__columns__arr,
  final base__storage__data__table__columns__kampa columns,
) =>
    columns.iterate__basic((final _, final column) {
      report__history__write(base__printing__indentation__increaseation__string * base__printing__indentation__increaseation);
      report__history__write(column__meta.name);

      if (column__meta.b__nil_able) //
        report__history__write__short('?');

      report__history__write__short(identifier__value__separator);
      report__history__write__short(column__meta.runtimeType);

      final columns__meta = ((column__meta is base__storage__data__table__column__type__array__meta__protocol) //
          ? table__columns__meta__arr[column__meta.columns__meta__id_]
          :  null);

      if (columns__meta !=  null) {
        report__history__write__short(char__bracket__round__open);
        report__history__write__short(columns__meta.column__meta__arr.count);
        report__history__write__short(char__colon);
        report__history__write__short(columns__meta.size);
        report__history__write__short(char__bracket__round__close);
      }

      report__history__write__short(base__printing__indentation__increaseation__string);
      report__history__write__short(column__meta.offset);

      report__history__write__short(char__colon);
      report__history__write__short(column__meta.size);

      report__line_feed();
      if (columns__meta !=  null) {
        base__printing__indentation__increase();

        report__base__storage__data__table__columns__meta__recursive__fancy(
          table__columns__meta__arr,
          columns__meta.column__meta__arr,
        );

        base__printing__indentation__decrease();
      }
    });*/
