import 'package:mysql_client/mysql_client.dart';
import 'package:rock_vin_cafe_app/models/user_model.dart';

abstract class Database {
  Future<MySQLConnection> getDbConnection();
  Future<void> saveData(String table, String columnlist, data);
  Future<UserModel> readUserData(String table, String uid);
}

class SQLDatabase implements Database {
  late MySQLConnection conn;

  @override
  Future<MySQLConnection> getDbConnection() async {
    conn = await MySQLConnection.createConnection(
      host: "localhost",
      // host: "10.0.2.2", //For Android
      port: 3306,
      userName: "root",
      password: "",
      databaseName: "rockvincafe", // optional
    );

    return conn;
  }

  @override
  Future<void> saveData(String table, String columnlist, data) async {
    try {
      var stmt = await conn.prepare(
        "insert into $table ($columnlist) values (?,?,?,?,?,?,?)",
      );
      await (stmt.execute(data));
    } catch (e) {
      print(e);
    }

    // await stmt.execute(data);
  }

  Future<UserModel> readUserData(String table, String uid) async {
    try {
      print("MySQLConnection");
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      // final resultSets = await conn.execute("select * from users");
      var resultSets = await conn.execute(
          "SELECT * FROM users WHERE userid = 'xDLKKjmJk6Ugdb06NUmX7ixyykJ2'");
      print(resultSets.numOfColumns);
      for (final row in resultSets.rows) {
        // print(row.colAt(0));
        // print(row.colByName("title"));

        // print all rows as Map<String, String>
        // print(row.assoc());

        return UserModel.fromMap(row.assoc());
      }

      if (resultSets.isNotEmpty) {
        return UserModel(
            userid: "No Data",
            phoneno: "",
            fname: "",
            lname: "",
            address: "",
            city: "",
            emailaddress: "");
      }
    } catch (e) {
      print(e.toString());
      return UserModel(
          userid: e.toString(),
          phoneno: "",
          fname: "",
          lname: "",
          address: "",
          city: "",
          emailaddress: "");
    }
    return UserModel(
        userid: "Unknown Error",
        phoneno: "",
        fname: "",
        lname: "",
        address: "",
        city: "",
        emailaddress: "");

    // throw Exception('Failed to load user data');
  }
}
