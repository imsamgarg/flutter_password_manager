import 'package:password_manager/app/data/models/password_model.dart';

abstract class DatabaseConnection {
  Future<void> init();

  Future<List<Password>> get allPasswords;

  Future<Password> getPass(int id);
  Future<Password> savePass(Password password);
  Future<void> deletePass(Password password);
  Future<Password> updatePass(Password password);
}
