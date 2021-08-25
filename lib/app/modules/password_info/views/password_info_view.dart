import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/values/sizing.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';

import '../controllers/password_info_controller.dart';

class PasswordInfoView extends GetView<PasswordInfoController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackPress,
      child: Scaffold(
        appBar: CustomAppBar(
          heading: controller.password.website!,
          trailingIcon: Icons.delete,
          trailingPress: controller.deletePass,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizing.sidesGapL,
          ),
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
              _PasswordField(),
              verSpacing10,
              _ChangePasswordButton(),
              verSpacing30,
              _Heading("Notes"),
              verSpacing10,
              _NotesField(),
              // verSpacing10,
              // _UpdateNotes(),
              verSpacing30,
              _Heading("Platform"),
              verSpacing20,
              Obx(
                () => SelectLogo(
                  index: controller.selectedIndex,
                  onPress: controller.changeLogo,
                ),
              ),
              verSpacing30
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends GetView<PasswordInfoController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.passController,
      readOnly: true,
      focusNode: controller.passFocusNode,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: controller.showChangePassDialog,
          icon: Icon(Icons.edit, color: Vx.white),
        ),
      ),
    );
  }
}

// class _UpdateNotes extends GetView<PasswordInfoController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: controller,
//       id: controller.notesBuilderId,
//       builder: (_) {
//         final value = controller.isNotesReadOnly ? 0 : 55;
//         return AnimatedContainer(
//           duration: Duration(milliseconds: 600),
//           height: value.toDouble(),
//           child: CustomButton(
//             "Update Notes",
//             onTap: controller.changeNotes,
//           ),
//         );
//       },
//     );
//   }
// }

class _NotesField extends GetView<PasswordInfoController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      id: controller.notesBuilderId,
      builder: (_) {
        return TextFormField(
          controller: controller.notesController,
          readOnly: controller.isNotesReadOnly,
          focusNode: controller.noteFocusNode,
          maxLines: null,
          minLines: 1,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                if (controller.isNotesReadOnly) {
                  controller.changeReadModeNotes(false);
                } else {
                  controller.updateNotes();
                }
              },
              icon: Icon(
                controller.isNotesReadOnly ? Icons.edit : Icons.check,
                color: Vx.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ChangePasswordButton extends GetView<PasswordInfoController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      id: controller.passFieldId,
      builder: (_) {
        final value = !controller.isPasswordDecrypted ? 55 : 0;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: value.toDouble(),
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
