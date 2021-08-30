import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/data/models/backup_model.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/file_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';

////TODOs For Future Version;
// enum BackupOptions {
//   FullEncrypted,
//   PasswordsEncrypted,
//   UnEncrypted,
// }

class BackupRestoreController extends GetxController {
  // late final int? lastBackupTime;
  late final int? totalPasswords;
  late final List<Password> _passwords;
  late final bool showBackupButton;

  bool backupButtonLoading = false;
  bool restoreButtonLoading = false;

  final String backupButtonId = "Backup Button";
  final String restoreButtonId = "Restore Button";

  final noPassErrorMsg = "You Do Not Have Any Passwords Saved!";

  @override
  void onInit() async {
    await initComponents();
    super.onInit();
  }

  Future<void> initComponents() async {
    // lastBackupTime = await Get.find<SharedPrefService>().storage.getInt(
    //       lastBackup,
    //     );

    _passwords = Get.find<HomeController>().passwords;
    totalPasswords = _passwords.length;
    showBackupButton = totalPasswords != 0;
  }

  void toggleBackupLoading(bool value) {
    backupButtonLoading = value;
    update([backupButtonId]);
  }

  void toggleRestoreLoading(bool value) {
    restoreButtonLoading = value;
    update([restoreButtonId]);
  }

  void performBackup() async {
    if (totalPasswords == 0) {
      errorSnackbar(noPassErrorMsg);
      return;
    }
    toggleBackupLoading(true);
    await _backup();
    toggleBackupLoading(false);
  }

  void performRestore() {}

  Future _backup() async {
    Backup backup = Backup(
      dateCreated: DateTime.now().millisecondsSinceEpoch,
      passwords: _passwords,
    );
    final string = backup.toString();
    final fileService = Get.find<FileService>();
    final file = await fileService.createTextFile(string, "backup.json");
    await fileService.shareFile(file.path);
  }
}
