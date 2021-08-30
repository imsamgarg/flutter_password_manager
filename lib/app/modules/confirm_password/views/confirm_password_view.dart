import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/global_widgets/auth_views_widgets.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';

import '../controllers/confirm_password_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ConfirmPasswordView extends StatelessWidget {
  final controller = Get.put(ConfirmPasswordController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderTheme.borderRadM),
      title: "Enter Password".text.make(),
      content: Form(
        key: controller.formKey,
        child: PasswordWidget(
          hint: "Master Password",
          validator: (v) => passValidator(v, v, 8),
          isPassObscure: controller.isPassObscure,
          togglePassVisibility: controller.togglePassVisibility,
          controller: controller.passController,
        ),
      ),
      actions: [
        GetBuilder(
          init: controller,
          builder: (_) {
            return DialogButton(
              onTap: controller.onSubmit,
              color: Theme.of(context).buttonColor,
              heading: "Verify",
              isLoading: controller.isLoading,
            );
          },
        ),
      ],
    );
  }
}
