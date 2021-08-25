import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/global_widgets/buttons.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteDialogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm"),
      content: Text("Are You Sure Want To Delete?"),
      shape: RoundedRectangleBorder(borderRadius: BorderTheme.borderRadM),
      actions: [
        DialogButton(
          heading: 'No',
          color: Colors.transparent,
          onTap: () => Get.back(result: false),
        ),
        DialogButton(
          heading: 'Yes',
          color: Vx.red700,
          onTap: () => Get.back(result: true),
        ),
      ],
    );
  }
}
