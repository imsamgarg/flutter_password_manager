import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/values/sizing.dart';

import 'color_theme.dart';

ThemeData dartTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: ColorTheme.accentColor,
  backgroundColor: ColorTheme.backgroungColor,
  textTheme: GoogleFonts.varelaRoundTextTheme(
    TextTheme(
      bodyText1: TextStyle(
        color: Vx.white,
      ),
      bodyText2: TextStyle(
        color: Vx.white,
      ),
    ),
  ),
  primaryColor: ColorTheme.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: ColorTheme.backgroungColor,
  ),
  buttonColor: ColorTheme.buttonColor,
  canvasColor: ColorTheme.backgroungColor,
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorTheme.inputBorderColor,
        width: 2,
      ),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorTheme.inputBorderFocusedColor,
        width: 2,
      ),
    ),
    labelStyle: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorTheme.inputBorderErrorColor,
        width: 1,
      ),
    ),
  ),
);

class BorderTheme {
  static const borderRadL = BorderRadius.all(Radius.circular(Sizing.radiusL));
  static const borderRadM = BorderRadius.all(Radius.circular(Sizing.radiusM));
  static const borderRadS = BorderRadius.all(Radius.circular(Sizing.radiusS));
  static const cardRadius = BorderRadius.all(Radius.circular(Sizing.radiusL));
}

class PaddingTheme {
  static const sidePaddingS =
      EdgeInsets.symmetric(horizontal: Sizing.sidesGapS);
  static const sidePaddingL =
      EdgeInsets.symmetric(horizontal: Sizing.sidesGapL);
  static const sidePaddingM =
      EdgeInsets.symmetric(horizontal: Sizing.sidesGapM);
}
