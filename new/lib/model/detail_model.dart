import 'dart:convert';

MedicineDetail medicineDetailFromJson(String str) =>
    MedicineDetail.fromJson(json.decode(str));

String medicineDetailToJson(MedicineDetail data) => json.encode(data.toJson());

class MedicineDetail {
  final int count;
  final List<Data> data;

  MedicineDetail({
    required this.count,
    required this.data,
  });

  factory MedicineDetail.fromJson(Map<String, dynamic> json) {
    int counter = json["count"];
    List<Data> dataList = [];
    if (json.containsKey("data") && json["data"] is List<dynamic>) {
      dataList = (json["data"] as List<dynamic>)
          .map((e) => Data.fromData(e as List<dynamic>))
          .toList();
    }

    return MedicineDetail(count: counter, data: dataList);
  }

  Map<String, dynamic> toJson() {
    final arr = List<dynamic>.from(data.map((e) => e.toJson()).toList());

    return {"count": count, "data": jsonEncode(arr)};
  }
}

class Data {
  final String producerGenName;
  final String medicineMarkName;
  final String spreadKind;
  final String boxGroupId;
  final String boxGenName;
  final String retailPriceBase;

  Data._(this.producerGenName, this.medicineMarkName, this.spreadKind,
      this.boxGroupId, this.boxGenName, this.retailPriceBase);

  factory Data.fromData(List<dynamic> data) {
    return Data._(
      data[0]?.toString() ?? "",
      data[1]?.toString() ?? "",
      data[2]?.toString() ?? "",
      data[3]?.toString() ?? "",
      data[4]?.toString() ?? "",
      data[5]?.toString() ?? "",
    );
  }

  List<dynamic> toJson() => [
        producerGenName,
        medicineMarkName,
        spreadKind,
        boxGroupId,
        boxGenName,
        retailPriceBase
      ];

  static List<String> getColumnKeys() => [
    "producer_gen_name",
    "medicine_mark_name",
    "spread_kind",
    "box_group_id",
    "box_gen_name",
    "retail_price_base"
  ];

  static List<String> sortedBy() => ["producer_gen_name"];
}
