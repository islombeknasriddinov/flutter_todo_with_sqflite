import 'package:darmon/kernel/medicine/medicine_api.dart';
import 'package:darmon/kernel/medicine/medicine_pref.dart';
import 'package:darmon/kernel/medicine/medicine_util.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_search_history.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:gwslib/localization/pref.dart';
import 'package:sqflite/sqflite.dart';

class UISearchHistoryDao {
  Database db;

  UISearchHistoryDao(this.db);

  Future<void> saveMedicineMarkSearchHistory(UIMedicineMark medicine) async {
    ZMedicineMarkSearchHistory history = await MedicineUtil.loadMedicineMarkSearchHistory(
        db,
        medicine.titleRu,
        medicine.type == UIMedicineMarkSearchResultType.INN
            ? MedicinePref.SEARCH_HISTORY_TYPE_INN
            : MedicinePref.SEARCH_HISTORY_TYPE_NAME);
    if (history == null) {
      await MedicineApi.saveMedicineMarkSearchHistory(
          db,
          ZMedicineMarkSearchHistory(
              titleRu: medicine.titleRu,
              titleEn: medicine.titleEn,
              titleUz: medicine.titleUz,
              sendServerText: medicine.sendServerText,
              type: medicine.type == UIMedicineMarkSearchResultType.INN
                  ? MedicinePref.SEARCH_HISTORY_TYPE_INN
                  : MedicinePref.SEARCH_HISTORY_TYPE_NAME,
              orderNo: 1));
    } else {
      await MedicineApi.updateMedicineMarkSearchHistoryOrderNo(db, history);
    }
  }

  Future<List<UIMedicineMark>> loadMedicineMarkSearchHistory({int limit}) async {
    String langCode = await LocalizationPref.getLanguage();
    return MedicineUtil.loadMedicineMarkSearchHistoryList(db, limit: limit).then((value) => value
        .map((e) => UIMedicineMark(
            langCode == 'ru'
                ? e.titleRu
                : (langCode == 'uz' ? e.titleUz : (langCode == 'en' ? e.titleEn : e.titleRu)),
            e.titleRu,
            e.titleUz,
            e.titleEn,
            e.sendServerText,
            e.type == MedicinePref.SEARCH_HISTORY_TYPE_INN
                ? UIMedicineMarkSearchResultType.INN
                : UIMedicineMarkSearchResultType.NAME))
        .toList());
  }

  Future<void> deleteMedicineMarkSearchHistory(UIMedicineMark mark) =>
      MedicineApi.deleteMedicineMarkSearchHistory(
          db,
          mark.titleRu,
          mark.type == UIMedicineMarkSearchResultType.INN
              ? MedicinePref.SEARCH_HISTORY_TYPE_INN
              : MedicinePref.SEARCH_HISTORY_TYPE_NAME);
}
