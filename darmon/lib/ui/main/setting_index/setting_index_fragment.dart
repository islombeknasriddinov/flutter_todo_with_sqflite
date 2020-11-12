import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/ui/main/setting_index/setting_index_viewmodel.dart';
import 'package:darmon/ui/presentation/presentation_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';

class SettingIndexFragment extends ViewModelFragment<SettingIndexViewModel> {
  @override
  SettingIndexViewModel onCreateViewModel(BuildContext buildContext) => SettingIndexViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    Log.debug("context:${context.runtimeType.hashCode}");
    return Scaffold(
      appBar: AppBar(
        title: MyText(R.strings.setting.settings),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: R.colors.background,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: MyTable.vertical([
        SizedBox(height: 24),
        _buildMenuTitle(R.strings.setting.interface),
        _buildChangeLanguageMenuItem(),
        SizedBox(height: 24),
        _buildMenuTitle(R.strings.setting.help),
        _buildMenuItem(R.strings.setting.about, () {
          // AboutContent.open(getContext());
        }),
        _buildMenuItem(R.strings.setting.tutorial, () {
          PresentationFragment.open(getContext());
        }),
      ]),
    );
  }

  Widget _buildMenuTitle(String title) {
    return MyTable.vertical([
      MyText(
        title,
        style: TS_Overline(textColor: Colors.black38),
        padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
        upperCase: true,
      ),
      Divider(height: 1, color: Colors.grey[300]),
    ], width: double.infinity, padding: EdgeInsets.fromLTRB(8, 0, 8, 0));
  }

  Widget _buildMenuItem(String title, Function clickAction) {
    return MyTable.vertical([
      MyText(title, style: TS_Body_1(Colors.black87), padding: EdgeInsets.all(16)),
      Divider(height: 1, color: Colors.grey[300]),
    ],
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        onTapCallback: clickAction);
  }

  Widget _buildChangeLanguageMenuItem() {
    final langWidget = AppLang.instance
        .getSupportLangText()
        .map(
          (lang) => DropdownMenuItem(
              value: lang.first, child: MyText(lang.second, style: TS_Body_1(Colors.black87))),
        )
        .toList();

    var lang = AppLang.instance.getLangCode();

    return MyTable.vertical([
      MyTable.horizontal(
        [
          MyText(
            R.strings.setting.change_lang,
            flex: 1,
            style: TS_Body_1(Colors.black87),
          ),
          DropdownButton(
            value: lang,
            icon: Container(),
            underline: Container(),
            style: TS_Body_1(R.colors.app_color),
            items: langWidget,
            onChanged: (selectValue) {
              AppLang.instance.changeLanguage(selectValue);
            },
          ),
        ],
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      Divider(height: 1, color: Colors.grey[300]),
    ], width: double.infinity, padding: EdgeInsets.fromLTRB(8, 0, 8, 0));
  }
}
