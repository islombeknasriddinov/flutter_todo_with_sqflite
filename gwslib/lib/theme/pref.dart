import 'package:gwslib/preferences/pref.dart';

class ThemePref {
  //------------------------------------------------------------------------------------------------

  static final String MODULE = "gwslib_theme";

  //------------------------------------------------------------------------------------------------

  static final String APP_THEME = "app_theme";

  static const String APP_THEME_DARK = "app_theme_dark";
  static const String APP_THEME_LIGHT = "app_theme_light";
  static const String APP_THEME_SYSTEM = "app_theme_system";

  //------------------------------------------------------------------------------------------------

  static Future<String> getTheme() {
    return Pref.load(MODULE, APP_THEME);
  }

  static Future<bool> setTheme(String appTheme) {
    if (appTheme == null || appTheme.trim().isEmpty) {
      throw new Exception("theme code is null or empty Theme[$appTheme]");
    }
    return Pref.save(MODULE, APP_THEME, appTheme);
  }
}
