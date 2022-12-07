import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBConnection {
  Future<Database> setDatabase() async {
    var direction = await getApplicationDocumentsDirectory();
    var path = join(direction.path, "todo_revision");
    var database = await openDatabase(path, version: 2, onCreate: _onCreatingDatabase);

    return database;
  }

  void _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE status(id INTEGER PRIMARY KEY, name TEXT, color TEXT)");

    await database.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, statusId INTEGER, FOREIGN KEY(statusId) REFERENCES status(id))");
  }
}