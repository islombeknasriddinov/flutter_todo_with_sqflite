import 'package:darmon/repository/sync_repository.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';
import 'package:in_app_update/in_app_update.dart';

class MainViewModel extends ViewModel {
  static const int SYNC_PROGRESS = 1;
  final SyncRepository syncRepository;

  MainViewModel(this.syncRepository);

  LazyStream<String> _currentLangCode = LazyStream(() => null);
  LazyStream<AppUpdateInfo> _appUpdateInfo = new LazyStream();

  Stream<AppUpdateInfo> get appUpdateInfoStream => _appUpdateInfo.stream;

  Stream<String> get currentLangCode => _currentLangCode.stream;

  @override
  void onCreate() {
    super.onCreate();
    LocalizationPref.getLanguage().then((value) {
      _currentLangCode.add(value);
    });
    checkSync();
    checkHasAppUpdate();
  }

  void checkSync() async {
    Stream<bool> progress = syncRepository.syncInProgress;
    if (progress != null) {
      setProgress(SYNC_PROGRESS, true);
      progress?.listen((event) {
        if (event == false) {
          setProgress(SYNC_PROGRESS, false);
          if (syncRepository.error != null) {
            setErrorMessage(syncRepository.error);
          }
        }
      });
    } else if (syncRepository.error != null) {
      setErrorMessage(syncRepository.error);
    }
  }

  void checkHasAppUpdate() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      final info = await InAppUpdate.checkForUpdate();
      _appUpdateInfo.add(info);
    } catch (error, st) {
      Log.error(error, st);
    }
  }

  void performImmediateUpdate() async {
    try {
      await InAppUpdate.performImmediateUpdate();
    } catch (error, st) {
      Log.error(error, st);
    }
  }

  @override
  void onDestroy() {
    _currentLangCode.close();
    _appUpdateInfo.close();
    super.onDestroy();
  }
}
