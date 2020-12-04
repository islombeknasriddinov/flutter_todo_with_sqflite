import 'package:darmon/common/resources.dart';
import 'package:flutter/material.dart';
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
  String medicine_mark_name;
  String producer_gen_name;
  String spread_kind;
  String box_group_id;
  String box_gen_name;
  String retail_base_price;

  MedicineListItem(
    this.medicine_mark_name,
    this.producer_gen_name,
    this.spread_kind,
    this.box_group_id,
    this.box_gen_name,
    this.retail_base_price,
  );

  /* factory MedicineListItem.fromJson(Map<String, dynamic> data) {
    return MedicineListItem(
      nvlTryInt(data["medicine_id"]),
      nvl(data["medicine_name"]),
      nvl(data["medicine_name_ru"]),
      nvl(data["medicine_name_uz"]),
      nvl(data["medicine_name_en"]),
    );
  }*/

  factory MedicineListItem.parseObjects(List<dynamic> data) {
    return MedicineListItem(
      nvl(data[0]),
      nvl(data[1]),
      nvl(data[2]),
      nvl(data[3]),
      nvl(data[4]),
      nvl(data[5]),
    );
  }

  static List<String> getKeys() => [
        "medicine_mark_name",
        "producer_gen_name",
        "spread_kind",
        "box_group_id",
        "box_gen_name",
        "retail_price_base"
      ];

  static List<String> getSortKeys() => ["medicine_mark_name", "producer_gen_name"];
}

class ProducerListItem {
  String medicineMarkName;
  String producerGenName;
  List<ProducerMedicineListItem> medicines;

  ProducerListItem(this.medicineMarkName, this.producerGenName, this.medicines);
}

class ProducerMedicineListItem {
  String spreadKind;
  String boxGroupId;
  String boxGenName;
  String retailBasePrice;

  ProducerMedicineListItem(this.spreadKind, this.boxGroupId, this.boxGenName, this.retailBasePrice);

  String get spreadKindTitle {
    if (spreadKind == "W") {
      return R.strings.medicine_list_fragment.with_recipe.translate();
    } else if (spreadKind == "O") {
      return R.strings.medicine_list_fragment.with_out_recipe.translate();
    } else {
      return R.strings.medicine_list_fragment.no_data_found.translate();
    }
  }

  Color get spreadKindColor {
    if (spreadKind == "W")
      return R.colors.priceColor;
    else if (spreadKind == "O") {
      return R.colors.status_success;
    } else {
      return R.colors.textColor;
    }
  }
}
