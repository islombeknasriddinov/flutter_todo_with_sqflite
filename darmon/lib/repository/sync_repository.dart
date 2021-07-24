import 'package:darmon/common/darmon_pref.dart';
import 'package:darmon/kernel/database.dart';
import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/network/network_manager.dart';
import 'package:gwslib/gwslib.dart';

class SyncRepository {
  static SyncRepository _instance;

  static void init(UIDarmonDao dao) {
    if (_instance == null) {
      _instance = SyncRepository._(dao);
    }
  }

  static SyncRepository getInstance({UIDarmonDao dao}) {
    if (_instance != null) {
      return _instance;
    }
    if (dao != null) {
      return SyncRepository._(dao);
    } else {
      throw Exception(
          "SyncRepository not installed. Please use init() function before call getInstance() function");
    }
  }

  final UIDarmonDao dao;

  SyncRepository._(this.dao);

  Stream<bool> _syncStatus;
  Exception _error;

  Stream<bool> get syncInProgress => _syncStatus;

  Exception get error => _error;

  Future<void> sync() async {
    LazyStream<bool> _sync = LazyStream();
    _syncStatus = _sync.stream;
    _sync.add(true);
    try {
      Log.debug("sync() start");
      await checkSync();
      Log.debug("sync() end");
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      _error = error;
    }
    _sync.add(false);
    _syncStatus = null;
    _sync.close();
  }

  Future<bool> checkSync() async {
    DateTime now = DateTime.now();
    String timeStamp = await DarmonPref.getLastVisitTimestamp();
    if (timeStamp?.isNotEmpty == true) {
      int syncTime = DateUtil.parse(timeStamp).millisecondsSinceEpoch;
      if (syncTime >=
          DateTime(now.year, now.month, now.day, now.hour - 12).millisecondsSinceEpoch) {
        return Future.value(false);
      }
    }
    Map<String, dynamic> result = await NetworkManager.sync();
    Timer timer = Timer();
    timer.start();
    await DarmonDatabase.sync(result);
    timer.stop("sync ended");
    DarmonPref.saveLastVisitTimestamp(result['laststamp']);
    DarmonPref.saveLastVisitTimestamp(
        DateUtil.format(DateTime.now(), DateUtil.FORMAT_DD_MM_YYYY_HH_MM));
    return true;
  }
}
