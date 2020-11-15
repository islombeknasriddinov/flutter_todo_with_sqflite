import 'package:darmon/filter/main/filter.dart';
import 'package:darmon/filter/main/filter_viewmodel.dart';
import 'package:gwslib/gwslib.dart';

import 'file:///D:/projects/darmon/smartup5x_darmon_mobile/darmon/lib/kernel/uis/ui_search_index_dao.dart';

class SearchIndexViewModel extends FilterViewModel<dynamic, UISearchIndexDao> {
  UISearchIndexDao dao;

  SearchIndexViewModel(this.dao);

  LazyStream<bool> _isClearActive = LazyStream(() => true);
  LazyStream<String> _searchText = LazyStream();
  LazyStream<List<String>> _items = LazyStream();
  LazyStream<List<Filter>> _filters = LazyStream();

  Stream<List<Filter>> get filters => _filters.stream;

  Stream<List<String>> get items => _items.stream;

  Stream<String> get searchText => _searchText.stream;

  Stream<bool> get isClearActive => _isClearActive.stream;
  List<String> list = [];

  @override
  UISearchIndexDao createDao() => dao;

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
      list.add("Item $i");
    }
    _items.add(list);

    _items.get().listen((value) async {});
  }

  void setSearchText(String txt) {
    _searchText.add(txt);
  }

  void _search(String text) {
    if (text != null) _items.add(list.where((element) => element.contains(text)).toList());
  }

  @override
  void reload() {
    super.reload();
    reloadFilters();
  }

  void reloadFilters() async {
    List<Filter> filters = await dao
        .getFilters()
        .then((value) => value.where((element) => element?.value != null).toList());
    _filters.add(filters);
  }

  void clearFilterValue(Filter item) {
    item.value = null;
    if (_filters.value != null) {
      _filters.add(_filters.value.where((element) => element?.value != null).toList());
    }
  }
}
