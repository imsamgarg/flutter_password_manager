import 'package:get/get.dart';

import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';

import '../controllers/startup_controller.dart';

class StartupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SecureKeyService>(SecureKeyService());
    Get.put<DatabaseService>(DatabaseService());
    Get.put<EncryptionService>(EncryptionService());
    Get.put<StartupController>(StartupController());
  }
}
