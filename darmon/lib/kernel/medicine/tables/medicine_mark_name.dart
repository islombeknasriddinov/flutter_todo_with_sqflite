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
	// ignore: non_constant_identifier_names
	static const String C_NAME_RU_PHONEX_CODE = "name_ru_phonex_code";
	// ignore: non_constant_identifier_names
	static const String C_NAME_UZ_PHONEX_CODE = "name_uz_phonex_code";
	// ignore: non_constant_identifier_names
	static const String C_NAME_EN_PHONEX_CODE = "name_en_phonex_code";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table z_medicine_mark_name (
	  name_ru                               text not null,
	  name_uz                               text not null,
	  name_en                               text not null,
	  name_ru_phonex_code                   text not null,
	  name_uz_phonex_code                   text not null,
	  name_en_phonex_code                   text not null
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String nameRu, String nameUz, String nameEn, String nameRuPhonexCode, String nameUzPhonexCode, String nameEnPhonexCode) {
		ArgumentError.checkNotNull(nameRu, C_NAME_RU);
		ArgumentError.checkNotNull(nameUz, C_NAME_UZ);
		ArgumentError.checkNotNull(nameEn, C_NAME_EN);
		ArgumentError.checkNotNull(nameRuPhonexCode, C_NAME_RU_PHONEX_CODE);
		ArgumentError.checkNotNull(nameUzPhonexCode, C_NAME_UZ_PHONEX_CODE);
		ArgumentError.checkNotNull(nameEnPhonexCode, C_NAME_EN_PHONEX_CODE);
	}

	final String nameRu;
	final String nameUz;
	final String nameEn;
	final String nameRuPhonexCode;
	final String nameUzPhonexCode;
	final String nameEnPhonexCode;

	ZMedicineMarkName({@required this.nameRu, @required this.nameUz, @required this.nameEn, @required this.nameRuPhonexCode, @required this.nameUzPhonexCode, @required this.nameEnPhonexCode});

	factory ZMedicineMarkName.fromData(Map<String, dynamic> data) {
		return ZMedicineMarkName(
			nameRu: data[C_NAME_RU],
			nameUz: data[C_NAME_UZ],
			nameEn: data[C_NAME_EN],
			nameRuPhonexCode: data[C_NAME_RU_PHONEX_CODE],
			nameUzPhonexCode: data[C_NAME_UZ_PHONEX_CODE],
			nameEnPhonexCode: data[C_NAME_EN_PHONEX_CODE],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_NAME_RU: this.nameRu,
			C_NAME_UZ: this.nameUz,
			C_NAME_EN: this.nameEn,
			C_NAME_RU_PHONEX_CODE: this.nameRuPhonexCode,
			C_NAME_UZ_PHONEX_CODE: this.nameUzPhonexCode,
			C_NAME_EN_PHONEX_CODE: this.nameEnPhonexCode,
		};
	}

	@override
	String toString() {
		 return "ZMedicineMarkName($C_NAME_RU:$nameRu, $C_NAME_UZ:$nameUz, $C_NAME_EN:$nameEn, $C_NAME_RU_PHONEX_CODE:$nameRuPhonexCode, $C_NAME_UZ_PHONEX_CODE:$nameUzPhonexCode, $C_NAME_EN_PHONEX_CODE:$nameEnPhonexCode)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_ZMedicineMarkName {

	// init
	static ZMedicineMarkName init({@required String nameRu, @required String nameUz, @required String nameEn, @required String nameRuPhonexCode, @required String nameUzPhonexCode, @required String nameEnPhonexCode}) {
		return new ZMedicineMarkName(nameRu: nameRu, nameUz: nameUz, nameEn: nameEn, nameRuPhonexCode: nameRuPhonexCode, nameUzPhonexCode: nameUzPhonexCode, nameEnPhonexCode: nameEnPhonexCode);
	}

	// load all rows in database
	static Future<List<ZMedicineMarkName>> loadAll(Database db) {
		return db.query(ZMedicineMarkName.TABLE_NAME)
			.then((it) => it.map((d) => ZMedicineMarkName.fromData(d)).toList());
	}

	// save row
	static Future<int> saveRow(Database db, ZMedicineMarkName row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(ZMedicineMarkName.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required String nameRu, @required String nameUz, @required String nameEn, @required String nameRuPhonexCode, @required String nameUzPhonexCode, @required String nameEnPhonexCode, bool removeNull = false}) {
		return saveRow(db, toRowFromList(values: [nameRu, nameUz, nameEn, nameRuPhonexCode, nameUzPhonexCode, nameEnPhonexCode]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(ZMedicineMarkName.TABLE_NAME);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, ZMedicineMarkName row) {
		ZMedicineMarkName.checkRequired(row.nameRu, row.nameUz, row.nameEn, row.nameRuPhonexCode, row.nameUzPhonexCode, row.nameEnPhonexCode);
		return db.insert(ZMedicineMarkName.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String nameRu, @required String nameUz, @required String nameEn, @required String nameRuPhonexCode, @required String nameUzPhonexCode, @required String nameEnPhonexCode}) {
		ZMedicineMarkName.checkRequired(nameRu, nameUz, nameEn, nameRuPhonexCode, nameUzPhonexCode, nameEnPhonexCode);
		return insertRowTry(db, toRowFromList(values: [nameRu, nameUz, nameEn, nameRuPhonexCode, nameUzPhonexCode, nameEnPhonexCode]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, ZMedicineMarkName row) {
		ZMedicineMarkName.checkRequired(row.nameRu, row.nameUz, row.nameEn, row.nameRuPhonexCode, row.nameUzPhonexCode, row.nameEnPhonexCode);
		return db.insert(ZMedicineMarkName.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String nameRu, @required String nameUz, @required String nameEn, @required String nameRuPhonexCode, @required String nameUzPhonexCode, @required String nameEnPhonexCode}) {
		ZMedicineMarkName.checkRequired(nameRu, nameUz, nameEn, nameRuPhonexCode, nameUzPhonexCode, nameEnPhonexCode);
		return insertRow(db, toRowFromList(values: [nameRu, nameUz, nameEn, nameRuPhonexCode, nameUzPhonexCode, nameEnPhonexCode]));
	}

	// to map
	static Map<String, dynamic> toMap({ZMedicineMarkName row, String f1, String f2, String f3, String f4, String f5, String f6, String nameRu, String nameUz, String nameEn, String nameRuPhonexCode, String nameUzPhonexCode, String nameEnPhonexCode}) {
		nameRu = nvl(row?.nameRu, nameRu);
		nameUz = nvl(row?.nameUz, nameUz);
		nameEn = nvl(row?.nameEn, nameEn);
		nameRuPhonexCode = nvl(row?.nameRuPhonexCode, nameRuPhonexCode);
		nameUzPhonexCode = nvl(row?.nameUzPhonexCode, nameUzPhonexCode);
		nameEnPhonexCode = nvl(row?.nameEnPhonexCode, nameEnPhonexCode);
		ZMedicineMarkName.checkRequired(nameRu, nameUz, nameEn, nameRuPhonexCode, nameUzPhonexCode, nameEnPhonexCode);
		return {nvlString(f1, ZMedicineMarkName.C_NAME_RU): nameRu, nvlString(f2, ZMedicineMarkName.C_NAME_UZ): nameUz, nvlString(f3, ZMedicineMarkName.C_NAME_EN): nameEn, nvlString(f4, ZMedicineMarkName.C_NAME_RU_PHONEX_CODE): nameRuPhonexCode, nvlString(f5, ZMedicineMarkName.C_NAME_UZ_PHONEX_CODE): nameUzPhonexCode, nvlString(f6, ZMedicineMarkName.C_NAME_EN_PHONEX_CODE): nameEnPhonexCode};
	}

	// to list
	static List<dynamic> toList({ZMedicineMarkName row, String nameRu, String nameUz, String nameEn, String nameRuPhonexCode, String nameUzPhonexCode, String nameEnPhonexCode}) {
		nameRu = nvl(row?.nameRu, nameRu);
		nameUz = nvl(row?.nameUz, nameUz);
		nameEn = nvl(row?.nameEn, nameEn);
		nameRuPhonexCode = nvl(row?.nameRuPhonexCode, nameRuPhonexCode);
		nameUzPhonexCode = nvl(row?.nameUzPhonexCode, nameUzPhonexCode);
		nameEnPhonexCode = nvl(row?.nameEnPhonexCode, nameEnPhonexCode);
		ZMedicineMarkName.checkRequired(nameRu, nameUz, nameEn, nameRuPhonexCode, nameUzPhonexCode, nameEnPhonexCode);
		return [nameRu, nameUz, nameEn, nameRuPhonexCode, nameUzPhonexCode, nameEnPhonexCode];
	}

	// to row from map
	static ZMedicineMarkName toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String f5, String f6, String nameRu, String nameUz, String nameEn, String nameRuPhonexCode, String nameUzPhonexCode, String nameEnPhonexCode}) {
		nameRu = nvl(data == null ? null : data[nvl(f1, ZMedicineMarkName.C_NAME_RU)], nameRu);
		nameUz = nvl(data == null ? null : data[nvl(f2, ZMedicineMarkName.C_NAME_UZ)], nameUz);
		nameEn = nvl(data == null ? null : data[nvl(f3, ZMedicineMarkName.C_NAME_EN)], nameEn);
		nameRuPhonexCode = nvl(data == null ? null : data[nvl(f4, ZMedicineMarkName.C_NAME_RU_PHONEX_CODE)], nameRuPhonexCode);
		nameUzPhonexCode = nvl(data == null ? null : data[nvl(f5, ZMedicineMarkName.C_NAME_UZ_PHONEX_CODE)], nameUzPhonexCode);
		nameEnPhonexCode = nvl(data == null ? null : data[nvl(f6, ZMedicineMarkName.C_NAME_EN_PHONEX_CODE)], nameEnPhonexCode);
		return new ZMedicineMarkName(nameRu: nameRu, nameUz: nameUz, nameEn: nameEn, nameRuPhonexCode: nameRuPhonexCode, nameUzPhonexCode: nameUzPhonexCode, nameEnPhonexCode: nameEnPhonexCode);
	}

	// to row from list
	static ZMedicineMarkName toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4, String f5, String f6}) {
		final nameRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkName.C_NAME_RU)) ?? 0];
		final nameUz = values[keys?.indexOf(nvl(f2, ZMedicineMarkName.C_NAME_UZ)) ?? 1];
		final nameEn = values[keys?.indexOf(nvl(f3, ZMedicineMarkName.C_NAME_EN)) ?? 2];
		final nameRuPhonexCode = values[keys?.indexOf(nvl(f4, ZMedicineMarkName.C_NAME_RU_PHONEX_CODE)) ?? 3];
		final nameUzPhonexCode = values[keys?.indexOf(nvl(f5, ZMedicineMarkName.C_NAME_UZ_PHONEX_CODE)) ?? 4];
		final nameEnPhonexCode = values[keys?.indexOf(nvl(f6, ZMedicineMarkName.C_NAME_EN_PHONEX_CODE)) ?? 5];
		return new ZMedicineMarkName(nameRu: nameRu, nameUz: nameUz, nameEn: nameEn, nameRuPhonexCode: nameRuPhonexCode, nameUzPhonexCode: nameUzPhonexCode, nameEnPhonexCode: nameEnPhonexCode);
	}

	// to row from list strings
	static ZMedicineMarkName toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4, String f5, String f6}) {
		dynamic nameRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkName.C_NAME_RU)) ?? 0];
		dynamic nameUz = values[keys?.indexOf(nvl(f2, ZMedicineMarkName.C_NAME_UZ)) ?? 1];
		dynamic nameEn = values[keys?.indexOf(nvl(f3, ZMedicineMarkName.C_NAME_EN)) ?? 2];
		dynamic nameRuPhonexCode = values[keys?.indexOf(nvl(f4, ZMedicineMarkName.C_NAME_RU_PHONEX_CODE)) ?? 3];
		dynamic nameUzPhonexCode = values[keys?.indexOf(nvl(f5, ZMedicineMarkName.C_NAME_UZ_PHONEX_CODE)) ?? 4];
		dynamic nameEnPhonexCode = values[keys?.indexOf(nvl(f6, ZMedicineMarkName.C_NAME_EN_PHONEX_CODE)) ?? 5];

		return new ZMedicineMarkName(nameRu: nameRu, nameUz: nameUz, nameEn: nameEn, nameRuPhonexCode: nameRuPhonexCode, nameUzPhonexCode: nameUzPhonexCode, nameEnPhonexCode: nameEnPhonexCode);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
