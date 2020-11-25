// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class ZMedicineMarkName {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "z_medicine_mark_name";
	// ignore: non_constant_identifier_names
	static const String C_NAME_RU = "name_ru";
	// ignore: non_constant_identifier_names
	static const String C_NAME_UZ = "name_uz";
	// ignore: non_constant_identifier_names
	static const String C_NAME_EN = "name_en";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table z_medicine_mark_name (
	  name_ru                               text not null,
	  name_uz                               text not null,
	  name_en                               text not null,
	  constraint z_medicine_mark_name_pk primary key (name_ru)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String nameRu, String nameUz, String nameEn) {
		ArgumentError.checkNotNull(nameRu, C_NAME_RU);
		ArgumentError.checkNotNull(nameUz, C_NAME_UZ);
		ArgumentError.checkNotNull(nameEn, C_NAME_EN);
	}

	static void checkPrimaryKeys(String nameRu) {
		ArgumentError.checkNotNull(nameRu, C_NAME_RU);
	}

	//------------------------------------------------------------------------------------------------

	final String nameRu;
	final String nameUz;
	final String nameEn;

	ZMedicineMarkName({@required this.nameRu, @required this.nameUz, @required this.nameEn}) {
		checkPrimaryKeys(nameRu);
	}

	factory ZMedicineMarkName.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_NAME_RU]);
		return ZMedicineMarkName(
			nameRu: data[C_NAME_RU],
			nameUz: data[C_NAME_UZ],
			nameEn: data[C_NAME_EN],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_NAME_RU: this.nameRu,
			C_NAME_UZ: this.nameUz,
			C_NAME_EN: this.nameEn,
		};
	}

	@override
	String toString() {
		 return "ZMedicineMarkName($C_NAME_RU:$nameRu, $C_NAME_UZ:$nameUz, $C_NAME_EN:$nameEn)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_ZMedicineMarkName {

	// init
	static ZMedicineMarkName init({@required String nameRu, @required String nameUz, @required String nameEn}) {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return new ZMedicineMarkName(nameRu: nameRu, nameUz: nameUz, nameEn: nameEn);
	}

	// load all rows in database
	static Future<List<ZMedicineMarkName>> loadAll(Database db) {
		return db.query(ZMedicineMarkName.TABLE_NAME)
			.then((it) => it.map((d) => ZMedicineMarkName.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<ZMedicineMarkName> take(Database db, String nameRu) async {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		final result = await db.query(ZMedicineMarkName.TABLE_NAME, where: "${ZMedicineMarkName.C_NAME_RU} = ?", whereArgs: [nameRu]);
		return result.isEmpty ? null : ZMedicineMarkName.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<ZMedicineMarkName> load(Database db, String nameRu) async {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		final result = await take(db, nameRu);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, String nameRu) {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return take(db, nameRu).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, String nameRu, void onResult(ZMedicineMarkName row)) async {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		ArgumentError.checkNotNull(onResult, "OnResult");
		final result = await take(db, nameRu);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateRow(Database db, ZMedicineMarkName row, {bool removeNull = false}) {
		ZMedicineMarkName.checkPrimaryKeys(row.nameRu);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.update(ZMedicineMarkName.TABLE_NAME, data, where: "${ZMedicineMarkName.C_NAME_RU} = ?", whereArgs: [row.nameRu]);
	}

	// update by one
	static Future<int> updateOne(Database db, {@required String nameRu, String nameUz, String nameEn, bool removeNull = false}) {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return updateRow(db, toRowFromList(values: [nameRu, nameUz, nameEn]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(Database db, ZMedicineMarkName row, {bool removeNull = false}) {
		ZMedicineMarkName.checkPrimaryKeys(row.nameRu);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(ZMedicineMarkName.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required String nameRu, @required String nameUz, @required String nameEn, bool removeNull = false}) {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return saveRow(db, toRowFromList(values: [nameRu, nameUz, nameEn]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(ZMedicineMarkName.TABLE_NAME);
	}

	// delete row by primary key
	static Future<int> deleteOne(Database db, String nameRu) {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return db.delete(ZMedicineMarkName.TABLE_NAME, where: "${ZMedicineMarkName.C_NAME_RU} = ?", whereArgs: [nameRu]);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, ZMedicineMarkName row) {
		ZMedicineMarkName.checkRequired(row.nameRu, row.nameUz, row.nameEn);
		return db.insert(ZMedicineMarkName.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String nameRu, @required String nameUz, @required String nameEn}) {
		ZMedicineMarkName.checkRequired(nameRu, nameUz, nameEn);
		return insertRowTry(db, toRowFromList(values: [nameRu, nameUz, nameEn]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, ZMedicineMarkName row) {
		ZMedicineMarkName.checkRequired(row.nameRu, row.nameUz, row.nameEn);
		return db.insert(ZMedicineMarkName.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String nameRu, @required String nameUz, @required String nameEn}) {
		ZMedicineMarkName.checkRequired(nameRu, nameUz, nameEn);
		return insertRow(db, toRowFromList(values: [nameRu, nameUz, nameEn]));
	}

	// to map
	static Map<String, dynamic> toMap({ZMedicineMarkName row, String f1, String f2, String f3, String nameRu, String nameUz, String nameEn}) {
		nameRu = nvl(row?.nameRu, nameRu);
		nameUz = nvl(row?.nameUz, nameUz);
		nameEn = nvl(row?.nameEn, nameEn);
		ZMedicineMarkName.checkRequired(nameRu, nameUz, nameEn);
		return {nvlString(f1, ZMedicineMarkName.C_NAME_RU): nameRu, nvlString(f2, ZMedicineMarkName.C_NAME_UZ): nameUz, nvlString(f3, ZMedicineMarkName.C_NAME_EN): nameEn};
	}

	// to list
	static List<dynamic> toList({ZMedicineMarkName row, String nameRu, String nameUz, String nameEn}) {
		nameRu = nvl(row?.nameRu, nameRu);
		nameUz = nvl(row?.nameUz, nameUz);
		nameEn = nvl(row?.nameEn, nameEn);
		ZMedicineMarkName.checkRequired(nameRu, nameUz, nameEn);
		return [nameRu, nameUz, nameEn];
	}

	// to row from map
	static ZMedicineMarkName toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String nameRu, String nameUz, String nameEn}) {
		nameRu = nvl(data == null ? null : data[nvl(f1, ZMedicineMarkName.C_NAME_RU)], nameRu);
		nameUz = nvl(data == null ? null : data[nvl(f2, ZMedicineMarkName.C_NAME_UZ)], nameUz);
		nameEn = nvl(data == null ? null : data[nvl(f3, ZMedicineMarkName.C_NAME_EN)], nameEn);
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return new ZMedicineMarkName(nameRu: nameRu, nameUz: nameUz, nameEn: nameEn);
	}

	// to row from list
	static ZMedicineMarkName toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3}) {
		final nameRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkName.C_NAME_RU)) ?? 0];
		final nameUz = values[keys?.indexOf(nvl(f2, ZMedicineMarkName.C_NAME_UZ)) ?? 1];
		final nameEn = values[keys?.indexOf(nvl(f3, ZMedicineMarkName.C_NAME_EN)) ?? 2];
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return new ZMedicineMarkName(nameRu: nameRu, nameUz: nameUz, nameEn: nameEn);
	}

	// to row from list strings
	static ZMedicineMarkName toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3}) {
		dynamic nameRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkName.C_NAME_RU)) ?? 0];
		dynamic nameUz = values[keys?.indexOf(nvl(f2, ZMedicineMarkName.C_NAME_UZ)) ?? 1];
		dynamic nameEn = values[keys?.indexOf(nvl(f3, ZMedicineMarkName.C_NAME_EN)) ?? 2];

		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return new ZMedicineMarkName(nameRu: nameRu, nameUz: nameUz, nameEn: nameEn);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
