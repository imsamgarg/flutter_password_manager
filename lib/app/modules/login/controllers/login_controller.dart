import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';

import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/interfaces/auth_interface.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class LoginController extends GetxController implements AuthInterface {
  late final bool updatePassCode;

  final _number = "".obs;
  String get number => _number.value;

  String get heading =>
      updatePassCode ? "Confirm Old Pass Code" : "Enter Pass Code";

  @override
  void onInit() {
    updatePassCode = Get.arguments ?? false;
    super.onInit();
  }

  void addNumber(int number) {
    if (_number.value.length > 5) return;
    this._number.value += "$number";
  }

  void removeNumber() {
    if (_number.value.length < 1) return;
    _number.value = _number.value.substring(0, _number.value.length - 1);
  }

  void clearNumber() {
    _number.value = "";
  }

  @override
  void verifyNumber() async {
    if (_number.value.length != 6) return;
    final service = Get.find<SecureKeyService>();
    final keyMatched = await service.matchKey(number, passCode);
    if (keyMatched) {
      if (updatePassCode) {
        return Get.offAndToNamed(Routes.REGISTER, arguments: updatePassCode);
      }
      return Get.offAndToNamed(Routes.HOME);
    }
    errorSnackbar("Wrong Pass Code!!");
  }
}
