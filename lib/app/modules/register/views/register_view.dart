import 'package:custom_utils/column_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/global_widgets/auth_views_widgets.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColExpanded(
        children: [
          GetBuilder<RegisterController>(
            init: controller,
            builder: (RegisterController con) {
              return Column(
                children: [
                  AuthHeading(heading: con.heading),
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
              );
            },
          ),
          KeyboardWidget(controller: controller),
        ],
      ),
    );
  }
}
