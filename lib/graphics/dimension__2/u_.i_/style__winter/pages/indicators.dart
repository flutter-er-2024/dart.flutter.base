part of "../_.dart";

base__widget base__indicate__progress__bar__widget({
  required final uu parts__count,
  required final base__value__alter__widget__re_build__event__channel__broadcast<uu>
      progress__channel /*
progress must be a multiple ,of `parts:count` */
  ,
  required final Color border__color,
  required final Color? progress__fill_ed__color /*
if not available ,`border__color` is used */
  ,
  required final Gradient?
      progress__fill_ed__gradient /*
`progress__fill_ed__color` has higher precedence ,hence if its available ,then given a preference */
  ,
}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(12.px),
      ),
      border: Border.all(
        color: border__color,
        width: 1.px,
      ),
    ),
    child: base__event__channel__broadcast__handling__widget(
      channel: progress__channel,
      build: (final context) {
        final //
            progress__flex = progress__channel.value(),
            remain_ing__flex = (parts__count - progress__flex),
            remain__ing__ok = (remain_ing__flex > /* handles `progress > parts:count` case ,vs `!=` */ 0),
            child = SizedBox(
              height: 16.px,
            );

        return Row(
          children: [
            if (progress__flex != 0) //
              Expanded(
                flex: progress__flex,
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(12.px),
                    right: (remain__ing__ok //
                        ? Radius.zero
                        : Radius.circular(12.px)),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: progress__fill_ed__color,
                      gradient: progress__fill_ed__gradient,
                    ),
                    child: child,
                  ),
                ),
              ),
            if (remain__ing__ok) //
              Expanded(
                flex: remain_ing__flex,
                child: child,
              ),
          ],
        );
      },
    ),
  );
}

base__widget base__indicate__activity__fragment({
  final fp? radius__size,
}) =>
    Center(
      child: base__indicate__activity__fragment__base(
        radius__size: radius__size,
      ),
    );

base__widget base__indicate__activity__fragment__base({
  final fp? radius__size /*`size:half`*/,
}) =>
    CupertinoActivityIndicator(
      color: color__foreground__dim,
      radius: (radius__size ?? 24.px),
    );

base__widget base__indicate__activity__page() => //
    page__foundation(
      base__indicate__activity__fragment(
        radius__size: 24.px,
      ),
    );

base__widget base__indicator__dis_connection([
  final fp? font__size,
]) =>
    Center(
      child: base__icon(
        flutter__icons.cloud_off_outlined /*flutter__icons.report_problem_outlined*/,
        size: font__size,
        color: color__foreground__dim,
      ),
    );

class base__indicator__dis_connection__page extends StatelessWidget {
  const base__indicator__dis_connection__page({
    super.key,
    required this.error,
    this.trace,
  });

  final Object error;
  final StackTrace? trace;

  @override
  base__widget build(final BuildContext context) {
    return page__foundation(
      Column(
        children: <base__widget>[
          Padding(
            padding: navigation__top__bubble__padding__insets(),
            child: base__navigation__top__bubble(
              left: (
                icon: base__icon__navigation__backward,
                on_press: () => context.navigate__backward(),
              ),
            ),
          ),
          const Expanded(
            child: empty__widget,
          ),
          base__indicator__dis_connection(
            96.px,
          ),
          base__widget__separat_or__vertical,
          box__text__widget(
            "Problem connecting\n" "to service\n" ":(",
            font__color: color__foreground__dim,
            font__size: 18.px,
            font__weight: FontWeight.w600,
            text__align: TextAlign.center,
          ),
          base__widget__separat_or__vertical,
          box__text__widget(
            error.toString(),
            font__color: color__foreground__dimmest,
            text__align: TextAlign.center,
          ),
          const Expanded(
            child: empty__widget,
          ),
        ],
      ),
    );
  }
}

/*class _DeficiencyIndicator extends StatelessWidget {
  const _DeficiencyIndicator({
    final Key? key,
    this.title = "No app found",
    this.subTitle = "to open item",
  }) : super(key: key);

  final string title, subTitle;

  @override
  base__widget build(final BuildContext context) {
    return NonScrollableListingPage(
      children: <base__widget>[
        base__icon(
          flutter__icons.app_blocking_outlined,
          font__size: 64.px,
        ),
        SizedBox(
          height: 32.px,
        ),
        Text(
          title,
          text__align: TextAlign.center,
          style: TextStyle(
            font__size: 20.px,
            font__weight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8.px,
        ),
        Text(
          subTitle,
          text__align: TextAlign.center,
          style: TextStyle(
            font__size: 16.px,
            font__weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}*/
