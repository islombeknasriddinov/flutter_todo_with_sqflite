import 'package:darmon/common/resources.dart';
import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/kernel/uis/ui_search_history_dao.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:darmon/ui/medicine_mark_list/medicine_mark_list_fragment.dart';
import 'package:gwslib/gwslib.dart';

class MedicineMarkListViewModel extends ViewModel<ArgMedicineMarkList> {
  DarmonRepository _repository;
  UISearchHistoryDao _searchHistoryDao;

  MedicineMarkListViewModel(this._repository, this._searchHistoryDao);

  LazyStream<String> _searchText = LazyStream();

  LazyStream<void> _reload = LazyStream();

  LazyStream<List<UIMedicineMark>> _medicineMarkInnList = LazyStream();
  LazyStream<List<UIMedicineMark>> _medicineMarkNameList = LazyStream();
  LazyStream<List<UIMedicineMark>> _searchHistory = LazyStream();

  Stream<List<UIMedicineMark>> get searchHistory => _searchHistory.stream;

  List<UIMedicineMark> get medicineMarkNameList => _medicineMarkNameList.value ?? [];

  List<UIMedicineMark> get medicineMarkInnList => _medicineMarkInnList.value;

  Stream<void> get reload => _reload.stream;

  Stream<String> get searchText => _searchText.stream;

  bool get medicineMarkInnListIsNotEmpty => (_medicineMarkInnList?.value?.length ?? -1) > 0;

  bool get medicineMarkNameListIsNotEmpty => (_medicineMarkNameList?.value?.length ?? -1) > 0;
  List<SearchField> searchFilterFields = [
    SearchField("by_name", R.strings.medicine_list_fragment.search_by_name.translate()),
    SearchField("by_inn", R.strings.medicine_list_fragment.search_by_inn.translate()),
  ];

  bool innIsActive = true;
  bool nameIsActive = true;

  String get getSearchText => _searchText.value;

  List<UIMedicineMark> get searchHistoryList => _searchHistory.value ?? [];

  bool hasMarkNameListNextPage = true;
  bool hasMarkInnListNextPage = true;

  @override
  void onCreate() {
    super.onCreate();
    loadSearchHistory();
    _searchText.get()?.listen((value) {
      if (value == null || value.isEmpty) loadSearchHistory();
    });
  }

  void loadSearchHistory() async {
    try {
      final result = await _searchHistoryDao.loadMedicineMarkSearchHistory();
      _searchHistory.add(result);
      _reload.add(() {});
    } catch (error, st) {
      Log.error("Error($error)\n$st");
    }
  }

  void setSearchText(String txt) async {
    if (_searchText.value == txt) return;
    _searchText.add(txt);
    try {
      final names = await _repository.searchMedicineMarkNames(txt);
      hasMarkNameListNextPage = names.length == 5;
      _medicineMarkNameList.add(names);

      final inns = await _repository.searchMedicineMarkInns(txt);
      hasMarkInnListNextPage = inns.length == 5;
      Log.debug("inn.lenght=${inns.length}");
      _medicineMarkInnList.add(inns);

      _reload.add(() {});
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      setError(error);
    }
  }

  void onSelectFilter() async {
    for (var filterFeld in searchFilterFields) {
      if (filterFeld.id == "by_name") {
        nameIsActive = filterFeld.getOnSelected;
        if (!nameIsActive) {
          _medicineMarkNameList.add([]);
        } else {
          final names = await _repository.searchMedicineMarkNames(_searchText.value ?? "");
          hasMarkNameListNextPage = names.length == 5;
          _medicineMarkNameList.add(names);
        }
      } else if (filterFeld.id == "by_inn") {
        innIsActive = filterFeld.getOnSelected;
        if (!innIsActive) {
          _medicineMarkInnList.add([]);
        } else {
          final inns = await _repository.searchMedicineMarkInns(_searchText.value ?? "");
          hasMarkInnListNextPage = inns.length == 5;
          _medicineMarkInnList.add(inns);
        }
      }
    }
    _reload.add(() {});
  }

  void saveMedicineMarkSearchHistory(UIMedicineMark medicine) {
    _searchHistoryDao.saveMedicineMarkSearchHistory(medicine);
  }

  @override
  void onDestroy() {
    _searchText.close();
    _reload.close();
    _medicineMarkInnList.close();
    _medicineMarkNameList.close();
    super.onDestroy();
  }

  void deleteSearchHistory(UIMedicineMark mark) async {
    try {
      await _searchHistoryDao.deleteMedicineMarkSearchHistory(mark);
      loadSearchHistory();
    } catch (error, st) {
      Log.error("Error($error)\n$st");
    }
  }

  void loadMedicineMarkInnMore() async {
    int length = (_medicineMarkInnList.value?.length ?? 0) + 10;
    final inns = await _repository.searchMedicineMarkInns(_searchText.value ?? "", limit: length);
    hasMarkInnListNextPage = inns.length == length;
    _medicineMarkInnList.add(inns);
    _reload.add(() {});
  }

  void loadMedicineMarkNameMore() async {
    int length = (_medicineMarkNameList.value?.length ?? 0) + 10;
    final names = await _repository.searchMedicineMarkNames(_searchText.value ?? "", limit: length);
    hasMarkNameListNextPage = names.length == length;
    _medicineMarkNameList.add(names);
    _reload.add(() {});
  }
}
