import 'package:mysql_client/mysql_client.dart';
import 'package:rock_vin_cafe_app/models/card_colums.dart';
import 'package:rock_vin_cafe_app/models/cart_model.dart';
import 'package:rock_vin_cafe_app/models/food_cat.dart';
import 'package:rock_vin_cafe_app/models/food_model.dart';
import 'package:rock_vin_cafe_app/models/order_h_model.dart';
import 'package:rock_vin_cafe_app/models/order_model.dart';
import 'package:rock_vin_cafe_app/models/user_model.dart';

abstract class Database {
  Future<MySQLConnection> getDbConnection();
  Future<void> saveData(String table, String columnlist, data);
  Future<void> updateUser(UserModel updatedUser);
  Future<void> saveCardData(String table, String columnlist, data);
  Future<UserModel> readUserData(String table, String uid);
  Future<List<CardModel>> readCardData(String uid);
  Future<List<FoodModel>> readFoodData(String where);
  Future<List<CategoryModel>> foodList();
  Future<List<CartModel>> readCartData(String uid);
  Future<List<OrderHModel>> readOrderData(String uid);
  Future<void> updateCartQ(int cartid, int count, int foodid);
  Future<void> addToCartQ(uid, foodid, quantity, totalprice);
  Future<void> deleteCartQ(int cartid);
  Future<void> addOrder(data);
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

      // host: "20.50.123.139",
      // // host: "10.0.2.2", //For Android
      // port: 3306,
      // userName: "rockvin",
      // password: "Rockvin@1234!",
      // databaseName: "caferockvin",
    );

    return conn;
  }

  @override
  Future<void> saveData(String table, String columnlist, data) async {
    try {
      var stmt = await conn.prepare(
        "insert into users ($columnlist) values (?,?,?,?,?,?,?)",
      );
      await (stmt.execute(data));
    } catch (e) {
      print(e);
    }

    // await stmt.execute(data);
  }

  Future<void> updateUser(UserModel updatedUser) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      await conn.execute("""
      UPDATE users 
      SET 
        phoneno = :phoneno,
        fname = :fname,
        lname = :lname,
        address = :address,
        city = :city,
        emailaddress = :emailaddress
      WHERE userid = :userid
    """, {
        "phoneno": updatedUser.phoneno,
        "fname": updatedUser.fname,
        "lname": updatedUser.lname,
        "address": updatedUser.address,
        "city": updatedUser.city,
        "emailaddress": updatedUser.emailaddress,
        "userid": updatedUser.userid,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> saveCardData(String table, String columnlist, data) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();
      var stmt = await conn.prepare(
        "insert into $table ($columnlist) values (?,?,?,?,?)",
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
      var resultSets =
          await conn.execute("SELECT * FROM users WHERE userid = '$uid'");
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
  Future<List<FoodModel>> readFoodData(String where) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      // final resultSets = await conn.execute("select * from users");
      var resultSets = await conn.execute(
          "SELECT food_id,food_name,food_price,food_desc,food_cat_id,CONCAT(LOWER(category.cate_name), '/', foods.food_img) AS food_img FROM foods LEFT JOIN category on category.cate_id = foods.food_cat_id $where LIMIT 20;");
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
  Future<List<CardModel>> readCardData(String uid) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      var resultSets = await conn.execute(
          "SELECT * FROM card_table where username = '$uid' order by (card_id) DESC");
      List<CardModel> cardList = [];
      for (final row in resultSets.rows) {
        // print(row.assoc());
        cardList.add(CardModel.fromMap(row.assoc()));
      }
      return cardList;
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

  @override
  Future<List<CartModel>> readCartData(String uid) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      var resultSets = await conn.execute(
          "SELECT ct.cartid, ct.uid, ct.quantity, ct.totalprice, ot.food_id, ot.food_name, ot.food_price, CONCAT(LOWER(category.cate_name), '/', ot.food_img) as food_img" +
              " FROM cart_table ct" +
              " LEFT JOIN foods ot ON ct.foodid = ot.food_id" +
              " LEFT JOIN category ON category.cate_id = ot.food_cat_id" +
              " WHERE ct.uid = '$uid'");

      // "SELECT ct.cartid, ct.uid ,ct.quantity,ct.totalprice,ot.food_id, ot.food_name,ot.food_price " +
      //     "FROM cart_table ct " +
      //     "LEFT JOIN foods ot on ct.foodid = ot.food_id " +
      //     "WHERE ct.uid = '$uid'");

      List<CartModel> cartlist = [];
      for (final row in resultSets.rows) {
        cartlist.add(CartModel.fromMap(row.assoc()));
      }
      return cartlist;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  @override
  Future<List<OrderHModel>> readOrderData(String uid) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      var resultSets = await conn.execute(
          "SELECT ct.orderid, ct.uid, ct.quantity, ct.totalprice,ct.status,ct.picup_time, ot.food_id, ot.food_name, ot.food_price, CONCAT(LOWER(category.cate_name), '/', ot.food_img) as food_img" +
              " FROM order_table ct" +
              " LEFT JOIN foods ot ON ct.foodid = ot.food_id" +
              " LEFT JOIN category ON category.cate_id = ot.food_cat_id" +
              " WHERE ct.uid = '$uid'" +
              " ORDER BY ct.status;");
      List<OrderHModel> cartlist = [];
      for (final row in resultSets.rows) {
        cartlist.add(OrderHModel.fromMap(row.assoc()));
      }
      return cartlist;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  @override
  Future<void> updateCartQ(int cartid, int count, int foodid) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      await conn.execute("""
          UPDATE cart_table 
          SET 
              quantity = quantity + :count,
              totalprice = (quantity) * (
                  SELECT food_price 
                  FROM foods
                  WHERE food_id = :foodid
              )
          WHERE cartid = :cartid

    """, {"count": count, "cartid": cartid, "foodid": foodid});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> addToCartQ(uid, foodid, quantity, totalprice) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();
      // final resultSets = await conn.execute("select * from users");
      var resultSets = await conn.execute(
          "SELECT * FROM cart_table WHERE uid = '$uid' AND foodid = '$foodid'");
      print(resultSets.rows.length);
      // for (final row in resultSets.rows) {
      // print(row.assoc());
      if (resultSets.rows.length == 0) {
        print("null");
        var stmt = await conn.prepare(
          "insert into cart_table (uid, foodid, quantity, totalprice) values (?, ?, ?, ?)",
        );
        await stmt.execute([uid, foodid, quantity, totalprice]);
        print("Done add to cart");
      } else {
        //Get the row data
        print(resultSets.rows.first.assoc()["cartid"]);
        // Update the row with add the quantity
        await conn.execute("""
          UPDATE cart_table 
          SET 
              quantity = quantity + :quantity,
              totalprice = totalprice + :totalprice
          WHERE cartid = :cartid
          """, {
          "quantity": quantity,
          "totalprice": totalprice,
          "cartid": resultSets.rows.first.assoc()["cartid"]
        });
      }
      // print(row.assoc()["cartid"]);
      // }
      // if (condition) {}
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> deleteCartQ(int cartid) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      await conn.transactional((conn) async {
        await conn.execute("DELETE FROM cart_table WHERE cartid = :cartid",
            {"cartid": cartid});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> addOrder(data) async {
    try {
      MySQLConnection conn = await getDbConnection();
      await conn.connect();

      var stmt = await conn.prepare(
        "insert into order_table (uid,foodid,quantity,totalprice,status,picup_time,order_from) values (?,?,?,?,?,?,?)",
      );
      await (stmt.execute(data));
    } catch (e) {
      print(e);
    }
  }
}
