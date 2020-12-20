import 'package:darmon/repository/darmon_repository.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class MainViewModel extends ViewModel {
  static const int SYNC_PROGRESS = 1;
  DarmonRepository repository;


  MainViewModel(this.repository);

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
    try {
      setProgress(SYNC_PROGRESS, true);
      await repository.checkSync();
      setProgress(SYNC_PROGRESS, false);
    } catch (error, st) {
      setProgress(SYNC_PROGRESS, false);
      setError(error);
      Log.error("Error($error)\n$st");
    }
  }

  @override
  void onDestroy() {
    _currentLangCode.close();
    super.onDestroy();
  }
}
