import 'package:darmon/common/resources.dart';
import 'package:darmon/common/result.dart';
import 'package:darmon/common/routes/slide_left_route.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
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
              child: StreamBuilder<List<MedicineListItem>>(
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

  Widget populateListItem(MedicineListItem medicine) {
    return MyTable.vertical(
      [
        MyText(
          medicine.medicineName(),
          style: TS_HeadLine6(R.colors.textColor),
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
      ],
      onTapCallback: () {
        MedicineItemFragment.open(getContext(), ArgMedicineItem(medicine.medicineMarkId));
      },
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      background: R.colors.cardColor,
      borderRadius: BorderRadius.circular(4),
      elevation: 2,
    );
  }
}
