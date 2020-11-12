import 'package:gwslib/kernel/mt/tables/translates.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class MoldDatabase {
  static Future<String> getPath() {
    return getDatabasesPath().then((path) => join(path, "oc_mold.db"));
  }

  static MoldDatabase _instance;

  static Future<void> init() async {
    if (!isOpen()) {
      final db = await openDatabase(
        await getPath(),
        version: 1,
        onCreate: (db, version) => onCreate.call(db),
      );
      _instance = MoldDatabase(db);
    } else {
      throw Exception("AccountDatabase already init");
    }
  }

  static bool isOpen() => _instance != null && _instance.db.isOpen;

  static Database instance() {
    if (isOpen()) {
      return _instance.db;
    }
    throw Exception("You can't getting reference database instance, "
        "database not init or you call closed database");
  }

  static Future<void> close() async {
    if (isOpen()) {
      await _instance.db.close();
    }
  }

  final Database db;

  MoldDatabase(this.db);

  static Future<void> onCreate(Database db) async {
    await db.execute(MtTranslates.TABLE);
  }
}
