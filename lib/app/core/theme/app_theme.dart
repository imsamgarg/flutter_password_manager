import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/app/core/values/sizing.dart';

import 'color_theme.dart';
// import 'package:password_manager/app/utils/colors.dart';

ThemeData dartTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: ColorTheme.accentColor,
  backgroundColor: ColorTheme.backgroungColor,
  textTheme: GoogleFonts.varelaRoundTextTheme(),
  // colorScheme: ColorScheme.fromSwatch(
  //   primarySwatch: MaterialColor(
  //     CustomColors.primaryValue,
  //     CustomColors.swatch,
  //   ),
  // ),
  primaryColor: ColorTheme.primaryColor,
  canvasColor: ColorTheme.backgroungColor,
);

class BorderTheme {
  static const borderRadius = BorderRadius.all(Radius.circular(Sizing.radiusL));
  static const cardRadius = BorderRadius.all(Radius.circular(Sizing.radiusL));
}
