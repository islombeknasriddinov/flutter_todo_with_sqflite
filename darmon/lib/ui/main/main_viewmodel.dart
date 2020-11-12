import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class MainViewModel extends ViewModel {
  LazyStream<int> _currentItemIndex = LazyStream(() => 0);

  Stream<int> get currentItemIndex => _currentItemIndex.stream;

  LazyStream<bool> _currentLangIsRU = LazyStream(() => null);

  Stream<bool> get currentLang => _currentLangIsRU.stream;

  @override
  void onCreate() {
    super.onCreate();
    LocalizationPref.getLanguage().then((value) {
      _currentLangIsRU.add(value == 'ru');
    });

    _currentLangIsRU.get().listen((value) {
      if (_currentItemIndex.value != null) {
        _currentItemIndex.add(_currentItemIndex.value);
      }
    });
  }

  bool get langIsRU => _currentLangIsRU.value;

  void setBottomNavigationBarItemIndex(int index) {
    _currentItemIndex.add(index);
  }

  @override
  void onDestroy() {
    _currentItemIndex.close();
    _currentLangIsRU.close();
    super.onDestroy();
  }
}
