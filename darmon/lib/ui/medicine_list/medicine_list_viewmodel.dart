import 'package:darmon/common/resources.dart';
import 'package:darmon/common/result.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:gwslib/gwslib.dart';

class MedicineListViewModel extends ViewModel {
  MedicineListRepository _repository;

  MedicineListViewModel(this._repository);

  LazyStream<List<MedicineListItem>> _items = LazyStream();
  LazyStream<MyResultStatus> _statuse = LazyStream(() => null);

  Stream<MyResultStatus> get statuse => _statuse.stream;

  Stream<List<MedicineListItem>> get items => _items.stream;



  @override
  void onCreate() {
    super.onCreate();
    loadFirstPage();
    _statuse.get().listen((value) {
      print(value);
    });
  }


  @override
  void onDestroy() {
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
