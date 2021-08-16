import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/modules/add_password/controllers/add_password_controller.dart';
import 'package:custom_utils/validator.dart' as V;

class NotesField extends GetView<AddPasswordController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.notesController,
      style: TextStyle(
        color: ColorTheme.inputColor,
      ),
      maxLines: 4,
      minLines: 1,
      decoration: InputDecoration(
        labelText: "Notes",
        suffix: InkWell(
          onTap: controller.clearNotes,
          child: Icon(Icons.clear),
        ),
      ),
    );
  }
}

class PasswordField extends GetView<AddPasswordController> with V.Validator {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: controller.passController,
        style: TextStyle(
          color: ColorTheme.inputColor,
        ),
        validator: (v) => lengthValidtor(v, 8),
        obscureText: controller.isPasswordHidden,
        decoration: InputDecoration(
          labelText: "Password",
          suffix: InkWell(
            onTap: controller.togglePassHide,
            child: Icon(
              controller.isPasswordHidden
                  ? Icons.visibility
                  : Icons.visibility_off_rounded,
            ),
          ),
        ),
      ),
    );
  }
}

class EmailField extends GetView<AddPasswordController> with V.Validator {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.emailController,
      style: TextStyle(
        color: ColorTheme.inputColor,
      ),
      validator: emailValidator,
      decoration: InputDecoration(
        labelText: "Email Address",
        labelStyle: TextStyle(
          color: Colors.grey,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        suffix: InkWell(
          onTap: controller.clearEmail,
          child: Icon(Icons.clear),
        ),
      ),
    );
  }
}

class WebsiteField extends GetView<AddPasswordController> with V.Validator {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.websiteController,
      style: TextStyle(
        color: ColorTheme.inputColor,
      ),
      validator: requiredValidator,
      decoration: InputDecoration(
        labelText: "Website",
        suffix: InkWell(
          onTap: controller.clearWebsite,
          child: Icon(Icons.clear),
        ),
      ),
    );
  }
}
