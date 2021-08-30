import 'package:get/get.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/shared_pref_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';

class BackupRestoreController extends GetxController {
  late final int? lastBackupTime;
  late final int? totalPasswords;
  late final List<Password> _passwords;

  @override
  void onInit() async {
    await initComponents();
    super.onInit();
  }

  Future<void> initComponents() async {
    lastBackupTime =
        await Get.find<SharedPrefService>().storage.getInt(lastBackup);

    _passwords = Get.find<HomeController>().passwords;
    totalPasswords = _passwords.length;
  }
}
