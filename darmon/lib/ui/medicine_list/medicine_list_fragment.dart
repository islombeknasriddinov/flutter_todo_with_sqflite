import 'package:darmon/common/resources.dart';
import 'package:darmon/common/result.dart';
import 'package:darmon/common/routes/slide_left_route.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:darmon/ui/medicine_list/medicine_list_viewmodel.dart';
import 'package:darmon/ui/medicine_mark_list/medicine_mark_list_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';
import 'package:darmon/common/extensions.dart';

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
        context,
        SlideLeftRoute(
            routeName: ROUTE_NAME, page: Mold.newInstance(MedicineListFragment()..argument = arg)));
    // Mold.openContent(context, ROUTE_NAME, arguments: medicineName);
  }

  ArgMedicineList get arg => argument as ArgMedicineList;

  @override
  MedicineListViewModel onCreateViewModel(BuildContext buildContext) => MedicineListViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return new Scaffold(
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
                MedicineMarkListFragment.popUntil(getContext());
              },
            ),
          ),
          elevation: 0,
          title: MyText(
            arg.medicineMark,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          backgroundColor: R.colors.appBarColor,
        ),
        floatingActionButton: FloatingActionButton(
          child: MyIcon.svg(R.asserts.search_left, size: 24, color: Colors.white),
          backgroundColor: R.colors.fabColor,
          onPressed: () {
            Mold.onBackPressed(this);
          },
        ),
        body: _buildListWidget());
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
                            R.strings.medicine_list.reload,
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
          medicine.producerGenName,
          style: TS_Subtitle_2(Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        MyTable.vertical(
          _buildMedicineProductsList(medicine.medicines),
          background: R.colors.cardColor,
          width: double.infinity,
        ),
      ],
      width: double.infinity,
      background: R.colors.stickHeaderColor,
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
        MyTable.horizontal(
          [
            MyTable.vertical(
              [
                MyText(
                  item.boxGenName,
                  style: TS_Body_1(R.colors.textColor),
                  padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 4),
                ),
                if (item.retailBasePrice?.isNotEmpty == true)
                  MyText(
                    R.strings.medicine_list.price
                        .translate(args: [item.retailBasePrice.toMoneyFormat()]),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    style: TS_List_Subtitle_1(),
                  )
                else
                  MyText(
                    R.strings.medicine_list.not_found_price,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    style: TS_List_Subtitle_1(),
                  ),
                SizedBox(height: 12)
              ],
              flex: 1,
            ),
            MyText(
              item.spreadKindTitle,
              style: TS_List_Subtitle_1(item.spreadKindColor,
                  item.spreadKindWithRecipe ? FontWeight.w600 : FontWeight.w300),
              padding: EdgeInsets.only(right: 16, top: 12),
            )
          ],
        ),
        isLast ? SizedBox(height: 10) : Divider(height: 1, color: R.colors.dividerColor)
      ],
      onTapCallback: () {
        MedicineItemFragment.open(getContext(), ArgMedicineItem(item.boxGroupId));
      },
      width: double.infinity,
    );
  }
}
