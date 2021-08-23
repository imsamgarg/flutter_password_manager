import 'package:get/get.dart';

import '../controllers/password_info_controller.dart';

class PasswordInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordInfoController>(
      () => PasswordInfoController(),
    );
  }
}
