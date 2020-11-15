import 'package:darmon/ui/medicine/medicine_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';

class MedicineFragment extends ViewModelFragment<MedicineViewModel> {
  static final String ROUTE_NAME = "/medicine";

  static void open(BuildContext context) {
    Mold.openContent(context, ROUTE_NAME);
  }

  @override
  MedicineViewModel onCreateViewModel(BuildContext buildContext) => MedicineViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return Center(
      child: MyText("medicine"),
    );
  }
}
