import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/backup_restore_controller.dart';

class BackupRestoreView extends GetView<BackupRestoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(heading: "Backup & Restore"),
      body: Padding(
        padding: PaddingTheme.sidePaddingM,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verSpacing20,
                "Total Passwords: ${controller.totalPasswords}"
                    .text
                    .bold
                    .size(18)
                    .make(),
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
                verSpacing20,
                RestoreSection(),
                verSpacing20,
                GetBuilder(
                  init: controller,
                  id: controller.restoreButtonId,
                  builder: (_) {
                    return CustomButton(
                      "Restore",
                      onTap: controller.performRestore,
                    );
                  },
                ),
                verSpacing20,
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Note".text.bold.size(16).make(),
                verSpacing4,
                "Backup Will Generate A .json File And Then Prompt You To Share File"
                    .text
                    .make(),
                verSpacing20,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RestoreSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
