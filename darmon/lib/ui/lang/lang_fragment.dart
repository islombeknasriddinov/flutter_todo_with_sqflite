import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/ui/intro/intro_pref.dart';
import 'package:darmon/ui/lang/lang_viewmodel.dart';
import 'package:darmon/ui/main/main_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/app_lang.dart';

class LangContentFragment extends ViewModelFragment<LangViewModel> {
  static final String ROUTE_NAME = "/lang";

  static void replace(BuildContext context) {
    Mold.replaceContent(context, ROUTE_NAME);
  }

  @override
  LangViewModel onCreateViewModel(BuildContext buildContext) => LangViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    List<Widget> langs = AppLang.instance
        .getSupportLangText()
        .map((e) => _buildItem(
            e.first, e.second, true, (lang) => setSelectLocale(lang)))
        .toList();

    final row = <Widget>[
      Padding(
          child: MyText(R.strings.lang.select_language,
              style: TS_LANG_TITLE(Colors.white)),
          padding: EdgeInsets.only(bottom: 36))
    ];

    if (langs.isNotEmpty || langs.length > 1) {
      row.addAll(langs);
    }

    Widget container = Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: row,
      ),
    );
    return Scaffold(
      body: container,
      backgroundColor: R.colors.app_color,
    );
  }

  Widget _buildItem(
      String lang, String title, bool hasDivider, void callback(String lang)) {
    List<Widget> listColumn = [];
    if (hasDivider) {
      listColumn.add(Divider(color: Colors.white30, height: 1.5));
    }
    listColumn.add(ListTile(
      title: Center(
        child: MyText(title, style: TS_LANG(Colors.white)),
      ),
      onTap: () {
        callback.call(lang);
      },
    ));
    return Container(
      width: 200,
      child: Column(children: listColumn),
    );
  }

  void setSelectLocale(String lang) {
    AppLang.instance.changeLanguage(lang).then((value) async {
//vaqtinchalik
      await IntroPref.setPresentationShowed(true);

      MainFragment.replace(getContext());
      //   PresentationFragment.replace(getContext(), openMainFragment: true);
    }).catchError((error) {
      viewmodel.setError(error);
    });
  }
}
