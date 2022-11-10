import 'package:darmon/network/network_manager.dart';
import 'package:darmon/repository/bean.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:gwslib/localization/pref.dart';

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

  Future<List<ProducerListItem>> loadMedicineAnalogues(String boxGroupId, int page) async {
    String langCode = await LocalizationPref.getLanguage();
    final body = {
      "d": {"box_group_id": boxGroupId, "lang": langCode},
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
