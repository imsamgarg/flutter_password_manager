import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:password_manager/app/modules/settings/controllers/settings_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteDialogView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Passwords"),
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderTheme.borderRadM),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Are You Sure Want To Delete All Passwords? This Action Cannot Be Undone!!!",
          ),
        ],
      ),
      actions: [
        DialogButton(
          onTap: () => Get.back(),
          color: Colors.transparent,
          heading: "No",
        ),
        DialogButton(
          onTap: controller.confirmDeletion,
          color: Vx.red500,
          heading: "Yes",
        ),
      ],
    );
  }
}
