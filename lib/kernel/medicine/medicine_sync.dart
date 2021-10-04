import 'package:darmon/kernel/medicine/medicine_pref.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_inn.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:gwslib/gwslib.dart';
import 'package:sqflite/sqflite.dart';

class MedicineSync {
  static Future<void> sync(Database db, Map<String, dynamic> values) async {
    await db.transaction((txn) async {
      final batch = txn.batch();
      if (values.containsKey(MedicinePref.SYNC_MEDICINE_MARK_NAME)) {
        Log.debug(
            "SYNC_MEDICINE_MARK_NAME.length=${(values[MedicinePref.SYNC_MEDICINE_MARK_NAME] as List<dynamic>).length}");
        for (List<dynamic> row in values[MedicinePref.SYNC_MEDICINE_MARK_NAME] as List<dynamic>) {
          var r = Z_ZMedicineMarkName.toRowFromListString(values: row.cast());
          batch.insert(ZMedicineMarkName.TABLE_NAME, r.toData(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        if (values.containsKey(MedicinePref.SYNC_MEDICINE_MARK_INN)) {
          Log.debug(
              "SYNC_MEDICINE_MARK_INN.length=${(values[MedicinePref.SYNC_MEDICINE_MARK_INN] as List<dynamic>).length}");
          for (List<dynamic> row in values[MedicinePref.SYNC_MEDICINE_MARK_INN] as List<dynamic>) {
            var r = Z_ZMedicineMarkInn.toRowFromListString(values: row.cast());
            batch.insert(ZMedicineMarkInn.TABLE_NAME, r.toData(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }
        }
      }
      final result = await batch.commit();
      Log.debug("batch.commit().length=${result.length}");
    });

    Z_ZMedicineMarkInn.loadAll(db).then((value) {
      Log.debug("Z_ZMedicineMarkInn.leght=${value.length}");
    });

    Z_ZMedicineMarkName.loadAll(db).then((value) {
      Log.debug("Z_ZMedicineMarkName.leght=${value.length}");
    });
  }
}
