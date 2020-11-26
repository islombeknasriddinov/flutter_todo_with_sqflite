import 'package:gwslib/gwslib.dart';

class SearchField {
  String id;
  String value;
  String title;
  LazyStream<bool> _onSelected = LazyStream(() => true);

  Stream<bool> get onSelected => _onSelected.stream;

  SearchField(this.id, this.title, {this.value});

  SearchField.id(this.id);

  SearchField.value(this.value);

  bool get getOnSelected => _onSelected.value;

  void setOnSelected(bool value) {
    _onSelected.add(value);
  }

  void dissmise() {
    _onSelected.close();
  }
}

class MedicineListItem {
  String medicineMarkId;
  String medicineNameRU;
  String medicineNameUZ;
  String medicineNameEN;
  String langCode;

  String medicineName() {
    if (langCode == "uz")
      return medicineNameUZ;
    else if (langCode == "en") return medicineNameEN;
    return medicineNameRU;
  }

  MedicineListItem(this.medicineMarkId, this.medicineNameRU, this.medicineNameUZ,
      this.medicineNameEN, this.langCode);

  /* factory MedicineListItem.fromJson(Map<String, dynamic> data) {
    return MedicineListItem(
      nvlTryInt(data["medicine_id"]),
      nvl(data["medicine_name"]),
      nvl(data["medicine_name_ru"]),
      nvl(data["medicine_name_uz"]),
      nvl(data["medicine_name_en"]),
    );
  }*/

  factory MedicineListItem.parseObjects(List<dynamic> data, String langCode) {
    return MedicineListItem(nvl(data[3]), nvl(data[1]), nvl(data[0]), nvl(data[2]), langCode);
  }
}
