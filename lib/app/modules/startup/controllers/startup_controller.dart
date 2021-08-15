import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class StartupController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    customLog("---Initializing Database---");
    await initDb();
    // await 10.delay();
    return validate();
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

  Future<void> initDb() async {
    final _service = Get.find<DatabaseService>();
    await _service.init();
  }
}
