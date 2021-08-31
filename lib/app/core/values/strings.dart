const String passCode = "secure_key";
const String passwordKey = "ds_pa_s";
const String promptForPassEveryTime = "promptForPassEveryTime";

const String lastBackup = "last_backup";
const String lastRestore = "last_restore";
const String passTableName = "password";
const String backupFileName = "backup.json";

abstract class PassFields {
  static const String email = "email";
  static const String password = "password";
  static const String type = "r";
  static const String tags = "tags";
  static const String created_on = "created_on";
  static const String modified_on = "modified_on";
  static const String website = "website";
  static const String notes = "notes";
}
