import 'package:darmon/common/result.dart';
import 'package:darmon/network/network_manager.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_list/medicine_list_fragment.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class MedicineListViewModel extends ViewModel<ArgMedicineList> {
  MedicineListRepository _repository;

  MedicineListViewModel();

  LazyStream<List<MedicineListItem>> _items = LazyStream();
  LazyStream<MyResultStatus> _statuse = LazyStream(() => null);

  Stream<MyResultStatus> get statuse => _statuse.stream;

  Stream<List<MedicineListItem>> get items => _items.stream;

  @override
  void onCreate() {
    super.onCreate();
    _repository = MedicineListRepository();
    loadFirstPage(argument.type, argument.sendServerText);
    _statuse.get().listen((value) {
      print(value);
    });
  }

  @override
  void onDestroy() {
    _items.close();
    super.onDestroy();
  }

  void reload() {
    loadFirstPage(argument.type, argument.sendServerText);
  }

  void loadPage() async {
    if (_statuse.value == MyResultStatus.SUCCESS && _repository.hasNextPage) {
      try {
        _statuse.add(MyResultStatus.LOADING);
        List<MedicineListItem> result =
            await _repository.loadList(argument.type, argument.sendServerText);

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

  void loadFirstPage(UIMedicineMarkSearchResultType type, String sendServerText) async {
    try {
      _statuse.add(MyResultStatus.LOADING);
      List<MedicineListItem> result = await _repository.loadFirstList(type, sendServerText);

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
  int LIMIT = 10;
  int page;
  bool hasNextPage = true;

  Future<List<MedicineListItem>> loadFirstList(
      UIMedicineMarkSearchResultType type, String sendServerText) async {
    List<MedicineListItem> result = await loadMedicine(type, sendServerText, FIRST_PAGE);
    page = FIRST_PAGE + 1;
    return result;
  }

  Future<List<MedicineListItem>> loadList(
      UIMedicineMarkSearchResultType type, String sendServerText) async {
    List<MedicineListItem> result = await loadMedicine(type, sendServerText, page);
    page = page + 1;
    return result;
  }

  Future<List<MedicineListItem>> loadMedicine(
      UIMedicineMarkSearchResultType type, String query, int page) async {
    final body = {
      "d": {"type": type == UIMedicineMarkSearchResultType.INN ? "I" : "N", "query": query},
      "p": {
        "column": ["name_uz", "name_ru", "name_en", "medicine_mark_id"],
        "filter": [],
        "sort": [],
        "offset": page,
        "limit": LIMIT
      }
    };
    Map<String, dynamic> result = await NetworkManager.medicineList(body);
    int resultCount = result["count"];
    List<dynamic> data = result["data"];
    hasNextPage = resultCount == LIMIT;
    return parseObjects(data);
  }

  Future<List<MedicineListItem>> parseObjects(List<dynamic> datas) async {
    List<MedicineListItem> result = [];
    String langCode = await LocalizationPref.getLanguage();
    for (var data in datas) {
      result.add(MedicineListItem.parseObjects(data, langCode));
    }
    return result;
  }
}
