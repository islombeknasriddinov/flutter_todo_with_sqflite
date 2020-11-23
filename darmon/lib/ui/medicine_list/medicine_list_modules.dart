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
  int medicineId;
  String medicineName;
  String medicineNameRU;
  String medicineNameUZ;
  String medicineNameEN;
  String medicineGenerationName;
  int medicineMNN;

  MedicineListItem(
    this.medicineId,
    this.medicineName,
    this.medicineNameRU,
    this.medicineNameUZ,
    this.medicineNameEN,
    this.medicineGenerationName,
    this.medicineMNN,
  );

  factory MedicineListItem.fromJson(Map<String, dynamic> data) {
    return MedicineListItem(
      nvlTryInt(data["medicine_id"]),
      nvl(data["medicine_name"]),
      nvl(data["medicine_name_ru"]),
      nvl(data["medicine_name_uz"]),
      nvl(data["medicine_name_en"]),
      nvl(data["medicine_generation_name"]),
      nvlTryInt(data["medicine_mnn"]),
    );
  }
}
