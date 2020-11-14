import 'package:gwslib/gwslib.dart';

class SearchIndexViewModel extends ViewModel {
  LazyStream<bool> _isClearActive = LazyStream(() => true);
  LazyStream<String> _searchText = LazyStream();
  LazyStream<List<String>> _items = LazyStream();

  Stream<List<String>> get items => _items.stream;

  Stream<String> get searchText => _searchText.stream;

  Stream<bool> get isClearActive => _isClearActive.stream;
  List<String> list = [];

  @override
  void onCreate() {
    super.onCreate();
    _searchText.get().listen((value) {
      if (value?.isNotEmpty == true) {
        if (_isClearActive.value != true) _isClearActive.add(true);
      } else {
        if (_isClearActive.value != false) _isClearActive.add(false);
      }
      _search(value);
    });

    for (int i = 0; i < 100; i++) {
      list.add("Item ${i}");
    }
    _items.add(list);

    _items.get().listen((value) async {});
  }

  void setSearchText(String txt) {
    _searchText.add(txt);
  }

  List<String> lastItems = [];

  void _search(String text) {
    lastItems = _items.value;
    if (text != null) _items.add(list.where((element) => element.contains(text)).toList());
  }
}
