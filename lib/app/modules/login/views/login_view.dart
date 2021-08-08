import 'package:custom_utils/column_utils.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/app/global_widgets/auth_views_widgets.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final heading = "Login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColExpanded(
        children: [
          Column(
            children: [
              AuthHeading(heading: heading),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => InputWidget(
                      number: controller.number,
                    ),
                  ),
                ),
              ),
            ],
          ),
          KeyboardWidget(controller: controller),
        ],
      ),
    );
  }
}
