import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';

import 'package:password_manager/app/core/utils/exceptions.dart';
import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/assets.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/core/values/values.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/modules/home/controllers/home_controller.dart';
import 'package:password_manager/app/modules/password_info/views/change_password_dialog_view.dart';
import 'package:password_manager/app/modules/password_info/views/delete_dialog_view.dart';

class PasswordInfoController extends GetxController {
  late Password password;
  late int passIndex;

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController websiteController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController notesController = TextEditingController();
  late final TextEditingController passController = TextEditingController();

  late final TextEditingController oldPassController = TextEditingController();
  late final TextEditingController newPassController = TextEditingController();

  late final FocusNode passFocusNode = FocusNode();
  late final FocusNode noteFocusNode = FocusNode();

  bool isPassLoading = false;
  bool changePassLoading = false;
  bool isPasswordDecrypted = false;
  bool isNotesReadOnly = true;
  bool anyUpdations = false;

  final decryptionErrorMsg = "Error In Decrypting Password";
  final notesUpdateErrorMsg = "Error Updating Notes";
  final wrongOldPassErrorMsg = "Incorrect Old Password";
  final changePassErrorMsg = "Error In Changing Password";
  final passChangedSuccessMsg = "Password Changes Successfully!!";

  final notesBuilderId = "notes";
  final passFieldId = "pass";
  final changePassBuilderId = "Change Pass";

  final Rx<int?> _selectedIndex = Rx<int?>(null);
  final _isNewPassObscure = true.obs;
  final _isOldPassObscure = true.obs;

  bool get isNewPassObscure => _isNewPassObscure.value;
  bool get isOldPassObscure => _isOldPassObscure.value;
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
      anyUpdations = true;
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
    passIndex = cont.index;
    password = cont.passwords[passIndex];
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
    passFocusNode.unfocus();
    noteFocusNode.unfocus();
    final deleteSelected = (await Get.dialog(DeleteDialogView())) ?? false;
    if (!deleteSelected) return;
    bool deleteSuccessfull = false;

    deleteSuccessfull = await showOverlay(_deletePass);

    if (deleteSuccessfull) {
      Get.back(result: {
        "index": null,
        "action": UpdateAction.PassRemoved,
      });
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
    } on Exception catch (_) {
      errorSnackbar(decryptionErrorMsg);
    }
    _togglePassLoading(false);
  }

  void _togglePassLoading(bool v) {
    isPassLoading = v;
    update([passFieldId]);
  }

  void _hideDecryprtPass() {
    isPasswordDecrypted = true;
    update([passFieldId]);
  }

  void _showDecryprtPass() {
    isPasswordDecrypted = false;
    update([passFieldId]);
  }

  Future<bool> onBackPress() async {
    Get.back(result: {
      "index": passIndex,
      "action": anyUpdations ? UpdateAction.Updations : UpdateAction.None,
    });
    return false;
  }

  void changeReadModeNotes(bool value) {
    isNotesReadOnly = value;
    update([notesBuilderId]);
  }

  void updateNotes() async {
    if (notesController.text.trim().isEmpty) {
      errorSnackbar("Enter Some Text Before Saving");
      return;
    }

    await showOverlay(_updateNotes);
  }

  Future<void> _updateNotes() async {
    try {
      noteFocusNode.unfocus();
      final service = Get.find<DatabaseService>();
      password.notes = notesController.text;
      // await 10.delay();
      await service.connection.updateNotes(password);
      changeReadModeNotes(true);
    } on DbException catch (e, s) {
      errorSnackbar(e.message);
      customLog(notesUpdateErrorMsg, name: "Error", error: e, stackTrace: s);
    } on Exception catch (e, s) {
      errorSnackbar(notesUpdateErrorMsg);
      customLog(notesUpdateErrorMsg, name: "Error", error: e, stackTrace: s);
    }
  }

  void changePassword() async {
    if (!formKey.currentState!.validate()) return;
    try {
      final encryService = Get.find<EncryptionService>();
      final sKeyService = Get.find<SecureKeyService>();
      final oldPassword = oldPassController.text;
      final newPassword = newPassController.text;
      final key = await sKeyService.getKey(secureKey);
      final dPass = await encryService.decryptText(password.password!, key);
      if (dPass != oldPassword) {
        errorSnackbar(wrongOldPassErrorMsg);
        return;
      }
      final ePass = await encryService.encryptText(newPassword, key);
      passController.text = ePass;
      password.password = ePass;
      oldPassController.clear();
      newPassController.clear();
      Get.back();
      _showDecryprtPass();
      successSnackbar(passChangedSuccessMsg);
    } on Exception catch (e, s) {
      errorSnackbar(changePassErrorMsg);
      customLog("Error Changing Pass", name: "Error", error: e, stackTrace: s);
    }
  }

  void showChangePassDialog() {
    Get.dialog(ChangePasswordDialogView());
  }

  void toggleNewPassVisibility() {
    _isNewPassObscure.value = !_isNewPassObscure.value;
  }

  void toggleOldPassVisibility() {
    _isOldPassObscure.value = !_isOldPassObscure.value;
  }
}
