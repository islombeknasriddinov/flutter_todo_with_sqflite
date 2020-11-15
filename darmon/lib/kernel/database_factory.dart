import 'package:darmon/filter/kernel/database.dart';
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
    if (!FilterDatabase.isOpen()) {
      await FilterDatabase.init("darmon");
    }
  }

  // check is open database
  bool isOpen() => _isOpenAccountDatabase();

  // getting connected database
  Database getDatabase() => FilterDatabase.instance();

  // close database
  Future<void> close() => FilterDatabase.close();

  //------------------------------------------------------------------------------------------------

  bool _isOpenAccountDatabase() => FilterDatabase.isOpen();
}
