import 'package:darmon/common/resources.dart';
import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:darmon/ui/medicine_mark_list/medicine_mark_list_fragment.dart';
import 'package:gwslib/gwslib.dart';

class MedicineMarkListViewModel extends ViewModel<ArgMedicineMarkList> {
  DarmonRepository _repository;

  MedicineMarkListViewModel(this._repository);

  LazyStream<bool> _isClearActive = LazyStream(() => true);
  LazyStream<String> _searchText = LazyStream();

  LazyStream<void> _reload = LazyStream();

  LazyStream<List<UIMedicineMark>> _medicineMarkInnList = LazyStream();
  LazyStream<List<UIMedicineMark>> _medicineMarkNameList = LazyStream();

  List<UIMedicineMark> get medicineMarkNameList =>
      _medicineMarkNameList.value ?? [];

  List<UIMedicineMark> get medicineMarkInnList => _medicineMarkInnList.value;

  Stream<void> get reload => _reload.stream;

  Stream<String> get searchText => _searchText.stream;

  Stream<bool> get isClearActive => _isClearActive.stream;

  bool get medicineMarkInnListIsNotEmpty =>
      (_medicineMarkInnList?.value?.length ?? -1) > 0;

  bool get medicineMarkNameListIsNotEmpty =>
      (_medicineMarkNameList?.value?.length ?? -1) > 0;
  List<SearchField> searchFilterFields = [
    SearchField(
        "by_name", R.strings.medicine_list_fragment.search_by_name.translate()),
    SearchField(
        "by_inn", R.strings.medicine_list_fragment.search_by_inn.translate()),
  ];

  bool innIsActive=true;
  bool nameIsActive=true;

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
    setSearchText(argument.query);
  }

  void setSearchText(String txt) async {
    _searchText.add(txt);
    try {
      final names = await _repository.searchMedicineMarkNames(txt);
      _medicineMarkNameList.add(names);

      final inns = await _repository.searchMedicineMarkInns(txt);
      _medicineMarkInnList.add(inns);

      _reload.add(() {});
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      setError(error);
    }
  }

  @override
  void onDestroy() {
    _isClearActive.close();
    _searchText.close();
    _reload.close();
    _medicineMarkInnList.close();
    _medicineMarkNameList.close();
    super.onDestroy();
  }

  void onSelectFilter() async {
    for (var filterFeld in searchFilterFields) {
      if (filterFeld.id == "by_name") {
        nameIsActive = filterFeld.getOnSelected;
        if (!nameIsActive) {
          _medicineMarkNameList.add([]);
        } else {
          final names = await _repository
              .searchMedicineMarkNames(_searchText.value ?? "");
          _medicineMarkNameList.add(names);
        }
      } else if (filterFeld.id == "by_inn") {
        innIsActive = filterFeld.getOnSelected;
        if (!innIsActive) {
          _medicineMarkInnList.add([]);
        } else {
          final inns =
              await _repository.searchMedicineMarkInns(_searchText.value ?? "");
          _medicineMarkInnList.add(inns);
        }
      }
    }
    _reload.add(() {});
  }
}
