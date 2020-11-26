import 'package:darmon/kernel/medicine/medicine_core.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_search_history.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:sqflite/sqflite.dart';

class MedicineUtil {
  static Future<ZMedicineMarkSearchHistory> loadMedicineMarkSearchHistory(
      Database db, String title, int type) {
    return Z_ZMedicineMarkSearchHistory.take(db, title, type);
  }

  static Future<List<ZMedicineMarkSearchHistory>>
      loadMedicineMarkSearchHistoryList(Database db, {int limit}) {
    final sql = """
    SELECT t.* 
          FROM ${ZMedicineMarkSearchHistory.TABLE_NAME} t
       ORDER BY t.${ZMedicineMarkSearchHistory.C_ORDER_NO} DESC
          LIMIT ${limit ?? 5}
    """;
    return db.rawQuery(sql).then(
        (it) => it.map((d) => ZMedicineMarkSearchHistory.fromData(d)).toList());
  }
}
