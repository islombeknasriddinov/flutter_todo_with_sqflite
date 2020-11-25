// WARNING: THIS FILE IS GENERATE AUTOMATICALLY
// NOT EDIT THIS FILE BY HAND
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

// Database table object information
class ZMedicineMarkInn {
	// ignore: non_constant_identifier_names
	static const String TABLE_NAME = "z_medicine_mark_inn";
	// ignore: non_constant_identifier_names
	static const String C_INN = "inn";

	//------------------------------------------------------------------------------------------------

	// ignore: non_constant_identifier_names
	static final String TABLE = """
	create table z_medicine_mark_inn (
	  inn                               text not null,
	  constraint z_medicine_mark_inn_pk primary key (name_inn)
	);
	""";

	//------------------------------------------------------------------------------------------------

	static void checkRequired(String inn) {
		ArgumentError.checkNotNull(inn, C_INN);
	}

	final String inn;

	ZMedicineMarkInn({@required this.inn});

	factory ZMedicineMarkInn.fromData(Map<String, dynamic> data) {
		return ZMedicineMarkInn(
			inn: data[C_INN],
		);
	}

	Map<String, dynamic> toData() {
		return {
			C_INN: this.inn,
		};
	}

	@override
	String toString() {
		 return "ZMedicineMarkInn($C_INN:$inn)";
	}
}

// Database table common functions
// ignore: camel_case_types
class Z_ZMedicineMarkInn {

	// init
	static ZMedicineMarkInn init({@required String inn}) {
		return new ZMedicineMarkInn(inn: inn);
	}

	// load all rows in database
	static Future<List<ZMedicineMarkInn>> loadAll(Database db) {
		return db.query(ZMedicineMarkInn.TABLE_NAME)
			.then((it) => it.map((d) => ZMedicineMarkInn.fromData(d)).toList());
	}

	// save row
	static Future<int> saveRow(Database db, ZMedicineMarkInn row, {bool removeNull = false}) {
		final data = row.toData();
		if (removeNull) {
			data.removeWhere((key, value) => value == null);
		}
		return db.insert(ZMedicineMarkInn.TABLE_NAME, data, conflictAlgorithm: ConflictAlgorithm.replace);
	}

	// save one
	static Future<int> saveOne(Database db, {@required String inn, bool removeNull = false}) {
		return saveRow(db, toRowFromList(values: [inn]), removeNull: removeNull);
	}

	// delete all rows in database
	static Future<int> deleteAll(Database db) {
		return db.delete(ZMedicineMarkInn.TABLE_NAME);
	}

	// insert row try insert if exists abort
	static Future<int> insertRowTry(Database db, ZMedicineMarkInn row) {
		ZMedicineMarkInn.checkRequired(row.inn);
		return db.insert(ZMedicineMarkInn.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.abort);
	}

	static Future<int> insertOneTry(Database db, {@required String inn}) {
		ZMedicineMarkInn.checkRequired(inn);
		return insertRowTry(db, toRowFromList(values: [inn]));
	}

	// insert row if exists fail
	static Future<int> insertRow(Database db, ZMedicineMarkInn row) {
		ZMedicineMarkInn.checkRequired(row.inn);
		return db.insert(ZMedicineMarkInn.TABLE_NAME, row.toData(), conflictAlgorithm: ConflictAlgorithm.fail);
	}

	static Future<int> insertOne(Database db, {@required String inn}) {
		ZMedicineMarkInn.checkRequired(inn);
		return insertRow(db, toRowFromList(values: [inn]));
	}

	// to map
	static Map<String, dynamic> toMap({ZMedicineMarkInn row, String f1, String inn}) {
		inn = nvl(row?.inn, inn);
		ZMedicineMarkInn.checkRequired(inn);
		return {nvlString(f1, ZMedicineMarkInn.C_INN): inn};
	}

	// to list
	static List<dynamic> toList({ZMedicineMarkInn row, String inn}) {
		inn = nvl(row?.inn, inn);
		ZMedicineMarkInn.checkRequired(inn);
		return [inn];
	}

	// to row from map
	static ZMedicineMarkInn toRowFromMap({Map<String, dynamic> data, String f1, String inn}) {
		inn = nvl(data == null ? null : data[nvl(f1, ZMedicineMarkInn.C_INN)], inn);
		return new ZMedicineMarkInn(inn: inn);
	}

	// to row from list
	static ZMedicineMarkInn toRowFromList({@required List<dynamic> values, List<String> keys, String f1}) {
		final inn = values[keys?.indexOf(nvl(f1, ZMedicineMarkInn.C_INN)) ?? 0];
		return new ZMedicineMarkInn(inn: inn);
	}

	// to row from list strings
	static ZMedicineMarkInn toRowFromListString({@required List<String> values, List<String> keys, String f1}) {
		dynamic inn = values[keys?.indexOf(nvl(f1, ZMedicineMarkInn.C_INN)) ?? 0];

		return new ZMedicineMarkInn(inn: inn);
	}

	static R nvl<R>(R a, R b) {
		return a == null ? b : a;
	}

	static String nvlString(String a, String b) {
		return a == null || a.isEmpty ? b : a;
	}
}
