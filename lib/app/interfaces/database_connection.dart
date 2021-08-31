import 'package:password_manager/app/data/models/password_model.dart';

abstract class DatabaseConnection {
  Future<void> init();

  Future<List<Password>> get allPasswords;

  Future<Password> getPass(int id);
  Future<int> savePass(Password password);
  Future<void> deletePass(Password password);
  Future<void> updatePass(Password password);

  Future<bool> checkIfExists(String website, String mail);

  Future<void> updateType(Password password);

  Future<void> updateNotes(Password password);

  Future<void> deleteAllPasswords();
}
