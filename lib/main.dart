import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Password Manager",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: dartTheme,
    ),
  );
}
