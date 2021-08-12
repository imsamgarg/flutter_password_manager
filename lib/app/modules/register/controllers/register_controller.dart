import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/interfaces/auth_interface.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class RegisterController extends GetxController implements AuthInterface {
  final _number1 = "".obs;
  final _number2 = "".obs;

  String get number1 => _number1.value;
  String get number2 => _number1.value;

  bool _isConfirmActivate = false;

  String get number {
    if (_isConfirmActivate) return _number2.value;
    return _number1.value;
  }

  String get heading {
    if (_isConfirmActivate) return "Confirm";
    return "Register";
  }

  void set number(String num) {
    if (_isConfirmActivate) {
      _number2.value = num;
    } else {
      _number1.value = num;
    }
  }

  @override
  void addNumber(int num) {
    if (number.length > 5) return;
    this.number += "$num";
  }

  void removeNumber() {
    if (number.length < 1) return;
    number = number.substring(0, number.length - 1);
  }

  void clearNumber() {
    number = "";
  }

  @override
  void verifyNumber() async {
    if (!_isConfirmActivate) {
      if (number1.length == 6) {
        _isConfirmActivate = true;
        update();
      }
    } else {
      if (number1 == number2) {
        final service = Get.find<SecureKeyService>();
        final bool hasSaved = await service.saveKey(number1, secureKey);
        if (hasSaved) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.rawSnackbar(
              message: "Failed To Save Pass Code!!",
              backgroundColor: Colors.red);
        }
      }
    }
  }
}
