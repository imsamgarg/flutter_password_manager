import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/core/values/sizing.dart';

void successSnackbar(String message, [int sec = 4]) {
  return customSnackBar(
    message,
    Icon(Icons.check, color: Vx.white),
    ColorTheme.successColor,
  );
}

void errorSnackbar(String message, [int sec = 4]) {
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
    shouldIconPulse: false,
    icon: icon,
    duration: Duration(seconds: sec),
    backgroundColor: bgColor,
    overlayColor: fgColor,
    borderRadius: Sizing.radiusS,
  );
}

Future<T> showOverlay<T>(Future<T> fun()) async {
  final value = await Get.showOverlay(
    asyncFunction: fun,
    loadingWidget: SpinKitThreeBounce(color: ColorTheme.primaryColor),
  );
  return value;
}

String? passValidator(String? v, String? v2, int length) {
  v ??= "";
  v2 ??= "";
  if (v.isEmpty) return "Please Enter The Password";
  if (v.length < length) return "Password Must be $length Chars Long";
  if (v != v2) return "Passwords Dont Match";
  return null;
}
