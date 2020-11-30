import 'package:darmon/common/darmon_pref.dart';
import 'package:darmon/kernel/database.dart';
import 'package:darmon/kernel/medicine/medicine_api.dart';
import 'package:darmon/kernel/medicine/medicine_pref.dart';
import 'package:darmon/kernel/medicine/medicine_util.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_search_history.dart';
import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/network/network_manager.dart';
import 'package:gwslib/common/date_util.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';
import 'package:sqflite/sqflite.dart';

class DarmonRepository {
  Database db;
  UIDarmonDao dao;

  DarmonRepository(this.db, this.dao);

  Future<bool> checkSync() async {
    DateTime now = DateTime.now();
    String timeStamp = await DarmonPref.getLastVisitTimestamp();
    if (timeStamp?.isNotEmpty == true) {
      int syncTime = DateUtil.parse(timeStamp).millisecondsSinceEpoch;
      if (syncTime >=
          DateTime(now.year, now.month, now.day, now.hour - 12)
              .millisecondsSinceEpoch) {
        return Future.value(false);
      }
    }
    Map<String, dynamic> result = await NetworkManager.sync();
    Timer timer =Timer();
    timer.start();
    await DarmonDatabase.sync(result);
    timer.stop("sync ended");
    //  DarmonPref.saveLastVisitTimestamp(result['laststamp']);
    DarmonPref.saveLastVisitTimestamp(
        DateUtil.format(DateTime.now(), DateUtil.FORMAT_DD_MM_YYYY_HH_MM));
    return true;
  }

  Future<List<UIMedicineMarkName>> searchMedicineMarkName(String query,
      {int limit}) async {
    return dao.searchMedicineMarkName(query.trim(), limit: limit).then(
        (value) => value
            .map((e) => UIMedicineMarkName(e.nameRu, e.nameUz, e.nameEn))
            .toList());
  }

  Future<List<UIMedicineMarkInn>> searchMedicineMarkInn(String query,
      {int limit}) async {
    return dao.searchMedicineMarkInn(query.trim(), limit: limit).then((value) =>
        value
            .map((e) => UIMedicineMarkInn(e.innRu, e.innEn, e.innIds))
            .toList());
  }

  Future<List<UIMedicineMark>> searchMedicineMark(String query) async {
    List<UIMedicineMark> result = [];
    String langCode = await LocalizationPref.getLanguage();
    List<UIMedicineMark> names = await searchMedicineMarkName(query)
        .then((value) => value.map((medicineMarkName) {
              String name = medicineMarkName.nameRu;
              if (langCode == "uz") {
                name = medicineMarkName.nameUz;
              } else if (langCode == "en") {
                name = medicineMarkName.nameEn;
              }
              return UIMedicineMark(name, medicineMarkName.nameEn,
                  UIMedicineMarkSearchResultType.NAME);
            }).toList());
    result.addAll(names);

    List<UIMedicineMark> inns =
        await searchMedicineMarkInn(query).then((value) => value.map((markInn) {
              String inn = markInn.innRu;
              if (langCode == "en") {
                inn = markInn.innEn;
              }
              return UIMedicineMark(
                  inn, markInn.innIds, UIMedicineMarkSearchResultType.INN);
            }).toList());
    result.addAll(inns);

    return result;
  }

  Future<List<UIMedicineMark>> searchMedicineMarkNames(String query,
      {int limit}) async {
    String langCode = await LocalizationPref.getLanguage();
    return await searchMedicineMarkName(query, limit: limit)
        .then((value) => value.map((medicineMarkName) {
              String name = medicineMarkName.nameRu;
              if (langCode == "uz") {
                name = medicineMarkName.nameUz;
              } else if (langCode == "en") {
                name = medicineMarkName.nameEn;
              }
              return UIMedicineMark(name, medicineMarkName.nameEn,
                  UIMedicineMarkSearchResultType.NAME);
            }).toList());
  }

  Future<List<UIMedicineMark>> searchMedicineMarkInns(String query,
      {int limit}) async {
    Log.debug("searchMedicineMarkInns($query)");
    String langCode = await LocalizationPref.getLanguage();
    return await searchMedicineMarkInn(query, limit: limit)
        .then((value) => value.map((markInn) {
              String inn = markInn.innRu;
              if (langCode == "en") {
                inn = markInn.innEn;
              }
              return UIMedicineMark(
                  inn, markInn.innIds, UIMedicineMarkSearchResultType.INN);
            }).toList());
  }
}

class UIMedicineMarkName {
  final String nameRu;
  final String nameUz;
  final String nameEn;

  UIMedicineMarkName(this.nameRu, this.nameUz, this.nameEn);
}

class UIMedicineMarkInn {
  final String innRu;
  final String innEn;
  final String innIds;

  UIMedicineMarkInn(this.innRu, this.innEn, this.innIds);
}

class UIMedicineMark {
  final String title;
  final String sendServerText;
  final UIMedicineMarkSearchResultType type;

  UIMedicineMark(this.title, this.sendServerText, this.type);
}

enum UIMedicineMarkSearchResultType { NAME, INN }
