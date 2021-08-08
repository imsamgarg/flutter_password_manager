import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/utils/theme.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: dartTheme,
    ),
  );
}
