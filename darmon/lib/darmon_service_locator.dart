import 'file:///D:/projects/darmon/smartup5x_darmon_mobile/darmon/lib/kernel/uis/ui_search_index_dao.dart';
import 'package:sqflite/sqflite.dart';

class DarmonServiceLocator {
  Database Function() database;

  DarmonServiceLocator(this.database);

  UISearchIndexDao _uiSearchIndexDao;

  UISearchIndexDao get searchIndexDao {
    if (_uiSearchIndexDao == null || _uiSearchIndexDao?.db?.isOpen != true) {
      _uiSearchIndexDao = UISearchIndexDao(database.call());
    }
    return _uiSearchIndexDao;
  }
}
