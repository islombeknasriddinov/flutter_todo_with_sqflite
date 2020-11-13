import 'package:flutter/material.dart';

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
  final Color app_color = Color(0xFF007BCF);
  final Color green_light = Color(0xFF63C832);
  final Color status_success = Color(0xFF63C832);
  final Color status_error = Color(0xFFE93558);
  final Color status_attention = Color(0xFFF79B26);
  final Color server_hint = Color(0xFF9AA4A8);
  final Color background = Color(0xFFF1F5F8);
}

class ResourceStrings {
  final PresentationStrings intro = PresentationStrings();
  final LanguageStrings lang = LanguageStrings();
  final MainStrings main = MainStrings();
  final SettingStrings setting = SettingStrings();
  final SearchIndexStrings search_index = new SearchIndexStrings();
  final SearchFragmentStrings search_fragment = new SearchFragmentStrings();
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
}

class SearchIndexStrings {
  final String search = "search_index:search";
  final String search_text = "search_index:search_text";
}

class SearchFragmentStrings {
  final String search = "search_fragment:search";
  final String search_by = "search_fragment:search_by";
  final String search_by_name = "search_fragment:search_by_name";
  final String search_by_mnn = "search_fragment:search_by_mnn";
}
