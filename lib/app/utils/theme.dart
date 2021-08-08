import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/app/utils/colors.dart';

ThemeData dartTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: CustomColors.accentColor,
  backgroundColor: CustomColors.backgroungColor,
  textTheme: GoogleFonts.varelaRoundTextTheme(),
  // colorScheme: ColorScheme.fromSwatch(
  //   primarySwatch: MaterialColor(
  //     CustomColors.primaryValue,
  //     CustomColors.swatch,
  //   ),
  // ),
  primaryColor: CustomColors.primaryColor,
  canvasColor: CustomColors.backgroungColor,
);
