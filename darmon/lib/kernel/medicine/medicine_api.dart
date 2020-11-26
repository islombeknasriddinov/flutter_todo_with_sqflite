import 'package:darmon/kernel/medicine/medicine_core.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_search_history.dart';
import 'package:sqflite/sqflite.dart';

class MedicineApi {
  static Future<int> saveMedicineMarkSearchHistory(
          Database db, ZMedicineMarkSearchHistory history) =>
      MedicineCore.saveMedicineMarkSearchHistory(db, history);

  static Future<int> updateMedicineMarkSearchHistoryOrderNo(
          Database db, ZMedicineMarkSearchHistory history) =>
      MedicineCore.updateMedicineMarkSearchHistoryOrderNo(db, history);

  static Future<void> deleteMedicineMarkSearchHistory(
          Database db, String title, int type) =>
      MedicineCore.deleteMedicineMarkSearchHistory(db, title, type);
}
