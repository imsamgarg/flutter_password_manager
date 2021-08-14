import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddPasswordController extends GetxController {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController websiteController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passController = TextEditingController();
  late TextEditingController notesController = TextEditingController();

  final _isPasswordHidden = true.obs;

  bool get isPasswordHidden => this._isPasswordHidden.value;

  bool loading = false;
  set isPasswordHidden(bool value) {
    this._isPasswordHidden.value = value;
  }

  void togglePassHide() {
    isPasswordHidden = !isPasswordHidden;
  }

  void clearEmail() {
    emailController.clear();
  }

  void clearNotes() {
    notesController.clear();
  }

  void clearWebsite() {
    websiteController.clear();
  }

  void generatePassword() {
    int passLength = 15;
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,./;:?><{}[]()-=_+~`!@#%^&*';
    // const String alphabetsC = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    // const String numbers = '0123456789';
    // const String specialChars = ',./;:?><{}[]()-=_+~`!@#%^&*';

    String password = "";
    // StringBuffer buf/
    final randomiser = Random();
    while (passLength-- != 0) {
      password += chars[randomiser.nextInt(chars.length - 1)];
    }
    passController.text = password;
  }

  void savePassword() {
    try {
      loading = true;
      update();

      //TODOO:
    } on Exception catch (_) {}
    loading = false;
    update();
  }
}
