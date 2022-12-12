import 'package:flutter_sqflite_revison/db/db.dart';
import 'package:sqflite/sqflite.dart';

class AppModule {
  DBConnection dbConnection = DBConnection();

  AppModule() {
    dbConnection = DBConnection();
  }

  /*Database Related*/
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await dbConnection.setDatabase();
    return _database!;
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    return connection.insert(table, data);
  }

  Future<List<Map<String, Object?>>> readTodoData() async {
    var connection = await database;
    return await connection.rawQuery(
        "SELECT b.id, b.statusId, a.color, b.title, b.description FROM status AS a INNER JOIN todos AS b ON a.id = b.statusId");
  }

  Future<List<Map<String, Object?>>> readData(String table) async {
    var connection = await database;
    return await connection.rawQuery("SELECT * FROM $table ORDER BY id DESC");
  }

  Future<List<Map<String, Object?>>> readDataById(table, int itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  Future<int> updateData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: "id=?", whereArgs: [data['id']]);
  }

  Future<int> deleteData(String table, int id) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $id");
  }

  Future<List<Map<String, Object?>>> readDataByStatusName(
      String table, String statusName, int value) async {
    var connection = await database;
    return connection.rawQuery("SELECT * FROM $table WHERE $statusName LIKE $value ORDER BY id");
  }
}
