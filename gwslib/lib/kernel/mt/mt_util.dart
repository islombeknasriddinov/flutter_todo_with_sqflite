import 'package:gwslib/kernel/database.dart';
import 'package:gwslib/kernel/mt/tables/translates.dart';
import 'package:sqflite/sqflite.dart';

class MtUtil {
  static Database get db => MoldDatabase.instance();

  static Future<Map<String, String>> loadAllTranslates(String langCode) {
    return db.rawQuery("""
    SELECT t.${MtTranslates.C_TRANSLATE_CODE},
           t.text_$langCode as text
      FROM ${MtTranslates.TABLE_NAME} t
    """).then<Map<String, String>>((value) {
      Map<String, String> data = <String, String>{};
      value.forEach((e) {
        data[e[MtTranslates.C_TRANSLATE_CODE]] = e["text"].toString();
      });
      return data;
    });
  }
}
