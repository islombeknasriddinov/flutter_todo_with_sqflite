// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class MyFilters {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "my_filters";
	// ignore: non_constant_identifier_names
	static const String C_FILTER_NAME = "filter_name";
	// ignore: non_constant_identifier_names
	static const String C_FILTER_CODE = "filter_code";
	// ignore: non_constant_identifier_names
	static const String C_FILTER_TYPE = "filter_type";
	// ignore: non_constant_identifier_names
	static const String C_FILTER_VALUE = "filter_value";
	// ignore: non_constant_identifier_names
	static const String C_QUERY = "query";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table my_filters (
	  filter_name              text not null,
	  filter_code              text not null,
	  filter_type              text not null,
	  filter_value             text,
	  query                    text,
	  constraint my_filters primary key (filter_name, filter_code),
	  constraint my_filters_u1 unique (filter_name, filter_code)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String filterName, String filterCode, String filterType) {
		ArgumentError.checkNotNull(filterName, C_FILTER_NAME);
		ArgumentError.checkNotNull(filterCode, C_FILTER_CODE);
		ArgumentError.checkNotNull(filterType, C_FILTER_TYPE);
	}

	static void checkPrimaryKeys(String filterName, String filterCode) {
		ArgumentError.checkNotNull(filterName, C_FILTER_NAME);
		ArgumentError.checkNotNull(filterCode, C_FILTER_CODE);
	}

	//------------------------------------------------------------------------------------------------

	final String filterName;
	final String filterCode;
	final String filterType;
	final String filterValue;
	final String query;

	MyFilters({@required this.filterName, @required this.filterCode, @required this.filterType, this.filterValue, this.query}) {
		checkPrimaryKeys(filterName, filterCode);
	}

	factory MyFilters.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_FILTER_NAME], data[C_FILTER_CODE]);
		return MyFilters(
			filterName: data[C_FILTER_NAME],
			filterCode: data[C_FILTER_CODE],
			filterType: data[C_FILTER_TYPE],
			filterValue: data[C_FILTER_VALUE],
			query: data[C_QUERY],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_FILTER_NAME: this.filterName,
			C_FILTER_CODE: this.filterCode,
			C_FILTER_TYPE: this.filterType,
			C_FILTER_VALUE: this.filterValue,
			C_QUERY: this.query,
		};
	}

	@override
	String toString() {
		 return "MyFilters($C_FILTER_NAME:$filterName, $C_FILTER_CODE:$filterCode, $C_FILTER_TYPE:$filterType, $C_FILTER_VALUE:$filterValue, $C_QUERY:$query)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_MyFilters {

	// init
	static MyFilters init({@required String filterName, @required String filterCode, @required String filterType, String filterValue, String query}) {
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		return new MyFilters(filterName: filterName, filterCode: filterCode, filterType: filterType, filterValue: filterValue, query: query);
	}

	// load all rows in database
	static Future<List<MyFilters>> loadAll(Database db) {
		return db.query(MyFilters.TABLE_NAME)
			.then((it) => it.map((d) => MyFilters.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<MyFilters> take(Database db, String filterName, String filterCode) async {
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		final result = await db.query(MyFilters.TABLE_NAME, where: "${MyFilters.C_FILTER_NAME} = ? AND ${MyFilters.C_FILTER_CODE} = ?", whereArgs: [filterName, filterCode]);
		return result.isEmpty ? null : MyFilters.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<MyFilters> load(Database db, String filterName, String filterCode) async {
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		final result = await take(db, filterName, filterCode);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, String filterName, String filterCode) {
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		return take(db, filterName, filterCode).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, String filterName, String filterCode, void onResult(MyFilters row)) async {
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		ArgumentError.checkNotNull(onResult, "OnResult");
		final result = await take(db, filterName, filterCode);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateRow(Database db, MyFilters row, {bool removeNull = false}) {
		MyFilters.checkPrimaryKeys(row.filterName, row.filterCode);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.update(MyFilters.TABLE_NAME, data, where: "${MyFilters.C_FILTER_NAME} = ? AND ${MyFilters.C_FILTER_CODE} = ?", whereArgs: [row.filterName, row.filterCode]);
	}

	// update by one
	static Future<int> updateOne(Database db, {@required String filterName, @required String filterCode, String filterType, String filterValue, String query, bool removeNull = false}) {
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		return updateRow(db, toRowFromList(values: [filterName, filterCode, filterType, filterValue, query]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(Database db, MyFilters row, {bool removeNull = false}) {
		MyFilters.checkPrimaryKeys(row.filterName, row.filterCode);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(MyFilters.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required String filterName, @required String filterCode, @required String filterType, String filterValue, String query, bool removeNull = false}) {
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		return saveRow(db, toRowFromList(values: [filterName, filterCode, filterType, filterValue, query]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(MyFilters.TABLE_NAME);
	}

	// delete row by primary key
	static Future<int> deleteOne(Database db, String filterName, String filterCode) {
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		return db.delete(MyFilters.TABLE_NAME, where: "${MyFilters.C_FILTER_NAME} = ? AND ${MyFilters.C_FILTER_CODE} = ?", whereArgs: [filterName, filterCode]);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, MyFilters row) {
		MyFilters.checkRequired(row.filterName, row.filterCode, row.filterType);
		return db.insert(MyFilters.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String filterName, @required String filterCode, @required String filterType, String filterValue, String query}) {
		MyFilters.checkRequired(filterName, filterCode, filterType);
		return insertRowTry(db, toRowFromList(values: [filterName, filterCode, filterType, filterValue, query]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, MyFilters row) {
		MyFilters.checkRequired(row.filterName, row.filterCode, row.filterType);
		return db.insert(MyFilters.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String filterName, @required String filterCode, @required String filterType, String filterValue, String query}) {
		MyFilters.checkRequired(filterName, filterCode, filterType);
		return insertRow(db, toRowFromList(values: [filterName, filterCode, filterType, filterValue, query]));
	}

	// to map
	static Map<String, dynamic> toMap({MyFilters row, String f1, String f2, String f3, String f4, String f5, String filterName, String filterCode, String filterType, String filterValue, String query}) {
		filterName = nvl(row?.filterName, filterName);
		filterCode = nvl(row?.filterCode, filterCode);
		filterType = nvl(row?.filterType, filterType);
		filterValue = nvl(row?.filterValue, filterValue);
		query = nvl(row?.query, query);
		MyFilters.checkRequired(filterName, filterCode, filterType);
		return {nvlString(f1, MyFilters.C_FILTER_NAME): filterName, nvlString(f2, MyFilters.C_FILTER_CODE): filterCode, nvlString(f3, MyFilters.C_FILTER_TYPE): filterType, nvlString(f4, MyFilters.C_FILTER_VALUE): filterValue, nvlString(f5, MyFilters.C_QUERY): query};
	}

	// to list
	static List<dynamic> toList({MyFilters row, String filterName, String filterCode, String filterType, String filterValue, String query}) {
		filterName = nvl(row?.filterName, filterName);
		filterCode = nvl(row?.filterCode, filterCode);
		filterType = nvl(row?.filterType, filterType);
		filterValue = nvl(row?.filterValue, filterValue);
		query = nvl(row?.query, query);
		MyFilters.checkRequired(filterName, filterCode, filterType);
		return [filterName, filterCode, filterType, filterValue, query];
	}

	// to row from map
	static MyFilters toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String f5, String filterName, String filterCode, String filterType, String filterValue, String query}) {
		filterName = nvl(data == null ? null : data[nvl(f1, MyFilters.C_FILTER_NAME)], filterName);
		filterCode = nvl(data == null ? null : data[nvl(f2, MyFilters.C_FILTER_CODE)], filterCode);
		filterType = nvl(data == null ? null : data[nvl(f3, MyFilters.C_FILTER_TYPE)], filterType);
		filterValue = nvl(data == null ? null : data[nvl(f4, MyFilters.C_FILTER_VALUE)], filterValue);
		query = nvl(data == null ? null : data[nvl(f5, MyFilters.C_QUERY)], query);
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		return new MyFilters(filterName: filterName, filterCode: filterCode, filterType: filterType, filterValue: filterValue, query: query);
	}

	// to row from list
	static MyFilters toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4, String f5}) {
		final filterName = values[keys?.indexOf(nvl(f1, MyFilters.C_FILTER_NAME)) ?? 0];
		final filterCode = values[keys?.indexOf(nvl(f2, MyFilters.C_FILTER_CODE)) ?? 1];
		final filterType = values[keys?.indexOf(nvl(f3, MyFilters.C_FILTER_TYPE)) ?? 2];
		final filterValue = values[keys?.indexOf(nvl(f4, MyFilters.C_FILTER_VALUE)) ?? 3];
		final query = values[keys?.indexOf(nvl(f5, MyFilters.C_QUERY)) ?? 4];
		MyFilters.checkPrimaryKeys(filterName, filterCode);
		return new MyFilters(filterName: filterName, filterCode: filterCode, filterType: filterType, filterValue: filterValue, query: query);
	}

	// to row from list strings
	static MyFilters toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4, String f5}) {
		dynamic filterName = values[keys?.indexOf(nvl(f1, MyFilters.C_FILTER_NAME)) ?? 0];
		dynamic filterCode = values[keys?.indexOf(nvl(f2, MyFilters.C_FILTER_CODE)) ?? 1];
		dynamic filterType = values[keys?.indexOf(nvl(f3, MyFilters.C_FILTER_TYPE)) ?? 2];
		dynamic filterValue = values[keys?.indexOf(nvl(f4, MyFilters.C_FILTER_VALUE)) ?? 3];
		dynamic query = values[keys?.indexOf(nvl(f5, MyFilters.C_QUERY)) ?? 4];

		MyFilters.checkPrimaryKeys(filterName, filterCode);
		return new MyFilters(filterName: filterName, filterCode: filterCode, filterType: filterType, filterValue: filterValue, query: query);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
