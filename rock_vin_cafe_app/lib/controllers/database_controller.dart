import 'package:mysql_client/mysql_client.dart';

abstract class Database {
  Future<MySQLConnection> getDbConnection();
  Future<void> saveData(String table, String columnlist, data);
}

class SQLDatabase implements Database {
  late MySQLConnection conn;

  @override
  Future<MySQLConnection> getDbConnection() async {
    conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 8889,
      userName: "root",
      password: "root",
      databaseName: "rockvincafe", // optional
    );

    return conn;
  }

  @override
  Future<void> saveData(String table, String columnlist, data) async {
    var stmt = await conn.prepare(
      "insert into $table ($columnlist) values (?,?,?,?,?,?)",
    );
    print(stmt.execute(data));

    // await stmt.execute(data);
  }
}
