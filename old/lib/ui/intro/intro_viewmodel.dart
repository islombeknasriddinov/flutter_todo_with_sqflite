import 'package:connectivity/connectivity.dart';
import 'package:darmon/common/darmon_pref.dart';
import 'package:darmon/repository/sync_repository.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class IntroViewModel extends ViewModel {
  final SyncRepository _syncRepository;

  IntroViewModel(this._syncRepository);

  LazyStream<ConnectivityResult> _connectionState = LazyStream();

  Stream<ConnectivityResult> get connectionState => _connectionState.stream;

  ConnectivityResult get getConnectionState => _connectionState.value;

  @override
  void onCreate() {
    super.onCreate();
    checkConnection();
  }

  Future<bool> isSelectedSystemLanguage() async {
    final langCode = await LocalizationPref.getLanguage();
    return langCode != null && langCode.isNotEmpty;
  }

  Future<bool> isSynced() => DarmonPref.getLastVisitTimestamp().then((v) => v?.isNotEmpty == true);

  void checkConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      _connectionState.add(result);
      if ((result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) &&
          (!(await isSelectedSystemLanguage()) || !(await isSynced()))) {
        _syncRepository.sync();
      }
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      setErrorMessage(error, st);
    }
  }

  @override
  void onDestroy() {
    _connectionState.close();
    super.onDestroy();
  }
}
