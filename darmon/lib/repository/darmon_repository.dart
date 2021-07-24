import 'package:darmon/common/string_util.dart';
import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/network/network_manager.dart';
import 'package:darmon/repository/bean.dart';
import 'package:darmon/ui/medicine_item/medicine_item_models.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class DarmonRepository {
  UIDarmonDao dao;

  DarmonRepository(this.dao);

  Future<List<UIMedicineMarkName>> searchMedicineMarkName(String query, String latinQuery,
      {int limit}) async {
    return dao.searchMedicineMarkName(query.trim(), latinQuery, limit: limit).then(
        (value) => value.map((e) => UIMedicineMarkName(e.nameRu, e.nameUz, e.nameEn)).toList());
  }

  Future<List<UIMedicineMarkInn>> searchMedicineMarkInn(String query, String latinQuery,
      {int limit}) async {
    return dao
        .searchMedicineMarkInn(query.trim(), latinQuery, limit: limit)
        .then((value) => value.map((e) => UIMedicineMarkInn(e.innRu, e.innEn, e.innIds)).toList());
  }

  Future<List<UIMedicineMark>> searchMedicineMark(String query) async {
    List<UIMedicineMark> result = [];
    String langCode = await LocalizationPref.getLanguage();
    String latinQuery = StringUtil.cyrillToLatin(query?.trim() ?? "");

    List<UIMedicineMark> names = await searchMedicineMarkName(query, latinQuery)
        .then((value) => value.map((medicineMarkName) {
              String name = medicineMarkName.nameRu;
              if (langCode == "uz") {
                name = medicineMarkName.nameUz;
              } else if (langCode == "en") {
                name = medicineMarkName.nameEn;
              }
              return UIMedicineMark(
                  name,
                  latinQuery,
                  medicineMarkName.nameRu,
                  medicineMarkName.nameUz,
                  medicineMarkName.nameEn,
                  medicineMarkName.nameEn,
                  UIMedicineMarkSearchResultType.NAME);
            }).toList());
    result.addAll(names);

    List<UIMedicineMark> inns =
        await searchMedicineMarkInn(query, latinQuery).then((value) => value.map((markInn) {
              String inn = markInn.innRu;
              if (langCode == "en") {
                inn = markInn.innEn;
              }
              return UIMedicineMark(
                inn,
                latinQuery,
                markInn.innRu,
                markInn.innEn,
                markInn.innEn,
                markInn.innIds,
                UIMedicineMarkSearchResultType.INN,
              );
            }).toList());
    result.addAll(inns);

    return result;
  }

  Future<List<UIMedicineMark>> searchMedicineMarkNames(String query, {int limit}) async {
    String langCode = await LocalizationPref.getLanguage();
    String latinQuery = StringUtil.cyrillToLatin(query?.trim() ?? "");

    return await searchMedicineMarkName(query, latinQuery, limit: limit)
        .then((value) => value.map((medicineMarkName) {
              String name = medicineMarkName.nameRu;
              if (langCode == "uz") {
                name = medicineMarkName.nameUz;
              } else if (langCode == "en") {
                name = medicineMarkName.nameEn;
              }
              return UIMedicineMark(
                  name,
                  latinQuery,
                  medicineMarkName.nameRu,
                  medicineMarkName.nameUz,
                  medicineMarkName.nameEn,
                  medicineMarkName.nameEn,
                  UIMedicineMarkSearchResultType.NAME);
            }).toList());
  }

  Future<List<UIMedicineMark>> searchMedicineMarkInns(String query, {int limit}) async {
    Log.debug("searchMedicineMarkInns($query)");
    String langCode = await LocalizationPref.getLanguage();
    String latinQuery = StringUtil.cyrillToLatin(query?.trim() ?? "");

    return await searchMedicineMarkInn(query, latinQuery, limit: limit)
        .then((value) => value.map((markInn) {
              String inn = markInn.innRu;
              if (langCode == "en") {
                inn = markInn.innEn;
              }

              return UIMedicineMark(
                inn,
                latinQuery,
                markInn.innRu,
                markInn.innEn,
                markInn.innEn,
                markInn.innIds,
                UIMedicineMarkSearchResultType.INN,
              );
            }).toList());
  }

  Future<MedicineItem> loadMedicineItem(String medicineId) async {
    String langCode = await LocalizationPref.getLanguage();
    final body = {"box_group_id": medicineId, "lang": langCode};
    Map<String, dynamic> result = await NetworkManager.medicineItem(body);
    return MedicineItem.fromData(result);
  }

  Future<MedicineItemInstruction> loadMedicineInstruction(String medicineId) async {
    String langCode = await LocalizationPref.getLanguage();
    final body = {"box_group_id": medicineId, "lang": langCode};
    Map<String, dynamic> result = await NetworkManager.medicineInstruction(body);
    return MedicineItemInstruction.fromData(result);
  }
}
