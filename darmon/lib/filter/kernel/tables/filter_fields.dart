// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class MyFilterFields {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "my_filter_fields";
	// ignore: non_constant_identifier_names
	static const String C_FILTER_NAME = "filter_name";
	// ignore: non_constant_identifier_names
	static const String C_FILTER_CODE = "filter_code";
	// ignore: non_constant_identifier_names
	static const String C_FILTER_FIELD_ID = "filter_field_id";
	// ignore: non_constant_identifier_names
	static const String C_FILTER_FIELD_VALUE = "filter_field_value";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table my_filter_fields (
	  filter_name              text not null,
	  filter_code              text not null,
	  filter_field_id          text not null,
	  filter_field_value       text ,
	  constraint my_filter_fields primary key (filter_name, filter_code,filter_field_id),
	  constraint my_filter_fields_u1 unique (filter_name, filter_code,filter_field_id)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String filterName, String filterCode, String filterFieldId) {
		ArgumentError.checkNotNull(filterName, C_FILTER_NAME);
		ArgumentError.checkNotNull(filterCode, C_FILTER_CODE);
		ArgumentError.checkNotNull(filterFieldId, C_FILTER_FIELD_ID);
	}

	static void checkPrimaryKeys(String filterName, String filterCode, String filterFieldId) {
		ArgumentError.checkNotNull(filterName, C_FILTER_NAME);
		ArgumentError.checkNotNull(filterCode, C_FILTER_CODE);
		ArgumentError.checkNotNull(filterFieldId, C_FILTER_FIELD_ID);
	}

	//------------------------------------------------------------------------------------------------

	final String filterName;
	final String filterCode;
	final String filterFieldId;
	final String filterFieldValue;

	MyFilterFields({@required this.filterName, @required this.filterCode, @required this.filterFieldId, this.filterFieldValue}) {
		checkPrimaryKeys(filterName, filterCode, filterFieldId);
	}

	factory MyFilterFields.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_FILTER_NAME], data[C_FILTER_CODE], data[C_FILTER_FIELD_ID]);
		return MyFilterFields(
			filterName: data[C_FILTER_NAME],
			filterCode: data[C_FILTER_CODE],
			filterFieldId: data[C_FILTER_FIELD_ID],
			filterFieldValue: data[C_FILTER_FIELD_VALUE],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_FILTER_NAME: this.filterName,
			C_FILTER_CODE: this.filterCode,
			C_FILTER_FIELD_ID: this.filterFieldId,
			C_FILTER_FIELD_VALUE: this.filterFieldValue,
		};
	}

	@override
	String toString() {
		 return "MyFilterFields($C_FILTER_NAME:$filterName, $C_FILTER_CODE:$filterCode, $C_FILTER_FIELD_ID:$filterFieldId, $C_FILTER_FIELD_VALUE:$filterFieldValue)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_MyFilterFields {

	// init
	static MyFilterFields init({@required String filterName, @required String filterCode, @required String filterFieldId, String filterFieldValue}) {
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		return new MyFilterFields(filterName: filterName, filterCode: filterCode, filterFieldId: filterFieldId, filterFieldValue: filterFieldValue);
	}

	// load all rows in database
	static Future<List<MyFilterFields>> loadAll(Database db) {
		return db.query(MyFilterFields.TABLE_NAME)
			.then((it) => it.map((d) => MyFilterFields.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<MyFilterFields> take(Database db, String filterName, String filterCode, String filterFieldId) async {
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		final result = await db.query(MyFilterFields.TABLE_NAME, where: "${MyFilterFields.C_FILTER_NAME} = ? AND ${MyFilterFields.C_FILTER_CODE} = ? AND ${MyFilterFields.C_FILTER_FIELD_ID} = ?", whereArgs: [filterName, filterCode, filterFieldId]);
		return result.isEmpty ? null : MyFilterFields.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<MyFilterFields> load(Database db, String filterName, String filterCode, String filterFieldId) async {
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		final result = await take(db, filterName, filterCode, filterFieldId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, String filterName, String filterCode, String filterFieldId) {
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		return take(db, filterName, filterCode, filterFieldId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, String filterName, String filterCode, String filterFieldId, void onResult(MyFilterFields row)) async {
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		ArgumentError.checkNotNull(onResult, "OnResult");
		final result = await take(db, filterName, filterCode, filterFieldId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateRow(Database db, MyFilterFields row, {bool removeNull = false}) {
		MyFilterFields.checkPrimaryKeys(row.filterName, row.filterCode, row.filterFieldId);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.update(MyFilterFields.TABLE_NAME, data, where: "${MyFilterFields.C_FILTER_NAME} = ? AND ${MyFilterFields.C_FILTER_CODE} = ? AND ${MyFilterFields.C_FILTER_FIELD_ID} = ?", whereArgs: [row.filterName, row.filterCode, row.filterFieldId]);
	}

	// update by one
	static Future<int> updateOne(Database db, {@required String filterName, @required String filterCode, @required String filterFieldId, String filterFieldValue, bool removeNull = false}) {
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		return updateRow(db, toRowFromList(values: [filterName, filterCode, filterFieldId, filterFieldValue]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(Database db, MyFilterFields row, {bool removeNull = false}) {
		MyFilterFields.checkPrimaryKeys(row.filterName, row.filterCode, row.filterFieldId);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(MyFilterFields.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required String filterName, @required String filterCode, @required String filterFieldId, String filterFieldValue, bool removeNull = false}) {
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		return saveRow(db, toRowFromList(values: [filterName, filterCode, filterFieldId, filterFieldValue]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(MyFilterFields.TABLE_NAME);
	}

	// delete row by primary key
	static Future<int> deleteOne(Database db, String filterName, String filterCode, String filterFieldId) {
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		return db.delete(MyFilterFields.TABLE_NAME, where: "${MyFilterFields.C_FILTER_NAME} = ? AND ${MyFilterFields.C_FILTER_CODE} = ? AND ${MyFilterFields.C_FILTER_FIELD_ID} = ?", whereArgs: [filterName, filterCode, filterFieldId]);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, MyFilterFields row) {
		MyFilterFields.checkRequired(row.filterName, row.filterCode, row.filterFieldId);
		return db.insert(MyFilterFields.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String filterName, @required String filterCode, @required String filterFieldId, String filterFieldValue}) {
		MyFilterFields.checkRequired(filterName, filterCode, filterFieldId);
		return insertRowTry(db, toRowFromList(values: [filterName, filterCode, filterFieldId, filterFieldValue]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, MyFilterFields row) {
		MyFilterFields.checkRequired(row.filterName, row.filterCode, row.filterFieldId);
		return db.insert(MyFilterFields.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String filterName, @required String filterCode, @required String filterFieldId, String filterFieldValue}) {
		MyFilterFields.checkRequired(filterName, filterCode, filterFieldId);
		return insertRow(db, toRowFromList(values: [filterName, filterCode, filterFieldId, filterFieldValue]));
	}

	// to map
	static Map<String, dynamic> toMap({MyFilterFields row, String f1, String f2, String f3, String f4, String filterName, String filterCode, String filterFieldId, String filterFieldValue}) {
		filterName = nvl(row?.filterName, filterName);
		filterCode = nvl(row?.filterCode, filterCode);
		filterFieldId = nvl(row?.filterFieldId, filterFieldId);
		filterFieldValue = nvl(row?.filterFieldValue, filterFieldValue);
		MyFilterFields.checkRequired(filterName, filterCode, filterFieldId);
		return {nvlString(f1, MyFilterFields.C_FILTER_NAME): filterName, nvlString(f2, MyFilterFields.C_FILTER_CODE): filterCode, nvlString(f3, MyFilterFields.C_FILTER_FIELD_ID): filterFieldId, nvlString(f4, MyFilterFields.C_FILTER_FIELD_VALUE): filterFieldValue};
	}

	// to list
	static List<dynamic> toList({MyFilterFields row, String filterName, String filterCode, String filterFieldId, String filterFieldValue}) {
		filterName = nvl(row?.filterName, filterName);
		filterCode = nvl(row?.filterCode, filterCode);
		filterFieldId = nvl(row?.filterFieldId, filterFieldId);
		filterFieldValue = nvl(row?.filterFieldValue, filterFieldValue);
		MyFilterFields.checkRequired(filterName, filterCode, filterFieldId);
		return [filterName, filterCode, filterFieldId, filterFieldValue];
	}

	// to row from map
	static MyFilterFields toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String filterName, String filterCode, String filterFieldId, String filterFieldValue}) {
		filterName = nvl(data == null ? null : data[nvl(f1, MyFilterFields.C_FILTER_NAME)], filterName);
		filterCode = nvl(data == null ? null : data[nvl(f2, MyFilterFields.C_FILTER_CODE)], filterCode);
		filterFieldId = nvl(data == null ? null : data[nvl(f3, MyFilterFields.C_FILTER_FIELD_ID)], filterFieldId);
		filterFieldValue = nvl(data == null ? null : data[nvl(f4, MyFilterFields.C_FILTER_FIELD_VALUE)], filterFieldValue);
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		return new MyFilterFields(filterName: filterName, filterCode: filterCode, filterFieldId: filterFieldId, filterFieldValue: filterFieldValue);
	}

	// to row from list
	static MyFilterFields toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4}) {
		final filterName = values[keys?.indexOf(nvl(f1, MyFilterFields.C_FILTER_NAME)) ?? 0];
		final filterCode = values[keys?.indexOf(nvl(f2, MyFilterFields.C_FILTER_CODE)) ?? 1];
		final filterFieldId = values[keys?.indexOf(nvl(f3, MyFilterFields.C_FILTER_FIELD_ID)) ?? 2];
		final filterFieldValue = values[keys?.indexOf(nvl(f4, MyFilterFields.C_FILTER_FIELD_VALUE)) ?? 3];
		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		return new MyFilterFields(filterName: filterName, filterCode: filterCode, filterFieldId: filterFieldId, filterFieldValue: filterFieldValue);
	}

	// to row from list strings
	static MyFilterFields toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4}) {
		dynamic filterName = values[keys?.indexOf(nvl(f1, MyFilterFields.C_FILTER_NAME)) ?? 0];
		dynamic filterCode = values[keys?.indexOf(nvl(f2, MyFilterFields.C_FILTER_CODE)) ?? 1];
		dynamic filterFieldId = values[keys?.indexOf(nvl(f3, MyFilterFields.C_FILTER_FIELD_ID)) ?? 2];
		dynamic filterFieldValue = values[keys?.indexOf(nvl(f4, MyFilterFields.C_FILTER_FIELD_VALUE)) ?? 3];

		MyFilterFields.checkPrimaryKeys(filterName, filterCode, filterFieldId);
		return new MyFilterFields(filterName: filterName, filterCode: filterCode, filterFieldId: filterFieldId, filterFieldValue: filterFieldValue);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
