import 'package:darmon/repository/darmon_repository.dart';
import 'package:gwslib/gwslib.dart';

class SearchIndexViewModel extends ViewModel {
  static const int SYNC_PROGRESS = 1;
  DarmonRepository repository;

  SearchIndexViewModel(this.repository);

  LazyStream<bool> _isClearActive = LazyStream(() => true);
  LazyStream<String> _searchText = LazyStream();
  LazyStream<List<String>> _menuItems = LazyStream();
  LazyStream<List<UIMedicineMark>> _medicines = LazyStream();

  Stream<List<UIMedicineMark>> get medicines => _medicines.stream;

  Stream<List<String>> get menuItems => _menuItems.stream;

  Stream<String> get searchText => _searchText.stream;

  Stream<bool> get isClearActive => _isClearActive.stream;

  Future<List<UIMedicineMark>> getLocationSuggestionsList(String text) async {
    return repository.searchMedicineMark(text);
  }

  @override
  void onCreate() {
    super.onCreate();
    initObjects();
  }

  void initObjects() {
    _searchText.get().listen((value) {
      if (value?.isNotEmpty == true) {
        if (_isClearActive.value != true) _isClearActive.add(true);
      } else {
        if (_isClearActive.value != false) _isClearActive.add(false);
      }
      _search(value);
    });

    List<String> list = [];
    for (int i = 0; i < 10; i++) {
      list.add("Menu Itme $i");
    }
    //  _menuItems.add(list);

    _menuItems.get().listen((value) async {});
    checkSync();
  }

  void setSearchText(String txt) {
    _searchText.add(txt);
  }

  void _search(String text) {
    repository.searchMedicineMark(text).then((value) {
      _medicines.add(value);
    }).catchError((error) {
      setError(error);
    });
  }

  @override
  void onDestroy() {
    _isClearActive.close();
    _searchText.close();
    _menuItems.close();
    _medicines.close();
    super.onDestroy();
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
}
