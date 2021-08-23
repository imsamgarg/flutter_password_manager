import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';

import 'package:password_manager/app/core/values/values.dart';

class EncryptionService extends GetxService {
  // Future<EncryptionService> init() async {
  //   return this;
  // }

  String encryptText(String text, String key) {
    ///Key Must Be 32 characters Long
    final pass = _generatekey(key);
    final _generatedKey = Key.fromUtf8(pass);
    final _iv = IV.fromLength(16);
    final _encrypter = Encrypter(AES(_generatedKey));

    return _encrypter.encrypt(text, iv: _iv).base64;
  }

  String _generatekey(String key) {
    var pass = key;
    if (key.length < keyLength) {
      pass = key.padRight(keyLength);
    }
    if (key.length > keyLength) {
      pass = key.substring(0, keyLength);
    }
    return pass;
  }

  String decryptText(String password, String key) {
    // /Key Must Be 32 characters Long
    final pass = _generatekey(key);
    final _generatedKey = Key.fromUtf8(pass);
    final _encryptedPass = Encrypted.fromBase64(password);
    final _iv = IV.fromLength(16);
    final _encrypter = Encrypter(AES(_generatedKey));

    return _encrypter.decrypt(_encryptedPass, iv: _iv);
  }
}
