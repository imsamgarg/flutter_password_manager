import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_master_password_controller.dart';

class ChangeMasterPasswordView extends GetView<ChangeMasterPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChangeMasterPasswordView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChangeMasterPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
