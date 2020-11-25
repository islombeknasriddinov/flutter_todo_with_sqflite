import 'package:darmon/kernel/medicine/medicine_pref.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_inn.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:sqflite/sqflite.dart';

class MedicineSync {
  static Future<void> sync(Database db, Map<String, dynamic> values) async {
    if (values.containsKey(MedicinePref.SYNC_MEDICINE_MARK_NAME)) {
      for (List<dynamic> row in values[MedicinePref.SYNC_MEDICINE_MARK_NAME] as List<dynamic>) {
        var r = Z_ZMedicineMarkName.toRowFromListString(values: row.cast());
        await Z_ZMedicineMarkName.saveRow(db, r);
      }
    }

    if (values.containsKey(MedicinePref.SYNC_MEDICINE_MARK_INN)) {
      for (List<dynamic> row in values[MedicinePref.SYNC_MEDICINE_MARK_INN] as List<dynamic>) {
        var r = Z_ZMedicineMarkInn.toRowFromListString(values: row.cast());
        await Z_ZMedicineMarkInn.saveRow(db, r);
      }
    }
  }
}
