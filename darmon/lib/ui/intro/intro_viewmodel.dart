import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:darmon/repository/sync_job.dart';
import 'package:darmon/repository/sync_repository.dart';
import 'package:darmon/ui/intro/intro_pref.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class IntroViewModel extends ViewModel {
  final SyncRepository _syncRepository;

  //final SyncJob _syncJob;

  IntroViewModel(this._syncRepository);

  LazyStream<ConnectivityResult> _connectionState = LazyStream();

  Stream<ConnectivityResult> get connectionState => _connectionState.stream;

  ConnectivityResult get getConnectionState => _connectionState.value;

  @override
  void onCreate() {
    super.onCreate();
    checkConnection();
    _syncRepository.sync();
    //  _syncJob.start();
  }

  Future<bool> isSelectedSystemLanguage() async {
    final langCode = await LocalizationPref.getLanguage();
    return langCode != null && langCode.isNotEmpty;
  }

  Future<bool> isShowedPresentation() => IntroPref.isPresentationShowed();

  void checkConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      _connectionState.add(result);
      if ((result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) &&
          (!(await isSelectedSystemLanguage()) || !(await isShowedPresentation()))) {
        _syncRepository.sync();
        // _syncJob.start();
      }
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      setError(error, st);
    }
  }

  @override
  void onDestroy() {
    _connectionState.close();
    super.onDestroy();
  }
}
