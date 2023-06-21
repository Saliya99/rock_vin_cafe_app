import 'package:mysql_client/mysql_client.dart';
import 'package:rock_vin_cafe_app/models/food_cat.dart';
import 'package:rock_vin_cafe_app/models/food_model.dart';
import 'package:rock_vin_cafe_app/models/user_model.dart';

abstract class Database {
  Future<MySQLConnection> getDbConnection();
  Future<void> saveData(String table, String columnlist, data);
  Future<UserModel> readUserData(String table, String uid);
  Future<List<FoodModel>> readFoodData();
  Future<List<CategoryModel>> foodList();
}

class SQLDatabase implements Database {
  late MySQLConnection conn;

  @override
  Future<MySQLConnection> getDbConnection() async {
    conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      // host: "10.0.2.2", //For Android
      port: 8889,
      userName: "root",
      password: "root",
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
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      // final resultSets = await conn.execute("select * from users");
      var resultSets = await conn.execute(
          "SELECT * FROM users WHERE userid = 'xDLKKjmJk6Ugdb06NUmX7ixyykJ2'");
      for (final row in resultSets.rows) {
        return UserModel.fromMap(row.assoc());
      }
    } catch (e) {
      print(e.toString());
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

  //for select aa from foods table
  Future<List<FoodModel>> readFoodData() async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      // final resultSets = await conn.execute("select * from users");
      var resultSets = await conn.execute("SELECT * FROM foods");
      List<FoodModel> foodList = [];
      for (final row in resultSets.rows) {
        foodList.add(FoodModel.fromMap(row.assoc()));
      }
      return foodList;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  @override
  Future<List<CategoryModel>> foodList() async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      // final resultSets = await conn.execute("select * from users");
      var resultSets = await conn.execute("SELECT * FROM category");
      List<CategoryModel> foodList = [];
      for (final row in resultSets.rows) {
        foodList.add(CategoryModel.fromMap(row.assoc()));
      }
      return foodList;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
