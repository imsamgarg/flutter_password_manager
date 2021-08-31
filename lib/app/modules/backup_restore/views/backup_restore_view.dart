import 'package:custom_utils/log_utils.dart';
import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/backup_restore_controller.dart';
import 'backup_view.dart';
import 'restore_view.dart';

class BackupRestoreView extends GetView<BackupRestoreController> {
  @override
  Widget build(BuildContext context) {
    final bottom = context.mq.viewInsets.bottom;
    return GestureDetector(
      onTap: controller.unfocus,
      child: Scaffold(
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
              return _MainView(bottom: bottom);
            } else {
              return LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}

class _MainView extends StatelessWidget {
  final double bottom;

  const _MainView({Key? key, required this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    customLog(bottom, name: "ibottom");
    customLog(context.mq.viewPadding, name: "padd");

    return Padding(
      padding: PaddingTheme.sidePaddingM,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              if (bottom < 100) verSpacing20,
              if (bottom < 100) BackupView(),
              verSpacing20,
              RestoreView(),
            ],
          ),
          if (bottom < 100) _Notes(),
        ],
      ),
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
