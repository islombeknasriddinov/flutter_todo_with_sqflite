import 'package:darmon/kernel/medicine/medicine_pref.dart';
import 'package:darmon/kernel/medicine/tables/medicine.dart';
import 'package:sqflite/sqflite.dart';

class MedicineSync {
  static Future<void> sync(Database db, Map<String, dynamic> values) async {
    if (values.containsKey(MedicinePref.SYNC_MEDICINE)) {
      for (List<dynamic> row in values[MedicinePref.SYNC_MEDICINE] as List<dynamic>) {
        var r = Z_ZMedicine.toRowFromListString(values: row.cast());
        await Z_ZMedicine.saveRow(db, r);
      }
    }
  }
}
