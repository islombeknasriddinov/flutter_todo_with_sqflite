import 'package:darmon/filter/kernel/database.dart';
import 'package:darmon/kernel/database.dart';
import 'package:gwslib/gwslib.dart';
import 'package:sqflite/sqflite.dart';

class DarmonDatabaseFactory {
  static DarmonDatabaseFactory instance = DarmonDatabaseFactory();
  static bool _startInit = false;

  Future<void> connectDatabase() async {
    if (_startInit) {
      return;
    }
    _startInit = true;
    try {
      await this.close();
      await this.init();
    } catch (e, st) {
      Log.error(e, st);
      rethrow;
    } finally {
      _startInit = false;
    }
  }

  // init database
  Future<void> init() async {
    await FilterDatabase.init("darmon_filter");
    await FilterDatabase.instance().close();
    await DarmonDatabase.init();
  }

  // check is open database
  bool isOpen() => DarmonDatabase.isOpen();

  // getting connected database
  Database getDatabase() => DarmonDatabase.instance();

  // close database
  Future<void> close() async {
    await FilterDatabase.close();
    await DarmonDatabase.close();
  }

//------------------------------------------------------------------------------------------------

}
