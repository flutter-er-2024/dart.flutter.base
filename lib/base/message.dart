part of "_.dart";

typedef base__message__handle__procedure<message__type> = //
    void Function(message__type message);

/*typedef message__channel__broadcast__observer<message__type> = //
    message__message__handle__procedure<message__type>;

class message__channel__broadcast<message__type> /*
like `dart:Stream`
`:unicast` is not needed 
  ,because the run-time cost/overhead ,of added in-direct-ion ,would exceed the benefits
data is plural ,datum/message is singular
  datum is called message ,because it arrives */
{
  message__channel__broadcast() //
      : _observers = base__accumulation<message__channel__broadcast__observer<message__type>>();

  final base__accumulation<message__channel__broadcast__observer<message__type>> _observers;

  uu observers__count() {
    return this._observers.elements__count;
  }

  void observers__add(
    final message__channel__broadcast__observer<message__type> observer,
  ) {
    this._observers.add__element(
          observer,
        );
  }

  void message__announc(
    final message__type message,
  ) {
    this._observers.iterate__basic(
          (final observer) => observer(message),
        );
  }

  void observers__remove(
    final message__channel__broadcast__observer<message__type> observer,
  ) {
    this._observers.remove__element(
          observer,
          base__value__same__ok,
        );
  }

  void observers__flush() {
    this._observers.flush();
  }

  void dispose() {
    this._observers.dispose();
  }
}*/
