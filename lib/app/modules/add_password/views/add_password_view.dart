import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';
import 'package:password_manager/app/modules/add_password/local_widgets/input_fields.dart';
import 'package:password_manager/app/core/values/sizing.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import '../controllers/add_password_controller.dart';
import 'package:velocity_x/velocity_x.dart';

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
            horizontal: Sizing.sidesGapL,
          ),
          child: ListView(
            children: [
              verSpacing20,
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
              verSpacing20,
              GetBuilder(
                init: controller,
                builder: (AddPasswordController c) {
                  return CustomButton(
                    "Save Password",
                    isLoading: c.loading,
                    onTap: c.savePassword,
                  );
                },
              ),
              verSpacing20,
              "Platforms".text.semiBold.color(Colors.grey).make(),
              verSpacing20,
              Obx(
                () => SelectLogo(
                  index: controller.selectedIndex,
                  onPress: controller.changeImage,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
