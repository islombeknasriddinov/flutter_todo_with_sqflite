import 'package:darmon/kernel/medicine/medicine_api.dart';
import 'package:darmon/kernel/medicine/medicine_pref.dart';
import 'package:darmon/kernel/medicine/medicine_util.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_search_history.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:sqflite/sqflite.dart';

class UISearchHistoryDao {
  Database db;

  UISearchHistoryDao(this.db);

  Future<void> saveMedicineMarkSearchHistory(UIMedicineMark medicine) async {
    ZMedicineMarkSearchHistory history =
        await MedicineUtil.loadMedicineMarkSearchHistory(
            db,
            medicine.title,
            medicine.type == UIMedicineMarkSearchResultType.INN
                ? MedicinePref.SEARCH_HISTORY_TYPE_INN
                : MedicinePref.SEARCH_HISTORY_TYPE_NAME);
    if (history == null) {
      await MedicineApi.saveMedicineMarkSearchHistory(
          db,
          ZMedicineMarkSearchHistory(
              title: medicine.title,
              sendServerText: medicine.sendServerText,
              type: medicine.type == UIMedicineMarkSearchResultType.INN
                  ? MedicinePref.SEARCH_HISTORY_TYPE_INN
                  : MedicinePref.SEARCH_HISTORY_TYPE_NAME,
              orderNo: 1));
    } else {
      await MedicineApi.updateMedicineMarkSearchHistoryOrderNo(db, history);
    }
  }

  Future<List<UIMedicineMark>> loadMedicineMarkSearchHistory({int limit}) {
    return MedicineUtil.loadMedicineMarkSearchHistoryList(db, limit: limit)
        .then((value) => value
            .map((e) => UIMedicineMark(
                e.title,
                e.sendServerText,
                e.type == MedicinePref.SEARCH_HISTORY_TYPE_INN
                    ? UIMedicineMarkSearchResultType.INN
                    : UIMedicineMarkSearchResultType.NAME))
            .toList());
  }

  Future<void> deleteMedicineMarkSearchHistory(UIMedicineMark mark) =>
      MedicineApi.deleteMedicineMarkSearchHistory(
          db,
          mark.title,
          mark.type == UIMedicineMarkSearchResultType.INN
              ? MedicinePref.SEARCH_HISTORY_TYPE_INN
              : MedicinePref.SEARCH_HISTORY_TYPE_NAME);
}
