import 'package:darmon/kernel/medicine/tables/medicine_mark_inn.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:sqflite/sqflite.dart';

class UIDarmonDao {
  Database db;

  UIDarmonDao(this.db);

  Future<List<ZMedicineMarkName>> searchMedicineMarkName(String query, {int limit = 5}) async {
    final sql = """
    SELECT t.* 
          FROM ${ZMedicineMarkName.TABLE_NAME} t
       WHERE t.${ZMedicineMarkName.C_NAME_EN} LIKE '%$query%'
          OR t.${ZMedicineMarkName.C_NAME_UZ} LIKE '%$query%'
          OR t.${ZMedicineMarkName.C_NAME_RU} LIKE '%$query%'
       ORDER BY t.${ZMedicineMarkName.C_NAME_EN} ASC
       LIMIT $limit;
    """;

    return db
        .rawQuery(sql)
        .then((value) => value.map((e) => ZMedicineMarkName.fromData(e)).toList());
  }

  Future<List<ZMedicineMarkInn>> searchMedicineMarkInn(String query, {int limit = 5}) async {
    final sql = """
    SELECT t.* 
          FROM ${ZMedicineMarkInn.TABLE_NAME} t
       WHERE t.${ZMedicineMarkInn.C_INN} LIKE '%$query%'
          LIMIT $limit;
    """;
    return db
        .rawQuery(sql)
        .then((value) => value.map((e) => ZMedicineMarkInn.fromData(e)).toList());
  }
}
