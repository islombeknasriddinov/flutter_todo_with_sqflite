import 'package:darmon/filter/kernel/tables/filter_fields.dart';
import 'package:darmon/filter/kernel/tables/filters.dart';
import 'package:gwslib/log/logger.dart';
import 'package:sqflite/sqflite.dart';

class MyFilterUtil {
  ///load all filter. Filters filtered by [filterName]
  ///[filterName] filter name
  ///
  /// @return filtered Filter list
  static Future<List<MyFilters>> loadFilers(Database db, String filterName) {
    return db.query(MyFilters.TABLE_NAME,
        where: "${MyFilters.C_FILTER_NAME} = ?",
        whereArgs: [filterName]).then((value) => value.map((e) => MyFilters.fromData(e)).toList());
  }

  ///load all filter fields. Fields filtered by [filterName] and [filterCode]
  /// [filterName] filter name
  /// [filterCode] filter code
  ///
  /// @return Future<List<MyFilterFields>> result
  static Future<List<MyFilterFields>> loadFilerFields(
      Database db, String filterName, String filterCode) {
    return db.query(MyFilterFields.TABLE_NAME,
        where: "${MyFilterFields.C_FILTER_NAME} = ? AND ${MyFilterFields.C_FILTER_CODE} = ?",
        whereArgs: [
          filterName,
          filterCode
        ]).then((value) => value.map((e) => MyFilterFields.fromData(e)).toList());
  }

  ///remove all filters and filter fields by [filterName]
  ///[filterName] filter unique key
  ///
  /// @return Future<bool> if delete successfully return true else return false
  static Future<bool> clear(Database db, String filterName) async {
    try {
      await db.delete(MyFilters.TABLE_NAME,
          where: "${MyFilters.C_FILTER_NAME} = ?", whereArgs: [filterName]);

      await db.delete(MyFilterFields.TABLE_NAME,
          where: "${MyFilterFields.C_FILTER_NAME} = ?", whereArgs: [filterName]);
      return true;
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      return false;
    }
  }
}
