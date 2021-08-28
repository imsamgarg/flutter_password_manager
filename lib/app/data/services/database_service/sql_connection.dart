import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:password_manager/app/core/utils/exceptions.dart';
import 'package:password_manager/app/core/values/queries.dart';
import 'package:password_manager/app/core/values/strings.dart';
import 'package:password_manager/app/data/models/password_model.dart';
import 'package:password_manager/app/interfaces/database_connection.dart';

class SqlConnection implements DatabaseConnection {
  late final Database _database;
  @override
  Future<List<Password>> get allPasswords async {
    final _res = await _database.rawQuery(Queries.getAllPasswords);
    if (_res.length > 0) {
      // customLog(_res.first, name: "Data");
      return _res.map((e) => Password.fromJson(e)).toList();
    } else {
      return List.empty();
    }
  }

  @override
  Future<void> deletePass(Password password) async {
    await _database.rawDelete(
      Queries.deletePassword,
      [
        password.website,
        password.email,
      ],
    );
  }

  @override
  Future<Password> getPass(int id) {
    // TODOS: For Future Use
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {
    final _path = join(await getDatabasesPath(), 'database.db');
    _database = await openDatabase(
      _path,
      onCreate: (db, i) {
        return db.execute(Queries.createTable);
      },
      version: 1,
    );
  }

  @override
  Future<Password> savePass(Password password) async {
    await _database.rawInsert(
      Queries.savePassword,
      [
        password.website,
        password.email,
        password.password,
        password.notes,
        password.r,
        password.tags,
        password.createdOn,
        password.modifiedOn,
      ],
    );
    return password;
  }

  @override
  Future<bool> checkIfExists(String website, String mail) async {
    const String query =
        "${PassFields.website} = ? COLLATE NOCASE AND ${PassFields.email} = ? COLLATE NOCASE";
    final _res = await _database.query(
      passTableName,
      columns: [PassFields.email],
      where: query,
      whereArgs: [website, mail],
    );
    return _res.isNotEmpty;
  }

  @override
  Future<void> updatePass(Password password) async {
    return await _updateDetails(password);
  }

  @override
  Future<void> updateType(Password password) async {
    return await _updateDetails(password);
  }

  @override
  Future<void> updateNotes(Password password) async {
    return await _updateDetails(password);
  }

  @override
  Future<void> deleteAllPasswords() {
    // TODO: implement deleteAllPasswords
    throw UnimplementedError();
  }

  Future<void> _updateDetails(Password password) async {
    final website = password.website;
    final mail = password.email;

    const String query =
        "${PassFields.website} = ? AND ${PassFields.email} = ?";
    final _res = await _database.update(passTableName, password.toJson(),
        where: query, whereArgs: [website, mail]);
    if (_res == 0)
      throw DbException("No Password Exists With That Combination");
  }
}
