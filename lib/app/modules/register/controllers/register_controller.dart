import 'package:get/get.dart';
import 'package:password_manager/app/core/utils/helpers.dart';

import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/services/secure_key_service.dart';
import 'package:password_manager/app/interfaces/auth_interface.dart';
import 'package:password_manager/app/modules/register/views/set_password_view.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class RegisterController extends GetxController implements AuthInterface {
  late final bool updatePassCode;

  @override
  void onInit() {
    updatePassCode = Get.arguments ?? false;
    super.onInit();
  }

  final _number1 = "".obs;
  final _number2 = "".obs;

  late final String errorMessage = "Failed To Save Pass Code!!";

  String get number1 => _number1.value;
  String get number2 => _number2.value;

  bool isConfirmActivate = false;

  String get number {
    if (isConfirmActivate) return _number2.value;
    return _number1.value;
  }

  String get heading {
    if (isConfirmActivate) return "Confirm Pin Code";
    return updatePassCode ? "Set A New Pin Code" : "Set A 6 Digit Pin Code";
  }

  void set number(String num) {
    if (isConfirmActivate) {
      _number2.value = num;
    } else {
      _number1.value = num;
    }
  }

  @override
  void addNumber(int num) {
    if (number.length > 5) return;
    this.number += "$num";
  }

  void removeNumber() {
    if (number.length < 1) return;
    number = number.substring(0, number.length - 1);
  }

  void clearNumber() {
    number = "";
  }

  @override
  void verifyNumber() async {
    if (!isConfirmActivate) {
      if (number1.length == 6) {
        isConfirmActivate = true;
        update();
      }
    } else {
      await showOverlay(_saveCode);
    }
  }

  Future<void> _saveCode() async {
    if (number1 == number2) {
      final service = Get.find<SecureKeyService>();
      final bool hasSaved = await service.saveKey(number1, passCode);
      final v = await service.saveKey('no', promptForPassEveryTime);

      if (hasSaved) {
        if (updatePassCode) {
          Get.until((route) => Get.currentRoute == Routes.SETTINGS);
          return successSnackbar("Pass Code Changes Successfully");
        }
        Get.to(() => SetPasswordView());
      } else {
        errorSnackbar(errorMessage);
      }
    } else {
      errorSnackbar("Wrong Pass Code");
    }
  }

  Future<bool> onBackPress() async {
    if (!isConfirmActivate) return true;
    isConfirmActivate = false;
    update();
    return false;
  }
}
