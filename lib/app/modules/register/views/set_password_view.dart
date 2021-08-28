import 'package:custom_utils/spacing_utils.dart';
import 'package:custom_utils/validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';
import 'package:password_manager/app/modules/register/controllers/register_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class SetPasswordView extends GetView<RegisterController> {
  final heading = "Set Password";

  final bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: context.width - 80,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                heading.text.size(20).bold.make(),
                verSpacing24,
                Obx(
                  () => PasswordWidget(
                    hint: 'Password',
                    controller: controller.passController,
                    isPassObscure: controller.isPassObscure,
                    togglePassVisibility: controller.togglePassVisibility,
                    validator: (v) {
                      final v2 = controller.confirmPassController.text;
                      return passValidator(v, v2, 8);
                    },
                  ),
                ),
                verSpacing16,
                Obx(
                  () => PasswordWidget(
                    hint: 'Confirm Password',
                    controller: controller.confirmPassController,
                    isPassObscure: controller.isConfirmPassObscure,
                    togglePassVisibility:
                        controller.toggleConfirmPassVisibility,
                    validator: (v) {
                      final v2 = controller.passController.text;
                      return passValidator(v, v2, 8);
                    },
                  ),
                ),
                verSpacing32,
                CustomButton(
                  "Submit",
                  onTap: controller.setPassword,
                  isLoading: isLoading,
                )
              ],
            ),
          ),
        ).box.p8.border(color: Colors.grey.shade400).make(),
      ),
    );
  }

  String? passValidator(String? v, String? v2, int length) {}
}

class PasswordWidget extends StatelessWidget with Validator {
  final String hint;
  final bool isPassObscure;
  final TextEditingController controller;
  final VoidCallback togglePassVisibility;
  final String? Function(String?)? validator;

  const PasswordWidget({
    required this.hint,
    required this.isPassObscure,
    required this.togglePassVisibility,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassObscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: ShowPasswordToggle(
          isHidden: isPassObscure,
          onTap: togglePassVisibility,
        ),
      ),
    );
  }
}
