import 'package:flutter/rendering.dart';

class ColorTheme {
  static const Color swatch1 = Color(0xff040405);
  static const Color swatch2 = Color(0xff1805d7);
  static const Color swatch3 = Color(0xff1304a3);
  static const Color swatch4 = Color(0xff0c0362);
  static const Color swatch5 = Color(0xff4c4946);
  static const Color swatch6 = Color(0xffdfdfe1);
  static const Color swatch7 = Color(0xffa9513b);
  static const Color swatch8 = Color(0xff3f58c4);

  static const Color accentColor = swatch7;
  static const Color primaryColor = swatch2;
  static const Color backgroungColor = swatch1;

  static int primaryValue = primaryColor.value;
  static const swatch = {
    50: Color(0xFF1500FF),
    100: Color(0xFF1400EC),
    200: Color(0xFF1100CC),
    300: Color(0xFF0F00AF),
    400: Color(0xFF0E00A7),
    500: swatch7,
    // 500: Color(0xFF0C0092),
    600: Color(0xFF0C0074),
    700: Color(0xFF08005A),
    800: Color(0xFF06003B),
    900: Color(0xFF040029),
  };
}
