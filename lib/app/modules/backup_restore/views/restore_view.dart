import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/global_widgets/auth_views_widgets.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/modules/backup_restore/controllers/backup_restore_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class RestoreView extends GetView<BackupRestoreController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      id: controller.restoreSectionId,
      builder: (_) {
        return Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Restore".text.bold.size(22).make(),
              verSpacing20,
              if (!controller.showRestoreInfo)
                GetBuilder(
                  id: controller.restoreTimeId,
                  init: controller,
                  builder: (_) {
                    return "Last Restore: ${controller.lastRestoreTime}"
                        .text
                        .bold
                        .size(16)
                        .make();
                  },
                ),
              if (controller.showRestoreInfo) ...[
                "Total Passwords: ${controller.totalPasswords}"
                    .text
                    .bold
                    .size(16)
                    .make(),
                verSpacing8,
                "Backup Date: ${controller.restoreFileBackupDate}"
                    .text
                    .bold
                    .size(16)
                    .make(),
                verSpacing8,
                Obx(
                  () => PasswordWidget(
                    hint: "Enter Password",
                    focusNode: controller.focusNode,
                    isPassObscure: controller.isPassObscure,
                    togglePassVisibility: controller.togglePassVisibility,
                    controller: controller.passController,
                  ),
                ),
              ],
              verSpacing20,
              if (!controller.showRestoreInfo)
                _RestoreFromFileButton(controller: controller),
              if (controller.showRestoreInfo)
                _RestoreButton(controller: controller),
            ],
          ).box.p16.border(color: Colors.grey.shade700).roundedSM.make(),
        );
      },
    );
  }
}

class _RestoreButton extends StatelessWidget {
  const _RestoreButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BackupRestoreController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: controller.restoreButtonId,
      init: controller,
      builder: (_) {
        return CustomButton(
          "Start Restore",
          onTap: controller.performRestore,
        );
      },
    );
  }
}

class _RestoreFromFileButton extends StatelessWidget {
  const _RestoreFromFileButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BackupRestoreController controller;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      "Restore From File",
      onTap: controller.restoreFromFile,
    );
  }
}
