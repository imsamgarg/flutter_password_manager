import 'package:get/utils.dart';

class Validator {
  static String? emailValidator(String? string) {
    string ??= '';
    if (string.isEmpty) return 'Please Enter Email Address';
    if (!string.isEmail) return 'Please Enter Valid Email Address';
    return null;
  }
}
