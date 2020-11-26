import 'package:darmon/common/darmon_pref.dart';
import 'package:darmon/kernel/database.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/network/network_manager.dart';
import 'package:gwslib/common/date_util.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class DarmonRepository {
  UIDarmonDao dao;

  DarmonRepository(this.dao);

  Future<bool> checkSync() async {
    DateTime now = DateTime.now();
    String timeStamp = await DarmonPref.getLastVisitTimestamp();
    if (timeStamp?.isNotEmpty == true) {
      int syncTime = DateUtil.parse(timeStamp).millisecondsSinceEpoch;
      if (syncTime >=
          DateTime(now.year, now.month, now.day, now.hour - 12).millisecondsSinceEpoch) {
        return Future.value(false);
      }
    }
    Map<String, dynamic> result = await NetworkManager.sync();
    print(result.toString());
    await DarmonDatabase.sync(result);
    DarmonPref.saveLastVisitTimestamp(result['laststamp']);
    return true;
  }

  Future<List<UIMedicineMarkName>> searchMedicineMarkName(String query) async {
/*    return [
      UIMedicineMarkName("name ru 1", "name uz 1", "name en 1"),
      UIMedicineMarkName("name ru 2", "name uz 2", "name en 2"),
      UIMedicineMarkName("name ru 3", "name uz 3", "name en 3"),
      UIMedicineMarkName("name ru 4", "name uz 4", "name en 4"),
      UIMedicineMarkName("name ru 5", "name uz 5", "name en 5"),
    ];*/
    return dao.searchMedicineMarkName(query.trim()).then(
        (value) => value.map((e) => UIMedicineMarkName(e.nameRu, e.nameUz, e.nameEn)).toList());
  }

  Future<List<UIMedicineMarkInn>> searchMedicineMarkInn(String query) async {
/*    return [
      UIMedicineMarkInn("inn 1"),
      UIMedicineMarkInn("inn 2"),
      UIMedicineMarkInn("inn 3"),
      UIMedicineMarkInn("inn 4"),
      UIMedicineMarkInn("inn 5"),
      UIMedicineMarkInn("inn 6"),
      UIMedicineMarkInn("inn 6"),
      UIMedicineMarkInn("inn 6"),
      UIMedicineMarkInn("inn 6"),
      UIMedicineMarkInn("inn 6"),
      UIMedicineMarkInn("inn 6"),
      UIMedicineMarkInn("inn 6"),
    ];*/
    return dao
        .searchMedicineMarkInn(query.trim())
        .then((value) => value.map((e) => UIMedicineMarkInn(e.innRu, e.innEn)).toList());
  }

  Future<List<UIMedicineMark>> searchMedicineMark(String query) async {
    List<UIMedicineMark> result = [];
    String langCode = await LocalizationPref.getLanguage();
    List<UIMedicineMark> names =
        await searchMedicineMarkName(query).then((value) => value.map((medicineMarkName) {
              String name = medicineMarkName.nameRu;
              if (langCode == "uz") {
                name = medicineMarkName.nameUz;
              } else if (langCode == "en") {
                name = medicineMarkName.nameEn;
              }
              return UIMedicineMark(
                  name, medicineMarkName.nameEn, UIMedicineMarkSearchResultType.NAME);
            }).toList());
    result.addAll(names);

    List<UIMedicineMark> inns =
        await searchMedicineMarkInn(query).then((value) => value.map((markInn) {
              String inn = markInn.innRu;
              if (langCode == "en") {
                inn = markInn.innEn;
              }
              return UIMedicineMark(inn, markInn.innEn, UIMedicineMarkSearchResultType.INN);
            }).toList());
    result.addAll(inns);

    return result;
  }

  Future<List<UIMedicineMark>> searchMedicineMarkNames(String query) async {
    String langCode = await LocalizationPref.getLanguage();
    return await searchMedicineMarkName(query).then((value) => value.map((medicineMarkName) {
          String name = medicineMarkName.nameRu;
          if (langCode == "uz") {
            name = medicineMarkName.nameUz;
          } else if (langCode == "en") {
            name = medicineMarkName.nameEn;
          }
          return UIMedicineMark(name, medicineMarkName.nameEn, UIMedicineMarkSearchResultType.NAME);
        }).toList());
  }

  Future<List<UIMedicineMark>> searchMedicineMarkInns(String query) async {
    String langCode = await LocalizationPref.getLanguage();
    return await searchMedicineMarkInn(query).then((value) => value.map((markInn) {
          String inn = markInn.innRu;
          if (langCode == "en") {
            inn = markInn.innEn;
          }
          return UIMedicineMark(inn,markInn.innEn, UIMedicineMarkSearchResultType.INN);
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

  UIMedicineMarkInn(this.innRu, this.innEn);
}

class UIMedicineMark {
  final String title;
  final String sendServerText;
  final UIMedicineMarkSearchResultType type;

  UIMedicineMark(this.title, this.sendServerText, this.type);
}

enum UIMedicineMarkSearchResultType { NAME, INN }
