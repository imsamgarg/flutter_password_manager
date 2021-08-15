// ${PassFields.id} INTEGER PRIMARY KEY,
import 'package:password_manager/app/core/values/strings.dart';

abstract class Queries {
  ///queries
  static const String createTable = """
    CREATE TABLE $passTableName(
      ${PassFields.website} TEXT NOT NULL,
      ${PassFields.email} TEXT NOT NULL,
      ${PassFields.password} TEXT NOT NULL,
      ${PassFields.notes} TEXT,
      ${PassFields.type} TEXT,
      ${PassFields.tags} TEXT,
      ${PassFields.created_on} INTEGER,
      ${PassFields.modified_on} INTEGER,
      PRIMARY KEY (${PassFields.website},${PassFields.email})
    )
    """;
  static const String getAllPasswords = """
    SELECT * FROM $passTableName
  """;

  static const String savePassword = """ 
    INSERT INTO $passTableName(
      ${PassFields.website},
      ${PassFields.email},
      ${PassFields.password},
      ${PassFields.notes},
      ${PassFields.type},
      ${PassFields.tags},
      ${PassFields.created_on},
      ${PassFields.modified_on}
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ? );
  """;

  static const String deletePassword = """ 
  DELETE FROM ${passTableName} WHERE ${PassFields.website} = ? AND ${PassFields.email} = ?
  """;
}
