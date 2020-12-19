import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/ui/main/main_viewmodel.dart';
import 'package:darmon/ui/medicine_mark_list/medicine_mark_list_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/widgets/icon.dart';

class MainFragment extends ViewModelFragment<MainViewModel> {
  static final String ROUTE_NAME = "/main";

  static void replace(BuildContext context) {
    Mold.replaceContent(context, ROUTE_NAME);
  }

  @override
  MainViewModel onCreateViewModel(BuildContext buildContext) => MainViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: R.colors.appBarColor,
          leading: StreamBuilder<String>(
            stream: viewmodel.currentLangCode,
            builder: (_, snapshot) {
              if (snapshot?.data == "ru") {
                return MyText("RU");
              } else if (snapshot?.data == "en") {
                return MyText("EN");
              } else if (snapshot?.data == "uz") {
                return MyText("UZ");
              } else {
                return Container();
              }
            },
          ),
          actions: [
            MyIcon.icon(
              Icons.info,
              color: Colors.white,
              padding: EdgeInsets.only(right: 12),
              onTap: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: MyTable.vertical(
            [
              Image.asset(R.asserts.pills, width: double.infinity),
              MyText(
                R.strings.main.title,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                style: TS_HeadLine5(Colors.white),
              ),
              MyTable.horizontal(
                [
                  MyIcon.svg(R.asserts.search, size: 20),
                  MyText(
                    R.strings.main.search_hint,
                    padding: EdgeInsets.only(left: 8),
                    style: TS_Subtitle_1(Colors.black54),
                  )
                ],
                onTapCallback: () {
                  MedicineMarkListFragment.open(getContext(), ArgMedicineMarkList(""));
                },
                background: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.all(14),
                borderRadius: BorderRadius.circular(12),
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
              ),
              MyTable.vertical(
                [
                  buildMenu(R.strings.main.medicine, R.asserts.medicine, onTapAction: () {}),
                  buildMenu(R.strings.main.pharmacy, R.asserts.pharmacy, onTapAction: () {}),
                ],
                width: double.infinity,
                background: Colors.white,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              )
            ],
            width: double.infinity,
            background: R.colors.appBarColor,
          ),
        ));
  }

  Widget buildMenu(String title, String icon, {void Function() onTapAction}) {
    return MyTable.horizontal(
      [
        MyIcon.svg(icon, size: 32, padding: EdgeInsets.only(left: 4)),
        MyText(title,
            style: TS_Subtitle_1(Colors.black), padding: EdgeInsets.only(left: 16), flex: 1),
        if (onTapAction != null) MyIcon.svg(R.asserts.arrow_forward, size: 16)
      ],
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      crossAxisAlignment: CrossAxisAlignment.center,
      onTapCallback: onTapAction,
    );
  }
}
