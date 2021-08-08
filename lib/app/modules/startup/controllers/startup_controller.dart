import 'package:get/get.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class StartupController extends GetxController {
  @override
  void onReady() {
    validate();
    super.onReady();
  }

  void validate() async {
    final service = Get.find<SecureKeyService>();
    bool hasKey = await service.hasKey(secureKey);
    if (hasKey) {
      Get.toNamed(Routes.LOGIN);
    } else {
      Get.toNamed(Routes.REGISTER);
    }
  }
}
