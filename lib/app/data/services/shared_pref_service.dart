import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService extends GetxService {
  late final SharedPreferences storage;

  @override
  void onInit() async {
    storage = await SharedPreferences.getInstance();
    super.onInit();
  }
}
