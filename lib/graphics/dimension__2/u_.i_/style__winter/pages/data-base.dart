part of "../_.dart";

/*widget__build__stored__kampa data__base__table__explore__page__stored({
  required final string db__name,
  required final array<data__base__table__column__meta__protocol> table__main,
  required final data__base__meta__kampa ds___meta,
  required final array<data__base__table__columns__meta__kampa> columns__meta__arr,
}) {
  final //
      scroll__manager_ = scroll__manager();

  base__widget page(final _) => //
      page__foundation(
        base__list_ing__generat_ed(
          scroll__manager: scroll__manager_,
          page__title: base__page__title__aligned__center(
            primary__string: db__name,
            secondary__string: (table__main.elements__count.toString() + " Tables"),
          ),
          item__array__count: table__main.elements__count,
          item__build: (final _, final table__id_) {
            final column__meta = table__main[table__id_];

            return GestureDetector(
              onTap: () {},
              child: base__listing__item(
                body: base__box__text__primary(
                  data__base__table__column__meta__convert__string(
                    column__meta,
                  ),
                ),
                trailing: base__icon(
                  base__icon__navigation__forward,
                ),
              ),
            );
          },
        ),
      );

  return (
    de_init_: scroll__manager_.de_init_,
    widget__build: page,
  );
}

widget__build__stored__kampa data__base__table__rows__page__stored({
  required final data__base__meta__kampa ds___meta,
  required final array<data__base__table__columns__meta__kampa> columns__meta__arr,
  required final array<data__base__table__column__meta__protocol> column__meta__arr,
  required final string name,
}) {
  final //
      scroll__manager_ = scroll__manager();

  base__widget page(final _) => //
      page__foundation(
        base__list_ing__generat_ed(
          scroll__manager: scroll__manager_,
          page__title: base__page__title__aligned__center(
            primary__string: name,
            secondary__string: (column__meta__arr.elements__count.toString() + " Rows"),
          ),
          item__array__count: column__meta__arr.elements__count,
          item__build: (final _, final column__id_) {
            final column__meta = column__meta__arr[column__id_];

            return GestureDetector(
              onTap: () {},
              child: base__listing__item(
                body: base__box__text__primary(
                  data__base__table__column__meta__convert__string(
                    column__meta,
                  ),
                ),
                trailing: base__icon(
                  base__icon__navigation__forward,
                ),
              ),
            );
          },
        ),
      );

  return (
    de_init_: scroll__manager_.de_init_,
    widget__build: page,
  );
}

widget__build__stored__kampa data__base__table__columns__page__stored({
  required final data__base__meta__kampa ds___meta,
  required final array<data__base__table__columns__meta__kampa> columns__meta__arr,
  required final array<data__base__table__column__meta__protocol> column__meta__arr,
  required final string name,
}) {
  final //
      scroll__manager_ = scroll__manager();

  base__widget page(final _) => //
      page__foundation(
        base__list_ing__generat_ed(
          scroll__manager: scroll__manager_,
          page__title: base__page__title__aligned__center(
            primary__string: name,
            secondary__string: (column__meta__arr.elements__count.toString() + " Columns"),
          ),
          item__array__count: column__meta__arr.elements__count,
          item__build: (final _, final column__id_) => //
              base__listing__item(
            body: base__box__text__primary(
              data__base__table__column__meta__convert__string(
                column__meta__arr[column__id_],
              ),
            ),
          ),
        ),
      );

  return (
    de_init_: scroll__manager_.de_init_,
    widget__build: page,
  );
}*/
