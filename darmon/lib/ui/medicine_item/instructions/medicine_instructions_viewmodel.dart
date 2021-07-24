import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_item/medicine_item_models.dart';
import 'package:gwslib/gwslib.dart';

class MedicineInstructionViewModel extends ViewModel<ArgMedicineItem> {
  static int PROGRESS = 1;
  final DarmonRepository _repository;

  MedicineInstructionViewModel(this._repository);

  LazyStream<MedicineItemInstruction> _instruction = LazyStream();

  Stream<MedicineItemInstruction> get instruction => _instruction.stream;

  @override
  void onCreate() {
    super.onCreate();
    reloadModel();
  }

  void reloadModel() {
    setProgress(PROGRESS, true);
    _repository.loadMedicineInstruction(argument.medicineId).then((value) {
      setProgress(PROGRESS, false);
      _instruction.add(value);
    }).catchError((e, st) {
      setProgress(PROGRESS, false);
      setError(e, st);
    });
  }

  @override
  void onDestroy() {
    super.onDestroy();
    _instruction.close();
  }
}
