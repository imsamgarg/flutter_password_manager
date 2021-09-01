import 'package:get/get.dart';

import '../controllers/change_master_password_controller.dart';

class ChangeMasterPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeMasterPasswordController>(
      () => ChangeMasterPasswordController(),
    );
  }
}
