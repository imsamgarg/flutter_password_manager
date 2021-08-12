import 'package:get/get.dart';

import '../controllers/add_password_controller.dart';

class AddPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPasswordController>(
      () => AddPasswordController(),
    );
  }
}
