import 'package:custom_utils/spacing_utils.dart';
import 'package:custom_utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/modules/password_info/controllers/password_info_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';

class ChangePasswordDialogView extends GetView<PasswordInfoController>
    with Validator {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderTheme.borderRadM,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // "Change Password".text.size(20).make(),
              // verSpacing20,
              TextFormField(
                validator: (v) => lengthValidtor(v, 8),
                controller: controller.oldPassController,
                decoration: InputDecoration(hintText: "Enter Old Password"),
              ),
              verSpacing20,
              TextFormField(
                validator: (v) => lengthValidtor(v, 8),
                controller: controller.newPassController,
                decoration: InputDecoration(hintText: "Enter New Password"),
              ),
              verSpacing30,
              SizedBox(
                height: 50,
                child: GetBuilder(
                  init: controller,
                  id: controller.changePassBuilderId,
                  builder: (_) {
                    return CustomButton(
                      "Change password",
                      onTap: controller.changePassword,
                      color: Theme.of(context).buttonColor,
                      isLoading: controller.changePassLoading,
                      // heading: "Change",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
