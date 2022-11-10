import 'dart:convert';

SyncMedicine syncMedicineFromJson(String str) =>
    SyncMedicine.fromJson(json.decode(str));

String syncMedicineToJson(SyncMedicine data) => json.encode(data.toJson());

class SyncMedicine {
  final List<MedicineName> medicineMarkName;
  final List<MedicineMarkInn> medicineMarkInn;
  final String laststamp;

  SyncMedicine({
    required this.medicineMarkName,
    required this.medicineMarkInn,
    required this.laststamp,
  });

  factory SyncMedicine.fromJson(Map<String, dynamic> json) {
    List<MedicineName> medicineMarkNameList = [];
    if (json.containsKey("medicine_mark_name") &&
        json["medicine_mark_name"] is List<dynamic>) {
      medicineMarkNameList = (json["medicine_mark_name"] as List<dynamic>)
          .map((e) => MedicineName.fromData(e as List<dynamic>))
          .toList();
    }

    List<MedicineMarkInn> medicineMarkInnList = [];
    if (json.containsKey("medicine_mark_inn") &&
        json["medicine_mark_inn"] is List<dynamic>) {
      medicineMarkInnList = (json["medicine_mark_inn"] as List<dynamic>)
          .map((e) => MedicineMarkInn.fromData(e as List<dynamic>))
          .toList();
    }

    return SyncMedicine(
        medicineMarkName: medicineMarkNameList,
        medicineMarkInn: medicineMarkInnList,
        laststamp: '');
  }

  Map<String, String> toJson() {
    final medicine_mark_name =
        List<dynamic>.from(medicineMarkName.map((e) => e.toJson()).toList());
    final medicine_mark_inn =
        List<dynamic>.from(medicineMarkInn.map((e) => e.toJson()).toList());

    return {
      "medicine_mark_name": jsonEncode(medicine_mark_name),
      "medicine_mark_inn": jsonEncode(medicine_mark_inn),
      "laststamp": laststamp,
    };
  }
}

class MedicineName {
  final String nameRu;
  final String nameUz;
  final String nameEn;
  final String nameRuPhonexCode;
  final String nameUzPhonexCode;
  final String nameEnPhonexCode;

  MedicineName._(
    this.nameRu,
    this.nameUz,
    this.nameEn,
    this.nameRuPhonexCode,
    this.nameUzPhonexCode,
    this.nameEnPhonexCode,
  );

  factory MedicineName.fromData(List<dynamic> data) {
    return MedicineName._(
      data[0]?.toString() ?? "",
      data[1]?.toString() ?? "",
      data[2]?.toString() ?? "",
      data[3]?.toString() ?? "",
      data[4]?.toString() ?? "",
      data[5]?.toString() ?? "",
    );
  }

  List<dynamic> toJson() => [
        nameRu,
        nameUz,
        nameEn,
        nameRuPhonexCode,
        nameUzPhonexCode,
        nameEnPhonexCode
      ];
}

class MedicineMarkInn {
  final String innRu;
  final String innEn;
  final String innRuPhonexCode;
  final String innEnPhonexCode;
  final String innIds;

  MedicineMarkInn._(this.innRu, this.innEn, this.innEnPhonexCode,
      this.innRuPhonexCode, this.innIds);

  factory MedicineMarkInn.fromData(List<dynamic> data) {
    return MedicineMarkInn._(
      data[0]?.toString() ?? "",
      data[1]?.toString() ?? "",
      data[2]?.toString() ?? "",
      data[3]?.toString() ?? "",
      data[4]?.toString() ?? "",
    );
  }

  List<dynamic> toJson() =>
      [innRu, innEn, innRuPhonexCode, innEnPhonexCode, innIds];
}
