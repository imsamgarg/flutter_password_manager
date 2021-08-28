import 'package:custom_utils/spacing_utils.dart';
import 'package:custom_utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/modules/password_info/controllers/password_info_controller.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';

class ChangePasswordDialogView extends GetView<PasswordInfoController> {
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
              // verSpacing20,
              OldPasswordField(controller: controller),
              verSpacing20,
              NewPasswordField(controller: controller),
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

class NewPasswordField extends StatelessWidget with Validator {
  const NewPasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PasswordInfoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        validator: (v) => lengthValidtor(v, 8),
        controller: controller.newPassController,
        obscureText: controller.isOldPassObscure,
        decoration: InputDecoration(
          hintText: "Enter New Password",
          suffixIcon: ShowPasswordToggle(
            isHidden: controller.isOldPassObscure,
            onTap: controller.toggleOldPassVisibility,
          ),
        ),
      ),
    );
  }
}

class OldPasswordField extends StatelessWidget with Validator {
  const OldPasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PasswordInfoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        validator: (v) => lengthValidtor(v, 8),
        controller: controller.oldPassController,
        obscureText: controller.isNewPassObscure,
        decoration: InputDecoration(
          hintText: "Enter Old Password",
          suffixIcon: ShowPasswordToggle(
            isHidden: controller.isNewPassObscure,
            onTap: controller.toggleNewPassVisibility,
          ),
        ),
      ),
    );
  }
}

class ShowPasswordToggle extends StatelessWidget {
  final VoidCallback onTap;
  final bool isHidden;

  const ShowPasswordToggle({
    Key? key,
    required this.onTap,
    required this.isHidden,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        isHidden ? Icons.visibility_off : Icons.visibility,
      ),
    );
  }
}
