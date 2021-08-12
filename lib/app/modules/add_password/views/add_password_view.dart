import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/core/values/sizing.dart';

import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';

import '../controllers/add_password_controller.dart';

class AddPasswordView extends GetView<AddPasswordController> {
  final heading = "Add Password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        heading: heading,
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizing.sidesGap,
          ),
          child: ListView(
            children: [
              verSpacing20,
              // FieldHeading(heading: "Website"),
              WebsiteField(),
              verSpacing20,
              EmailField(),
              verSpacing20,
              PasswordField(),
              verSpacing20,
              CustomButton(
                "Generate Password",
                onTap: controller.generatePassword,
              ),
              verSpacing20,
              NotesField(),
            ],
          ),
        ),
      ),
    );
  }
}

class NotesField extends GetView<AddPasswordController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.notesController,
      style: TextStyle(
        color: ColorTheme.inputColor,
      ),
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

class PasswordField extends GetView<AddPasswordController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.passController,
      style: TextStyle(
        color: ColorTheme.inputColor,
      ),
      obscureText: controller.isPasswordHidden,
      decoration: InputDecoration(
        labelText: "Password",
        suffix: InkWell(
          onTap: controller.togglePassHide,
          child: Obx(
            () => Icon(
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

class EmailField extends GetView<AddPasswordController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.emailController,
      style: TextStyle(
        color: ColorTheme.inputColor,
      ),
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

class WebsiteField extends GetView<AddPasswordController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.websiteController,
      style: TextStyle(
        color: ColorTheme.inputColor,
      ),
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
