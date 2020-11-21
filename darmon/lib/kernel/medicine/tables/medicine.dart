// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class ZMedicine {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "z_medicine";
	// ignore: non_constant_identifier_names
	static const String C_MEDICINE_ID = "medicine_id";
	// ignore: non_constant_identifier_names
	static const String C_NAME_RU = "name_ru";
	// ignore: non_constant_identifier_names
	static const String C_NAME_UZ = "name_uz";
	// ignore: non_constant_identifier_names
	static const String C_NAME_EN = "name_en";
	// ignore: non_constant_identifier_names
	static const String C_PRODUCER_ID = "producer_id";
	// ignore: non_constant_identifier_names
	static const String C_PRODUCER_NAME = "producer_name";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table z_medicine (
	  medicine_id                           int not null,
	  name_ru                               text not null,
	  name_uz                               text not null,
	  name_en                               text not null,
	  producer_id                           int not null,
	  producer_name                         text not null,
	  constraint z_medicine_pk primary key (medicine_id)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(int medicineId, String nameRu, String nameUz, String nameEn, int producerId, String producerName) {
		ArgumentError.checkNotNull(medicineId, C_MEDICINE_ID);
		ArgumentError.checkNotNull(nameRu, C_NAME_RU);
		ArgumentError.checkNotNull(nameUz, C_NAME_UZ);
		ArgumentError.checkNotNull(nameEn, C_NAME_EN);
		ArgumentError.checkNotNull(producerId, C_PRODUCER_ID);
		ArgumentError.checkNotNull(producerName, C_PRODUCER_NAME);
	}

	static void checkPrimaryKeys(int medicineId) {
		ArgumentError.checkNotNull(medicineId, C_MEDICINE_ID);
	}

	//------------------------------------------------------------------------------------------------

	final int medicineId;
	final String nameRu;
	final String nameUz;
	final String nameEn;
	final int producerId;
	final String producerName;

	ZMedicine({@required this.medicineId, @required this.nameRu, @required this.nameUz, @required this.nameEn, @required this.producerId, @required this.producerName}) {
		checkPrimaryKeys(medicineId);
	}

	factory ZMedicine.fromData(Map<String, dynamic> data) {
		checkPrimaryKeys(data[C_MEDICINE_ID]);
		return ZMedicine(
			medicineId: data[C_MEDICINE_ID],
			nameRu: data[C_NAME_RU],
			nameUz: data[C_NAME_UZ],
			nameEn: data[C_NAME_EN],
			producerId: data[C_PRODUCER_ID],
			producerName: data[C_PRODUCER_NAME],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_MEDICINE_ID: this.medicineId,
			C_NAME_RU: this.nameRu,
			C_NAME_UZ: this.nameUz,
			C_NAME_EN: this.nameEn,
			C_PRODUCER_ID: this.producerId,
			C_PRODUCER_NAME: this.producerName,
		};
	}

	@override
	String toString() {
		 return "ZMedicine($C_MEDICINE_ID:$medicineId, $C_NAME_RU:$nameRu, $C_NAME_UZ:$nameUz, $C_NAME_EN:$nameEn, $C_PRODUCER_ID:$producerId, $C_PRODUCER_NAME:$producerName)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_ZMedicine {

	// init
	static ZMedicine init({@required int medicineId, @required String nameRu, @required String nameUz, @required String nameEn, @required int producerId, @required String producerName}) {
		ZMedicine.checkPrimaryKeys(medicineId);
		return new ZMedicine(medicineId: medicineId, nameRu: nameRu, nameUz: nameUz, nameEn: nameEn, producerId: producerId, producerName: producerName);
	}

	// load all rows in database
	static Future<List<ZMedicine>> loadAll(Database db) {
		return db.query(ZMedicine.TABLE_NAME)
			.then((it) => it.map((d) => ZMedicine.fromData(d)).toList());
	}

	// take row in database if no_data_found return null
	static Future<ZMedicine> take(Database db, int medicineId) async {
		ZMedicine.checkPrimaryKeys(medicineId);
		final result = await db.query(ZMedicine.TABLE_NAME, where: "${ZMedicine.C_MEDICINE_ID} = ?", whereArgs: [medicineId]);
		return result.isEmpty ? null : ZMedicine.fromData(result.first);
	}

	// load row in database if no_data_found throw exception
	static Future<ZMedicine> load(Database db, int medicineId) async {
		ZMedicine.checkPrimaryKeys(medicineId);
		final result = await take(db, medicineId);
		if (result == null) {
			throw Exception("no data found");
		}
		return result;
	}

	// check exist row in database return boolean if exists true or else
	static Future<bool> exist(Database db, int medicineId) {
		ZMedicine.checkPrimaryKeys(medicineId);
		return take(db, medicineId).then((it) => it != null);
	}

	// check exist row in database and getting result
	static Future<bool> existTake(Database db, int medicineId, void onResult(ZMedicine row)) async {
		ZMedicine.checkPrimaryKeys(medicineId);
		ArgumentError.checkNotNull(onResult, "OnResult");
		final result = await take(db, medicineId);
		onResult.call(result);
		return result != null;
	}

	// update row
	static Future<int> updateRow(Database db, ZMedicine row, {bool removeNull = false}) {
		ZMedicine.checkPrimaryKeys(row.medicineId);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.update(ZMedicine.TABLE_NAME, data, where: "${ZMedicine.C_MEDICINE_ID} = ?", whereArgs: [row.medicineId]);
	}

	// update by one
	static Future<int> updateOne(Database db, {@required int medicineId, String nameRu, String nameUz, String nameEn, int producerId, String producerName, bool removeNull = false}) {
		ZMedicine.checkPrimaryKeys(medicineId);
		return updateRow(db, toRowFromList(values: [medicineId, nameRu, nameUz, nameEn, producerId, producerName]), removeNull: removeNull);
	}

	// save row
	static Future<int> saveRow(Database db, ZMedicine row, {bool removeNull = false}) {
		ZMedicine.checkPrimaryKeys(row.medicineId);
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(ZMedicine.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required int medicineId, @required String nameRu, @required String nameUz, @required String nameEn, @required int producerId, @required String producerName, bool removeNull = false}) {
		ZMedicine.checkPrimaryKeys(medicineId);
		return saveRow(db, toRowFromList(values: [medicineId, nameRu, nameUz, nameEn, producerId, producerName]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(ZMedicine.TABLE_NAME);
	}

	// delete row by primary key
	static Future<int> deleteOne(Database db, int medicineId) {
		ZMedicine.checkPrimaryKeys(medicineId);
		return db.delete(ZMedicine.TABLE_NAME, where: "${ZMedicine.C_MEDICINE_ID} = ?", whereArgs: [medicineId]);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, ZMedicine row) {
		ZMedicine.checkRequired(row.medicineId, row.nameRu, row.nameUz, row.nameEn, row.producerId, row.producerName);
		return db.insert(ZMedicine.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required int medicineId, @required String nameRu, @required String nameUz, @required String nameEn, @required int producerId, @required String producerName}) {
		ZMedicine.checkRequired(medicineId, nameRu, nameUz, nameEn, producerId, producerName);
		return insertRowTry(db, toRowFromList(values: [medicineId, nameRu, nameUz, nameEn, producerId, producerName]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, ZMedicine row) {
		ZMedicine.checkRequired(row.medicineId, row.nameRu, row.nameUz, row.nameEn, row.producerId, row.producerName);
		return db.insert(ZMedicine.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required int medicineId, @required String nameRu, @required String nameUz, @required String nameEn, @required int producerId, @required String producerName}) {
		ZMedicine.checkRequired(medicineId, nameRu, nameUz, nameEn, producerId, producerName);
		return insertRow(db, toRowFromList(values: [medicineId, nameRu, nameUz, nameEn, producerId, producerName]));
	}

	// to map
	static Map<String, dynamic> toMap({ZMedicine row, String f1, String f2, String f3, String f4, String f5, String f6, int medicineId, String nameRu, String nameUz, String nameEn, int producerId, String producerName}) {
		medicineId = nvl(row?.medicineId, medicineId);
		nameRu = nvl(row?.nameRu, nameRu);
		nameUz = nvl(row?.nameUz, nameUz);
		nameEn = nvl(row?.nameEn, nameEn);
		producerId = nvl(row?.producerId, producerId);
		producerName = nvl(row?.producerName, producerName);
		ZMedicine.checkRequired(medicineId, nameRu, nameUz, nameEn, producerId, producerName);
		return {nvlString(f1, ZMedicine.C_MEDICINE_ID): medicineId, nvlString(f2, ZMedicine.C_NAME_RU): nameRu, nvlString(f3, ZMedicine.C_NAME_UZ): nameUz, nvlString(f4, ZMedicine.C_NAME_EN): nameEn, nvlString(f5, ZMedicine.C_PRODUCER_ID): producerId, nvlString(f6, ZMedicine.C_PRODUCER_NAME): producerName};
	}

	// to list
	static List<dynamic> toList({ZMedicine row, int medicineId, String nameRu, String nameUz, String nameEn, int producerId, String producerName}) {
		medicineId = nvl(row?.medicineId, medicineId);
		nameRu = nvl(row?.nameRu, nameRu);
		nameUz = nvl(row?.nameUz, nameUz);
		nameEn = nvl(row?.nameEn, nameEn);
		producerId = nvl(row?.producerId, producerId);
		producerName = nvl(row?.producerName, producerName);
		ZMedicine.checkRequired(medicineId, nameRu, nameUz, nameEn, producerId, producerName);
		return [medicineId, nameRu, nameUz, nameEn, producerId, producerName];
	}

	// to row from map
	static ZMedicine toRowFromMap({Map<String, dynamic> data, String f1, String f2, String f3, String f4, String f5, String f6, int medicineId, String nameRu, String nameUz, String nameEn, int producerId, String producerName}) {
		medicineId = nvl(data == null ? null : data[nvl(f1, ZMedicine.C_MEDICINE_ID)], medicineId);
		nameRu = nvl(data == null ? null : data[nvl(f2, ZMedicine.C_NAME_RU)], nameRu);
		nameUz = nvl(data == null ? null : data[nvl(f3, ZMedicine.C_NAME_UZ)], nameUz);
		nameEn = nvl(data == null ? null : data[nvl(f4, ZMedicine.C_NAME_EN)], nameEn);
		producerId = nvl(data == null ? null : data[nvl(f5, ZMedicine.C_PRODUCER_ID)], producerId);
		producerName = nvl(data == null ? null : data[nvl(f6, ZMedicine.C_PRODUCER_NAME)], producerName);
		ZMedicine.checkPrimaryKeys(medicineId);
		return new ZMedicine(medicineId: medicineId, nameRu: nameRu, nameUz: nameUz, nameEn: nameEn, producerId: producerId, producerName: producerName);
	}

	// to row from list
	static ZMedicine toRowFromList({@required List<dynamic> values, List<String> keys, String f1, String f2, String f3, String f4, String f5, String f6}) {
		final medicineId = values[keys?.indexOf(nvl(f1, ZMedicine.C_MEDICINE_ID)) ?? 0];
		final nameRu = values[keys?.indexOf(nvl(f2, ZMedicine.C_NAME_RU)) ?? 1];
		final nameUz = values[keys?.indexOf(nvl(f3, ZMedicine.C_NAME_UZ)) ?? 2];
		final nameEn = values[keys?.indexOf(nvl(f4, ZMedicine.C_NAME_EN)) ?? 3];
		final producerId = values[keys?.indexOf(nvl(f5, ZMedicine.C_PRODUCER_ID)) ?? 4];
		final producerName = values[keys?.indexOf(nvl(f6, ZMedicine.C_PRODUCER_NAME)) ?? 5];
		ZMedicine.checkPrimaryKeys(medicineId);
		return new ZMedicine(medicineId: medicineId, nameRu: nameRu, nameUz: nameUz, nameEn: nameEn, producerId: producerId, producerName: producerName);
	}

	// to row from list strings
	static ZMedicine toRowFromListString({@required List<String> values, List<String> keys, String f1, String f2, String f3, String f4, String f5, String f6}) {
		dynamic medicineId = values[keys?.indexOf(nvl(f1, ZMedicine.C_MEDICINE_ID)) ?? 0];
		dynamic nameRu = values[keys?.indexOf(nvl(f2, ZMedicine.C_NAME_RU)) ?? 1];
		dynamic nameUz = values[keys?.indexOf(nvl(f3, ZMedicine.C_NAME_UZ)) ?? 2];
		dynamic nameEn = values[keys?.indexOf(nvl(f4, ZMedicine.C_NAME_EN)) ?? 3];
		dynamic producerId = values[keys?.indexOf(nvl(f5, ZMedicine.C_PRODUCER_ID)) ?? 4];
		dynamic producerName = values[keys?.indexOf(nvl(f6, ZMedicine.C_PRODUCER_NAME)) ?? 5];
		medicineId = medicineId is String && medicineId.isNotEmpty ? num.parse(medicineId) : null;
		producerId = producerId is String && producerId.isNotEmpty ? num.parse(producerId) : null;
		ZMedicine.checkPrimaryKeys(medicineId);
		return new ZMedicine(medicineId: medicineId, nameRu: nameRu, nameUz: nameUz, nameEn: nameEn, producerId: producerId, producerName: producerName);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
