import 'package:get/get.dart';

import 'package:password_manager/app/routes/app_pages.dart';

class HomeController extends GetxController {
  void onAddTap() {
    Get.toNamed(Routes.ADD_PASSWORD);
  }

  void onSettingsTap() {}
}
