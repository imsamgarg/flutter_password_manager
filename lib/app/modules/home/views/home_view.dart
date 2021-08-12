import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/global_widgets/app_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final heading = "Passwords";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        heading: heading,
        leadingIcon: Icons.settings,
        leadingPress: controller.onSettingsTap,
        trailingIcon: Icons.add_circle_outline_rounded,
        trailingPress: controller.onAddTap,
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
