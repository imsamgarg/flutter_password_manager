import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:custom_utils/log_utils.dart';
import 'package:get/get.dart';

import 'package:password_manager/app/core/utils/helpers.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/core/values/values.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/data/services/database_service/database_service.dart';
import 'package:password_manager/app/data/services/encryption_service.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class HomeController extends GetxController {
  late List<Password> passwords;
  late Future<bool> instance = _getPasswords();
  late FocusNode focusNode = FocusNode();
  late int index;

  void onAddTap() {
    Get.toNamed(Routes.ADD_PASSWORD)?.then((value) {
      if (value != null) {
        passwords.add(value);
        update();
      }
    });
  }

  void onSettingsTap() async {
    await Get.toNamed(Routes.SETTINGS);
    if (passwords.length == 0) {
      update();
    }
  }

  Future<bool> _getPasswords() async {
    final service = Get.find<DatabaseService>();
    passwords = await service.connection.allPasswords;
    return true;
  }

  void copyPassword(int index) async {
    try {
      final isEnabled = await checkIfPromptEnabled();
      if (isEnabled) {
        final isVerified = await promptForPass();
        if (!isVerified) return;
      }

      final pass = this.passwords[index].password ?? "";
      final secureKeyService = Get.find<SecureKeyService>();
      final encryptService = Get.find<EncryptionService>();

      final key = await secureKeyService.getKey(passwordKey);
      final decryptedPass = await encryptService.decryptText(pass, key);
      Clipboard.setData(ClipboardData(text: decryptedPass));
      successSnackbar("Password Copied To Clipboard");
    } on Exception catch (e, s) {
      errorSnackbar("Failed To Decrypt Password");
      customLog("Error", stackTrace: s, error: e);
    }
  }

  void onTilePress(int index) async {
    this.index = index;
    final res = (await Get.toNamed(Routes.PASSWORD_INFO)) ?? {};
    final UpdateAction action = res["action"] ?? UpdateAction.None;
    final int? i = res["index"];
    switch (action) {
      case UpdateAction.Updations:
        {
          update(["Tile$i"]);
        }
        break;
      case UpdateAction.PassRemoved:
        {
          passwords.removeAt(index);
          update();
        }
        break;
      case UpdateAction.None:
        break;
    }
  }

  void searchText(String value) {
    passwords.forEach((element) {
      final reg = RegExp(value, caseSensitive: false);
      if (element.email!.contains(reg) || element.website!.contains(reg)) {
        element.isVisible = true;
      } else {
        element.isVisible = false;
      }
    });

    print(passwords.where((element) => element.isVisible).toList());
    update();
  }

  void unfocus() {
    focusNode.unfocus();
  }
}
