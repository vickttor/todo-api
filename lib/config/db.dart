import 'dart:io';

import 'package:postgres/postgres.dart';

class DatabaseConfig {
  DatabaseConfig() {
    final env = Platform.environment;

    _host = env['DATABASE_HOST'];
    _user = env['DATABASE_USERNAME'];
    _password = env['DATABASE_PASSWORD'];
    _dbname = env['DATABASE_NAME'];
  }

  String? _host;
  String? _user;
  String? _password;
  String? _dbname;

  Future<Connection> connect() async {
    return Connection.open(
      Endpoint(
        host: _host!,
        database: _dbname!,
        username: _user,
        password: _password,
      ),
    );
  }

  Future<void> initilize(Connection conn) async {
    await conn.execute('CREATE TABLE IF NOT EXISTS todos ('
        '  id TEXT NOT NULL, '
        '  name TEXT NOT NULL, '
        '  isCompleted BOOLEAN NOT NULL, '
        '  createdAt DATETIME NOT NULL  '
        ')');
  }
}
