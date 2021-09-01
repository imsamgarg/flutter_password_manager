import 'package:custom_utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';

class ChangeMasterPasswordController extends GetxController {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final newPassController = TextEditingController();
  late final confirmNewPassController = TextEditingController();
  late final oldPassController = TextEditingController();

  late final _isOldPassObscure = true.obs;
  late final _isNewPassObscure = true.obs;
  late final _isConfirmNewPassObscure = true.obs;
  @override
  void onClose() {
    newPassController.dispose();
    confirmNewPassController.dispose();
    oldPassController.dispose();
    super.onClose();
  }

  final wrongPassErrorMsg = "Old Password Is Wrong";
  final changePassFailedErrorMsg = "Failed To Set New Password";
  final dbErrorMsg = "Failed To Encrypt N Save Password To Database";
  final successMsg = "Password Changed Successfully!!";

  bool isLoading = false;

  bool get isOldPassObscure => _isOldPassObscure.value;
  bool get isNewPassObscure => _isNewPassObscure.value;
  bool get isConfirmNewPassObscure => _isConfirmNewPassObscure.value;

  void setPassword() async {
    if (!formKey.currentState!.validate()) return;

    toggleLoading(true);

    final oldPass = oldPassController.text;
    final newPass = newPassController.text;

    final keyService = Get.find<SecureKeyService>();
    final matchKey = await keyService.matchKey(oldPass, passwordKey);

    if (!matchKey) {
      toggleLoading(false);
      return errorSnackbar(wrongPassErrorMsg);
    }

    final v = await keyService.saveKey(newPass, passwordKey);
    if (!v) {
      toggleLoading(false);
      return errorSnackbar(changePassFailedErrorMsg);
    }

    /// Encrypting New Passwords
    final encryService = Get.find<EncryptionService>();
    final dbService = Get.find<DatabaseService>();
    try {
      Get.find<HomeController>().passwords.forEach((e) async {
        e.password =
            encryService.decryptNEncrypt(e.password!, oldPass, newPass);
        await dbService.connection.updatePass(e);
      });
    } on Exception catch (e, s) {
      customLog("Db Updation", name: "Error", error: e, stackTrace: s);
      errorSnackbar(dbErrorMsg);
    }

    Get.back();
    successSnackbar(successMsg);
    toggleLoading(false);
  }

  void toggleLoading(bool value) {
    isLoading = value;
    update();
  }

  void toggleConfirmNewPassVisibility() {
    _isConfirmNewPassObscure.value = !_isConfirmNewPassObscure.value;
  }

  void toggleNewPassVisibility() {
    _isNewPassObscure.value = !_isNewPassObscure.value;
  }

  void toggleOldPassVisibility() {
    _isOldPassObscure.value = !_isOldPassObscure.value;
  }
}
