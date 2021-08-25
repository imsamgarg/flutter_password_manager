import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:custom_utils/log_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/modules/password_info/views/delete_dialog_view.dart';

import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';

class PasswordInfoController extends GetxController {
  final message = "Error In Decrypting Password";
  late Password password;

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController websiteController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passController = TextEditingController();
  late final TextEditingController notesController = TextEditingController();

  late final FocusNode focusNode = FocusNode();

  final Rx<int?> _selectedIndex = Rx<int?>(null);

  bool isPassLoading = false;

  bool isPasswordDecrypted = false;

  int? get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    initControllers();
    super.onInit();
  }

  void changeLogo(int p1) {
    _selectedIndex.value = p1;
  }

  void initControllers() {
    final cont = Get.find<HomeController>();
    password = cont.passwords[cont.index];
    emailController.text = password.email!;
    passController.text = password.password!;
    notesController.text = password.notes!;
    websiteController.text = password.website!;
  }

  void deletePass() async {
    focusNode.unfocus();
    final deleteSelected = (await Get.dialog(DeleteDialogView())) ?? false;
    if (!deleteSelected) return;
    bool deleteSuccessfull = false;

    deleteSuccessfull = await Get.showOverlay(
      asyncFunction: _deletePass,
      loadingWidget: SpinKitThreeBounce(color: ColorTheme.primaryColor),
    );

    if (deleteSuccessfull) {
      Get.back(result: true);
      successSnackbar("Password Deleted Succesfully!!");
    } else {
      errorSnackbar("Error In Deleting Password");
    }
  }

  Future<bool> _deletePass() async {
    try {
      final service = Get.find<DatabaseService>();
      await service.connection.deletePass(password);
      return true;
    } on Exception catch (e, s) {
      customLog("Error Deleting Pass", name: "Error", error: e, stackTrace: s);
      return false;
    }
  }

  void decryptPassword() async {
    _togglePassLoading(true);
    try {
      final encryService = Get.find<EncryptionService>();
      final sKeyService = Get.find<SecureKeyService>();
      final key = await sKeyService.getKey(secureKey);
      final pass = await encryService.decryptText(this.password.password!, key);
      if (pass.isEmpty) throw Exception("");
      passController.text = pass;
      _hideDecryprtPass();
    } on Exception catch (e) {
      errorSnackbar(message);
    }
    _togglePassLoading(false);
  }

  void _togglePassLoading(bool v) {
    isPassLoading = v;
    update();
  }

  void changePassword() {}

  void changeNotes() {}

  void _hideDecryprtPass() {
    isPasswordDecrypted = true;
    update();
  }
}
