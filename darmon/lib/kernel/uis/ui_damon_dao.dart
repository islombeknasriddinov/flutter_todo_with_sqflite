import 'package:darmon/kernel/medicine/tables/medicine.dart';
import 'package:sqflite/sqflite.dart';

class UIDarmonDao {
  Database db;

  UIDarmonDao(this.db);

  Future<List<ZMedicine>> searchMedicine(String query, {int limit = 5}) async {
    final sql = """
    SELECT t.* 
          FROM ${ZMedicine.TABLE_NAME} t
       WHERE t.${ZMedicine.C_NAME_EN} LIKE '%$query%'
          OR t.${ZMedicine.C_NAME_UZ} LIKE '%$query%'
          OR t.${ZMedicine.C_NAME_RU} LIKE '%$query%'
          OR t.${ZMedicine.C_PRODUCER_NAME} LIKE '%$query%'
       ORDER BY t.${ZMedicine.C_NAME_EN} ASC
       LIMIT $limit;
    """;

    return db.rawQuery(sql).then((value) => value.map((e) => ZMedicine.fromData(e)).toList());
  }
}
