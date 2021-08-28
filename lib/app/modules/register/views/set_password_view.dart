import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/values/sizing.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';
import 'package:password_manager/app/modules/register/controllers/set_password_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class SetPasswordView extends StatelessWidget {
  final heading = "Set Password";
  final controller = Get.put(SetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
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
                      GetBuilder(
                        init: controller,
                        builder: (_) {
                          return CustomButton(
                            "Submit",
                            onTap: controller.setPassword,
                            isLoading: controller.isLoading,
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
                  .box
                  .p16
                  .color(Theme.of(context).backgroundColor)
                  .withRounded(value: Sizing.radiusM)
                  .shadowSm
                  .make(),
            ),
          ),
          Container(
            width: context.width - 80,
            child: "This Is The Master Password. You Cannot Recover It"
                .text
                .center
                .make(),
          )
              .box
              .p16
              .color(Theme.of(context).backgroundColor)
              .withRounded(value: Sizing.radiusM)
              .shadowSm
              .make(),
          verSpacing20
        ],
      ),
    );
  }

  String? passValidator(String? v, String? v2, int length) {
    v ??= "";
    v2 ??= "";
    if (v.isEmpty) return "Please Enter The Password";
    if (v.length < length) return "Password Must be $length Chars Long";
    if (v != v2) return "Passwords Dont Match";
    return null;
  }
}

class PasswordWidget extends StatelessWidget {
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
