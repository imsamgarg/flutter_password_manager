import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';

import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/assets.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';

class AddPasswordController extends GetxController {
  static const _errorMessage = "Failed To Save Password";
  static const _successMessage = "Password Saved Successfully!!";
  static const _alreadyExistMessage = "This Website Mail Combo Already Exists!";

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController websiteController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passController = TextEditingController();
  late final TextEditingController notesController = TextEditingController();

  final _isPasswordHidden = true.obs;

  final Rx<int?> _selectedIndex = Rx<int?>(null);

  int? get selectedIndex => _selectedIndex.value;

  void changeImage(int i) {
    _selectedIndex.value = i;
  }

  bool get isPasswordHidden => this._isPasswordHidden.value;

  bool loading = false;
  set isPasswordHidden(bool value) {
    this._isPasswordHidden.value = value;
  }

  void togglePassHide() {
    isPasswordHidden = !isPasswordHidden;
  }

  void clearEmail() {
    emailController.clear();
  }

  void clearNotes() {
    notesController.clear();
  }

  void clearWebsite() {
    websiteController.clear();
  }

  void generatePassword() {
    int passLength = 15;
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,./;:?><{}[]()-=_+~`!@#%^&*';
    String password = "";
    final randomiser = Random();
    while (passLength-- != 0) {
      password += chars[randomiser.nextInt(chars.length - 1)];
    }
    passController.text = password;
  }

  void savePassword() async {
    if (!formKey.currentState!.validate()) return;
    try {
      loading = true;
      update();
      customLog("--Saving Password--");

      //cred
      final mail = emailController.text;
      final website = websiteController.text;
      final pass = passController.text;
      final notes = notesController.text;

      //Services
      final _dbService = Get.find<DatabaseService>();
      final _encryService = Get.find<EncryptionService>();
      final _secureKeyService = Get.find<SecureKeyService>();

      //check if website email combo already exist
      bool exists = await _dbService.connection.checkIfExists(website, mail);

      if (exists) {
        errorSnackbar(_alreadyExistMessage, 8);
        stopLoading();
        return;
      }

      //Current Time
      int _time = DateTime.now().millisecondsSinceEpoch;

      //Will use key for encryption
      final _key = await _secureKeyService.getKey(secureKey);
      if (_key.isEmpty) throw Exception();

      //Encrypt Password
      final _encryptedPass = _encryService.encryptText(
        pass,
        _key,
      );

      //app icon
      var type;
      if (selectedIndex != null) {
        type = AssetsLogos.logoList[selectedIndex!].name;
      }

      //Saving Details To Database
      Password password = Password(
        createdOn: _time,
        modifiedOn: _time,
        email: mail,
        notes: notes,
        password: _encryptedPass,
        r: type ?? "",
        tags: "",
        website: website,
      );
      final _res = await _dbService.connection.savePass(password);
      customLog(_res, name: "result");
      //Stops Loading
      stopLoading();

      //pop current screen
      Get.back(result: password);
      successSnackbar(_successMessage);
    } on Exception catch (e, s) {
      customLog("Error", error: e, stackTrace: s);

      //Stop Loading
      stopLoading();
      errorSnackbar(_errorMessage);
    }
  }

  void stopLoading() {
    loading = false;
    update();
  }

  void startLoading() {
    loading = true;
    update();
  }
}
