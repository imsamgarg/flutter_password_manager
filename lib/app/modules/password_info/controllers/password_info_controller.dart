import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';

import 'package:password_manager/app/core/utils/exceptions.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/assets.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';
import 'package:password_manager/app/modules/password_info/views/delete_dialog_view.dart';

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
  // bool anyUpdations = false;
  int? get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    initComponents();
    super.onInit();
  }

  void changeLogo(int p1) async {
    await showOverlay(() => _changeLogo(p1));
    _selectedIndex.value = p1;
  }

  Future<void> _changeLogo(int p1) async {
    try {
      final dbService = Get.find<DatabaseService>();
      password.r = AssetsLogos.logoList[p1].name;
      await dbService.connection.updateType(password);
    } on DbException catch (e, s) {
      errorSnackbar(e.message);
      customLog("DB Exception", name: "Db Error", error: e, stackTrace: s);
    } on Exception catch (e, s) {
      errorSnackbar("Error In Updating Logo");
      customLog("DB Exception", name: "Db Error", error: e, stackTrace: s);
    } catch (e, s) {
      customLog("Error", error: e, stackTrace: s);
    }
  }

  void initComponents() {
    final cont = Get.find<HomeController>();
    password = cont.passwords[cont.index];
    emailController.text = password.email!;
    passController.text = password.password!;
    notesController.text = password.notes!;
    websiteController.text = password.website!;
    final image = password.r!;
    if (image.isNotEmpty && AssetsLogos.isLogoExist(image)) {
      customLog(image);
      _selectedIndex.value = AssetsLogos.logos[image]!.index;
    }
  }

  void deletePass() async {
    focusNode.unfocus();
    final deleteSelected = (await Get.dialog(DeleteDialogView())) ?? false;
    if (!deleteSelected) return;
    bool deleteSuccessfull = false;

    deleteSuccessfull = await showOverlay(_deletePass);

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

  // Future<bool> onBackPress() async {
  //   Get.back(result: anyUpdations);
  //   return false;
  // }
}
