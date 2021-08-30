import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/modules/confirm_password/views/confirm_password_view.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';
import 'package:password_manager/app/modules/settings/views/delete_dialog_view.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class SettingsController extends GetxController {
  late final _askForPassSwitch = false.obs;
  bool get askForPassSwitch => _askForPassSwitch.value;

  final String deletingPassErrorMessage = "Error Deleting Passwords";
  final String askForPassErrorMsg = "Failed To Change Value";

  @override
  void onInit() async {
    await initComponents();
    super.onInit();
  }

  Future<void> initComponents() async {
    final service = Get.find<SecureKeyService>();
    final value = await service.getKey(promptForPassEveryTime);
    if (value == "yes") {
      _askForPassSwitch.value = true;
    } else {
      _askForPassSwitch.value = false;
    }
  }

  void toggleAskForPassSwitch(bool value) async {
    await showOverlay(() => _toggleAskForPassSwitch(value));
  }

  Future<void> _toggleAskForPassSwitch(bool value) async {
    final service = Get.find<SecureKeyService>();
    final v = value ? "yes" : "no";
    final isSuccessfull = await service.saveKey(v, promptForPassEveryTime);
    if (!isSuccessfull) {
      return errorSnackbar(askForPassErrorMsg);
    }
    _askForPassSwitch.value = value;
  }

  void changePassCode() {
    Get.toNamed(Routes.LOGIN, arguments: true);
  }

  void backupAndRestore() {}

  void deleteAllPasswords() async {
    final passwords = Get.find<HomeController>().passwords;
    if (passwords.isEmpty) {
      return errorSnackbar("You Do Not Have Any Password Saved");
    }
    Get.dialog(DeleteDialogView());
  }

  void confirmDeletion() async {
    // await showOverlay(_deleteAllPasswords);
    _deleteAllPasswords();
  }

  Future<void> _deleteAllPasswords() async {
    try {
      //deleting password from db

      final res = await Get.dialog(ConfirmPasswordView());
      if (!(res ?? false)) {
        Get.back();
        return;
      }

      final service = Get.find<DatabaseService>();
      await service.connection.deleteAllPasswords();
      successSnackbar("Passwords Deleted Successfully");

      //clearing passwords from memory
      Get.find<HomeController>().passwords.clear();
    } on Exception catch (e, s) {
      customLog("Deleting Password", name: "Error", error: e, stackTrace: s);
      errorSnackbar(deletingPassErrorMessage);
    }
  }
}
