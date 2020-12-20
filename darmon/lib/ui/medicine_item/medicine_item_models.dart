import 'dart:convert';

import 'package:darmon/common/resources.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class MedicineItem {
  final String medicineName;
  final String medicineMnn;
  final String producerGenName;
  final String spreadKind;
  final String boxGroupId;
  final String boxGenName;
  final String retailBasePrice;
  final List<AnalogMedicineItem> analogs;

  MedicineItem(
    this.medicineName,
    this.medicineMnn,
    this.producerGenName,
    this.spreadKind,
    this.boxGroupId,
    this.boxGenName,
    this.retailBasePrice,
    this.analogs,
  );

  factory MedicineItem.fromData(Map<String, dynamic> data) {
    List<dynamic> analogsJson = nvl(data['analogs']) ?? [];

    List<AnalogMedicineItem> analogs = [];
    for (var analog in analogsJson) {
      analogs.add(AnalogMedicineItem.fromData(jsonDecode(analog)));
    }

    return MedicineItem(
      nvl(data['medicine_name']),
      nvl(data['medicine_mnn']),
      nvl(data['producer_gen_name']),
      nvl(data['spread_kind']),
      nvl(data['box_group_id']),
      nvl(data['box_gen_name']),
      nvl(data['retail_base_price']),
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
  final String medicineMnn;
  final String producerGenName;
  final List<MedicineInstruction> instructions;

  MedicineItemInstruction(
    this.medicineName,
    this.medicineMnn,
    this.producerGenName,
    this.instructions,
  );

  factory MedicineItemInstruction.fromData(Map<String, dynamic> data) {
    List<dynamic> instructionsJson = nvl(data['instructions']) ?? [];

    List<MedicineInstruction> instructions = [];
    for (var instruction in instructionsJson) {
      instructions.add(MedicineInstruction.fromData(jsonDecode(instruction)));
    }

    return MedicineItemInstruction(
      nvl(data['medicine_name']),
      nvl(data['medicine_mnn']),
      nvl(data['producer_gen_name']),
      instructions,
    );
  }
}

class MedicineInstruction {
  final String header;
  final String body;

  MedicineInstruction(this.header, this.body);

  factory MedicineInstruction.fromData(Map<String, dynamic> data) {
    return MedicineInstruction(
      nvl(data['header']),
      nvl(data['body']),
    );
  }
}

class AnalogMedicineItem {
  final String medicineName;
  final String producerGenName;
  final String boxGroupId;
  final String boxGenName;
  final String retailBasePrice;

  AnalogMedicineItem(
    this.medicineName,
    this.producerGenName,
    this.boxGroupId,
    this.boxGenName,
    this.retailBasePrice,
  );

  factory AnalogMedicineItem.fromData(Map<String, dynamic> data) {
    return AnalogMedicineItem(
      nvl(data['medicine_name']),
      nvl(data['producer_gen_name']),
      nvl(data['box_group_id']),
      nvl(data['box_gen_name']),
      nvl(data['retail_base_price']),
    );
  }
}
