import 'package:darmon/filter/kernel/tables/filter_fields.dart';
import 'package:darmon/filter/kernel/tables/filters.dart';
import 'package:sqflite/sqflite.dart';

class MyFilterCore {
  ///save Filter to [MyFilters] table. filter is make unique [filterName] and [filterCode]
  ///[filterName] filter name
  ///[filterCode] filter unique code inside [filterName]
  ///[type] filter type. all types [MyFilterPref] inside
  ///[value] filter value
  ///[query] filter custom query
  ///
  /// @return Future<bool> if saved successfully return true else return false
  static Future<bool> saveFilter(
      Database db, String filterName, String filterCode, String type, String value,
      {String query}) async {
    await Z_MyFilters.saveOne(db,
        filterName: filterName,
        filterCode: filterCode,
        filterType: type,
        filterValue: value,
        query: query);
    return true;
  }

  ///save filter field to [MyFilterFields] table. filter is make unique [filterName], [filterCode] and [filterFieldId]
  ///[filterName] filter name
  ///[filterCode] filter unique code inside [filterName]
  ///[filterFieldId] filter field unique key
  ///[filterFieldValue]filter field value
  ///
  /// @return Future<bool> if saved successfully return true else return false
  static Future<bool> saveFilterField(
      Database db, String filterName, String filterCode, String filterFieldId,
      {String filterFieldValue}) async {
    await Z_MyFilterFields.insertOne(db,
        filterName: filterName,
        filterCode: filterCode,
        filterFieldId: filterFieldId,
        filterFieldValue: filterFieldValue);

    return true;
  }
}
