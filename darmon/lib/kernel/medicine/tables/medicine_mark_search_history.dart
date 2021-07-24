// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class ZMedicineMarkSearchHistory {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "z_medicine_mark_search_history";
	// ignore: non_constant_identifier_names
	static const String C_TITLE_RU = "title_ru";
	// ignore: non_constant_identifier_names
	static const String C_TITLE_EN = "title_en";
	// ignore: non_constant_identifier_names
	static const String C_TITLE_UZ = "title_uz";
	// ignore: non_constant_identifier_names
	static const String C_SEND_SERVER_TEXT = "send_server_text";
	// ignore: non_constant_identifier_names
	static const String C_TYPE = "type";
	// ignore: non_constant_identifier_names
	static const String C_ORDER_NO = "order_no";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table z_medicine_mark_search_history (
	  title_ru                             text not null,
	  title_en                             text,
	  title_uz                             text,
	  send_server_text                     text not null,
	  type                                 int not null,
	  order_no                             int not null,
	  constraint z_medicine_mark_search_history_pk primary key (title_ru,type)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String titleRu, String sendServerText, int type, int orderNo) {
		ArgumentError.checkNotNull(titleRu, C_TITLE_RU);
		ArgumentError.checkNotNull(sendServerText, C_SEND_SERVER_TEXT);
		ArgumentError.checkNotNull(type, C_TYPE);
		ArgumentError.checkNotNull(orderNo, C_ORDER_NO);
	}

	static void checkPrimaryKeys(String titleRu, int type) {
		ArgumentError.checkNotNull(titleRu, C_TITLE_RU);
		ArgumentError.checkNotNull(type, C_TYPE);
	}

	//------------------------------------------------------------------------------------------------

	final String titleRu;
	final String titleEn;
	final String titleUz;
	final String sendServerText;
	final int type;
	final int orderNo;

	ZMedicineMarkSearchHistory({@required this.titleRu, this.titleEn, this.titleUz, @required this.sendServerText, @required this.type, @required this.orderNo}) {
		checkPrimaryKeys(titleRu, type);
	}

	factory ZMedicineMarkSearchHistory.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_TITLE_RU], data[C_TYPE]);
		return ZMedicineMarkSearchHistory(
			titleRu: data[C_TITLE_RU],
			titleEn: data[C_TITLE_EN],
			titleUz: data[C_TITLE_UZ],
			sendServerText: data[C_SEND_SERVER_TEXT],
			type: data[C_TYPE],
			orderNo: data[C_ORDER_NO],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_TITLE_RU: this.titleRu,
			C_TITLE_EN: this.titleEn,
			C_TITLE_UZ: this.titleUz,
			C_SEND_SERVER_TEXT: this.sendServerText,
			C_TYPE: this.type,
			C_ORDER_NO: this.orderNo,
		};
	}

	@override
	String toString() {
		 return "ZMedicineMarkSearchHistory($C_TITLE_RU:$titleRu, $C_TITLE_EN:$titleEn, $C_TITLE_UZ:$titleUz, $C_SEND_SERVER_TEXT:$sendServerText, $C_TYPE:$type, $C_ORDER_NO:$orderNo)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_ZMedicineMarkSearchHistory {

	// init
	static ZMedicineMarkSearchHistory init({@required String titleRu, String titleEn, String titleUz, @required String sendServerText, @required int type, @required int orderNo}) {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		return new ZMedicineMarkSearchHistory(titleRu: titleRu, titleEn: titleEn, titleUz: titleUz, sendServerText: sendServerText, type: type, orderNo: orderNo);
	}

	// load all rows in database
	static Future<List<ZMedicineMarkSearchHistory>> loadAll(Database db) {
		return db.query(ZMedicineMarkSearchHistory.TABLE_NAME)
			.then((it) => it.map((d) => ZMedicineMarkSearchHistory.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<ZMedicineMarkSearchHistory> take(Database db, String titleRu, int type) async {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		final result = await db.query(ZMedicineMarkSearchHistory.TABLE_NAME, where: "${ZMedicineMarkSearchHistory.C_TITLE_RU} = ? AND ${ZMedicineMarkSearchHistory.C_TYPE} = ?", whereArgs: [titleRu, type]);
		return result.isEmpty ? null : ZMedicineMarkSearchHistory.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<ZMedicineMarkSearchHistory> load(Database db, String titleRu, int type) async {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		final result = await take(db, titleRu, type);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, String titleRu, int type) {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		return take(db, titleRu, type).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, String titleRu, int type, void onResult(ZMedicineMarkSearchHistory row)) async {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		ArgumentError.checkNotNull(onResult, "OnResult");
		final result = await take(db, titleRu, type);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateRow(Database db, ZMedicineMarkSearchHistory row, {bool removeNull = false}) {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(row.titleRu, row.type);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.update(ZMedicineMarkSearchHistory.TABLE_NAME, data, where: "${ZMedicineMarkSearchHistory.C_TITLE_RU} = ? AND ${ZMedicineMarkSearchHistory.C_TYPE} = ?", whereArgs: [row.titleRu, row.type]);
	}

	// update by one
	static Future<int> updateOne(Database db, {@required String titleRu, String titleEn, String titleUz, String sendServerText, @required int type, int orderNo, bool removeNull = false}) {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		return updateRow(db, toRowFromList(values: [titleRu, titleEn, titleUz, sendServerText, type, orderNo]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(Database db, ZMedicineMarkSearchHistory row, {bool removeNull = false}) {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(row.titleRu, row.type);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(ZMedicineMarkSearchHistory.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required String titleRu, String titleEn, String titleUz, @required String sendServerText, @required int type, @required int orderNo, bool removeNull = false}) {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		return saveRow(db, toRowFromList(values: [titleRu, titleEn, titleUz, sendServerText, type, orderNo]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(ZMedicineMarkSearchHistory.TABLE_NAME);
	}

	// delete row by primary key
	static Future<int> deleteOne(Database db, String titleRu, int type) {
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		return db.delete(ZMedicineMarkSearchHistory.TABLE_NAME, where: "${ZMedicineMarkSearchHistory.C_TITLE_RU} = ? AND ${ZMedicineMarkSearchHistory.C_TYPE} = ?", whereArgs: [titleRu, type]);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, ZMedicineMarkSearchHistory row) {
		ZMedicineMarkSearchHistory.checkRequired(row.titleRu, row.sendServerText, row.type, row.orderNo);
		return db.insert(ZMedicineMarkSearchHistory.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String titleRu, String titleEn, String titleUz, @required String sendServerText, @required int type, @required int orderNo}) {
		ZMedicineMarkSearchHistory.checkRequired(titleRu, sendServerText, type, orderNo);
		return insertRowTry(db, toRowFromList(values: [titleRu, titleEn, titleUz, sendServerText, type, orderNo]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, ZMedicineMarkSearchHistory row) {
		ZMedicineMarkSearchHistory.checkRequired(row.titleRu, row.sendServerText, row.type, row.orderNo);
		return db.insert(ZMedicineMarkSearchHistory.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String titleRu, String titleEn, String titleUz, @required String sendServerText, @required int type, @required int orderNo}) {
		ZMedicineMarkSearchHistory.checkRequired(titleRu, sendServerText, type, orderNo);
		return insertRow(db, toRowFromList(values: [titleRu, titleEn, titleUz, sendServerText, type, orderNo]));
	}

	// to map
	static Map<String, dynamic> toMap({ZMedicineMarkSearchHistory row, String f1, String f2, String f3, String f4, String f5, String f6, String titleRu, String titleEn, String titleUz, String sendServerText, int type, int orderNo}) {
		titleRu = nvl(row?.titleRu, titleRu);
		titleEn = nvl(row?.titleEn, titleEn);
		titleUz = nvl(row?.titleUz, titleUz);
		sendServerText = nvl(row?.sendServerText, sendServerText);
		type = nvl(row?.type, type);
		orderNo = nvl(row?.orderNo, orderNo);
		ZMedicineMarkSearchHistory.checkRequired(titleRu, sendServerText, type, orderNo);
		return {nvlString(f1, ZMedicineMarkSearchHistory.C_TITLE_RU): titleRu, nvlString(f2, ZMedicineMarkSearchHistory.C_TITLE_EN): titleEn, nvlString(f3, ZMedicineMarkSearchHistory.C_TITLE_UZ): titleUz, nvlString(f4, ZMedicineMarkSearchHistory.C_SEND_SERVER_TEXT): sendServerText, nvlString(f5, ZMedicineMarkSearchHistory.C_TYPE): type, nvlString(f6, ZMedicineMarkSearchHistory.C_ORDER_NO): orderNo};
	}

	// to list
	static List<dynamic> toList({ZMedicineMarkSearchHistory row, String titleRu, String titleEn, String titleUz, String sendServerText, int type, int orderNo}) {
		titleRu = nvl(row?.titleRu, titleRu);
		titleEn = nvl(row?.titleEn, titleEn);
		titleUz = nvl(row?.titleUz, titleUz);
		sendServerText = nvl(row?.sendServerText, sendServerText);
		type = nvl(row?.type, type);
		orderNo = nvl(row?.orderNo, orderNo);
		ZMedicineMarkSearchHistory.checkRequired(titleRu, sendServerText, type, orderNo);
		return [titleRu, titleEn, titleUz, sendServerText, type, orderNo];
	}

	// to row from map
	static ZMedicineMarkSearchHistory toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String f5, String f6, String titleRu, String titleEn, String titleUz, String sendServerText, int type, int orderNo}) {
		titleRu = nvl(data == null ? null : data[nvl(f1, ZMedicineMarkSearchHistory.C_TITLE_RU)], titleRu);
		titleEn = nvl(data == null ? null : data[nvl(f2, ZMedicineMarkSearchHistory.C_TITLE_EN)], titleEn);
		titleUz = nvl(data == null ? null : data[nvl(f3, ZMedicineMarkSearchHistory.C_TITLE_UZ)], titleUz);
		sendServerText = nvl(data == null ? null : data[nvl(f4, ZMedicineMarkSearchHistory.C_SEND_SERVER_TEXT)], sendServerText);
		type = nvl(data == null ? null : data[nvl(f5, ZMedicineMarkSearchHistory.C_TYPE)], type);
		orderNo = nvl(data == null ? null : data[nvl(f6, ZMedicineMarkSearchHistory.C_ORDER_NO)], orderNo);
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		return new ZMedicineMarkSearchHistory(titleRu: titleRu, titleEn: titleEn, titleUz: titleUz, sendServerText: sendServerText, type: type, orderNo: orderNo);
	}

	// to row from list
	static ZMedicineMarkSearchHistory toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4, String f5, String f6}) {
		final titleRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkSearchHistory.C_TITLE_RU)) ?? 0];
		final titleEn = values[keys?.indexOf(nvl(f2, ZMedicineMarkSearchHistory.C_TITLE_EN)) ?? 1];
		final titleUz = values[keys?.indexOf(nvl(f3, ZMedicineMarkSearchHistory.C_TITLE_UZ)) ?? 2];
		final sendServerText = values[keys?.indexOf(nvl(f4, ZMedicineMarkSearchHistory.C_SEND_SERVER_TEXT)) ?? 3];
		final type = values[keys?.indexOf(nvl(f5, ZMedicineMarkSearchHistory.C_TYPE)) ?? 4];
		final orderNo = values[keys?.indexOf(nvl(f6, ZMedicineMarkSearchHistory.C_ORDER_NO)) ?? 5];
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		return new ZMedicineMarkSearchHistory(titleRu: titleRu, titleEn: titleEn, titleUz: titleUz, sendServerText: sendServerText, type: type, orderNo: orderNo);
	}

	// to row from list strings
	static ZMedicineMarkSearchHistory toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4, String f5, String f6}) {
		dynamic titleRu = values[keys?.indexOf(nvl(f1, ZMedicineMarkSearchHistory.C_TITLE_RU)) ?? 0];
		dynamic titleEn = values[keys?.indexOf(nvl(f2, ZMedicineMarkSearchHistory.C_TITLE_EN)) ?? 1];
		dynamic titleUz = values[keys?.indexOf(nvl(f3, ZMedicineMarkSearchHistory.C_TITLE_UZ)) ?? 2];
		dynamic sendServerText = values[keys?.indexOf(nvl(f4, ZMedicineMarkSearchHistory.C_SEND_SERVER_TEXT)) ?? 3];
		dynamic type = values[keys?.indexOf(nvl(f5, ZMedicineMarkSearchHistory.C_TYPE)) ?? 4];
		dynamic orderNo = values[keys?.indexOf(nvl(f6, ZMedicineMarkSearchHistory.C_ORDER_NO)) ?? 5];
		type = type is String && type.isNotEmpty ? num.parse(type) : null;
		orderNo = orderNo is String && orderNo.isNotEmpty ? num.parse(orderNo) : null;
		ZMedicineMarkSearchHistory.checkPrimaryKeys(titleRu, type);
		return new ZMedicineMarkSearchHistory(titleRu: titleRu, titleEn: titleEn, titleUz: titleUz, sendServerText: sendServerText, type: type, orderNo: orderNo);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
