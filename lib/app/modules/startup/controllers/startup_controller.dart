import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';

import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/modules/register/views/set_password_view.dart';
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
    bool hasPassCode = await service.hasKey(passCode);
    bool hasPassword = await service.hasKey(passwordKey);

    if (hasPassCode) {
      if (hasPassword) {
        return Get.offNamed(Routes.LOGIN);
      } else {
        return Get.offAll(() => SetPasswordView());
      }
    }
    return Get.offNamed(Routes.REGISTER);
  }

  Future<void> initDb() async {
    final _service = Get.find<DatabaseService>();
    await _service.init();
  }
}
