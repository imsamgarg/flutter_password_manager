import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/confirm_password_controller.dart';

class ConfirmPasswordView extends GetView<ConfirmPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConfirmPasswordView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ConfirmPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
