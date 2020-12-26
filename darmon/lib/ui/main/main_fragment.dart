import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/main.dart';
import 'package:darmon/ui/about/about_program_fragment.dart';
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
  MainViewModel onCreateViewModel(BuildContext buildContext) =>
      MainViewModel(DarmonApp.instance.darmonServiceLocator.darmonRepository);

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: R.colors.appBarColor,
        body: SafeArea(
          child: MyTable([
            Align(
              child: Image.asset(R.asserts.pills, width: double.infinity,fit:BoxFit.fill ),
              alignment: Alignment.topCenter,
            ),
            Align(
              child: MyTable.horizontal(
                [
                  StreamBuilder<String>(
                    stream: viewmodel.currentLangCode,
                    builder: (_, snapshot) {
                      return buildChooseLangWidget(snapshot?.data);
                    },
                  ),
                  Expanded(child: Container()),
                  MyIcon.icon(
                    Icons.info,
                    color: Colors.white,
                    padding: EdgeInsets.only(right: 12),
                    onTap: () {
                      AboutProgramFragment.open(getContext());
                    },
                  )
                ],
                width: double.infinity,
                padding: EdgeInsets.all(12),
              ),
              alignment: Alignment.topCenter,
            ),
            Align(
              child: SingleChildScrollView(
                child: MyTable.vertical(
                  [
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
                    StreamBuilder<Map<int, bool>>(
                      stream: viewmodel.progressStream,
                      builder: (_, snapshot) {
                        if ((snapshot.data?.values?.where((element) => element)?.length ?? -1) >
                            0) {
                          return MyTable.vertical(
                            [
                              LinearProgressIndicator(),
                              MyText(R.strings.search_index.syncing, style: TS_Body_1(Colors.white))
                            ],
                            padding: EdgeInsets.all(12),
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                          );
                        } else {
                          return Container(color: R.colors.background);
                        }
                      },
                    ),
                    MyTable.vertical(
                      [
                        buildMenu(R.strings.main.medicine, R.asserts.medicine, onTapAction: () {}),
                        Divider(height: 0.5, color: Colors.grey),
                        buildMenu(R.strings.main.pharmacy, R.asserts.pharmacy),
                        Divider(height: 0.5, color: Colors.grey),
                        buildMenu(R.strings.main.medical_facilities, R.asserts.medical_facilities),
                      ],
                      width: double.infinity,
                      background: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    )
                  ],
                  width: double.infinity,
                ),
              ),
              alignment: Alignment.bottomCenter,
            )
          ]),
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

  Widget buildChooseLangWidget(String data) {
    final langWidget = AppLang.instance
        .getSupportLangText()
        .map(
          (lang) => DropdownMenuItem(
              value: lang.first, child: MyText(lang.second, style: TS_Body_1(Colors.white))),
        )
        .toList();

    var lang = data?.isNotEmpty == true ? data : AppLang.instance.getLangCode();
    return Container(
      height: 40,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton(
        value: lang,
        icon: MyIcon.icon(Icons.arrow_drop_down, size: 16, color: Colors.white),
        underline: Container(),
        style: TS_Body_1(R.colors.app_color),
        items: langWidget,
        dropdownColor: R.colors.appBarColor,
        onChanged: (selectValue) {
          AppLang.instance.changeLanguage(selectValue);
        },
      ),
    );
  }
}
