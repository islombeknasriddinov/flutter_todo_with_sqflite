import 'package:gwslib/kernel/database.dart';
import 'package:gwslib/kernel/mt/tables/translates.dart';
import 'package:sqflite/sqflite.dart';

class MtApi {
  static Database get db => MoldDatabase.instance();

  static Future<void> saveTranslates(String langCode, List<dynamic> translates) async {
    var batch = db.batch();
    for (List<dynamic> item in translates) {
      final data = {
        MtTranslates.C_PROJECT_CODE: item[0].toString(),
        MtTranslates.C_TRANSLATE_CODE: item[1].toString(),
        "text_$langCode": item[2].toString()
      };
      batch.insert(MtTranslates.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }
}
