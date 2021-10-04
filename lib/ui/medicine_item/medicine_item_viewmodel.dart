import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_item/medicine_item_models.dart';
import 'package:gwslib/gwslib.dart';

class MedicineItemViewModel extends ViewModel<ArgMedicineItem> {
  static const int PROGRESS = 1;
  final DarmonRepository _repository;

  MedicineItemViewModel(this._repository);

  LazyStream<MedicineItem> _item = LazyStream();

  LazyStream<ErrorMessage> _errorMessage = new LazyStream();

  LazyStream<MedicineItemInstruction> _instruction = LazyStream();

  Stream<ErrorMessage> get errorMessageStream => _errorMessage.stream;

  Stream<MedicineItemInstruction> get instruction => _instruction.stream;

  Stream<MedicineItem> get item => _item.stream;

  @override
  void onCreate() {
    super.onCreate();
    reloadModel();
  }

  void reloadModel() async {
    try {
      setProgress(PROGRESS, true);
      _errorMessage.add(ErrorMessage(""));
      final medicineItem = await _repository.loadMedicineItem(argument.medicineId);
      final instruction = await _repository.loadMedicineInstruction(argument.medicineId);
      setProgress(PROGRESS, false);
      _item.add(medicineItem);
      _instruction.add(instruction);
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      setProgress(PROGRESS, false);
      _errorMessage.add(ErrorMessage.parseWithStacktrace(error, st));
    }
  }

  @override
  void onDestroy() {
    _item.close();
    _errorMessage.close();
    _instruction.close();
    super.onDestroy();
  }
}
