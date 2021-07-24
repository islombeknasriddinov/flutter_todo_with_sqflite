import 'package:darmon/filter/kernel/my_filter_pref.dart';
import 'package:darmon/filter/kernel/my_filter_util.dart';
import 'package:darmon/filter/kernel/tables/filter_fields.dart';
import 'package:darmon/filter/kernel/tables/filters.dart';
import 'package:darmon/filter/main/filter_helper.dart';
import 'package:gwslib/gwslib.dart';
import 'package:sqflite/sqflite.dart';

abstract class FilterDao extends FilterController {
  Database db;
  String filterName;

  FilterDao(this.db, this.filterName) : super(db, filterName);

  Future<List<Map<String, dynamic>>> query(String table,
          {bool distinct,
          List<String> columns,
          String where,
          List<dynamic> whereArgs,
          String groupBy,
          String having,
          String orderBy,
          int limit,
          int offset}) =>
      db.query(table,
          distinct: distinct,
          columns: columns,
          where: where,
          whereArgs: whereArgs,
          limit: limit,
          orderBy: orderBy,
          groupBy: groupBy,
          having: having,
          offset: offset);

  Future<List<Map<String, dynamic>>> filterQuery(String sql, [List<dynamic> arguments]) async {
    String filterQueries = await generateFilterQuery();

    String query =
        filterQueries?.isNotEmpty == true ? "SELECT * FROM ($sql) WHERE $filterQueries" : sql;
    Log.debug(filterQueries);
    return db.rawQuery(query, arguments);
  }

  String addQuery(String oldQuery, String q) {
    return q?.isNotEmpty == true
        ? (oldQuery?.isNotEmpty == true ? " $oldQuery AND $q" : q)
        : oldQuery;
  }

  Future<int> rawUpdate(String sql, [List<dynamic> arguments]) => db.rawUpdate(sql, arguments);

  Future<int> update(String table, Map<String, dynamic> values,
          {String where, List<dynamic> whereArgs, ConflictAlgorithm conflictAlgorithm}) =>
      db.update(table, values, where: where, whereArgs: whereArgs);

  Future<int> rawDelete(String sql, [List<dynamic> arguments]) => db.rawDelete(sql, arguments);

  Future<int> delete(String table, {String where, List<dynamic> whereArgs}) =>
      db.delete(table, where: where, whereArgs: whereArgs);

  Batch batch() => db.batch();

  Future<String> generateFilterQuery() async {
    String result = "";
    if (filterName?.isNotEmpty == true) {
      List<MyFilters> myFilters = await MyFilterUtil.loadFilers(db,filterName);
      for (MyFilters myFilter in myFilters) {
        switch (myFilter.filterType) {
          case MyFilterPref.EQUAL_INT:
            if (myFilter.filterValue?.isNotEmpty == true)
              result = addQuery(result, "${myFilter.filterCode} = ${myFilter.filterValue}");
            break;
          case MyFilterPref.EQUAL_STRING:
            if (myFilter.filterValue?.isNotEmpty == true)
              result = addQuery(result, "${myFilter.filterCode} = '${myFilter.filterValue}'");
            break;
          case MyFilterPref.LIKE:
            if (myFilter.filterValue?.isNotEmpty == true)
              result = addQuery(result, "${myFilter.filterCode} LIKE '%${myFilter.filterValue}%'");
            break;
          case MyFilterPref.CUSTOM:
            if (myFilter.query?.isNotEmpty == true) result = addQuery(result, myFilter.query);
            break;
          case MyFilterPref.IN:
            List<MyFilterFields> fields =
                await MyFilterUtil.loadFilerFields(db,myFilter.filterName, myFilter.filterCode);
            if (fields?.isNotEmpty == true)
              result = addQuery(result,
                  "${myFilter.filterCode} IN (${fields.map((e) => e.filterFieldId).join(", ")})");
            break;

          case MyFilterPref.DATE_RANGE:
          case MyFilterPref.TIME_RANGE:
          case MyFilterPref.DATE_TIME_RANGE:
            List<MyFilterFields> fields =
                await MyFilterUtil.loadFilerFields(db,myFilter.filterName, myFilter.filterCode);
            String format = myFilter.filterType == MyFilterPref.DATE_RANGE
                ? "YYYY-MM-DD"
                : (myFilter.filterType == MyFilterPref.DATE_TIME_RANGE
                    ? "YYYY-MM-DD HH:MM:SS"
                    : (myFilter.filterType == MyFilterPref.TIME_RANGE ? "HH:MM:SS" : ""));
            if (format.isEmpty) throw Exception("Not supported TYPE");
            if (fields.where((element) => element.filterFieldValue?.isNotEmpty == true).length ==
                2) {
              result = addQuery(result,
                  "date(${myFilter.filterCode}, '$format') BETWEEN date(${fields.first.filterFieldValue},'$format') AND date(${fields[1].filterFieldValue},'$format')");
            } else if (fields.length == 2 && fields.first?.filterFieldValue?.isNotEmpty == true) {
              result = addQuery(result,
                  "date(${myFilter.filterCode}, '$format') > date(${fields.first.filterFieldValue},'$format')");
            } else if (fields.length == 2 && fields[1]?.filterFieldValue?.isNotEmpty == true) {
              result = addQuery(result,
                  "date(${myFilter.filterCode}, '$format') < date(${fields.first.filterFieldValue},'$format')");
            }
            break;
          case MyFilterPref.INT_RANGE:
            List<MyFilterFields> fields =
                await MyFilterUtil.loadFilerFields(db,myFilter.filterName, myFilter.filterCode);

            if (fields.where((element) => element.filterFieldValue?.isNotEmpty == true).length ==
                2) {
              result = addQuery(result,
                  "${myFilter.filterCode} BETWEEN ${fields.first.filterFieldValue} AND ${fields[1].filterFieldValue}");
            } else if (fields.length == 2 && fields.first?.filterFieldValue?.isNotEmpty == true) {
              result =
                  addQuery(result, "${myFilter.filterCode} > ${fields.first.filterFieldValue}");
            } else if (fields.length == 2 && fields[1]?.filterFieldValue?.isNotEmpty == true) {
              result =
                  addQuery(result, "${myFilter.filterCode} < ${fields.first.filterFieldValue}");
            }
            break;
          case MyFilterPref.CUSTOM_IN:
            List<MyFilterFields> fields =
                await MyFilterUtil.loadFilerFields(db,myFilter.filterName, myFilter.filterCode);
            if (fields?.isNotEmpty == true)
              result = addQuery(result,
                  myFilter?.query?.replaceAll("?", fields.map((e) => e.filterFieldId).join(", ")));
            break;
        }
      }
    }
    return result;
  }
}
