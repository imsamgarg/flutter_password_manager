import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/values/sizing.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';

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
                focusNode: controller.focusNode,
                controller: controller.passController,
              ),
              verSpacing30,
              _Heading("Notes"),
              verSpacing10,
              TextFormField(
                // focusNode: controller.focusNode,
                controller: controller.notesController,
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

class _Heading extends StatelessWidget {
  // const _Heading({Key? key}) : super(key: key);

  final String heading;

  const _Heading(this.heading);
  //  : super(key: key);
  @override
  Widget build(BuildContext context) {
    return heading.text.size(13).color(Colors.grey).bold.make();
  }
}
