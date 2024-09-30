part of "_.dart";

class base__widget__focus__depository //
    extends base__depository__base {
  base__widget__focus__depository({
    final bool focus_ed__initial = NO,
    final base__event__channel__broadcast<base__widget__tree__node>? focus__channel,
  })  : _focus_ed__ok = focus_ed__initial,
        focus__channel = (focus__channel ?? base__widget__re_build__event__channel__broadcast());

  final base__event__channel__broadcast<base__widget__tree__node> focus__channel /*
tracks `focus_ed__ok()` */
      ;

  bool _focus_ed__ok;

  FocusNode? _focus;

  bool focus_ed__ok() {
    return _focus_ed__ok;
  }

  void focus() {
    if (_focus_ed__ok) {
      return;
    }

    _focus?.requestFocus(); /*
will invoke `focus__channel.event__announce` */
  }

  void focus__remove() {
    if (_focus_ed__ok.not) {
      return;
    }

    _focus?.unfocus(); /*
will invoke `focus__channel.event__announce` */
  }

  void de_focus() => //
      focus__remove();

  FocusNode //
      focus__node() {
    final $_focus = _focus;

    if ($_focus != null) {
      return $_focus;
    }

    final focus = FocusNode();

    focus.addListener(() {
      _focus_ed__ok = focus.hasFocus;

      focus__channel.event__announce();
    });

    return (_focus = focus);
  }

  @override
  void dispose() /*
also de-focus-es */
  {
    _focus?.dispose();

    focus__channel.dispose();
  }
}

class base__widget__focus__exclusive__depository /*
maintains single/exclusive focus */ //
    extends base__widget__focus__depository {
  base__widget__focus__exclusive__depository({
    super.focus_ed__initial = NO,
    final base__event__channel__broadcast<base__widget__tree__node>? focus__channel,
  }) : super(
          focus__channel: (focus__channel ??
              base__event__channel__broadcast<base__widget__tree__node>(
                (final context) {
                  context.re_build();
                  asyn___schedule(() {
                    /*if (focus_ed__ok().not)*/ {
                      focus__channel?.descriptors__remove(
                        context,
                      );
                    }
                  });
                },
              )),
        );
}
