import 'dart:convert';

import 'package:custom_utils/log_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/models/backup_model.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/file_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/data/services/shared_pref_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite/sqflite.dart';

class BackupRestoreController extends GetxController {
  late Backup _backupFile;
  late int? _lastBackupTime;
  late int? _lastRestoreTime;
  late int? totalPasswords;
  late int? restoreTotalPasswords;
  late List<Password> _passwords;
  late int _restoreFileBackupDate;

  late final bool showBackupButton;
  late final bool showShareFileButton;

  bool backupButtonLoading = false;
  bool restoreButtonLoading = false;
  bool showRestoreInfo = false;

  final String backupButtonId = "Backup Button";
  final String backupTimeId = "Backup Time";
  final String passwordsId = "Total Passwords";
  final String backupSectionId = "Backup Section";

  final String restoreButtonId = "Restore Button";
  final String restoreTimeId = "Restore Time";
  final String restoreSectionId = "Restore Section";

  final noPassErrorMsg = "You Do Not Have Any Passwords Saved!";

  late final TextEditingController passController = TextEditingController();
  late final GlobalKey<FormState> formKey = GlobalKey();
  late final FocusNode focusNode = FocusNode();

  late final instance = initComponents();

  final _isPassObscure = false.obs;
  bool get isPassObscure => _isPassObscure.value;

  void togglePassVisibility() {
    _isPassObscure.value = !_isPassObscure.value;
  }

  @override
  void onClose() {
    passController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void unfocus() {
    focusNode.unfocus();
  }

  ///GETTERS
  ///--------
  String get restoreFileBackupDate {
    if (_restoreFileBackupDate == 0) {
      return "Not Defined";
    } else
      return DateTime.fromMillisecondsSinceEpoch(
        _restoreFileBackupDate,
      ).toString();
  }

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

  /// INITIALIAZATION/
  ///
  ///
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

  ///TOGGLE LOADING
  ///
  ///
  void toggleBackupLoading(bool value) {
    backupButtonLoading = value;
    update([backupButtonId]);
  }

  void toggleRestoreLoading(bool value) {
    restoreButtonLoading = value;
    update([restoreButtonId]);
  }

  ///BACKUP PART
  ///
  ///
  void performBackup() async {
    if (totalPasswords == 0) {
      errorSnackbar(noPassErrorMsg);
      return;
    }
    toggleBackupLoading(true);
    await _backup();
    toggleBackupLoading(false);
  }

  Future _backup() async {
    int time = DateTime.now().millisecondsSinceEpoch;
    final encryService = Get.find<EncryptionService>();
    final keyService = Get.find<SecureKeyService>();
    final masterPassword = await keyService.getKey(passwordKey);
    final List<Password> newPasswords = [];

    _passwords.forEach((e) {
      final dMail = encryService.encryptText(e.email!, masterPassword);
      final p = Password.fromJson(e.toJson());
      p.email = dMail;
      newPasswords.add(p);
    });

    Backup backup = Backup(
      dateCreated: time,
      passwords: newPasswords,
    );

    final fileService = Get.find<FileService>();
    late final file;
    try {
      final jsonString = JsonEncoder().convert(backup.toJson());
      file = await fileService.createTextFile(jsonString, backupFileName);
    } on Exception catch (e) {
      return errorSnackbar("Failed To Create Backup");
    }

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

  ///BACKUP PART ENDS HERE
  ///
  ///

  /// RESTORE PART Begin
  ///
  ///
  void restoreFromFile() async {
    final service = Get.find<FileService>();
    final file = await service.pickFile();
    if (file != null) {
      await showOverlay(() => _parseFile(file));
    }
  }

  Future<void> _parseFile(PlatformFile? file) async {
    try {
      final service = Get.find<FileService>();
      final json = await service.decodeJsonFile(file!.path!);
      final Backup backup = Backup.fromJson(json);
      if (backup.passwords?.isEmpty ?? true) {
        return errorSnackbar("File Is Empty");
      }
      _backupFile = backup;
      _updateRestoreInfo();
    } on Exception catch (e, s) {
      customLog("Error", error: e, stackTrace: s);
    }
  }

  void _updateRestoreInfo() {
    _restoreFileBackupDate = _backupFile.dateCreated ?? 0;
    showRestoreInfo = true;
    restoreTotalPasswords = _backupFile.passwords?.length;
    update([restoreSectionId]);
  }

  void performRestore() async {
    final pass = passController.text;
    if (!formKey.currentState!.validate()) return;
    toggleRestoreLoading(true);
    final ecryptService = Get.find<EncryptionService>();
    final keyService = Get.find<SecureKeyService>();
    final dbService = Get.find<DatabaseService>();
    final masterPass = await keyService.getKey(passwordKey);
    try {
      _parsePassword(ecryptService, pass, masterPass);
      _savePassToDb(dbService);
    } on ArgumentError catch (e, s) {
      customLog("WRONG PASS", error: e, stackTrace: s);
      return errorSnackbar("Wrong Password");
    } on Exception catch (e, s) {
      customLog("Restore Error", error: e, stackTrace: s);
      return errorSnackbar("Failed To Restore Password");
    }
    _passwords = _backupFile.passwords!;
    Get.find<HomeController>().passwords = _backupFile.passwords!;
    await _updateAfterRestore();
    successSnackbar("Passwords Restored Successfully!!");
    toggleRestoreLoading(false);
  }

  Future<void> _savePassToDb(DatabaseService dbService) async {
    _backupFile.passwords?.forEach((e) async {
      try {
        await dbService.connection.savePass(e);
      } on DatabaseException catch (e, s) {
        customLog("Pass Exist", error: e, stackTrace: s);
      }
    });
  }

  void _parsePassword(EncryptionService ecryptService, pass, masterPass) {
    _backupFile.passwords?.forEach((e) {
      final decryptMail = ecryptService.decryptText(e.email!, pass);
      e.email = decryptMail;
      final decryptPass = ecryptService.decryptText(e.password!, pass);
      final encryptedPass = ecryptService.encryptText(decryptPass, masterPass);
      e.password = encryptedPass;
    });
  }

  Future<void> _updateAfterRestore() async {
    final prefs = Get.find<SharedPrefService>();
    final time = DateTime.now().millisecondsSinceEpoch;
    await prefs.storage.setInt(
      lastRestore,
      DateTime.now().millisecondsSinceEpoch,
    );
    _lastRestoreTime = time;
    showRestoreInfo = false;
    totalPasswords = _passwords.length;
    update([restoreSectionId, backupSectionId]);
  }
}
