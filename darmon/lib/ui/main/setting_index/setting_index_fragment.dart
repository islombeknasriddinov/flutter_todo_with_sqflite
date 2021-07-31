import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/ui/main/setting_index/setting_index_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class SettingIndexFragment extends ViewModelFragment<SettingIndexViewModel> {
  @override
  SettingIndexViewModel onCreateViewModel(BuildContext buildContext) => SettingIndexViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    Log.debug("context:${context.runtimeType.hashCode}");
    return Scaffold(
      backgroundColor: R.colors.background,
      appBar: AppBar(
        title: MyText(R.strings.setting.settings),
        backgroundColor: R.colors.appBarColor,
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
/*        _buildMenuItem(R.strings.setting.tutorial, () {
          PresentationFragment.open(getContext());
        }),*/
        _buildChangeThemeMenuItem()
      ]),
    );
  }

  Widget _buildMenuTitle(String title) {
    return MyTable.vertical([
      MyText(
        title,
        style: TS_Overline(textColor: R.colors.hintTextColor),
        padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
        upperCase: true,
      ),
      Divider(height: 1, color: R.colors.dividerColor),
    ], width: double.infinity, padding: EdgeInsets.fromLTRB(8, 0, 8, 0));
  }

  Widget _buildMenuItem(String title, Function clickAction) {
    return MyTable.vertical([
      MyText(title, style: TS_Body_1(R.colors.textColor), padding: EdgeInsets.all(16)),
      Divider(height: 1, color: R.colors.dividerColor),
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
              value: lang.first, child: MyText(lang.second, style: TS_Body_1(R.colors.textColor))),
        )
        .toList();

    var lang = AppLang.instance.getLangCode();

    return MyTable.vertical([
      MyTable.horizontal(
        [
          MyText(
            R.strings.setting.change_lang,
            flex: 1,
            style: TS_Body_1(R.colors.textColor),
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
      Divider(height: 1, color: R.colors.dividerColor),
    ], width: double.infinity, padding: EdgeInsets.fromLTRB(8, 0, 8, 0));
  }

  Widget _buildChangeThemeMenuItem() {
    return MyTable.vertical([
      MyTable.horizontal([
        MyText(R.strings.setting.dark_mode,
            style: TS_Body_1(R.colors.textColor), padding: EdgeInsets.all(16), flex: 1),
        Switch(
          activeColor: R.colors.switchColor,
          value: AppLang.instance.isDarkMode,
          onChanged: (boolVal) {
            if (AppLang.instance.isDarkMode) {
              AppLang.instance.setLightTheme();
            } else {
              AppLang.instance.setDarkTheme();
            }
          },
        )
      ]),
      Divider(height: 1, color: R.colors.dividerColor),
    ], width: double.infinity, padding: EdgeInsets.fromLTRB(8, 0, 8, 0), onTapCallback: () {
      if (AppLang.instance.isDarkMode) {
        AppLang.instance.setLightTheme();
      } else {
        AppLang.instance.setDarkTheme();
      }
    });
  }
}
