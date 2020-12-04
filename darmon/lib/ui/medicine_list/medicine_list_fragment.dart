import 'package:darmon/common/resources.dart';
import 'package:darmon/common/result.dart';
import 'package:darmon/common/routes/slide_left_route.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:darmon/ui/medicine_list/medicine_list_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';

class ArgMedicineList {
  final String medicineMark;
  final String sendServerText;
  final UIMedicineMarkSearchResultType type;

  ArgMedicineList(this.medicineMark, this.sendServerText, this.type);
}

class MedicineListFragment extends ViewModelFragment<MedicineListViewModel> {
  static final String ROUTE_NAME = "/medicine_list_fragment";

  static void open(BuildContext context, ArgMedicineList arg) {
    Navigator.push<dynamic>(
        context, SlideLeftRoute(page: Mold.newInstance(MedicineListFragment()..argument = arg)));
    // Mold.openContent(context, ROUTE_NAME, arguments: medicineName);
  }

  ArgMedicineList get arg => argument as ArgMedicineList;

  @override
  MedicineListViewModel onCreateViewModel(BuildContext buildContext) => MedicineListViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: BackButton(color: R.colors.iconColors),
          elevation: 1,
          title: MyText(
            arg.medicineMark,
            style: TextStyle(color: R.colors.textColor),
          ),
          backgroundColor: R.colors.background,
        ),
        body: MyTable.vertical([
          Divider(height: 1, color: R.colors.dividerColor),
          Expanded(child: _buildListWidget())
        ]));
  }

  Widget _buildListWidget() {
    return MyTable.vertical(
      [
        Expanded(
          child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  viewmodel.loadPage();
                }
                return true;
              },
              child: StreamBuilder<List<ProducerListItem>>(
                stream: viewmodel.items,
                builder: (_, snapshot) {
                  print("snapshot?.data=${snapshot?.data}");

                  if (snapshot?.data?.isNotEmpty == true) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return populateListItem(snapshot.data[index]);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              )),
        ),
        StreamBuilder<MyResultStatus>(
            stream: viewmodel.statuse,
            builder: (_, snapshot) {
              if (snapshot?.data != null) {
                if (snapshot.data == MyResultStatus.ERROR) {
                  return MyTable.vertical(
                    [
                      MyText(
                        viewmodel?.errorMessageValue?.message ?? "",
                        style: TS_ErrorText(),
                      ),
                      Padding(
                        child: ContainerElevation(
                          MyText(
                            R.strings.medicine_list_fragment.reload,
                            style: TS_Button(R.colors.app_color),
                            upperCase: true,
                          ),
                          backgroundColor: R.colors.cardColor,
                          padding: EdgeInsets.only(top: 11, bottom: 11, left: 16, right: 16),
                          elevation: 2,
                          borderRadius: BorderRadius.circular(4),
                          onClick: () {
                            viewmodel.reload();
                          },
                        ),
                        padding: EdgeInsets.only(left: 6, right: 16, top: 16, bottom: 16),
                      )
                    ],
                    width: double.infinity,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    background: Colors.transparent,
                  );
                } else if (snapshot.data == MyResultStatus.LOADING) {
                  return Container(
                    height: 50.0,
                    color: Colors.transparent,
                    child: Center(
                      child: new CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            })
      ],
      background: R.colors.background,
    );
  }

  Widget populateListItem(ProducerListItem medicine) {
    return MyTable.vertical(
      [
        MyText(
          medicine.medicineMarkName,
          style: TS_Body_1(R.colors.textColorOpposite),
          padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 4),
        ),
        MyText(
          medicine.producerGenName,
          style: TS_Subtitle_2(textColor: R.colors.textColorOpposite),
          padding: EdgeInsets.only(left: 12, right: 12, bottom: 10),
        ),
        MyTable.vertical(
          _buildMedicineProductsList(medicine.medicines),
          borderRadius: BorderRadius.circular(8),
          background: R.colors.cardColor,
          width: double.infinity,
        ),
      ],
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      background: R.colors.app_color,
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
    );
  }

  List<Widget> _buildMedicineProductsList(List<ProducerMedicineListItem> medicines) {
    List<Widget> result = [];
    int medLength = medicines.length;
    for (int i = 0; i < medLength; i++) {
      result.add(_buildMedicineProduct(medicines[i], i == medLength - 1));
    }
    return result.isNotEmpty ? result : [Container()];
  }

  Widget _buildMedicineProduct(ProducerMedicineListItem item, bool isLast) {
    return MyTable.vertical(
      [
        MyText(
          item.boxGenName,
          style: TS_Body_1(R.colors.textColor),
          padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 4),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: RichText(
              text: TextSpan(
                  style: TS_Subtitle_2(textColor: item.spreadKindColor),
                  children: <TextSpan>[
                TextSpan(
                    text:
                        R.strings.medicine_list_fragment.pharmacy_dispensing_conditions.translate(),
                    style: TS_Subtitle_2(textColor: R.colors.priceTitleTextColor)),
                TextSpan(
                    text: item.spreadKindTitle,
                    style: TS_Subtitle_2(textColor: item.spreadKindColor))
              ])),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: RichText(
              text: TextSpan(
                  style: TS_Body_2(item.retailBasePrice?.isNotEmpty == true
                      ? R.colors.app_color
                      : R.colors.priceColor),
                  children: <TextSpan>[
                TextSpan(
                    text: R.strings.medicine_list_fragment.price.translate(),
                    style: TS_Body_2(R.colors.priceTitleTextColor)),
                TextSpan(
                    text: getMedicinePrice(item),
                    style: TS_Body_2(item.retailBasePrice?.isNotEmpty == true
                        ? R.colors.app_color
                        : R.colors.priceColor)),
                if (item.retailBasePrice?.isNotEmpty == true)
                  TextSpan(
                      text: R.strings.medicine_list_fragment.price_currency.translate(),
                      style: TS_Body_2(item.retailBasePrice?.isNotEmpty == true
                          ? R.colors.app_color
                          : R.colors.priceColor))
              ])),
        ),
        isLast ? SizedBox(height: 10) : Divider(height: 1, color: R.colors.dividerColor)
      ],
      onTapCallback: () {
        //MedicineItemFragment.open(getContext(), ArgMedicineItem(item.boxGroupId));
      },
      width: double.infinity,
    );
  }

  String getMedicinePrice(ProducerMedicineListItem item) {
    if (item.retailBasePrice?.isNotEmpty == true) {
      return item.retailBasePrice;
    } else {
      return R.strings.medicine_list_fragment.not_found_price.translate();
    }
  }
}
