// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class ZMedicineMarkInn {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "z_medicine_mark_inn";
	// ignore: non_constant_identifier_names
	static const String C_INN_RU = "inn_ru";
	// ignore: non_constant_identifier_names
	static const String C_INN_EN = "inn_en";
	// ignore: non_constant_identifier_names
	static const String C_INN_RU_PHONEX_CODE = "inn_ru_phonex_code";
	// ignore: non_constant_identifier_names
	static const String C_INN_EN_PHONEX_CODE = "inn_en_phonex_code";
	// ignore: non_constant_identifier_names
	static const String C_INN_IDS = "inn_ids";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table z_medicine_mark_inn (
	  inn_ru                               text not null,
	  inn_en                               text not null,
	  inn_ru_phonex_code                   text not null,
	  inn_en_phonex_code                   text not null,
	  inn_ids                              text not null,
	  constraint z_medicine_mark_inn_pk primary key (inn_ru)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String innRu, String innEn, String innRuPhonexCode, String innEnPhonexCode, String innIds) {
		ArgumentError.checkNotNull(innRu, C_INN_RU);
		ArgumentError.checkNotNull(innEn, C_INN_EN);
		ArgumentError.checkNotNull(innRuPhonexCode, C_INN_RU_PHONEX_CODE);
		ArgumentError.checkNotNull(innEnPhonexCode, C_INN_EN_PHONEX_CODE);
		ArgumentError.checkNotNull(innIds, C_INN_IDS);
	}

	static void checkPrimaryKeys(String innRu) {
		ArgumentError.checkNotNull(innRu, C_INN_RU);
	}

	//------------------------------------------------------------------------------------------------

	final String innRu;
	final String innEn;
	final String innRuPhonexCode;
	final String innEnPhonexCode;
	final String innIds;

	ZMedicineMarkInn({@required this.innRu, @required this.innEn, @required this.innRuPhonexCode, @required this.innEnPhonexCode, @required this.innIds}) {
		checkPrimaryKeys(innRu);
	}

	factory ZMedicineMarkInn.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_INN_RU]);
		return ZMedicineMarkInn(
			innRu: data[C_INN_RU],
			innEn: data[C_INN_EN],
			innRuPhonexCode: data[C_INN_RU_PHONEX_CODE],
			innEnPhonexCode: data[C_INN_EN_PHONEX_CODE],
			innIds: data[C_INN_IDS],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_INN_RU: this.innRu,
			C_INN_EN: this.innEn,
			C_INN_RU_PHONEX_CODE: this.innRuPhonexCode,
			C_INN_EN_PHONEX_CODE: this.innEnPhonexCode,
			C_INN_IDS: this.innIds,
		};
	}

	@override
	String toString() {
		 return "ZMedicineMarkInn($C_INN_RU:$innRu, $C_INN_EN:$innEn, $C_INN_RU_PHONEX_CODE:$innRuPhonexCode, $C_INN_EN_PHONEX_CODE:$innEnPhonexCode, $C_INN_IDS:$innIds)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_ZMedicineMarkInn {

	// init
	static ZMedicineMarkInn init({@required String innRu, @required String innEn, @required String innRuPhonexCode, @required String innEnPhonexCode, @required String innIds}) {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return new ZMedicineMarkInn(innRu: innRu, innEn: innEn, innRuPhonexCode: innRuPhonexCode, innEnPhonexCode: innEnPhonexCode, innIds: innIds);
	}

	// load all rows in database
	static Future<List<ZMedicineMarkInn>> loadAll(Database db) {
		return db.query(ZMedicineMarkInn.TABLE_NAME)
			.then((it) => it.map((d) => ZMedicineMarkInn.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<ZMedicineMarkInn> take(Database db, String innRu) async {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		final result = await db.query(ZMedicineMarkInn.TABLE_NAME, where: "${ZMedicineMarkInn.C_INN_RU} = ?", whereArgs: [innRu]);
		return result.isEmpty ? null : ZMedicineMarkInn.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<ZMedicineMarkInn> load(Database db, String innRu) async {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		final result = await take(db, innRu);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, String innRu) {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return take(db, innRu).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, String innRu, void onResult(ZMedicineMarkInn row)) async {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		ArgumentError.checkNotNull(onResult, "OnResult");
		final result = await take(db, innRu);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateRow(Database db, ZMedicineMarkInn row, {bool removeNull = false}) {
		ZMedicineMarkInn.checkPrimaryKeys(row.innRu);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.update(ZMedicineMarkInn.TABLE_NAME, data, where: "${ZMedicineMarkInn.C_INN_RU} = ?", whereArgs: [row.innRu]);
	}

	// update by one
	static Future<int> updateOne(Database db, {@required String innRu, String innEn, String innRuPhonexCode, String innEnPhonexCode, String innIds, bool removeNull = false}) {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return updateRow(db, toRowFromList(values: [innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(Database db, ZMedicineMarkInn row, {bool removeNull = false}) {
		ZMedicineMarkInn.checkPrimaryKeys(row.innRu);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(ZMedicineMarkInn.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required String innRu, @required String innEn, @required String innRuPhonexCode, @required String innEnPhonexCode, @required String innIds, bool removeNull = false}) {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return saveRow(db, toRowFromList(values: [innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(ZMedicineMarkInn.TABLE_NAME);
	}

	// delete row by primary key
	static Future<int> deleteOne(Database db, String innRu) {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return db.delete(ZMedicineMarkInn.TABLE_NAME, where: "${ZMedicineMarkInn.C_INN_RU} = ?", whereArgs: [innRu]);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, ZMedicineMarkInn row) {
		ZMedicineMarkInn.checkRequired(row.innRu, row.innEn, row.innRuPhonexCode, row.innEnPhonexCode, row.innIds);
		return db.insert(ZMedicineMarkInn.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String innRu, @required String innEn, @required String innRuPhonexCode, @required String innEnPhonexCode, @required String innIds}) {
		ZMedicineMarkInn.checkRequired(innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds);
		return insertRowTry(db, toRowFromList(values: [innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, ZMedicineMarkInn row) {
		ZMedicineMarkInn.checkRequired(row.innRu, row.innEn, row.innRuPhonexCode, row.innEnPhonexCode, row.innIds);
		return db.insert(ZMedicineMarkInn.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String innRu, @required String innEn, @required String innRuPhonexCode, @required String innEnPhonexCode, @required String innIds}) {
		ZMedicineMarkInn.checkRequired(innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds);
		return insertRow(db, toRowFromList(values: [innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds]));
	}

	// to map
	static Map<String, dynamic> toMap({ZMedicineMarkInn row, String f1, String f2, String f3, String f4, String f5, String innRu, String innEn, String innRuPhonexCode, String innEnPhonexCode, String innIds}) {
		innRu = nvl(row?.innRu, innRu);
		innEn = nvl(row?.innEn, innEn);
		innRuPhonexCode = nvl(row?.innRuPhonexCode, innRuPhonexCode);
		innEnPhonexCode = nvl(row?.innEnPhonexCode, innEnPhonexCode);
		innIds = nvl(row?.innIds, innIds);
		ZMedicineMarkInn.checkRequired(innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds);
		return {nvlString(f1, ZMedicineMarkInn.C_INN_RU): innRu, nvlString(f2, ZMedicineMarkInn.C_INN_EN): innEn, nvlString(f3, ZMedicineMarkInn.C_INN_RU_PHONEX_CODE): innRuPhonexCode, nvlString(f4, ZMedicineMarkInn.C_INN_EN_PHONEX_CODE): innEnPhonexCode, nvlString(f5, ZMedicineMarkInn.C_INN_IDS): innIds};
	}

	// to list
	static List<dynamic> toList({ZMedicineMarkInn row, String innRu, String innEn, String innRuPhonexCode, String innEnPhonexCode, String innIds}) {
		innRu = nvl(row?.innRu, innRu);
		innEn = nvl(row?.innEn, innEn);
		innRuPhonexCode = nvl(row?.innRuPhonexCode, innRuPhonexCode);
		innEnPhonexCode = nvl(row?.innEnPhonexCode, innEnPhonexCode);
		innIds = nvl(row?.innIds, innIds);
		ZMedicineMarkInn.checkRequired(innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds);
		return [innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds];
	}

	// to row from map
	static ZMedicineMarkInn toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String f5, String innRu, String innEn, String innRuPhonexCode, String innEnPhonexCode, String innIds}) {
		innRu = nvl(data == null ? null : data[nvl(f1, ZMedicineMarkInn.C_INN_RU)], innRu);
		innEn = nvl(data == null ? null : data[nvl(f2, ZMedicineMarkInn.C_INN_EN)], innEn);
		innRuPhonexCode = nvl(data == null ? null : data[nvl(f3, ZMedicineMarkInn.C_INN_RU_PHONEX_CODE)], innRuPhonexCode);
		innEnPhonexCode = nvl(data == null ? null : data[nvl(f4, ZMedicineMarkInn.C_INN_EN_PHONEX_CODE)], innEnPhonexCode);
		innIds = nvl(data == null ? null : data[nvl(f5, ZMedicineMarkInn.C_INN_IDS)], innIds);
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return new ZMedicineMarkInn(innRu: innRu, innEn: innEn, innRuPhonexCode: innRuPhonexCode, innEnPhonexCode: innEnPhonexCode, innIds: innIds);
	}

	// to row from list
	static ZMedicineMarkInn toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4, String f5}) {
		final innRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkInn.C_INN_RU)) ?? 0];
		final innEn = values[keys?.indexOf(nvl(f2, ZMedicineMarkInn.C_INN_EN)) ?? 1];
		final innRuPhonexCode = values[keys?.indexOf(nvl(f3, ZMedicineMarkInn.C_INN_RU_PHONEX_CODE)) ?? 2];
		final innEnPhonexCode = values[keys?.indexOf(nvl(f4, ZMedicineMarkInn.C_INN_EN_PHONEX_CODE)) ?? 3];
		final innIds = values[keys?.indexOf(nvl(f5, ZMedicineMarkInn.C_INN_IDS)) ?? 4];
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return new ZMedicineMarkInn(innRu: innRu, innEn: innEn, innRuPhonexCode: innRuPhonexCode, innEnPhonexCode: innEnPhonexCode, innIds: innIds);
	}

	// to row from list strings
	static ZMedicineMarkInn toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4, String f5}) {
		dynamic innRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkInn.C_INN_RU)) ?? 0];
		dynamic innEn = values[keys?.indexOf(nvl(f2, ZMedicineMarkInn.C_INN_EN)) ?? 1];
		dynamic innRuPhonexCode = values[keys?.indexOf(nvl(f3, ZMedicineMarkInn.C_INN_RU_PHONEX_CODE)) ?? 2];
		dynamic innEnPhonexCode = values[keys?.indexOf(nvl(f4, ZMedicineMarkInn.C_INN_EN_PHONEX_CODE)) ?? 3];
		dynamic innIds = values[keys?.indexOf(nvl(f5, ZMedicineMarkInn.C_INN_IDS)) ?? 4];

		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return new ZMedicineMarkInn(innRu: innRu, innEn: innEn, innRuPhonexCode: innRuPhonexCode, innEnPhonexCode: innEnPhonexCode, innIds: innIds);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
