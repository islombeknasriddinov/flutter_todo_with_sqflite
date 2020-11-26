import 'package:darmon/common/soundex.dart';
import 'package:darmon/common/string_util.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_inn.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:sqflite/sqflite.dart';

class UIDarmonDao {
  Database db;

  UIDarmonDao(this.db);

  Future<List<ZMedicineMarkName>> searchMedicineMarkName(String query,
      {int limit}) async {
    if (query == null || query.isEmpty) return [];
    String querySoundex = Soundex.soundex(query);

    String latinQuery = StringUtil.cyrillToLatin(query);
    String latinSoundex = Soundex.soundex(latinQuery);
    final sql = """
    SELECT t.* 
          FROM ${ZMedicineMarkName.TABLE_NAME} t
       WHERE t.${ZMedicineMarkName.C_NAME_RU_SOUNDEX} = '$querySoundex'
          OR t.${ZMedicineMarkName.C_NAME_EN_SOUNDEX} = '$latinSoundex'
          OR t.${ZMedicineMarkName.C_NAME_UZ_SOUNDEX} = '$latinSoundex'
          OR t.${ZMedicineMarkName.C_NAME_EN} LIKE '%$latinQuery%'
          OR t.${ZMedicineMarkName.C_NAME_RU} LIKE '%$query%'
          OR t.${ZMedicineMarkName.C_NAME_UZ} LIKE '%$latinQuery%'
       ORDER BY t.${ZMedicineMarkName.C_NAME_EN} ASC
       LIMIT ${limit ?? 5}
    """;

    return db.rawQuery(sql).then(
        (value) => value.map((e) => ZMedicineMarkName.fromData(e)).toList());
  }

  Future<List<ZMedicineMarkInn>> searchMedicineMarkInn(String query,
      {int limit}) async {
    if (query == null || query.isEmpty) return [];
    String querySoundex = Soundex.soundex(query);

    String latinQuery = StringUtil.cyrillToLatin(query);
    String latinSoundex = Soundex.soundex(latinQuery);

    final sql = """
    SELECT t.* 
          FROM ${ZMedicineMarkInn.TABLE_NAME} t
       WHERE t.${ZMedicineMarkInn.C_INN_RU_SOUNDEX} = '$querySoundex'
          OR t.${ZMedicineMarkInn.C_INN_EN_SOUNDEX} = '$latinSoundex'
          OR t.${ZMedicineMarkInn.C_INN_RU} LIKE '%$query%'
          OR t.${ZMedicineMarkInn.C_INN_EN} LIKE '%$query%'
          LIMIT ${limit ?? 5}
    """;
    return db.rawQuery(sql).then(
        (value) => value.map((e) => ZMedicineMarkInn.fromData(e)).toList());
  }
}
