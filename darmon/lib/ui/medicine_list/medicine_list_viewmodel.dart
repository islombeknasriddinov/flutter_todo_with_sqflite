import 'package:darmon/common/resources.dart';
import 'package:darmon/common/result.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:gwslib/gwslib.dart';

class MedicineListViewModel extends ViewModel {
  MedicineListRepository _repository;

  MedicineListViewModel(this._repository);

  LazyStream<bool> _isClearActive = LazyStream(() => true);
  LazyStream<String> _searchText = LazyStream();
  LazyStream<List<MedicineListItem>> _items = LazyStream();
  LazyStream<MyResultStatus> _statuse = LazyStream(() => null);

  Stream<MyResultStatus> get statuse => _statuse.stream;

  Stream<List<MedicineListItem>> get items => _items.stream;

  Stream<String> get searchText => _searchText.stream;

  Stream<bool> get isClearActive => _isClearActive.stream;

  List<SearchField> searchFilterFields = [
    SearchField("by_name", R.strings.medicine_list_fragment.search_by_name.translate()),
    SearchField("by_mnn", R.strings.medicine_list_fragment.search_by_mnn.translate()),
  ];

  @override
  void onCreate() {
    super.onCreate();
    _searchText.get().listen((value) {
      if (value?.isNotEmpty == true) {
        if (_isClearActive.value != true) _isClearActive.add(true);
      } else {
        if (_isClearActive.value != false) _isClearActive.add(false);
      }
    });
    loadFirstPage();
    _statuse.get().listen((value) {
      print(value);
    });
  }

  void setSearchText(String txt) {
    _searchText.add(txt);
  }

  @override
  void onDestroy() {
    _isClearActive.close();
    _searchText.close();
    _items.close();
    super.onDestroy();
  }

  void reload() {}

  void loadPage() async {
    if (_statuse.value == MyResultStatus.SUCCESS) {
      try {
        _statuse.add(MyResultStatus.LOADING);
        List<MedicineListItem> result = await _repository.loadList();

        List<MedicineListItem> list = _items.value ?? [];
        list.addAll(result);
        if (result != null) _items.add(list);

        _statuse.add(MyResultStatus.SUCCESS);
      } catch (error, st) {
        Log.error("Error($error)\n$st");
        setError(error, st);
        _statuse.add(MyResultStatus.ERROR);
      }
    }
  }

  void loadFirstPage() async {
    try {
      _statuse.add(MyResultStatus.LOADING);
      List<MedicineListItem> result = await _repository.loadFirstList();

      List<MedicineListItem> list = _items.value ?? [];
      list.addAll(result);
      if (result != null) _items.add(list);

      _statuse.add(MyResultStatus.SUCCESS);
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      setError(error, st);
      _statuse.add(MyResultStatus.ERROR);
    }
  }
}

class MedicineListRepository {
  int FIRST_PAGE = 0;
  int page;

  Future<List<MedicineListItem>> loadFirstList() async {
    List<MedicineListItem> result = await loadMedicine("query", FIRST_PAGE);
    page = FIRST_PAGE + 1;
    return result;
  }

  Future<List<MedicineListItem>> loadList() async {
    List<MedicineListItem> result = await loadMedicine("query", page);
    page = page + 1;
    return result;
  }

  Future<List<MedicineListItem>> loadMedicine(String query, int page) async {
    await new Future.delayed(new Duration(seconds: 2));
    if (page == 3) throw Exception("fuck");
    List<MedicineListItem> result = [];
    for (int i = 0; i < 10; i++) {
      result.add(MedicineListItem((page * 10) + (i + 1), "medicineName ${(page * 10) + (i + 1)}",
          "", "", "", "", (page * 10) + (i + 1)));
    }
    return result;
  }
}
