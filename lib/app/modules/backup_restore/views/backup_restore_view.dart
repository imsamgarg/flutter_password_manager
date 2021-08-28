import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/backup_restore_controller.dart';

class BackupRestoreView extends GetView<BackupRestoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BackupRestoreView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BackupRestoreView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
