import 'package:darmon/kernel/medicine/tables/medicine_mark_search_history.dart';
import 'package:sqflite/sqflite.dart';

class MedicineCore {
  static Future<int> saveMedicineMarkSearchHistory(
      Database db, ZMedicineMarkSearchHistory history) {
    return Z_ZMedicineMarkSearchHistory.saveRow(db, history);
  }

  static Future<int> updateMedicineMarkSearchHistoryOrderNo(
      Database db, ZMedicineMarkSearchHistory history) async {
    return db.update(ZMedicineMarkSearchHistory.TABLE_NAME,
        {ZMedicineMarkSearchHistory.C_ORDER_NO: ((history?.orderNo ?? 0) + 1)},
        where:
            "${ZMedicineMarkSearchHistory.C_TITLE} = ? AND ${ZMedicineMarkSearchHistory.C_TYPE} = ?",
        whereArgs: [history.title, history.type]);
  }

  static Future<void> deleteMedicineMarkSearchHistory(
          Database db, String title, int type) =>
      Z_ZMedicineMarkSearchHistory.deleteOne(db, title, type);
}
