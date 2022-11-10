import 'dart:io';

import 'package:darmon/kernel/medicine/medicine_sync.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_inn.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_search_history.dart';
import 'package:gwslib/gwslib.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DarmonDatabase extends MyDatabase {
  static const SCHEMA = "darmon";
  static const DATABASE = "oc_${SCHEMA}_v1.db";
  static const VERSION = 1;

  static DarmonDatabase getInstance() => MyDatabase.instance(DATABASE);

  static bool isDatabaseOpen() => MyDatabase.isDatabaseOpen(DATABASE);

  static void onConfigure(Batch batch) {}

  static void onCreate(Batch batch) async {
    Log.debug("########## Execute ZMedicine Tables ##########");
    batch.execute(ZMedicineMarkName.TABLE);
    batch.execute(ZMedicineMarkInn.TABLE);
    batch.execute(ZMedicineMarkSearchHistory.TABLE);
  }

  static Future<DarmonDatabase> newInstance() async {
    String path = await getDatabasesPath().then((path) => join(path, DATABASE));

    final database = await connectDatabase(DATABASE, path, onCreate: onCreate);

    final db = new DarmonDatabase(database);
    await db.init(calcSha256(path));
    return db;
  }

  DarmonDatabase(Database db) : super(DATABASE, db);

  @override
  Future<void> init(String databaseKey) async {
    return super.init(databaseKey).then((value) => onCheckVersion(databaseKey, SCHEMA, VERSION));
  }

  @override
  void onDowngrade(String schema, Batch batch) async {
    if (schema == SCHEMA) {
      Log.debug("########## Execute ZMedicine Tables ##########");
      batch.execute(ZMedicineMarkSearchHistory.TABLE);
      batch.execute(ZMedicineMarkInn.TABLE);
      batch.execute(ZMedicineMarkName.TABLE);

      onCreate(batch);
    } else {
      super.onDowngrade(schema, batch);
    }
  }

  Future<void> syncDatabase(Map<String, dynamic> values) async {
    await MedicineSync.sync(getDatabase(), values);
  }

  ///delete database file created by  [serverId]
  Future<void> deleteServer(String serverId) async {
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
