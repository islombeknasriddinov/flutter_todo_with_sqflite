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
    return dao.searchMedicineMarkName(query.trim()).then(
        (value) => value.map((e) => UIMedicineMarkName(e.nameRu, e.nameUz, e.nameEn)).toList());
  }

  Future<List<UIMedicineMarkInn>> searchMedicineMarkInn(String query) async {
    return dao
        .searchMedicineMarkInn(query.trim())
        .then((value) => value.map((e) => UIMedicineMarkInn(e.inn)).toList());
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
              return UIMedicineMark(name, UIMedicineMarkSearchResultType.NAME);
            }).toList());
    result.addAll(names);

    List<UIMedicineMark> inns =
        await searchMedicineMarkInn(query).then((value) => value.map((inn) {
              return UIMedicineMark(inn.inn, UIMedicineMarkSearchResultType.INN);
            }).toList());
    result.addAll(inns);

    return result;
  }
}

class UIMedicineMarkName {
  final String nameRu;
  final String nameUz;
  final String nameEn;

  UIMedicineMarkName(this.nameRu, this.nameUz, this.nameEn);
}

class UIMedicineMarkInn {
  final String inn;

  UIMedicineMarkInn(this.inn);
}

class UIMedicineMark {
  final String title;
  final UIMedicineMarkSearchResultType type;

  UIMedicineMark(this.title, this.type);
}

enum UIMedicineMarkSearchResultType { NAME, INN }
