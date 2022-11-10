import 'package:uzphariminfo/model/sync_model.dart';

class ItemSearchList{
  String? title;
  MedicineName? medicineName;
  MedicineMarkInn? medicineMarkInn;
  ListType? type;

  ItemSearchList._(this.title, this.type);

  ItemSearchList.header(this.title) : type = ListType.HEADER;

  ItemSearchList.medicine(this.title, {this.medicineName}) : type = ListType.MEDICINE;

  ItemSearchList.inn(this.title, {this.medicineMarkInn}) : type = ListType.INN;

  ItemSearchList.moreMedicine(this.title) : type = ListType.MORE_MEDICINE;

  ItemSearchList.moreInn(this.title) : type = ListType.MORE_INN;

}

enum ListType {
  HEADER,
  MEDICINE,
  INN,
  MORE_MEDICINE,
  MORE_INN,
}
