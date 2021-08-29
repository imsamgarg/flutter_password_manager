import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';
import 'package:password_manager/app/modules/settings/views/delete_dialog_view.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class SettingsController extends GetxController {
  late final _askForPassSwitch = false.obs;
  bool get askForPassSwitch => _askForPassSwitch.value;

  final String deletingPassErrorMessage = "Error Deleting Passwords";
  @override
  void onInit() {
    initComponents();
    super.onInit();
  }

  void toggleAskForPassSwitch(bool value) {
    _askForPassSwitch.value = value;
  }

  void changePassCode() {
    Get.toNamed(Routes.LOGIN, arguments: true);
  }

  void backupAndRestore() {}

  void initComponents() {}

  void deleteAllPasswords() async {
    Get.dialog(DeleteDialogView());
  }

  void confirmDeletion() async {
    await showOverlay(_deleteAllPasswords);
  }

  Future<void> _deleteAllPasswords() async {
    final service = Get.find<DatabaseService>();
    try {
      //deleting password from db
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
