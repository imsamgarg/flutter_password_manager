import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/core/values/sizing.dart';
import 'package:velocity_x/velocity_x.dart';

void successSnackbar(String message, [int sec = 4]) {
  // Get.rawSnackbar(
  //   message: message,
  //   icon: Icon(Icons.check, color: Vx.white),
  //   duration: Duration(seconds: sec),
  //   backgroundColor: ColorTheme.successColor,
  //   overlayColor: Vx.white,
  //   borderRadius: Sizing.radiusM,
  // );
  return customSnackBar(
    message,
    Icon(Icons.check, color: Vx.white),
    ColorTheme.successColor,
  );
}

void errorSnackbar(String message, [int sec = 4]) {
  // Get.rawSnackbar(
  //   message: message,
  //   icon: Icon(Icons.cancel_rounded, color: Vx.white),
  //   duration: Duration(seconds: sec),
  //   backgroundColor: ColorTheme.errorColor,
  //   overlayColor: Vx.white,
  //   borderRadius: Sizing.radiusM,
  // );
  return customSnackBar(
    message,
    Icon(Icons.cancel_rounded, color: Vx.white),
    ColorTheme.errorColor,
  );
}

void customSnackBar(
  String message,
  Icon icon,
  Color bgColor, [
  int sec = 4,
  Color fgColor = Vx.white,
]) {
  Get.rawSnackbar(
    message: message,
    icon: icon,
    duration: Duration(seconds: sec),
    backgroundColor: bgColor,
    overlayColor: fgColor,
    borderRadius: Sizing.radiusM,
  );
}
