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

  Future<bool> saveKey(String code, String key) async {
    try {
      await _secureStorage.write(key: key, value: code);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> matchKey(String value, String key) async {
    try {
      final _value = await _secureStorage.read(key: key);
      return (_value == value);
    } catch (e) {
      return false;
    }
  }
}
