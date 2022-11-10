import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/kernel/uis/ui_search_history_dao.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/repository/medicine_list_repository.dart';
import 'package:darmon/repository/sync_repository.dart';
import 'package:sqflite/sqflite.dart';

class DarmonServiceLocator {
  Database Function() database;

  DarmonServiceLocator(this.database);

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

  UISearchHistoryDao _searchHistoryDao;

  UISearchHistoryDao get searchHistoryDao {
    if (_searchHistoryDao == null) {
      _searchHistoryDao = UISearchHistoryDao(database.call());
    }
    return _searchHistoryDao;
  }

  SyncRepository get syncRepository => SyncRepository.getInstance();
}
