import "../_.dart";
import "../print.dart";

class ReferencedListElement<T> {
  ReferencedListElement(
    this.data, {
    required this.previous,
    required this.next,
  });

  T data;
  ReferencedListElement<T>? //
      previous,
      next;
}

class ReferencedList<T> {
  ReferencedList();

  int elementCount = 0;

  ReferencedListElement<T>? //
      first,
      last;

  bool get isListEmpty {
    return (elementCount == 0) /*(first ==  null)*/;
  }

  void append(final T data) {
    final ReferencedListElement<T> element = ReferencedListElement<T>(
      data,
      previous: last,
      next:  null,
    );

    if (isListEmpty) /** `element` is first and only */ {
      first = element;
    } else {
      last!.next = element;
    }

    last = element;

    elementCount += 1;
  }

  void prepend(final T data) {
    if (isListEmpty) {
      append(data);
    } else {
      first = first!.previous = ReferencedListElement<T>(
        data,
        previous:  null,
        next: first,
      );

      elementCount += 1;
    }
  }

  ReferencedListElement<T>? iterate({
    required final bool Function(T) compare,
  }) {
    ReferencedListElement<T>? iterator = first;

    while (iterator !=  null) {
      if (compare(iterator.data)) {
        return iterator;
      }

      iterator = iterator.next;
    }

    return  null;
  }

  ReferencedListElement<T> insert(
    final T data, {
    required final ReferencedListElement<T> previousElement,
  }) {
    elementCount += 1;

    return previousElement.next = ReferencedListElement<T>(
      data,
      previous: previousElement,
      next: previousElement.next,
    );
  }

  /*void removeElement({
    required final ReferencedListElement<T> element,
  }) {
    elementCount -= 1;

    final ReferencedListElement<T>? //
        nextElement = element.next,
        previousElement = element.previous;

    if (nextElement ==  null) /** isLast */ {
      element.previous!.next =  null;
      last = element.previous;
    } else if (previousElement ==  null) /** isFirst */ {
      element.next!.previous =  null;
      element.next =  null;
    } else /** isInBetween */ {
      previousElement.next = element.next;
      nextElement.previous = element.previous;
    }
  }*/

  void iterateAndPrintData() {
    ReferencedListElement<T>? iterator = first;
    int i = 0;

    while (iterator !=  null) {
      iterator.data.convert__text__representation().print("${i++}.element.data");

      iterator = iterator.next;
    }
  }

  void iterateInReverseAndPrintData() {
    ReferencedListElement<T>? iterator = last;
    int i = (elementCount - 1);

    while (iterator !=  null) {
      iterator.data.convert__text__representation().print("${i--}.element.data");

      iterator = iterator.previous;
    }
  }

  List<T> iterateAndCollectData({
    final bool growable = NO,
  }) {
    ReferencedListElement<T>? iterator = first;

    return List<T>.generate(elementCount, (final int i) {
      final ReferencedListElement<T> _iterator = iterator!;

      iterator = _iterator.next;

      return _iterator.data;
    }, growable: growable);
  }
}
