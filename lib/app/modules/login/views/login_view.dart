import 'package:flutter/material.dart';

import 'package:custom_utils/column_utils.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/global_widgets/auth_views_widgets.dart';

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
              LockIcon(),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () {
                      if (controller.number.isEmpty)
                        return Center(
                          child: controller.heading.text.bold
                              .size(18)
                              .color(Theme.of(context).accentColor)
                              .make(),
                        );
                      return InputWidget(
                        number: controller.number,
                      ).py32();
                    },
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
