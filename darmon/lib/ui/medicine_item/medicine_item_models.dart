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

  String getName() {
    int l = medicineName.length;
    int center = l ~/ 2;
    String first = medicineName.substring(0, center);
    String second = medicineName.substring(center, l);
    return "$first\n$second";
  }
}
