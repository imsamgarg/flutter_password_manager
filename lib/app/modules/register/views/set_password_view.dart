import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SetPasswordView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SetPasswordView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SetPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
