import 'package:darmon/common/resources.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_item/medicine_item_models.dart';
import 'package:gwslib/gwslib.dart';

class MedicineItemViewModel extends ViewModel<ArgMedicineItem> {
  static const int PROGRESS = 1;
  final DarmonRepository _repository;

  MedicineItemViewModel(this._repository);

  LazyStream<MedicineItem> _item = LazyStream();

  Stream<MedicineItem> get item => _item.stream;

  @override
  void onCreate() {
    super.onCreate();
    reloadModel();
  }

  void reloadModel() {
    _item.add(MedicineItem("medicineName", "medicineMnn", "producerGenName", "W", "boxGroupId",
        "boxGenName", "100 200", [
      AnalogMedicineItem("analog 1", "producerGenName", "boxGroupId", "boxGenName", "120 022"),
      AnalogMedicineItem(
          "analog 2", "producerGenName", "boxGroupId", "boxGenName", "120 022 000 252"),
      AnalogMedicineItem(
          "analog 3", "producerGenName", "boxGroupId", "boxGenName", "120 022 000 252")
    ]));
  }

  @override
  void onDestroy() {
    _item.close();
    super.onDestroy();
  }
}
