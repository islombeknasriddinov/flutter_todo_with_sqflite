import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/kernel/uis/ui_search_index_dao.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_list/medicine_list_viewmodel.dart';
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

  UIDarmonDao _darmonDao;

  UIDarmonDao get darmonDao {
    if (_darmonDao == null || _darmonDao?.db?.isOpen != true) {
      _darmonDao = UIDarmonDao(database.call());
    }
    return _darmonDao;
  }

  DarmonRepository _darmonRepository;

  DarmonRepository get darmonRepository {
    if (_darmonRepository == null) {
      _darmonRepository = DarmonRepository(darmonDao);
    }
    return _darmonRepository;
  }

  MedicineListRepository _medicineListRepository;

  MedicineListRepository get medicineListRepository {
    if (_medicineListRepository == null) {
      _medicineListRepository = MedicineListRepository();
    }
    return _medicineListRepository;
  }
}
