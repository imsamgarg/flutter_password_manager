import 'dart:math';

import 'package:custom_utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';

class AddPasswordController extends GetxController {
  static const _errorMessage = "Failed To Save Password";
  static const _successMessage = "Password Saved Successfully!!";

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
    String password = "";
    final randomiser = Random();
    while (passLength-- != 0) {
      password += chars[randomiser.nextInt(chars.length - 1)];
    }
    passController.text = password;
  }

  void savePassword() async {
    if (!formKey.currentState!.validate()) return;
    try {
      loading = true;
      update();
      customLog("--Saving Password--");

      //Services
      final _dbService = Get.find<DatabaseService>();
      final _encryService = Get.find<EncryptionService>();
      final _secureKeyService = Get.find<SecureKeyService>();

      //Current Time
      int _time = DateTime.now().millisecondsSinceEpoch;

      //Will use key for encryption
      final _key = await _secureKeyService.getKey(secureKey);
      if (_key.isEmpty) throw Exception();

      //Encrypt Password
      final _encryptedPass = _encryService.encryptText(
        passController.text,
        _key,
      );

      //Saving Details To Database
      Password password = Password(
        createdOn: _time,
        modifiedOn: _time,
        email: emailController.text,
        notes: notesController.text,
        password: _encryptedPass,
        r: "G",
        tags: "g",
        website: websiteController.text,
      );
      final _res = await _dbService.connection.savePass(password);
      customLog(_res, name: "result");
      //Stops Loading
      stopLoading();

      //pop current screen
      Get.back();
      successSnackbar(_successMessage);
    } on Exception catch (e, s) {
      customLog("Error", error: e, stackTrace: s);

      //Stop Loading
      stopLoading();
      errorSnackbar(_errorMessage);
    }
  }

  void stopLoading() {
    loading = false;
    update();
  }

  void startLoading() {
    loading = true;
    update();
  }
}
