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

  LazyStream<List<ProducerListItem>> _items = LazyStream();
  LazyStream<MyResultStatus> _statuse = LazyStream(() => null);

  Stream<MyResultStatus> get statuse => _statuse.stream;

  Stream<List<ProducerListItem>> get items => _items.stream;

  @override
  void onCreate() {
    super.onCreate();
    _repository = MedicineListRepository();
    loadFirstPage(
        argument.type,
        argument.type == UIMedicineMarkSearchResultType.BOX_GROUP
            ? argument.boxGroupId
            : argument.sendServerText);
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
    loadFirstPage(
        argument.type,
        argument.type == UIMedicineMarkSearchResultType.BOX_GROUP
            ? argument.boxGroupId
            : argument.sendServerText);
  }

  void loadPage() async {
    if (_statuse.value == MyResultStatus.SUCCESS && _repository.hasNextPage) {
      try {
        _statuse.add(MyResultStatus.LOADING);
        List<ProducerListItem> result = await _repository.loadList(
            argument.type,
            argument.type == UIMedicineMarkSearchResultType.BOX_GROUP
                ? argument.boxGroupId
                : argument.sendServerText);

        List<ProducerListItem> list = _items.value ?? [];
        ProducerListItem last = list?.isNotEmpty == true ? list?.last : null;
        ProducerListItem resultFirst = result?.isNotEmpty == true ? result?.first : null;

        if (last != null &&
            resultFirst != null &&
            last?.producerGenName == resultFirst?.producerGenName &&
            last?.producerGenName == resultFirst?.producerGenName) {
          last.medicines.addAll(resultFirst.medicines);
          result.remove(resultFirst);
        }
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
      List<ProducerListItem> result = await _repository.loadFirstList(type, sendServerText);

      List<ProducerListItem> list = _items.value ?? [];
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

  Future<List<ProducerListItem>> loadFirstList(
      UIMedicineMarkSearchResultType type, String sendServerText) async {
    List<ProducerListItem> result = await loadMedicine(type, sendServerText, FIRST_PAGE);

    page = FIRST_PAGE + 1;

    return result;
  }

  Future<List<ProducerListItem>> loadList(
      UIMedicineMarkSearchResultType type, String sendServerText) async {
    List<ProducerListItem> result = await loadMedicine(type, sendServerText, page);

    page = page + 1;

    return result;
  }

  Future<List<ProducerListItem>> loadMedicineAnalogues(String box_group_id, int page) async {
    String langCode = await LocalizationPref.getLanguage();
    final body = {
      "d": {"box_group_id": box_group_id, "lang": langCode},
      "p": {
        "column": MedicineListItem.getKeys(),
        "filter": [],
        "sort": MedicineListItem.getSortKeys(),
        "offset": page * LIMIT,
        "limit": LIMIT
      }
    };
    Map<String, dynamic> result = await NetworkManager.medicineAnalogsList(body);
    int resultCount = result["count"];
    List<dynamic> data = result["data"];
    hasNextPage = resultCount > ((page + 1) * LIMIT);
    List<MedicineListItem> list = await parseObjects(data);
    return toMedicineMarkNameListItem(list);
  }

  Future<List<ProducerListItem>> loadMedicine(
      UIMedicineMarkSearchResultType type, String query, int page) async {
    if (type == UIMedicineMarkSearchResultType.BOX_GROUP)
      return loadMedicineAnalogues(query, page);
    else
      return loadMedicineList(type, query, page);
  }

  Future<List<ProducerListItem>> loadMedicineList(
      UIMedicineMarkSearchResultType type, String query, int page) async {
    String langCode = await LocalizationPref.getLanguage();
    final body = {
      "d": {
        "type": type == UIMedicineMarkSearchResultType.INN ? "I" : "M",
        "query": query,
        "lang": langCode
      },
      "p": {
        "column": MedicineListItem.getKeys(),
        "filter": [],
        "sort": MedicineListItem.getSortKeys(),
        "offset": page * LIMIT,
        "limit": LIMIT
      }
    };
    Map<String, dynamic> result = await NetworkManager.medicineList(body);
    int resultCount = result["count"];
    List<dynamic> data = result["data"];
    hasNextPage = resultCount > ((page + 1) * LIMIT);
    List<MedicineListItem> list = await parseObjects(data);
    if (type == UIMedicineMarkSearchResultType.NAME)
      return toProducerMedicineListItem(list);
    else
      return toMedicineMarkNameListItem(list);
  }

  Future<List<MedicineListItem>> parseObjects(List<dynamic> datas) async {
    List<MedicineListItem> result = [];
    for (var data in datas) {
      result.add(MedicineListItem.parseObjects(data));
    }
    return result;
  }

  List<ProducerListItem> toProducerMedicineListItem(List<MedicineListItem> items) {
    List<ProducerListItem> result = [];
    for (var medicine in items) {
      ProducerMedicineListItem producerMedicineListItem = ProducerMedicineListItem(
          medicine.spread_kind,
          medicine.box_group_id,
          medicine.box_gen_name,
          medicine.retail_base_price,
          medicine.producer_gen_name);

      ProducerListItem producerListItem = result.firstWhere(
          (element) => element.producerGenName == medicine.producer_gen_name,
          orElse: () => null);
      if (producerListItem != null) {
        producerListItem.medicines.add(producerMedicineListItem);
      } else {
        result.add(ProducerListItem(
            medicine.medicine_mark_name, medicine.producer_gen_name, [producerMedicineListItem]));
      }
    }

    return result;
  }

  List<ProducerListItem> toMedicineMarkNameListItem(List<MedicineListItem> items) {
    List<ProducerListItem> result = [];
    for (var medicine in items) {
      ProducerMedicineListItem producerMedicineListItem = ProducerMedicineListItem(
          medicine.spread_kind,
          medicine.box_group_id,
          medicine.box_gen_name,
          medicine.retail_base_price,
          medicine.producer_gen_name);

      ProducerListItem producerListItem = result.firstWhere(
          (element) => element.medicineMarkName == medicine.medicine_mark_name,
          orElse: () => null);
      if (producerListItem != null) {
        producerListItem.medicines.add(producerMedicineListItem);
      } else {
        result.add(ProducerListItem(
            medicine.medicine_mark_name, medicine.producer_gen_name, [producerMedicineListItem]));
      }
    }

    return result;
  }
}
