import 'package:get/get.dart';

import 'package:password_manager/app/data/services/database_service/sql_connection.dart';
import 'package:password_manager/app/interfaces/database_connection.dart';

class DatabaseService extends GetxService {
  late DatabaseConnection connection;

  Future<DatabaseConnection> init() async {
    connection = await SqlConnection()
      ..init();
    return connection;
  }
}
