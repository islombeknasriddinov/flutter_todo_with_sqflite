import 'package:flutter/material.dart';
import 'package:gwslib/theme/pref.dart';

class AppStateNotifier extends ChangeNotifier {
  //
  bool isDarkMode = false;
  bool isLightMode = false;
  bool isSystemMode = true;

  Future<bool> init() async {
    var theme = await ThemePref.getTheme();
    if (theme == null) {
      setSystemTheme();
    } else {
      switch (theme) {
        case ThemePref.APP_THEME_DARK:
          setDarkTheme();
          break;
        case ThemePref.APP_THEME_LIGHT:
          setLightTheme();
          break;
        case ThemePref.APP_THEME_SYSTEM:
          setSystemTheme();
          break;
      }
    }
    return true;
  }

  void setDarkTheme() {
    this.isDarkMode = true;
    this.isLightMode = false;
    this.isSystemMode = false;
    ThemePref.setTheme(ThemePref.APP_THEME_DARK);
    notifyListeners();
  }

  void setLightTheme() {
    this.isDarkMode = false;
    this.isLightMode = true;
    this.isSystemMode = false;
    ThemePref.setTheme(ThemePref.APP_THEME_LIGHT);
    notifyListeners();
  }

  void setSystemTheme() {
    this.isDarkMode = false;
    this.isLightMode = false;
    this.isSystemMode = true;
    ThemePref.setTheme(ThemePref.APP_THEME_SYSTEM);
    notifyListeners();
  }
}
