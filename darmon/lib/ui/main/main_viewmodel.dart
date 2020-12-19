import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class MainViewModel extends ViewModel {
  LazyStream<String> _currentLangCode = LazyStream(() => null);

  Stream<String> get currentLangCode => _currentLangCode.stream;

  @override
  void onCreate() {
    super.onCreate();
    LocalizationPref.getLanguage().then((value) {
      _currentLangCode.add(value);
    });
  }

  @override
  void onDestroy() {
    _currentLangCode.close();
    super.onDestroy();
  }
}
