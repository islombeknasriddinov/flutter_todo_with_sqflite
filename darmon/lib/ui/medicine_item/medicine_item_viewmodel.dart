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
    setProgress(PROGRESS, true);
    setError(ErrorMessage(""));
    _repository.loadMedicineItem(argument.medicineId).then((value) {
      setProgress(PROGRESS, false);
      _item.add(value);
    }).catchError((e, st) {
      setProgress(PROGRESS, false);
      setError(e);
    });
  }

  @override
  void onDestroy() {
    _item.close();
    super.onDestroy();
  }
}
