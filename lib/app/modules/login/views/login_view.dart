import 'package:flutter/material.dart';

import 'package:custom_utils/column_utils.dart';
import 'package:get/get.dart';
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
              // AuthHeading(heading: heading),
              SafeArea(
                child: Icon(
                  Icons.lock,
                  color: Theme.of(context).accentColor,
                  size: 50,
                ).py32(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () {
                      if (controller.number.isEmpty)
                        return Center(
                          child: "Enter Pin Code"
                              .text
                              .bold
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
