import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';

class ConfirmPasswordController extends GetxController {
  late final TextEditingController passController = TextEditingController();
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _isPassObscure = true.obs;
  bool get isPassObscure => _isPassObscure.value;

  void togglePassVisibility() {
    _isPassObscure.value = !_isPassObscure.value;
  }

  void onSubmit() async {
    if (!formKey.currentState!.validate()) return;

    final service = Get.find<SecureKeyService>();
    final hasMatched = await service.matchKey(passController.text, passwordKey);
    if (hasMatched) {
      return Get.back(result: true);
    }
    errorSnackbar("Wrong Pass Code");
  }
}
