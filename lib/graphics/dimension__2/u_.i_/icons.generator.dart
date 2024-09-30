import "package:base/base/_.dart";
import "package:base/graphics/dimension__2/u_.i_/flutter/_.dart";

const //
    _html_css__keyboard_key /* can try at `http://codepen.io/pen` */ = """
<html>

<body style="background-color: #1b1b1d;">
  <kbd style="
    align-items: center;
    background: linear-gradient(-26.5deg,#565872,#31355b);
    border: 0;
    border-radius: 3px;
    box-shadow: inset 0 -2px 0 0 #282d55,inset 0 0 1px 1px #51577d,0 2px 2px 0 rgba(3,4,9,.3);
    color: #7f8497;
    display: flex;
    height: 16px;
    justify-content: center;
    margin-right: .4em;
    padding: 0 0 3px;
    position: relative;
    top: -1px;
    width: 20px;
  ">
    <svg class="DocSearch-Control-Key-Icon" height="15" width="15">
      <path d="M4.505 4.496h2M5.505 5.496v5M8.216 4.496l.055 5.993M10 7.5c.333.333.5.667.5 1v2M12.326 4.5v5.996M8.384 4.496c1.674 0 2.116 0 2.116 1.5s-.442 1.5-2.116 1.5M3.205 9.303c-.09.448-.277 1.21-1.241 1.203C1 10.5.5 9.513.5 8V7c0-1.57.5-2.5 1.464-2.494.964.006 1.134.598 1.24 1.342M12.553 10.5h1.953" strOKe-width="1.2" strOKe="currentColor" fill="none" strOKe-linecap="square">
      </path>
    </svg></kbd>
</body>

</html>
""";

Widget generate__cover__icon() {
  const Color //
      icon__primary__color = Color.fromARGB(159, 0, 0, 0),
      icon__secondary__color = icon__primary__color;

  const IconData //
      icon__primary /* bottom left */ = flutter__icons.home,
      icon__secondary /* top right */ = flutter__icons.search;

  const fp scale = 8 /* 1: 64*64; 2: 128*128 */;

  const List<Color> colors = <Color>[
    Color(0xff26a69a) /* flutter__colors.teal[400] */,
    Color(0xff00897b) /* flutter__colors.teal[600] */,
  ];

  return ColoredBox(
    color: flutter__colors.white,
    child: Center(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16 * scale)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8 * scale),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12 * scale)),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: colors,
              ),
            ),
            child: SizedBox(
              width: (64 * scale),
              height: (64 * scale),
              child: Padding(
                padding: const EdgeInsets.all(2 * scale),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        String.fromCharCode(icon__primary.codePoint),
                        style: TextStyle(
                          fontSize: (48 /* (32 + 16) */ * scale),
                          color: icon__primary__color,
                          fontFamily: icon__primary.fontFamily,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        String.fromCharCode(icon__secondary.codePoint),
                        style: TextStyle(
                          fontSize: (24 * scale),
                          color: icon__secondary__color,
                          fontFamily: icon__secondary.fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
