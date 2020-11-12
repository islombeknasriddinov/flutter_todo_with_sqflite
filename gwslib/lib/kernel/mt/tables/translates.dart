// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class MtTranslates {
	// ignore: non_constant_identifier_names
	static final String TABLE_NAME = "mt_translates";
	// ignore: non_constant_identifier_names
	static final String C_PROJECT_CODE = "project_code";
	// ignore: non_constant_identifier_names
	static final String C_TRANSLATE_CODE = "translate_code";
	// ignore: non_constant_identifier_names
	static final String C_TEXT_RU = "text_ru";
	// ignore: non_constant_identifier_names
	static final String C_TEXT_EN = "text_en";
	// ignore: non_constant_identifier_names
	static final String C_TEXT_UZ = "text_uz";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table mt_translates (
	  project_code                     text not null,
	  translate_code                   text not null,
	  text_ru                          text not null,
	  text_en                          text,
	  text_uz                          text,
	  constraint mt_translates_pk primary key (translate_code)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String projectCode, String translateCode, String textRu) {
		ArgumentError.checkNotNull(projectCode, C_PROJECT_CODE);
		ArgumentError.checkNotNull(translateCode, C_TRANSLATE_CODE);
		ArgumentError.checkNotNull(textRu, C_TEXT_RU);
	}

	static void checkPrimaryKeys(String translateCode) {
		ArgumentError.checkNotNull(translateCode, C_TRANSLATE_CODE);
	}

	//------------------------------------------------------------------------------------------------

	final String projectCode;
	final String translateCode;
	final String textRu;
	final String textEn;
	final String textUz;

	MtTranslates({@required this.projectCode, @required this.translateCode, @required this.textRu, this.textEn, this.textUz}) {
		checkPrimaryKeys(translateCode);
	}

	factory MtTranslates.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_TRANSLATE_CODE]);
		return MtTranslates(
			projectCode: data[C_PROJECT_CODE],
			translateCode: data[C_TRANSLATE_CODE],
			textRu: data[C_TEXT_RU],
			textEn: data[C_TEXT_EN],
			textUz: data[C_TEXT_UZ],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_PROJECT_CODE: this.projectCode,
			C_TRANSLATE_CODE: this.translateCode,
			C_TEXT_RU: this.textRu,
			C_TEXT_EN: this.textEn,
			C_TEXT_UZ: this.textUz,
		};
	}

	@override
	String toString() {
		 return "MtTranslates($C_PROJECT_CODE:$projectCode, $C_TRANSLATE_CODE:$translateCode, $C_TEXT_RU:$textRu, $C_TEXT_EN:$textEn, $C_TEXT_UZ:$textUz)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_MtTranslates {

	// init
	static MtTranslates init({@required String projectCode, @required String translateCode, @required String textRu, String textEn, String textUz}) {
		MtTranslates.checkPrimaryKeys(translateCode);
		return new MtTranslates(projectCode: projectCode, translateCode: translateCode, textRu: textRu, textEn: textEn, textUz: textUz);
	}

	// load all rows in database
	static Future<List<MtTranslates>> loadAll(Database db) {
		return db.query(MtTranslates.TABLE_NAME)
			.then((it) => it.map((d) => MtTranslates.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<MtTranslates> take(Database db, String translateCode) async {
		MtTranslates.checkPrimaryKeys(translateCode);
		final result = await db.query(MtTranslates.TABLE_NAME, where: "${MtTranslates.C_TRANSLATE_CODE} = ?", whereArgs: [translateCode]);
		return result.isEmpty ? null : MtTranslates.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<MtTranslates> load(Database db, String translateCode) async {
		MtTranslates.checkPrimaryKeys(translateCode);
		final result = await take(db, translateCode);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, String translateCode) {
		MtTranslates.checkPrimaryKeys(translateCode);
		return take(db, translateCode).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, String translateCode, void onResult(MtTranslates row)) async {
		MtTranslates.checkPrimaryKeys(translateCode);
		ArgumentError.checkNotNull(onResult, "OnResult");
		final result = await take(db, translateCode);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateRow(Database db, MtTranslates row, {bool removeNull = false}) {
		MtTranslates.checkPrimaryKeys(row.translateCode);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.update(MtTranslates.TABLE_NAME, data, where: "${MtTranslates.C_TRANSLATE_CODE} = ?", whereArgs: [row.translateCode]);
	}

	// update by one
	static Future<int> updateOne(Database db, {String projectCode, @required String translateCode, String textRu, String textEn, String textUz, bool removeNull = false}) {
		MtTranslates.checkPrimaryKeys(translateCode);
		return updateRow(db, toRowFromList(values: [projectCode, translateCode, textRu, textEn, textUz]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(Database db, MtTranslates row, {bool removeNull = false}) {
		MtTranslates.checkPrimaryKeys(row.translateCode);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(MtTranslates.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required String projectCode, @required String translateCode, @required String textRu, String textEn, String textUz, bool removeNull = false}) {
		MtTranslates.checkPrimaryKeys(translateCode);
		return saveRow(db, toRowFromList(values: [projectCode, translateCode, textRu, textEn, textUz]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(MtTranslates.TABLE_NAME);
	}

	// delete row by primary key
	static Future<int> deleteOne(Database db, String translateCode) {
		MtTranslates.checkPrimaryKeys(translateCode);
		return db.delete(MtTranslates.TABLE_NAME, where: "${MtTranslates.C_TRANSLATE_CODE} = ?", whereArgs: [translateCode]);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, MtTranslates row) {
		MtTranslates.checkRequired(row.projectCode, row.translateCode, row.textRu);
		return db.insert(MtTranslates.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String projectCode, @required String translateCode, @required String textRu, String textEn, String textUz}) {
		MtTranslates.checkRequired(projectCode, translateCode, textRu);
		return insertRowTry(db, toRowFromList(values: [projectCode, translateCode, textRu, textEn, textUz]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, MtTranslates row) {
		MtTranslates.checkRequired(row.projectCode, row.translateCode, row.textRu);
		return db.insert(MtTranslates.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String projectCode, @required String translateCode, @required String textRu, String textEn, String textUz}) {
		MtTranslates.checkRequired(projectCode, translateCode, textRu);
		return insertRow(db, toRowFromList(values: [projectCode, translateCode, textRu, textEn, textUz]));
	}

	// to map
	static Map<String, dynamic> toMap({MtTranslates row, String f1, String f2, String f3, String f4, String f5, String projectCode, String translateCode, String textRu, String textEn, String textUz}) {
		projectCode = nvl(row?.projectCode, projectCode);
		translateCode = nvl(row?.translateCode, translateCode);
		textRu = nvl(row?.textRu, textRu);
		textEn = nvl(row?.textEn, textEn);
		textUz = nvl(row?.textUz, textUz);
		MtTranslates.checkRequired(projectCode, translateCode, textRu);
		return {nvlString(f1, MtTranslates.C_PROJECT_CODE): projectCode, nvlString(f2, MtTranslates.C_TRANSLATE_CODE): translateCode, nvlString(f3, MtTranslates.C_TEXT_RU): textRu, nvlString(f4, MtTranslates.C_TEXT_EN): textEn, nvlString(f5, MtTranslates.C_TEXT_UZ): textUz};
	}

	// to list
	static List<dynamic> toList({MtTranslates row, String projectCode, String translateCode, String textRu, String textEn, String textUz}) {
		projectCode = nvl(row?.projectCode, projectCode);
		translateCode = nvl(row?.translateCode, translateCode);
		textRu = nvl(row?.textRu, textRu);
		textEn = nvl(row?.textEn, textEn);
		textUz = nvl(row?.textUz, textUz);
		MtTranslates.checkRequired(projectCode, translateCode, textRu);
		return [projectCode, translateCode, textRu, textEn, textUz];
	}

	// to row from map
	static MtTranslates toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String f5, String projectCode, String translateCode, String textRu, String textEn, String textUz}) {
		projectCode = nvl(data == null ? null : data[nvl(f1, MtTranslates.C_PROJECT_CODE)], projectCode);
		translateCode = nvl(data == null ? null : data[nvl(f2, MtTranslates.C_TRANSLATE_CODE)], translateCode);
		textRu = nvl(data == null ? null : data[nvl(f3, MtTranslates.C_TEXT_RU)], textRu);
		textEn = nvl(data == null ? null : data[nvl(f4, MtTranslates.C_TEXT_EN)], textEn);
		textUz = nvl(data == null ? null : data[nvl(f5, MtTranslates.C_TEXT_UZ)], textUz);
		MtTranslates.checkPrimaryKeys(translateCode);
		return new MtTranslates(projectCode: projectCode, translateCode: translateCode, textRu: textRu, textEn: textEn, textUz: textUz);
	}

	// to row from list
	static MtTranslates toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4, String f5}) {
		final projectCode = values[keys?.indexOf(nvl(f1, MtTranslates.C_PROJECT_CODE)) ?? 0];
		final translateCode = values[keys?.indexOf(nvl(f2, MtTranslates.C_TRANSLATE_CODE)) ?? 1];
		final textRu = values[keys?.indexOf(nvl(f3, MtTranslates.C_TEXT_RU)) ?? 2];
		final textEn = values[keys?.indexOf(nvl(f4, MtTranslates.C_TEXT_EN)) ?? 3];
		final textUz = values[keys?.indexOf(nvl(f5, MtTranslates.C_TEXT_UZ)) ?? 4];
		MtTranslates.checkPrimaryKeys(translateCode);
		return new MtTranslates(projectCode: projectCode, translateCode: translateCode, textRu: textRu, textEn: textEn, textUz: textUz);
	}

	// to row from list strings
	static MtTranslates toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4, String f5}) {
		dynamic projectCode = values[keys?.indexOf(nvl(f1, MtTranslates.C_PROJECT_CODE)) ?? 0];
		dynamic translateCode = values[keys?.indexOf(nvl(f2, MtTranslates.C_TRANSLATE_CODE)) ?? 1];
		dynamic textRu = values[keys?.indexOf(nvl(f3, MtTranslates.C_TEXT_RU)) ?? 2];
		dynamic textEn = values[keys?.indexOf(nvl(f4, MtTranslates.C_TEXT_EN)) ?? 3];
		dynamic textUz = values[keys?.indexOf(nvl(f5, MtTranslates.C_TEXT_UZ)) ?? 4];

		MtTranslates.checkPrimaryKeys(translateCode);
		return new MtTranslates(projectCode: projectCode, translateCode: translateCode, textRu: textRu, textEn: textEn, textUz: textUz);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
