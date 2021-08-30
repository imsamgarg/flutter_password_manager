import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/global_widgets/app_bar.dart';

import '../controllers/backup_restore_controller.dart';

class BackupRestoreView extends GetView<BackupRestoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(heading: "Backup & Restore"),
      body: ListView(
        children: [],
      ),
    );
  }
}
