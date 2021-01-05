import 'package:darmon/common/resources.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

import 'package:darmon/common/extensions.dart';

class MedicineItem {
  final String medicineName;
  final String medicineMnn;
  final String producerGenName;
  final String spreadKind;
  final String boxGroupId;
  final String retailBasePrice;
  final List<AnalogMedicineItem> analogs;

  MedicineItem(
    this.boxGroupId,
    this.medicineMnn,
    this.medicineName,
    this.producerGenName,
    this.spreadKind,
    this.retailBasePrice,
    this.analogs,
  );

  factory MedicineItem.fromData(Map<String, dynamic> data) {
    List<dynamic> analogsJson = data['similar_box_groups'] ?? [];

    List<AnalogMedicineItem> analogs = [];
    for (var analog in analogsJson) {
      analogs.add(AnalogMedicineItem.fromData(analog));
    }

    return MedicineItem(
      nvl(data['box_group_id']),
      nvl(data['inn']),
      nvl(data['box_gen_name']),
      nvl(data['producer_gen_name']),
      nvl(data['spread_kind']),
      nvl(data['retail_price_base']),
      analogs,
    );
  }

  String get spreadKindTitle {
    if (spreadKind == "W") {
      return R.strings.medicine_item.with_recipe.translate();
    } else if (spreadKind == "O") {
      return R.strings.medicine_item.with_out_recipe.translate();
    } else {
      return R.strings.medicine_item.no_data_found.translate();
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

class MedicineItemInstruction {
  final String medicineName;
  final String medicineInn;
  final String producerGenName;

  final String atcName;
  final String spreadKind;
  final String shelfLifeKind;
  final String shelfLife;
  final String openedShelfLifeKind;
  final String openedShelfLife;
  final String scope;
  final String storage;
  final String pharmacologicAction;
  final String boxGroupId;
  final String medicineProduct;
  final String routeAdministration;
  final String pharmacotherapeuticGroup;
  final String clinicalPharmacologicalGroup;

  MedicineItemInstruction(
      this.medicineName,
      this.medicineInn,
      this.producerGenName,
      this.atcName,
      this.spreadKind,
      this.shelfLifeKind,
      this.shelfLife,
      this.openedShelfLifeKind,
      this.openedShelfLife,
      this.scope,
      this.storage,
      this.pharmacologicAction,
      this.boxGroupId,
      this.medicineProduct,
      this.routeAdministration,
      this.pharmacotherapeuticGroup,
      this.clinicalPharmacologicalGroup);

  factory MedicineItemInstruction.fromData(Map<String, dynamic> data) {
    return MedicineItemInstruction(
        nvl(data['box_gen_name']),
        nvl(data['inn']),
        nvl(data['producer_gen_name']),
        nvl(data['atc_name']),
        nvl(data['spread_kind']),
        nvl(data['shelf_life_kind']),
        nvl(data['shelf_life']),
        nvl(data['opened_shelf_life_kind']),
        nvl(data['opened_shelf_life']),
        nvl(data['scope']),
        nvl(data['storage']),
        nvl(data['pharmacologic_action']),
        nvl(data['box_group_id']),
        nvl(data['medicine_product']),
        nvl(data['route_administration']),
        nvl(data['pharmacotherapeutic_group']),
        nvl(data['clinical_pharmacological_group']));
  }

  String get getShelfLifeInfo {
    if (shelfLifeKind == "Y") {
      return R.strings.medicine_instructions.year.translate(args: [shelfLife]);
    } else if (shelfLifeKind == "M") {
      return R.strings.medicine_instructions.month.translate(args: [shelfLife]);
    } else if (shelfLifeKind == "W") {
      return R.strings.medicine_instructions.week.translate(args: [shelfLife]);
    } else if (shelfLifeKind == "D") {
      return R.strings.medicine_instructions.day.translate(args: [shelfLife]);
    }
    return shelfLife;
  }

  String get getOpenedShelfLifeInfo {
    if (openedShelfLifeKind == "Y") {
      return R.strings.medicine_instructions.year.translate(args: [openedShelfLife]);
    } else if (openedShelfLifeKind == "M") {
      return R.strings.medicine_instructions.month.translate(args: [openedShelfLife]);
    } else if (openedShelfLifeKind == "W") {
      return R.strings.medicine_instructions.week.translate(args: [openedShelfLife]);
    } else if (openedShelfLifeKind == "D") {
      return R.strings.medicine_instructions.day.translate(args: [openedShelfLife]);
    }
    return openedShelfLife;
  }

  String get getSpreadInfo {
    if (spreadKind == "W") {
      return R.strings.medicine_instructions.with_recipe.translate();
    } else if (spreadKind == "O") {
      return R.strings.medicine_instructions.with_out_recipe.translate();
    } else {
      return R.strings.medicine_instructions.no_data_found.translate();
    }
  }
}

class AnalogMedicineItem {
  final String medicineName;
  final String producerGenName;
  final String boxGroupId;
  final String spreadKind;
  final String retailBasePrice;

  AnalogMedicineItem(
    this.boxGroupId,
    this.medicineName,
    this.producerGenName,
    this.spreadKind,
    this.retailBasePrice,
  );

  factory AnalogMedicineItem.fromData(Map<String, dynamic> data) {
    return AnalogMedicineItem(
      nvl(data['box_group_id']),
      nvl(data['box_gen_name']),
      nvl(data['producer_gen_name']),
      nvl(data['spread_kind']),
      nvl(data['retail_price_base']),
    );
  }

  String get getPrice => retailBasePrice?.isNotEmpty == true
      ? R.strings.medicine_item.medicine_price.translate(args: [retailBasePrice.toMoneyFormat()])
      : R.strings.medicine_item.not_found_price.translate();

  String getName() {
    int l = medicineName.length;
    int center = l ~/ 2;
    String first = medicineName.substring(0, center);
    String second = medicineName.substring(center, l);
    return "$first\n$second";
  }
}
