import 'package:darmon/common/resources.dart';
import 'package:darmon/common/routes/slide_left_route.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/main.dart';
import 'package:darmon/ui/medicine_item/instructions/medicine_instructions_fragment.dart';
import 'package:darmon/custom/expansion_title.dart' as wid;
import 'package:darmon/ui/medicine_item/medicine_item_models.dart';
import 'package:darmon/ui/medicine_item/medicine_item_viewmodel.dart';
import 'package:darmon/ui/medicine_list/medicine_list_fragment.dart';
import 'package:darmon/ui/medicine_mark_list/medicine_mark_list_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:darmon/common/extensions.dart';
import 'package:gwslib/gwslib.dart';

class ArgMedicineItem {
  String medicineId;

  ArgMedicineItem(this.medicineId);
}

class MedicineItemFragment extends ViewModelFragment<MedicineItemViewModel> {
  static final String ROUTE_NAME = "/medicine";

  static void open(BuildContext context, ArgMedicineItem argMedicineItem) {
    Navigator.push<dynamic>(
        context,
        SlideLeftRoute(
            routeName: ROUTE_NAME,
            page: Mold.newInstance(MedicineItemFragment()..argument = argMedicineItem)));
  }

  static void replace(BuildContext context, ArgMedicineItem argMedicineItem) {
    Navigator.pushReplacement(
        context,
        SlideLeftRoute(
            routeName: ROUTE_NAME,
            page: Mold.newInstance(MedicineItemFragment()..argument = argMedicineItem)));
  }

  ArgMedicineItem get argMedicineItem => argument;

  @override
  MedicineItemViewModel onCreateViewModel(BuildContext buildContext) =>
      MedicineItemViewModel(DarmonApp.instance.darmonServiceLocator.darmonRepository);

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
        floatingActionButton: FloatingActionButton(
          child: MyIcon.svg(R.asserts.search_left, size: 24, color: Colors.white),
          backgroundColor: R.colors.fabColor,
          onPressed: () {
            MedicineMarkListFragment.popUntil(getContext());
          },
        ),
        body: StreamBuilder<MedicineItem>(
            stream: viewmodel.item,
            builder: (_, snapshot) {
              if (snapshot?.data != null) {
                return SingleChildScrollView(
                  child: MyTable.vertical(
                    [
                      _buildBodyWidget(snapshot.data),
                      _buildAnalogMedicinesListWidgets(snapshot.data),
                      _buildInstruction()
                    ],
                    width: double.infinity,
                  ),
                );
              } else {
                return Center(
                  child: MyTable.vertical([
                    StreamBuilder<Map<int, bool>>(
                        stream: viewmodel.progressStream,
                        builder: (_, snapshot) {
                          if (snapshot?.data?.isNotEmpty == true &&
                              snapshot.data[MedicineItemViewModel.PROGRESS] == true) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Container();
                          }
                        }),
                    StreamBuilder<ErrorMessage>(
                        stream: viewmodel.errorMessageStream,
                        builder: (_, snapshot) {
                          if (snapshot?.data?.message?.isNotEmpty == true) {
                            return Center(
                                child: MyTable.vertical(
                              [
                                MyIcon.icon(Icons.error_outlined,
                                    size: 60, color: R.colors.fabColor),
                                SizedBox(height: 16),
                                MyText(viewmodel.errorMessageValue.message,
                                    style: TS_ErrorText(),
                                    textAlign: TextAlign.center,
                                    padding: EdgeInsets.symmetric(horizontal: 12)),
                                SizedBox(height: 8),
                                MyTable.horizontal(
                                  [
                                    MyText(R.strings.medicine_item.reload,
                                        style: TS_Button(Colors.white))
                                  ],
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
                            return Container();
                          }
                        }),
                  ]),
                );
              }
            }));
  }

  Widget _buildBodyWidget(MedicineItem item) {
    return Container(
      child: MyTable.vertical([
        MyTable.horizontal(
          [
            MyText(item.producerGenName, flex: 1, style: TS_CAPTION(Colors.white)),
            MyTable(
              [
                MyText(item.spreadKindTitle, style: TS_CAPTION(Colors.white)),
              ],
              background: item?.spreadKindColor,
              borderRadius: BorderRadius.circular(4),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            )
          ],
          width: double.infinity,
        ),
        SizedBox(height: 6),
        MyText(
          item.medicineName,
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w400),
        ),
        /*   SizedBox(height: 6),
        MyText(
          item.medicineMnn,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w400),
        ),*/
        SizedBox(height: 14),
        MyTable.horizontal(
          [
            MyTable.vertical(
              [
                item.retailBasePrice?.isNotEmpty == true
                    ? RichText(
                        text: TextSpan(
                            text: item.retailBasePrice.toMoneyFormat(),
                            style: TS_HeadLine4(Colors.white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: R.strings.medicine_item.price.translate(),
                                  style: TextStyle(fontSize: 16)),
                            ]),
                      )
                    : MyText(
                        R.strings.medicine_item.not_found_price,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontFamily: "SourceSansPro"),
                      ),
                MyText(
                  R.strings.medicine_item.marginal_price,
                  style: TS_List_Subtitle_1(Colors.white70),
                )
              ],
              flex: 1,
            ),
            /*         MyTable.horizontal(
              [
                MyText(
                  R.strings.medicine_item.instructions,
                  style: TS_Caption(Colors.white),
                ),
                MyIcon.icon(Icons.chevron_right,
                    size: 16, color: Colors.white, padding: EdgeInsets.only(left: 8))
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              borderColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              onTapCallback: () {
                MedicineInstructionFragment.open(getContext(), argMedicineItem);
              },
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            )*/
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        )
      ]),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [R.colors.appBarColor, Color(0xFF3980B2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }

  Widget _buildAnalogMedicinesListWidgets(MedicineItem item) {
    if (item?.analogs?.isNotEmpty == true) {
      return MyTable.vertical(
        [
          MyText(
            R.strings.medicine_item.analogs_count.translate(args: [item.analogs.length.toString()]),
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.w600),
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
          ),
          Container(
            width: double.infinity,
            height: 105,
            child: ListView.builder(
                itemCount: item.analogs.length + 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  if (index == item.analogs.length) {
                    return _buildMoreAnalogMedicinesBtnWidget(item);
                  }
                  return _buildAnalogMedicineWidget(item.analogs[index]);
                }),
          )
        ],
        width: double.infinity,
      );
    } else {
      return Container();
    }
  }

  Widget _buildMoreAnalogMedicinesBtnWidget(MedicineItem item) {
    return MyTable(
      [
        MyTable.vertical(
          [
            MyText(
              R.strings.medicine_item.show_all,
              singleLine: true,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: "SourceSansPro"),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
        Align(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: MyIcon.icon(Icons.add, color: R.colors.appBarColor, size: 24),
              ),
            ),
          ),
          alignment: Alignment.bottomRight,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      borderRadius: BorderRadius.circular(4),
      elevation: 1,
      onTapCallback: () {
        MedicineListFragment.open(
            getContext(), ArgMedicineList.boxGroupId(item.medicineName, item.boxGroupId));
      },
      margin: EdgeInsets.all(4),
      background: Color(0xFFE8EDEF),
    );
  }

  Widget _buildAnalogMedicineWidget(AnalogMedicineItem analog) {
    return MyTable(
      [
        MyTable.vertical(
          [
            MyText(
              analog.getName(),
              singleLine: true,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: "SourceSansPro"),
            ),
            MyText(
              analog.producerGenName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: "SourceSansPro",
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            MyText(
              R.strings.medicine_item.medicine_marginal_price.translate(args: [analog.getPrice]),
              singleLine: true,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: "SourceSansPro"),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
        Align(
          child: MyIcon.svg(R.asserts.stroke, padding: EdgeInsets.only(bottom: 5)),
          alignment: Alignment.bottomRight,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      borderRadius: BorderRadius.circular(4),
      elevation: 1,
      onTapCallback: () {
        MedicineItemFragment.replace(getContext(), ArgMedicineItem(analog.boxGroupId));
      },
      margin: EdgeInsets.all(4),
      background: Color(0xFF39B070),
    );
  }

  Widget _buildInstruction() {
    return StreamBuilder<MedicineItemInstruction>(
        stream: viewmodel.instruction,
        builder: (_, snapshot) {
          if (snapshot?.data != null) {
            MedicineItemInstruction instruction = snapshot.data;
            return SingleChildScrollView(
              child: MyTable.vertical(
                [
                  _buildHeaderWidget(instruction),
                  MyTable.vertical([
                    _buildInstructionWidget(
                        R.strings.medicine_instructions.spread_kind, instruction.getSpreadInfo),
                    _buildInstructionWidget(
                        R.strings.medicine_instructions.shelf_life, instruction.getShelfLifeInfo),
                    _buildInstructionWidget(
                        R.strings.medicine_instructions.atc_name, instruction.atcName),
                    _buildInstructionWidget(R.strings.medicine_instructions.opened_shelf_life,
                        instruction.getOpenedShelfLifeInfo),
                    _buildInstructionWidget(R.strings.medicine_instructions.pharmacologic_action,
                        instruction.pharmacologicAction),
                    _buildInstructionWidget(
                        R.strings.medicine_instructions.scope, instruction.scope),
                    _buildInstructionWidget(
                        R.strings.medicine_instructions.storage, instruction.storage),
                    _buildInstructionWidget(R.strings.medicine_instructions.medicine_product,
                        instruction.medicineProduct),
                    _buildInstructionWidget(R.strings.medicine_instructions.route_of_administration,
                        instruction.routeAdministration),
                    _buildInstructionWidget(
                        R.strings.medicine_instructions.pharmacotherapeutic_group,
                        instruction.pharmacotherapeuticGroup),
                    _buildInstructionWidget(
                        R.strings.medicine_instructions.clinical_pharmacological_group,
                        instruction.clinicalPharmacologicalGroup),
                  ])
                ],
                width: double.infinity,
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget _buildHeaderWidget(MedicineItemInstruction data) {
    return MyTable.vertical(
      [
        RichText(
            text: TextSpan(
                text: R.strings.medicine_instructions.mnn.translate(),
                style: TextStyle(
                    fontFamily: "SourceSansPro",
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
                children: <TextSpan>[
              TextSpan(text: data.medicineInn, style: TextStyle(fontWeight: FontWeight.w400)),
            ])),
        RichText(
            text: TextSpan(
                text: R.strings.medicine_instructions.producer.translate(),
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

  Widget _buildInstructionWidget(String header, String body) {
    if (header == null || header.isEmpty || body == null || body.isEmpty) return Container();
    return MyTable.vertical(
      [
        wid.MyExpansionTile(
          hasBorder: false,
          title: MyText(
            header,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.w400),
          ),
          initiallyExpanded: false,
          children: [
            MyText(
              body,
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
