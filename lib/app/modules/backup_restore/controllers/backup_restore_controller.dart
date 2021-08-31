import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/models/backup_model.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/file_service.dart';
import 'package:password_manager/app/data/services/shared_pref_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';

class BackupRestoreController extends GetxController {
  late int? _lastBackupTime;
  late final int? _lastRestoreTime;
  late final int? totalPasswords;
  late final List<Password> _passwords;
  late final bool showBackupButton;
  late final bool showShareFileButton;

  bool backupButtonLoading = false;
  bool restoreButtonLoading = false;
  bool showRestoreInfo = false;

  final String backupButtonId = "Backup Button";
  final String backupTimeId = "Backup Time";
  final String passwordsId = "Total Passwords";
  final String restoreButtonId = "Restore Button";
  final String restoreTimeId = "Restore Time";
  final String restoreSectionId = "Restore Section";

  final noPassErrorMsg = "You Do Not Have Any Passwords Saved!";

  late final instance = initComponents();

  String get lastBackupTime {
    if (_lastBackupTime != null) {
      return DateTime.fromMillisecondsSinceEpoch(_lastBackupTime!).toString();
    }
    return "Never";
  }

  String get lastRestoreTime {
    if (_lastRestoreTime != null) {
      return DateTime.fromMillisecondsSinceEpoch(_lastRestoreTime!).toString();
    }
    return "Never";
  }

  Future<bool> initComponents() async {
    final storage = Get.find<SharedPrefService>().storage;
    _lastBackupTime = await storage.getInt(
      lastBackup,
    );
    _lastRestoreTime = await storage.getInt(
      lastRestore,
    );

    _passwords = Get.find<HomeController>().passwords;
    showShareFileButton = await Get.find<FileService>().isFileExists(
      backupFileName,
    );
    totalPasswords = _passwords.length;
    showBackupButton = totalPasswords != 0;
    return true;
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
    int time = DateTime.now().millisecondsSinceEpoch;
    Backup backup = Backup(
      dateCreated: time,
      passwords: _passwords,
    );

    final string = backup.toString();

    final fileService = Get.find<FileService>();
    final file = await fileService.createTextFile(string, backupFileName);

    await Get.find<SharedPrefService>().storage.setInt(lastBackup, time);
    _lastBackupTime = time;
    update([backupTimeId]);
    await fileService.shareFile(file.path);
  }

  void shareFile() async {
    final fileService = Get.find<FileService>();
    final fullPath = await fileService.getFullPath(backupFileName);
    fileService.shareFile(fullPath);
  }
}
