import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/interfaces/auth_interface.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class LoginController extends GetxController implements AuthInterface {
  final _number = "".obs;
  String get number => _number.value;

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
    final keyMatched = await service.matchKey(number, secureKey);
    if (keyMatched) {
      Get.offAllNamed(Routes.HOME);
      return;
    }
    Get.rawSnackbar(message: "Wrong Pass Code!!", backgroundColor: Colors.red);
  }
}
