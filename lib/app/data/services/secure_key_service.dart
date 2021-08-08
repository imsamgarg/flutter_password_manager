import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/state_manager.dart';

class SecureKeyService extends GetxService {
  late FlutterSecureStorage _secureStorage;

  @override
  void onInit() {
    _secureStorage = FlutterSecureStorage();
    super.onInit();
  }

  Future<bool> hasKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }
}
