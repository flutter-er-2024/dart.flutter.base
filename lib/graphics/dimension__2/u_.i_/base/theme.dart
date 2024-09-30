part of "_.dart";

final base__app__theme__change__broadcast__channel = base__widget__re_build__event__channel__broadcast();

late bool //
    base__app__theme__colors__ground___back__dark__ok /*
`{
  final hour = DateTime.now().hour;
  if (((hour > 18) || (hour < 6)).not) {
    base__app__theme__colors__ground___back__dark__ok = NO;
  }
}` */
    ;

late bool //
    base__app__interface__simple__ok /*
`(screen__width <= screen__width__phone__min)`
should be avoided ,because of great increase ,in deviation ,from the standard interface 
  ,further increasing the complexity ,for similicity seekers ,because the standard guides ,would stop working */
    ;

void base__app__theme__colors__ground___back__dark__ok__switch() {
  base__app__theme__colors__ground___back__dark__ok = base__app__theme__colors__ground___back__dark__ok.not;

  /*base__app__re_build()*/ base__app__theme__change__broadcast__channel.event__announce();
}
