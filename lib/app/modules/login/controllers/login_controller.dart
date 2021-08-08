import 'package:get/get.dart';

class LoginController extends GetxController {
  final _number = "".obs;
  String get number => _number.value;
  void addNumber(int number) {
    if (_number.value.length > 5) return;
    this._number.value += "$number";
  }

  void removeNumber() {
    if (_number.value.length < 1) return;
    _number.value = _number.value.substring(0, _number.value.length - 1);
  }

  void clearNumber() {
    _number.value = "";
  }
}
