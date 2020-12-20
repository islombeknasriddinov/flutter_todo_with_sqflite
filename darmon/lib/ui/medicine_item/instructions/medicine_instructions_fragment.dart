import 'package:darmon/common/resources.dart';
import 'package:darmon/common/routes/slide_left_route.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/main.dart';
import 'package:darmon/ui/medicine_item/instructions/medicine_instructions_viewmodel.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_item/medicine_item_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';
import 'package:darmon/custom/expansion_title.dart' as wid;

class MedicineInstructionFragment extends ViewModelFragment<MedicineInstructionViewModel> {
  static final String ROUTE_NAME = "/instruction";

  static void open(BuildContext context, ArgMedicineItem argMedicineItem) {
    Navigator.push<dynamic>(
        context,
        SlideLeftRoute(
            routeName: ROUTE_NAME,
            page: Mold.newInstance(MedicineInstructionFragment()..argument = argMedicineItem)));
  }

  @override
  MedicineInstructionViewModel onCreateViewModel(BuildContext buildContext) =>
      MedicineInstructionViewModel(DarmonApp.instance.darmonServiceLocator.darmonRepository);

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: MyIcon.icon(Icons.arrow_back, color: Colors.white, size: 24),
              ),
              onTap: () {
                Mold.onBackPressed(this);
              },
            ),
          ),
          elevation: 0,
          backgroundColor: R.colors.appBarColor,
        ),
        body: StreamBuilder<MedicineItemInstruction>(
            stream: viewmodel.instruction,
            builder: (_, snapshot) {
              if (snapshot?.data != null) {
                return SingleChildScrollView(
                  child: MyTable.vertical(
                    [
                      _buildHeaderWidget(snapshot.data),
                      _buildInstructionListWidget(snapshot.data),
                    ],
                    width: double.infinity,
                  ),
                );
              } else {
                if (viewmodel.errorMessageValue?.message?.isNotEmpty == true) {
                  return Center(
                      child: MyTable.vertical(
                    [
                      MyIcon.icon(Icons.error_outlined, size: 60, color: R.colors.fabColor),
                      SizedBox(height: 16),
                      MyText(viewmodel.errorMessageValue.message, style: TS_ErrorText()),
                      SizedBox(height: 8),
                      MyTable.horizontal(
                        [MyText(R.strings.medicine_item.reload, style: TS_Button(Colors.white))],
                        padding: EdgeInsets.all(12),
                        borderRadius: BorderRadius.circular(8),
                        background: R.colors.appBarColor,
                        onTapCallback: () {
                          viewmodel.reloadModel();
                        },
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            }));
  }

  Widget _buildHeaderWidget(MedicineItemInstruction data) {
    return MyTable.vertical(
      [
        MyText(data.medicineName,
            style: TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18)),
        SizedBox(height: 8),
        RichText(
            text: TextSpan(
                text: R.strings.medicine_item.mnn.translate(),
                style: TextStyle(
                    fontFamily: "SourceSansPro",
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
                children: <TextSpan>[
              TextSpan(text: data.medicineMnn, style: TextStyle(fontWeight: FontWeight.w400)),
            ])),
        RichText(
            text: TextSpan(
                text: R.strings.medicine_item.producer.translate(),
                style: TextStyle(
                    fontFamily: "SourceSansPro",
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
                children: <TextSpan>[
              TextSpan(text: data.producerGenName, style: TextStyle(fontWeight: FontWeight.w400)),
            ]))
      ],
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    );
  }

  Widget _buildInstructionListWidget(MedicineItemInstruction data) {
    List<Widget> instructions = data.instructions.map((e) => _buildInstructionWidget(e)).toList();
    if (instructions.isEmpty) return Container();
    return MyTable.vertical(instructions);
  }

  Widget _buildInstructionWidget(MedicineInstruction instruction) {
    return MyTable.vertical(
      [
        wid.MyExpansionTile(
          hasBorder: false,
          title: MyText(
            instruction.header,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.w400),
          ),
          initiallyExpanded: false,
          children: [
            MyText(
              instruction.body,
              style: TS_List_Subtitle_1(Colors.black),
              padding: EdgeInsets.all(16),
            )
          ],
        ),
        Divider(height: 0.5, color: Colors.grey)
      ],
      background: Colors.white,
    );
  }
}
