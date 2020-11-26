import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class R {
  static ResourceAssert asserts = ResourceAssert();
  static ResourceStrings strings = ResourceStrings();
  static ResourceColors colors = ResourceColors();
}

class ResourceAssert {
  final String intro_logo = "assets/images/intro_logo.png";
  final String drawer_menu = "assets/libs/accounts/svg/drawer_menu.svg";
  final String edit_24 = "assets/libs/accounts/svg/edit_24.svg";
  final String leading_back = "assets/libs/accounts/svg/leading_back.svg";
}

class ResourceColors {
  final Color status_success = Color(0xFF63C832);
  final Color status_error = Color(0xFFE93558);
  final Color status_attention = Color(0xFFF79B26);
  final Color server_hint = Color(0xFF9AA4A8);

  Color get app_color =>
      AppLang.instance.isDarkMode ? Colors.blue[200] : Color(0xFF007BCF);

  Color get background =>
      AppLang.instance.isDarkMode ? Colors.grey[800] : Color(0xFFF1F5F8);

  Color get statusError =>
      AppLang.instance.isDarkMode ? Color(0xFFCF6679) : Color(0xFFE93558);

  Color get cardColor => AppLang.instance.isDarkMode
      ? ThemeData.dark().cardColor
      : ThemeData.light().cardColor;

  Color get dividerColor => AppLang.instance.isDarkMode
      ? ThemeData.dark().dividerColor
      : ThemeData.light().dividerColor;

  Color get textColorOpposite =>
      AppLang.instance.isDarkMode ? Colors.black87 : Colors.white;

  Color get iconColors => AppLang.instance.isDarkMode
      ? ThemeData.dark().iconTheme.color
      : ThemeData.light().iconTheme.color;

  Color get textColor =>
      AppLang.instance.isDarkMode ? Colors.white : Colors.black87;

  Color get hintTextColor =>
      AppLang.instance.isDarkMode ? Colors.white38 : Colors.black38;

  Color get switchColor =>
      AppLang.instance.isDarkMode ? Colors.blue[200] : Color(0xFF007BCF);

  Color get stickHeaderColor =>
      AppLang.instance.isDarkMode ? Colors.grey[700] : Colors.grey[300];
}

class ResourceStrings {
  final PresentationStrings intro = PresentationStrings();
  final LanguageStrings lang = LanguageStrings();
  final MainStrings main = MainStrings();
  final SettingStrings setting = SettingStrings();
  final SearchIndexStrings search_index = new SearchIndexStrings();
  final MedicineListFragmentStrings medicine_list_fragment =
      new MedicineListFragmentStrings();

  final MedicineMarkListFragmentStrings medicine_mark_list_fragment =
      new MedicineMarkListFragmentStrings();
  final FilterStrings filter = FilterStrings();
  final String more = "more";
}

class PresentationStrings {
  final String next = "presentation:next";
  final String done = "presentation:done";
}

class LanguageStrings {
  final String select_language = "lang:select_language";
}

class MainStrings {
  final String medicine = "main:medicine";
  final String setting = "main:setting";
}

class SettingStrings {
  final String change_lang = "setting:change_lang";
  final String help = "setting:help";
  final String interface = "setting:interface";
  final String settings = "setting:settings";
  final String about = "setting:about";
  final String tutorial = "setting:tutorial";
  final String dark_mode = "setting:dark_mode";
}

class SearchIndexStrings {
  final String search = "search_index:search";
  final String search_text = "search_index:search_text";
  final String list_is_empty = "search_index:list_is_empty";
  final String filter = "search_index:filter";
}

class MedicineListFragmentStrings {
  final String search = "medicine_list_fragment:search";
  final String search_by = "medicine_list_fragment:search_by";
  final String search_by_name = "medicine_list_fragment:search_by_name";
  final String search_by_inn = "medicine_list_fragment:search_by_inn";
  final String reload = "medicine_list_fragment:reload";
}

class MedicineMarkListFragmentStrings {
  final String mark_name = "medicine_mark_list_fragment:mark_name";
  final String mark_inn = "medicine_mark_list_fragment:mark_inn";
  final String search_history = "medicine_mark_list_fragment:search_history";
  final String  show_more ="medicine_mark_list_fragment:show_more";
}

class FilterStrings {
  final String integer_text_field_hint = "filter:integer_text_field_hint";
  final String string_text_field_hint = "filter:string_text_field_hint";
  final String integer_range_from_hint = "filter:integer_range_from_hint";
  final String integer_range_to_hint = "filter:integer_range_to_hint";
  final String clear_btn = "filter:clear_btn";
  final String apply_btn = "filter:apply_btn";
}
