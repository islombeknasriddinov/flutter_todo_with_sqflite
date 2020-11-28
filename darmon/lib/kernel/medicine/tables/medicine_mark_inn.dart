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
	static const String C_INN_RU_SOUNDEX = "inn_ru_soundex";
	// ignore: non_constant_identifier_names
	static const String C_INN_EN = "inn_en";
	// ignore: non_constant_identifier_names
	static const String C_INN_EN_SOUNDEX = "inn_en_soundex";
	// ignore: non_constant_identifier_names
	static const String C_INN_IDS = "inn_ids";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table z_medicine_mark_inn (
	  inn_ru                               text not null,
	  inn_ru_soundex                       text not null,
	  inn_en                               text not null,
	  inn_en_soundex                       text not null,
	  inn_ids                              text not null,
	  constraint z_medicine_mark_inn_pk primary key (inn_ru)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String innRu, String innRuSoundex, String innEn, String innEnSoundex, String innIds) {
		ArgumentError.checkNotNull(innRu, C_INN_RU);
		ArgumentError.checkNotNull(innRuSoundex, C_INN_RU_SOUNDEX);
		ArgumentError.checkNotNull(innEn, C_INN_EN);
		ArgumentError.checkNotNull(innEnSoundex, C_INN_EN_SOUNDEX);
		ArgumentError.checkNotNull(innIds, C_INN_IDS);
	}

	static void checkPrimaryKeys(String innRu) {
		ArgumentError.checkNotNull(innRu, C_INN_RU);
	}

	//------------------------------------------------------------------------------------------------

	final String innRu;
	final String innRuSoundex;
	final String innEn;
	final String innEnSoundex;
	final String innIds;

	ZMedicineMarkInn({@required this.innRu, @required this.innRuSoundex, @required this.innEn, @required this.innEnSoundex, @required this.innIds}) {
		checkPrimaryKeys(innRu);
	}

	factory ZMedicineMarkInn.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_INN_RU]);
		return ZMedicineMarkInn(
			innRu: data[C_INN_RU],
			innRuSoundex: data[C_INN_RU_SOUNDEX],
			innEn: data[C_INN_EN],
			innEnSoundex: data[C_INN_EN_SOUNDEX],
			innIds: data[C_INN_IDS],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_INN_RU: this.innRu,
			C_INN_RU_SOUNDEX: this.innRuSoundex,
			C_INN_EN: this.innEn,
			C_INN_EN_SOUNDEX: this.innEnSoundex,
			C_INN_IDS: this.innIds,
		};
	}

	@override
	String toString() {
		 return "ZMedicineMarkInn($C_INN_RU:$innRu, $C_INN_RU_SOUNDEX:$innRuSoundex, $C_INN_EN:$innEn, $C_INN_EN_SOUNDEX:$innEnSoundex, $C_INN_IDS:$innIds)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_ZMedicineMarkInn {

	// init
	static ZMedicineMarkInn init({@required String innRu, @required String innRuSoundex, @required String innEn, @required String innEnSoundex, @required String innIds}) {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return new ZMedicineMarkInn(innRu: innRu, innRuSoundex: innRuSoundex, innEn: innEn, innEnSoundex: innEnSoundex, innIds: innIds);
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
	static Future<int> updateOne(Database db, {@required String innRu, String innRuSoundex, String innEn, String innEnSoundex, String innIds, bool removeNull = false}) {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return updateRow(db, toRowFromList(values: [innRu, innRuSoundex, innEn, innEnSoundex, innIds]), removeNull: removeNull);
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
	static Future<int> saveOne(Database db, {@required String innRu, @required String innRuSoundex, @required String innEn, @required String innEnSoundex, @required String innIds, bool removeNull = false}) {
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return saveRow(db, toRowFromList(values: [innRu, innRuSoundex, innEn, innEnSoundex, innIds]), removeNull: removeNull);
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
		ZMedicineMarkInn.checkRequired(row.innRu, row.innRuSoundex, row.innEn, row.innEnSoundex, row.innIds);
		return db.insert(ZMedicineMarkInn.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String innRu, @required String innRuSoundex, @required String innEn, @required String innEnSoundex, @required String innIds}) {
		ZMedicineMarkInn.checkRequired(innRu, innRuSoundex, innEn, innEnSoundex, innIds);
		return insertRowTry(db, toRowFromList(values: [innRu, innRuSoundex, innEn, innEnSoundex, innIds]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, ZMedicineMarkInn row) {
		ZMedicineMarkInn.checkRequired(row.innRu, row.innRuSoundex, row.innEn, row.innEnSoundex, row.innIds);
		return db.insert(ZMedicineMarkInn.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String innRu, @required String innRuSoundex, @required String innEn, @required String innEnSoundex, @required String innIds}) {
		ZMedicineMarkInn.checkRequired(innRu, innRuSoundex, innEn, innEnSoundex, innIds);
		return insertRow(db, toRowFromList(values: [innRu, innRuSoundex, innEn, innEnSoundex, innIds]));
	}

	// to map
	static Map<String, dynamic> toMap({ZMedicineMarkInn row, String f1, String f2, String f3, String f4, String f5, String innRu, String innRuSoundex, String innEn, String innEnSoundex, String innIds}) {
		innRu = nvl(row?.innRu, innRu);
		innRuSoundex = nvl(row?.innRuSoundex, innRuSoundex);
		innEn = nvl(row?.innEn, innEn);
		innEnSoundex = nvl(row?.innEnSoundex, innEnSoundex);
		innIds = nvl(row?.innIds, innIds);
		ZMedicineMarkInn.checkRequired(innRu, innRuSoundex, innEn, innEnSoundex, innIds);
		return {nvlString(f1, ZMedicineMarkInn.C_INN_RU): innRu, nvlString(f2, ZMedicineMarkInn.C_INN_RU_SOUNDEX): innRuSoundex, nvlString(f3, ZMedicineMarkInn.C_INN_EN): innEn, nvlString(f4, ZMedicineMarkInn.C_INN_EN_SOUNDEX): innEnSoundex, nvlString(f5, ZMedicineMarkInn.C_INN_IDS): innIds};
	}

	// to list
	static List<dynamic> toList({ZMedicineMarkInn row, String innRu, String innRuSoundex, String innEn, String innEnSoundex, String innIds}) {
		innRu = nvl(row?.innRu, innRu);
		innRuSoundex = nvl(row?.innRuSoundex, innRuSoundex);
		innEn = nvl(row?.innEn, innEn);
		innEnSoundex = nvl(row?.innEnSoundex, innEnSoundex);
		innIds = nvl(row?.innIds, innIds);
		ZMedicineMarkInn.checkRequired(innRu, innRuSoundex, innEn, innEnSoundex, innIds);
		return [innRu, innRuSoundex, innEn, innEnSoundex, innIds];
	}

	// to row from map
	static ZMedicineMarkInn toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String f5, String innRu, String innRuSoundex, String innEn, String innEnSoundex, String innIds}) {
		innRu = nvl(data == null ? null : data[nvl(f1, ZMedicineMarkInn.C_INN_RU)], innRu);
		innRuSoundex = nvl(data == null ? null : data[nvl(f2, ZMedicineMarkInn.C_INN_RU_SOUNDEX)], innRuSoundex);
		innEn = nvl(data == null ? null : data[nvl(f3, ZMedicineMarkInn.C_INN_EN)], innEn);
		innEnSoundex = nvl(data == null ? null : data[nvl(f4, ZMedicineMarkInn.C_INN_EN_SOUNDEX)], innEnSoundex);
		innIds = nvl(data == null ? null : data[nvl(f5, ZMedicineMarkInn.C_INN_IDS)], innIds);
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return new ZMedicineMarkInn(innRu: innRu, innRuSoundex: innRuSoundex, innEn: innEn, innEnSoundex: innEnSoundex, innIds: innIds);
	}

	// to row from list
	static ZMedicineMarkInn toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4, String f5}) {
		final innRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkInn.C_INN_RU)) ?? 0];
		final innRuSoundex = values[keys?.indexOf(nvl(f2, ZMedicineMarkInn.C_INN_RU_SOUNDEX)) ?? 1];
		final innEn = values[keys?.indexOf(nvl(f3, ZMedicineMarkInn.C_INN_EN)) ?? 2];
		final innEnSoundex = values[keys?.indexOf(nvl(f4, ZMedicineMarkInn.C_INN_EN_SOUNDEX)) ?? 3];
		final innIds = values[keys?.indexOf(nvl(f5, ZMedicineMarkInn.C_INN_IDS)) ?? 4];
		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return new ZMedicineMarkInn(innRu: innRu, innRuSoundex: innRuSoundex, innEn: innEn, innEnSoundex: innEnSoundex, innIds: innIds);
	}

	// to row from list strings
	static ZMedicineMarkInn toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4, String f5}) {
		dynamic innRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkInn.C_INN_RU)) ?? 0];
		dynamic innRuSoundex = values[keys?.indexOf(nvl(f2, ZMedicineMarkInn.C_INN_RU_SOUNDEX)) ?? 1];
		dynamic innEn = values[keys?.indexOf(nvl(f3, ZMedicineMarkInn.C_INN_EN)) ?? 2];
		dynamic innEnSoundex = values[keys?.indexOf(nvl(f4, ZMedicineMarkInn.C_INN_EN_SOUNDEX)) ?? 3];
		dynamic innIds = values[keys?.indexOf(nvl(f5, ZMedicineMarkInn.C_INN_IDS)) ?? 4];

		ZMedicineMarkInn.checkPrimaryKeys(innRu);
		return new ZMedicineMarkInn(innRu: innRu, innRuSoundex: innRuSoundex, innEn: innEn, innEnSoundex: innEnSoundex, innIds: innIds);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
