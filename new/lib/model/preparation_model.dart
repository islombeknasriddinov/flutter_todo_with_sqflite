import 'dart:convert';

Preparation preparationFromJson(String str) =>
    Preparation.fromJson(json.decode(str));

String preparationToJson(Preparation data) => json.encode(data.toJson());

class Preparation {
  final String? boxGroupId;
  final String? boxGenName;
  final String? producerGenName;
  final String? retailPriceBase;
  final String? spreadKind;
  final String? inn;
  final List<AnalogMedicineItem>? similarBoxGroups;

  Preparation({
    this.boxGroupId,
    this.boxGenName,
    this.producerGenName,
    this.retailPriceBase,
    this.spreadKind,
    this.inn,
    this.similarBoxGroups,
  });

  factory Preparation.fromJson(Map<String, dynamic> json) => Preparation(
        boxGroupId: json["box_group_id"],
        boxGenName: json["box_gen_name"],
        producerGenName: json["producer_gen_name"],
        retailPriceBase: json["retail_price_base"],
        spreadKind: json["spread_kind"],
        inn: json["inn"],
        similarBoxGroups: List<AnalogMedicineItem>.from(
            json["similar_box_groups"]
                .map((x) => AnalogMedicineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "box_group_id": boxGroupId,
        "box_gen_name": boxGenName,
        "producer_gen_name": producerGenName,
        "retail_price_base": retailPriceBase,
        "spread_kind": spreadKind,
        "inn": inn,
        "similar_box_groups":
            List<dynamic>.from(similarBoxGroups!.map((x) => x.toJson)),
      };
}

class AnalogMedicineItem {
  final String? boxGroupId;
  final String? medicineName;
  final String? producerGenName;
  final String? spreadKind;
  final String? retailBasePrice;

  AnalogMedicineItem({
    this.boxGroupId,
    this.medicineName,
    this.producerGenName,
    this.spreadKind,
    this.retailBasePrice,
  });

  factory AnalogMedicineItem.fromJson(Map<String, dynamic> json) =>
      AnalogMedicineItem(
        boxGroupId: json['box_group_id'],
        medicineName: json['box_gen_name'],
        producerGenName: json['producer_gen_name'],
        spreadKind: json['spread_kind'],
        retailBasePrice: json['retail_price_base'],
      );

  Map<String, dynamic> toJson() => {
        "box_group_id": boxGroupId,
        "box_gen_name": medicineName,
        "producer_gen_name": producerGenName,
        "spread_kind": spreadKind,
        "retail_price_base": retailBasePrice
      };
}
