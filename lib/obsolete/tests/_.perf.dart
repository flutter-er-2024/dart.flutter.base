part of "../_.dart";

void test__list() /*
  test result:
    type: u8
    data: 255
    count: 99999999
      List: 2.5 seconds
      list__kampa: 7.3 seconds
    type: string
    data: ("255"*255)
    count: 999999
      List: 1.5 seconds
      list__kampa: 1.67 seconds */
{
  const count = 99999999;

  final //
      ls = /*List<u8>.empty(growable: OK)*/ list<u8>(),
      w = Stopwatch()..start();

  uu i = count;

  while ((i -= 1) > 0) //
    ls.add(255);

  i = count;
  w
    ..stop()
    ..reset()
    ..start();

  while ((i -= 1) > 0) //
    ls.add(255);

  w.stop();
  print(w.elapsedMicroseconds);
  print(ls. /*length*/ elements__count);
}
