class UIMedicineMarkName {
  final String nameRu;
  final String nameUz;
  final String nameEn;

  UIMedicineMarkName(this.nameRu, this.nameUz, this.nameEn);
}

class UIMedicineMarkInn {
  final String innRu;
  final String innEn;
  final String innIds;

  UIMedicineMarkInn(this.innRu, this.innEn, this.innIds);
}

class UIMedicineMark {
  final String title;
  final String titleRu;
  final String titleUz;
  final String titleEn;
  final String sendServerText;
  final UIMedicineMarkSearchResultType type;

  UIMedicineMark(
    this.title,
    this.titleRu,
    this.titleUz,
    this.titleEn,
    this.sendServerText,
    this.type,
  );
}

enum UIMedicineMarkSearchResultType { NAME, INN, BOX_GROUP }
