import 'package:darmon/filter/kernel/tables/filter_fields.dart';
import 'package:darmon/filter/kernel/tables/filters.dart';
import 'package:gwslib/log/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

class FilterDatabase {
  static Future<String> getPath(String serverId) {
    return getDatabasesPath().then((path) => join(path, serverId, "oc_filter_v1.db"));
  }

  static FilterDatabase _instance;

  static Future<void> init(String serverId) async {
    if (!isOpen()) {
      final db = await openDatabase(
        await getPath(serverId),
        version: 1,
        onCreate: (db, version) => onCreate.call(db),
        onDowngrade: (db, oldVersion, newVersion) => onDowngrade.call(db),
      );
      _instance = FilterDatabase(serverId, db);
    } else {
      throw Exception("FilterDatabase already init");
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

  final String serverId;
  final Database db;

  FilterDatabase(this.serverId, this.db);

  static Future<void> onCreate(Database db) async {
    final batch = db.batch();

    Log.debug("########## Execute MyFilter Tables ##########");
    batch.execute(MyFilters.TABLE);
    batch.execute(MyFilterFields.TABLE);

    await batch.commit();
  }

  static Future<void> onDowngrade(Database db) async {
    Log.debug("########## Delete MBT Tables ##########");
    await db.rawQuery("drop table ${MyFilters.TABLE_NAME}");
    await db.rawQuery("drop table ${MyFilterFields.TABLE_NAME}");

    await onCreate(db);
  }
}
