import 'package:darmon/ui/medicine_item/medicine_item_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';

class ArgMedicineItem {
  int medicineId;

  ArgMedicineItem(this.medicineId);
}

class MedicineItemFragment extends ViewModelFragment<MedicineItemViewModel> {
  static final String ROUTE_NAME = "/medicine";

  static void open(BuildContext context, ArgMedicineItem argMedicineItem) {
    Mold.openContent(context, ROUTE_NAME, arguments: argMedicineItem);
  }

  ArgMedicineItem get argMedicineItem => argument;

  @override
  MedicineItemViewModel onCreateViewModel(BuildContext buildContext) => MedicineItemViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return Center(
      child: MyText("medicine_id - ${argMedicineItem?.medicineId ?? ""} "),
    );
  }
}
