import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controllers/startup_controller.dart';

class StartupView extends GetView<StartupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
    );
  }
}
