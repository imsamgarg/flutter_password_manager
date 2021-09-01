import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class SetPasswordController extends GetxController {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final passController = TextEditingController();
  late final confirmPassController = TextEditingController();

  late final _isPassObscure = true.obs;
  late final _isConfirmPassObscure = true.obs;

  bool isLoading = false;

  bool get isPassObscure => _isPassObscure.value;
  bool get isConfirmPassObscure => _isConfirmPassObscure.value;
  void setPassword() async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    update();
    final keyService = Get.find<SecureKeyService>();
    final v = await keyService.saveKey(passController.text, passwordKey);
    if (v) {
      return Get.offAndToNamed(Routes.HOME);
    }
    errorSnackbar("Error Saving Password");
    isLoading = false;
    update();
  }

  @override
  void onClose() {
    passController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }

  void toggleConfirmPassVisibility() {
    _isConfirmPassObscure.value = !_isConfirmPassObscure.value;
  }

  void togglePassVisibility() {
    _isPassObscure.value = !_isPassObscure.value;
  }
}
