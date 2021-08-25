import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/values/sizing.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/password_info_controller.dart';

class PasswordInfoView extends GetView<PasswordInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        heading: controller.password.website!,
        trailingIcon: Icons.delete,
        trailingPress: controller.deletePass,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizing.sidesGapL,
        ),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              verSpacing20,
              _Heading("Website"),
              verSpacing10,
              TextFormField(
                controller: controller.websiteController,
                enabled: false,
              ),
              verSpacing30,
              _Heading("Email"),
              verSpacing10,
              TextFormField(
                controller: controller.emailController,
                enabled: false,
              ),
              verSpacing30,
              _Heading("Password"),
              verSpacing10,
              TextFormField(
                controller: controller.passController,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: EditButton(onTap: controller.changePassword),
                ),
              ),
              verSpacing10,
              _ChangePasswordButton(),
              verSpacing30,
              _Heading("Notes"),
              verSpacing10,
              TextFormField(
                controller: controller.notesController,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: EditButton(onTap: controller.changeNotes),
                ),
              ),
              verSpacing30,
              _Heading("Platform"),
              verSpacing20,
              Obx(
                () => SelectLogo(
                  index: controller.selectedIndex,
                  onPress: controller.changeLogo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(Icons.edit, color: Vx.white),
    );
  }
}

class _ChangePasswordButton extends GetView<PasswordInfoController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Visibility(
          visible: !controller.isPasswordDecrypted,
          child: CustomButton(
            "Decrypt Password",
            isLoading: controller.isPassLoading,
            onTap: controller.decryptPassword,
          ),
        );
      },
    );
  }
}

class _Heading extends StatelessWidget {
  final String heading;
  const _Heading(this.heading);
  @override
  Widget build(BuildContext context) {
    return heading.text.size(13).color(Colors.grey).bold.make();
  }
}
