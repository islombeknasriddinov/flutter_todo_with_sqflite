import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_item/medicine_item_models.dart';
import 'package:gwslib/gwslib.dart';

class MedicineInstructionViewModel extends ViewModel<ArgMedicineItem> {
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
    _instruction.add(MedicineItemInstruction("medicineName", "medicineMnn", "producerGenName", [
      MedicineInstruction("Состав",
          "Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке соответствующий условий активизации. Разнообразный и богатый опыт дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. "),
      MedicineInstruction("Состав",
          "Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке соответствующий условий активизации. Разнообразный и богатый опыт дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. "),
      MedicineInstruction("Состав",
          "Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке соответствующий условий активизации. Разнообразный и богатый опыт дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. "),
      MedicineInstruction("Состав",
          "Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке соответствующий условий активизации. Разнообразный и богатый опыт дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. "),
      MedicineInstruction("Состав",
          "Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке соответствующий условий активизации. Разнообразный и богатый опыт дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. "),
      MedicineInstruction("Состав",
          "Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке соответствующий условий активизации. Разнообразный и богатый опыт дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. "),
      MedicineInstruction("Состав",
          "Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке соответствующий условий активизации. Разнообразный и богатый опыт дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. "),
      MedicineInstruction("Состав",
          "Не следует, однако забывать, что постоянное информационно-пропагандистское обеспечение нашей деятельности позволяет выполнять важные задания по разработке соответствующий условий активизации. Разнообразный и богатый опыт дальнейшее развитие различных форм деятельности играет важную роль в формировании направлений прогрессивного развития. "),
    ]));
  }

  @override
  void onDestroy() {
    super.onDestroy();
    _instruction.close();
  }
}
