import 'dart:io';

import 'package:darmon/filter/kernel/database.dart';
import 'package:darmon/kernel/medicine/medicine_sync.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_inn.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_search_history.dart';
import 'package:gwslib/common/tuple.dart';
import 'package:gwslib/gwslib.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DarmonDatabase {
  static Future<String> getPath() {
    return getDatabasesPath().then((path) => join(path, "darmon.db"));
  }

  static DarmonDatabase _instance;

  static Future<void> init() async {
    if (_instance == null || !_instance.db.isOpen) {
      final db = await openDatabase(
        await getPath(),
        version: 1,
        onCreate: (db, version) => onCreate.call(db),
        onDowngrade: (db, oldVersion, newVersion) => onDowngrade.call(db),
      );

      _instance = DarmonDatabase(db);
    } else {
      throw Exception("DarmonDatabase already init");
    }
  }

  static bool isOpen() {
    if (_instance != null && _instance.db.isOpen) {
      return true;
    }
    return false;
  }

  static Future<List<Tuple<String, String>>> getLinkedDatabases() async {
    final filterDatabase = await FilterDatabase.getPath("darmon_filter");
    return [Tuple("filters", filterDatabase)];
  }

  static Future<void> attachLinkedDatabase(Database db) async {
    final attachedDatabase = await db.rawQuery("pragma database_list");
    final databaseNameList = attachedDatabase.map((e) => e["name"].toString()).toString();
    final databases = (await getLinkedDatabases()) //
        .where((it) => !databaseNameList.contains(it.first));
    for (final tuple in databases) {
      await db.execute("attach database '${tuple.second}' as '${tuple.first}'");
    }
    Log.debug("########## filter connect linked database success ##########");
  }

  static Database instance() {
    if (isOpen()) {
      return _instance.db;
    }
    throw Exception("You can't getting reference database instance, "
        "database not init or you call closed database");
  }

  static Future<void> sync(Map<String, dynamic> values) async {
    await _instance.syncDatabase(values);
  }

  static Future<void> close() async {
    if (isOpen()) {
      await _instance.db.close();
    }
  }

  final Database db;

  DarmonDatabase(this.db);

  static Future<void> onCreate(Database db) async {
    Log.debug("########## Execute ZMedicine Tables ##########");
    await db.execute(ZMedicineMarkName.TABLE);
    await db.execute(ZMedicineMarkInn.TABLE);
    await db.execute(ZMedicineMarkSearchHistory.TABLE);
  }

  static Future<void> onDowngrade(Database db) async {
    Log.debug("########## Execute ZMedicine Tables ##########");
    await db.execute(ZMedicineMarkSearchHistory.TABLE);
    await db.execute(ZMedicineMarkInn.TABLE);
    await db.execute(ZMedicineMarkName.TABLE);

    await onCreate(db);
  }

  Future<void> syncDatabase(Map<String, dynamic> values) async {
    await MedicineSync.sync(db, values);
  }

  ///delete database file created by  [serverId]
  static Future<void> deleteServer(String serverId) async {
    try {
      await close();
      Directory(await getDatabasesPath().then((path) => join(path, serverId)))
          .delete(recursive: true);
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      rethrow;
    }
  }
}
