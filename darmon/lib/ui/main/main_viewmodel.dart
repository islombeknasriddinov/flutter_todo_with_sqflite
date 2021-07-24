import 'package:darmon/repository/sync_repository.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class MainViewModel extends ViewModel {
  static const int SYNC_PROGRESS = 1;
  SyncRepository syncRepository;

  MainViewModel(this.syncRepository);

  LazyStream<String> _currentLangCode = LazyStream(() => null);

  Stream<String> get currentLangCode => _currentLangCode.stream;

  @override
  void onCreate() {
    super.onCreate();
    LocalizationPref.getLanguage().then((value) {
      _currentLangCode.add(value);
    });
    checkSync();
  }

  void checkSync() async {
    Stream<bool> progress = syncRepository.syncInProgress;
    if (progress != null) {
      setProgress(SYNC_PROGRESS, true);
      progress?.listen((event) {
        if (event == false) {
          setProgress(SYNC_PROGRESS, false);
          if (syncRepository.error != null) {
            setError(syncRepository.error);
          }
        }
      });
    } else if (syncRepository.error != null) {
      setError(syncRepository.error);
    }
  }

  @override
  void onDestroy() {
    _currentLangCode.close();
    super.onDestroy();
  }
}
