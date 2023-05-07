import 'package:commons_core/commons_core.dart';

import 'database.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseMySqlAdapter implements Database {
  @override
  Future<MySqlConnection> get getConnection async =>
      await MySqlConnection.connect(
        ConnectionSettings(
          host: (await CustomEnv.get<String>(key: 'host')).trim(),
          port: (await CustomEnv.get<int>(key: 'port')),
          user: (await CustomEnv.get<String>(key: 'user')).trim(),
          db: (await CustomEnv.get<String>(key: 'db')).trim(),
          password: (await CustomEnv.get<String>(key: 'password')).trim(),
        ),
      );

  @override
  query(String sql, [List? params]) async {
    var conn = await getConnection;
    return conn.query(sql, params);
  }
}
