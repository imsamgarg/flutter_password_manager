import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/sizing.dart';
import 'package:password_manager/app/global_widgets/auth_views_widgets.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/change_master_password_controller.dart';

class ChangeMasterPasswordView extends GetView<ChangeMasterPasswordController> {
  final heading = "Change Password";

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
                          hint: 'Old Password',
                          controller: controller.oldPassController,
                          isPassObscure: controller.isOldPassObscure,
                          togglePassVisibility:
                              controller.toggleOldPassVisibility,
                          validator: (v) {
                            return passValidator(v, v, 8);
                          },
                        ),
                      ),
                      verSpacing16,
                      Obx(
                        () => PasswordWidget(
                          hint: 'New Password',
                          controller: controller.newPassController,
                          isPassObscure: controller.isNewPassObscure,
                          togglePassVisibility:
                              controller.toggleNewPassVisibility,
                          validator: (v) {
                            final v2 = controller.confirmNewPassController.text;
                            return passValidator(v, v2, 8);
                          },
                        ),
                      ),
                      verSpacing16,
                      Obx(
                        () => PasswordWidget(
                          hint: 'Confirm New Password',
                          controller: controller.confirmNewPassController,
                          isPassObscure: controller.isConfirmNewPassObscure,
                          togglePassVisibility:
                              controller.toggleConfirmNewPassVisibility,
                          validator: (v) {
                            final v2 = controller.newPassController.text;
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
            child:
                "Current Passwords Will Be Encrypted Using New Password. This May Take A While"
                    .text
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
}
