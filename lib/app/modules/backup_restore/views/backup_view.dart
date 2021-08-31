import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:password_manager/app/modules/backup_restore/controllers/backup_restore_controller.dart';

class BackupView extends GetView<BackupRestoreController> {
  @override
  Widget build(BuildContext context) {
    if (context.mq.viewInsets.bottom < 100)
      return GetBuilder(
        id: controller.backupSectionId,
        init: controller,
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Backup".text.size(22).bold.make(),
              verSpacing16,
              "Total Passwords: ${controller.totalPasswords}"
                  .text
                  .bold
                  .size(16)
                  .make(),
              verSpacing8,
              _BackupTime(controller: controller),
              verSpacing20,
              GetBuilder(
                id: controller.backupButtonId,
                init: controller,
                builder: (_) {
                  return CustomButton(
                    "Backup",
                    onTap: controller.performBackup,
                  );
                },
              ),
              verSpacing10,
              if (controller.showShareFileButton)
                CustomButton("Share File", onTap: controller.shareFile),
            ],
          ).box.p16.border(color: Colors.grey.shade700).roundedSM.make();
        },
      );
    else
      return Container();
  }
}

class _BackupTime extends StatelessWidget {
  const _BackupTime({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BackupRestoreController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: controller.backupTimeId,
      init: controller,
      builder: (_) {
        return "Last Backup: ${controller.lastBackupTime}"
            .text
            .bold
            .size(16)
            .make();
      },
    );
  }
}
