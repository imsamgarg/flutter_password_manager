import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/backup_restore_controller.dart';

class BackupRestoreView extends GetView<BackupRestoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(heading: "Backup & Restore"),
      body: FutureBuilder<bool>(
        future: controller.instance,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: "Something Went Wrong".text.size(24).make(),
            );
          }
          if (snapshot.hasData) {
            return _MainView();
          } else
            return LoadingWidget();
        },
      ),
    );
  }
}

class _MainView extends GetView<BackupRestoreController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingTheme.sidePaddingM,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verSpacing20,
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
          _Notes(),
        ],
      ),
    );
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

class _Notes extends StatelessWidget {
  const _Notes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class RestoreSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
