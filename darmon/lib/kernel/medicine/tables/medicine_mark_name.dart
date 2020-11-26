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
	static const String C_NAME_RU_SOUNDEX = "name_ru_soundex";
	// ignore: non_constant_identifier_names
	static const String C_NAME_UZ = "name_uz";
	// ignore: non_constant_identifier_names
	static const String C_NAME_UZ_SOUNDEX = "name_uz_soundex";
	// ignore: non_constant_identifier_names
	static const String C_NAME_EN = "name_en";
	// ignore: non_constant_identifier_names
	static const String C_NAME_EN_SOUNDEX = "name_en_soundex";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table z_medicine_mark_name (
	  name_ru                               text not null,
	  name_ru_soundex                       text not null,
	  name_uz                               text not null,
	  name_uz_soundex                       text not null,
	  name_en                               text not null,
	  name_en_soundex                       text not null,
	  constraint z_medicine_mark_name_pk primary key (name_ru)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String nameRu, String nameRuSoundex, String nameUz, String nameUzSoundex, String nameEn, String nameEnSoundex) {
		ArgumentError.checkNotNull(nameRu, C_NAME_RU);
		ArgumentError.checkNotNull(nameRuSoundex, C_NAME_RU_SOUNDEX);
		ArgumentError.checkNotNull(nameUz, C_NAME_UZ);
		ArgumentError.checkNotNull(nameUzSoundex, C_NAME_UZ_SOUNDEX);
		ArgumentError.checkNotNull(nameEn, C_NAME_EN);
		ArgumentError.checkNotNull(nameEnSoundex, C_NAME_EN_SOUNDEX);
	}

	static void checkPrimaryKeys(String nameRu) {
		ArgumentError.checkNotNull(nameRu, C_NAME_RU);
	}

	//------------------------------------------------------------------------------------------------

	final String nameRu;
	final String nameRuSoundex;
	final String nameUz;
	final String nameUzSoundex;
	final String nameEn;
	final String nameEnSoundex;

	ZMedicineMarkName({@required this.nameRu, @required this.nameRuSoundex, @required this.nameUz, @required this.nameUzSoundex, @required this.nameEn, @required this.nameEnSoundex}) {
		checkPrimaryKeys(nameRu);
	}

	factory ZMedicineMarkName.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_NAME_RU]);
		return ZMedicineMarkName(
			nameRu: data[C_NAME_RU],
			nameRuSoundex: data[C_NAME_RU_SOUNDEX],
			nameUz: data[C_NAME_UZ],
			nameUzSoundex: data[C_NAME_UZ_SOUNDEX],
			nameEn: data[C_NAME_EN],
			nameEnSoundex: data[C_NAME_EN_SOUNDEX],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_NAME_RU: this.nameRu,
			C_NAME_RU_SOUNDEX: this.nameRuSoundex,
			C_NAME_UZ: this.nameUz,
			C_NAME_UZ_SOUNDEX: this.nameUzSoundex,
			C_NAME_EN: this.nameEn,
			C_NAME_EN_SOUNDEX: this.nameEnSoundex,
		};
	}

	@override
	String toString() {
		 return "ZMedicineMarkName($C_NAME_RU:$nameRu, $C_NAME_RU_SOUNDEX:$nameRuSoundex, $C_NAME_UZ:$nameUz, $C_NAME_UZ_SOUNDEX:$nameUzSoundex, $C_NAME_EN:$nameEn, $C_NAME_EN_SOUNDEX:$nameEnSoundex)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_ZMedicineMarkName {

	// init
	static ZMedicineMarkName init({@required String nameRu, @required String nameRuSoundex, @required String nameUz, @required String nameUzSoundex, @required String nameEn, @required String nameEnSoundex}) {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return new ZMedicineMarkName(nameRu: nameRu, nameRuSoundex: nameRuSoundex, nameUz: nameUz, nameUzSoundex: nameUzSoundex, nameEn: nameEn, nameEnSoundex: nameEnSoundex);
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
	static Future<int> updateOne(Database db, {@required String nameRu, String nameRuSoundex, String nameUz, String nameUzSoundex, String nameEn, String nameEnSoundex, bool removeNull = false}) {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return updateRow(db, toRowFromList(values: [nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex]), removeNull: removeNull);
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
	static Future<int> saveOne(Database db, {@required String nameRu, @required String nameRuSoundex, @required String nameUz, @required String nameUzSoundex, @required String nameEn, @required String nameEnSoundex, bool removeNull = false}) {
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return saveRow(db, toRowFromList(values: [nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex]), removeNull: removeNull);
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
		ZMedicineMarkName.checkRequired(row.nameRu, row.nameRuSoundex, row.nameUz, row.nameUzSoundex, row.nameEn, row.nameEnSoundex);
		return db.insert(ZMedicineMarkName.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String nameRu, @required String nameRuSoundex, @required String nameUz, @required String nameUzSoundex, @required String nameEn, @required String nameEnSoundex}) {
		ZMedicineMarkName.checkRequired(nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex);
		return insertRowTry(db, toRowFromList(values: [nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, ZMedicineMarkName row) {
		ZMedicineMarkName.checkRequired(row.nameRu, row.nameRuSoundex, row.nameUz, row.nameUzSoundex, row.nameEn, row.nameEnSoundex);
		return db.insert(ZMedicineMarkName.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String nameRu, @required String nameRuSoundex, @required String nameUz, @required String nameUzSoundex, @required String nameEn, @required String nameEnSoundex}) {
		ZMedicineMarkName.checkRequired(nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex);
		return insertRow(db, toRowFromList(values: [nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex]));
	}

	// to map
	static Map<String, dynamic> toMap({ZMedicineMarkName row, String f1, String f2, String f3, String f4, String f5, String f6, String nameRu, String nameRuSoundex, String nameUz, String nameUzSoundex, String nameEn, String nameEnSoundex}) {
		nameRu = nvl(row?.nameRu, nameRu);
		nameRuSoundex = nvl(row?.nameRuSoundex, nameRuSoundex);
		nameUz = nvl(row?.nameUz, nameUz);
		nameUzSoundex = nvl(row?.nameUzSoundex, nameUzSoundex);
		nameEn = nvl(row?.nameEn, nameEn);
		nameEnSoundex = nvl(row?.nameEnSoundex, nameEnSoundex);
		ZMedicineMarkName.checkRequired(nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex);
		return {nvlString(f1, ZMedicineMarkName.C_NAME_RU): nameRu, nvlString(f2, ZMedicineMarkName.C_NAME_RU_SOUNDEX): nameRuSoundex, nvlString(f3, ZMedicineMarkName.C_NAME_UZ): nameUz, nvlString(f4, ZMedicineMarkName.C_NAME_UZ_SOUNDEX): nameUzSoundex, nvlString(f5, ZMedicineMarkName.C_NAME_EN): nameEn, nvlString(f6, ZMedicineMarkName.C_NAME_EN_SOUNDEX): nameEnSoundex};
	}

	// to list
	static List<dynamic> toList({ZMedicineMarkName row, String nameRu, String nameRuSoundex, String nameUz, String nameUzSoundex, String nameEn, String nameEnSoundex}) {
		nameRu = nvl(row?.nameRu, nameRu);
		nameRuSoundex = nvl(row?.nameRuSoundex, nameRuSoundex);
		nameUz = nvl(row?.nameUz, nameUz);
		nameUzSoundex = nvl(row?.nameUzSoundex, nameUzSoundex);
		nameEn = nvl(row?.nameEn, nameEn);
		nameEnSoundex = nvl(row?.nameEnSoundex, nameEnSoundex);
		ZMedicineMarkName.checkRequired(nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex);
		return [nameRu, nameRuSoundex, nameUz, nameUzSoundex, nameEn, nameEnSoundex];
	}

	// to row from map
	static ZMedicineMarkName toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String f5, String f6, String nameRu, String nameRuSoundex, String nameUz, String nameUzSoundex, String nameEn, String nameEnSoundex}) {
		nameRu = nvl(data == null ? null : data[nvl(f1, ZMedicineMarkName.C_NAME_RU)], nameRu);
		nameRuSoundex = nvl(data == null ? null : data[nvl(f2, ZMedicineMarkName.C_NAME_RU_SOUNDEX)], nameRuSoundex);
		nameUz = nvl(data == null ? null : data[nvl(f3, ZMedicineMarkName.C_NAME_UZ)], nameUz);
		nameUzSoundex = nvl(data == null ? null : data[nvl(f4, ZMedicineMarkName.C_NAME_UZ_SOUNDEX)], nameUzSoundex);
		nameEn = nvl(data == null ? null : data[nvl(f5, ZMedicineMarkName.C_NAME_EN)], nameEn);
		nameEnSoundex = nvl(data == null ? null : data[nvl(f6, ZMedicineMarkName.C_NAME_EN_SOUNDEX)], nameEnSoundex);
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return new ZMedicineMarkName(nameRu: nameRu, nameRuSoundex: nameRuSoundex, nameUz: nameUz, nameUzSoundex: nameUzSoundex, nameEn: nameEn, nameEnSoundex: nameEnSoundex);
	}

	// to row from list
	static ZMedicineMarkName toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4, String f5, String f6}) {
		final nameRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkName.C_NAME_RU)) ?? 0];
		final nameRuSoundex = values[keys?.indexOf(nvl(f2, ZMedicineMarkName.C_NAME_RU_SOUNDEX)) ?? 1];
		final nameUz = values[keys?.indexOf(nvl(f3, ZMedicineMarkName.C_NAME_UZ)) ?? 2];
		final nameUzSoundex = values[keys?.indexOf(nvl(f4, ZMedicineMarkName.C_NAME_UZ_SOUNDEX)) ?? 3];
		final nameEn = values[keys?.indexOf(nvl(f5, ZMedicineMarkName.C_NAME_EN)) ?? 4];
		final nameEnSoundex = values[keys?.indexOf(nvl(f6, ZMedicineMarkName.C_NAME_EN_SOUNDEX)) ?? 5];
		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return new ZMedicineMarkName(nameRu: nameRu, nameRuSoundex: nameRuSoundex, nameUz: nameUz, nameUzSoundex: nameUzSoundex, nameEn: nameEn, nameEnSoundex: nameEnSoundex);
	}

	// to row from list strings
	static ZMedicineMarkName toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4, String f5, String f6}) {
		dynamic nameRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkName.C_NAME_RU)) ?? 0];
		dynamic nameRuSoundex = values[keys?.indexOf(nvl(f2, ZMedicineMarkName.C_NAME_RU_SOUNDEX)) ?? 1];
		dynamic nameUz = values[keys?.indexOf(nvl(f3, ZMedicineMarkName.C_NAME_UZ)) ?? 2];
		dynamic nameUzSoundex = values[keys?.indexOf(nvl(f4, ZMedicineMarkName.C_NAME_UZ_SOUNDEX)) ?? 3];
		dynamic nameEn = values[keys?.indexOf(nvl(f5, ZMedicineMarkName.C_NAME_EN)) ?? 4];
		dynamic nameEnSoundex = values[keys?.indexOf(nvl(f6, ZMedicineMarkName.C_NAME_EN_SOUNDEX)) ?? 5];

		ZMedicineMarkName.checkPrimaryKeys(nameRu);
		return new ZMedicineMarkName(nameRu: nameRu, nameRuSoundex: nameRuSoundex, nameUz: nameUz, nameUzSoundex: nameUzSoundex, nameEn: nameEn, nameEnSoundex: nameEnSoundex);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
