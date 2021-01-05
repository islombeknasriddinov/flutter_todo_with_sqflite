import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class R {
  static ResourceAssert asserts = ResourceAssert();
  static ResourceStrings strings = ResourceStrings();
  static ResourceColors colors = ResourceColors();
}

class ResourceAssert {
  final String intro_logo = "assets/images/uzpharminfo.png";
  final String pills = "assets/images/pills.png";
  final String pills_horizontal = "assets/images/pills_horizontal.png";
  final String drawer_menu = "assets/libs/accounts/svg/drawer_menu.svg";
  final String edit_24 = "assets/libs/accounts/svg/edit_24.svg";
  final String leading_back = "assets/libs/accounts/svg/leading_back.svg";
  final String search = "assets/svg/search.svg";
  final String medicine = "assets/svg/medicine.svg";
  final String pharmacy = "assets/svg/pharmacy.svg";
  final String arrow_forward = "assets/svg/arrow_forward.svg";
  final String medical_facilities = "assets/svg/medical_facilities.svg";
  final String home = "assets/svg/home.svg";
  final String envelope = "assets/svg/envelope.svg";
  final String pager = "assets/svg/pager.svg";
  final String phone = "assets/svg/phone.svg";
  final String telegram = "assets/svg/telegram.svg";
  final String arrow_back = "assets/svg/arrow_back.svg";
  final String uzpharminfo_logo = "assets/svg/uzpharminfo_logo.svg";
  final String uzpharminfo_logo_small = "assets/svg/uzpharminfo_logo_small.svg";
  final String history = "assets/svg/history.svg";
  final String search_left = "assets/svg/search_left.svg";
  final String stroke = "assets/svg/stroke.svg";
  final String fax = "assets/svg/fax.svg";
  final String medicine_12 = "assets/svg/medicine_12.svg";
  final String info_circle = "assets/svg/info_circle.svg";
  final String animation_intro = "assets/anim/intro_anim.json";
}

class ResourceColors {
  final Color status_success = Color(0xFF63C832);
  final Color status_error = Color(0xFFE93558);
  final Color status_attention = Color(0xFFF79B26);
  final Color server_hint = Color(0xFF9AA4A8);
  final Color fabColor = Color(0xFFE15A5A);

  Color get app_color =>
      AppLang.instance.isDarkMode ? Colors.blue[200] : Color(0xFF489FCA);

  Color get statusBarColor =>
      AppLang.instance.isDarkMode ? Colors.black87 : Color(0xFF489FCA);

  Color get appBarColor => AppLang.instance.isDarkMode
      ? ThemeData.dark().appBarTheme.color
      : Color(0xFF489FCA);

  Color get background =>
      AppLang.instance.isDarkMode ? Colors.grey[800] : Color(0xFFF1F5F8);

  Color get medicineMarkBackground =>
      AppLang.instance.isDarkMode ? Colors.grey[800] : Color(0xFFE5E5E5);

  Color get backgroundColor => AppLang.instance.isDarkMode
      ? ThemeData.dark().backgroundColor
      : ThemeData.light().backgroundColor;

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
      : Colors.black54;

  Color get unselectedItemColor => AppLang.instance.isDarkMode
      ? ThemeData.dark().unselectedWidgetColor
      : ThemeData.light().unselectedWidgetColor;

  Color get textColor =>
      AppLang.instance.isDarkMode ? Colors.white : Colors.black87;

  Color get hintTextColor =>
      AppLang.instance.isDarkMode ? Colors.white38 : Colors.black38;

  Color get priceTitleTextColor =>
      AppLang.instance.isDarkMode ? Colors.white60 : Colors.black54;

  Color get switchColor =>
      AppLang.instance.isDarkMode ? Colors.blue[200] : Color(0xFF007BCF);

  Color get stickHeaderColor =>
      AppLang.instance.isDarkMode ? Colors.grey[700] : Color(0xFF489FCA);

  Color get priceColor =>
      AppLang.instance.isDarkMode ? Color(0xFFCF6679) : Color(0xFFda5b58);
}

class ResourceStrings {
  final PresentationStrings intro = PresentationStrings();
  final LanguageStrings lang = LanguageStrings();
  final MainStrings main = MainStrings();
  final SettingStrings setting = SettingStrings();
  final SearchIndexStrings search_index = new SearchIndexStrings();
  final MedicineItemStrings medicine_item = new MedicineItemStrings();
  final MedicineInstructionStrings medicine_instructions =
      new MedicineInstructionStrings();
  final MedicineListStrings medicine_list = new MedicineListStrings();

  final AboutStrings about = new AboutStrings();
  final MedicineMarkListStrings medicine_mark_list =
      new MedicineMarkListStrings();

  final FilterStrings filter = FilterStrings();
  final String more = "more";
  final String please_wait = "please_wait";
}

class PresentationStrings {
  final String next = "presentation:next";
  final String done = "presentation:done";
}

class AboutStrings {
  final String address = "about:address";
  final String phone = "about:phone";
  final String site = "about:site";
  final String mail = "about:mail";
  final String fax = "about:fax";
}

class LanguageStrings {
  final String select_language = "lang:select_language";
}

class MainStrings {
  final String medicine = "main:medicine";
  final String pharmacy = "main:pharmacy";
  final String medical_facilities = "main:medical_facilities";
  final String setting = "main:setting";
  final String title = "main:title";
  final String search_hint = "main:search_hint";
  final String about = "main:about";
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
  final String syncing = "search_index:syncing";
}

class MedicineItemStrings {
  final String reload = "medicine_item:reload";
  final String with_recipe = "medicine_item:with_recipe";
  final String with_out_recipe = "medicine_item:with_out_recipe";
  final String no_data_found = "medicine_item:no_data_found";
  final String price = "medicine_item:price";
  final String instructions = "medicine_item:instructions";
  final String marginal_price = "medicine_item:marginal_price";
  final String medicine_price = "medicine_item:medicine_price";
  final String analogs_count = "medicine_item:analogs_count";
  final String mnn = "medicine_item:mnn";
  final String producer = "medicine_item:producer";
  final String not_found_price = "medicine_item:not_found_price";
  final String medicine_marginal_price = "medicine_item:medicine_marginal_price";
  final String show_all = "medicine_item:show_all";
}

class MedicineInstructionStrings {
  final String reload = "medicine_instruction:reload";
  final String mnn = "medicine_instruction:mnn";
  final String producer = "medicine_instruction:producer";
  final String scope = "medicine_instruction:scope";
  final String storage = "medicine_instruction:storage";
  final String pharmacologic_action =
      "medicine_instruction:pharmacologic_action";
  final String atc_name = "medicine_instruction:atc_name";
  final String shelf_life = "medicine_instruction:shelf_life";
  final String opened_shelf_life = "medicine_instruction:opened_shelf_life";
  final String spread_kind = "medicine_instruction:spread_kind";
  final String clinical_pharmacological_group =
      "medicine_instruction:clinical_pharmacological_group";
  final String pharmacotherapeutic_group =
      "medicine_instruction:pharmacotherapeutic_group";
  final String color = "medicine_instruction:color";
  final String taste = "medicine_instruction:taste";
  final String route_of_administration =
      "medicine_instruction:route_of_administration";
  final String medicine_product = "medicine_instruction:medicine_product";
  final String year = "medicine_instruction:year";
  final String month = "medicine_instruction:month";
  final String week = "medicine_instruction:week";
  final String day = "medicine_instruction:day";
  final String with_recipe = "medicine_instruction:with_recipe";
  final String with_out_recipe = "medicine_instruction:with_out_recipe";
  final String no_data_found = "medicine_instruction:no_data_found";
}

class MedicineListStrings {
  final String search = "medicine_list_fragment:search";
  final String search_by = "medicine_list_fragment:search_by";
  final String search_by_name = "medicine_list_fragment:search_by_name";
  final String search_by_inn = "medicine_list_fragment:search_by_inn";
  final String reload = "medicine_list_fragment:reload";
  final String with_recipe = "medicine_list_fragment:with_recipe";
  final String with_out_recipe = "medicine_list_fragment:with_out_recipe";
  final String no_data_found = "medicine_list_fragment:no_data_found";
  final String price = "medicine_list_fragment:price";
  final String not_found_price = "medicine_list_fragment:not_found_price";
  final String price_currency = "medicine_list_fragment:price_currency";
  final String pharmacy_dispensing_conditions =
      "medicine_list_fragment:pharmacy_dispensing_conditions";
}

class MedicineMarkListStrings {
  final String mark_name = "medicine_mark_list_fragment:mark_name";
  final String mark_inn = "medicine_mark_list_fragment:mark_inn";
  final String search_history = "medicine_mark_list_fragment:search_history";
  final String show_more = "medicine_mark_list_fragment:show_more";
  final String warning = "medicine_mark_list_fragment:warning";
  final String delete_message = "medicine_mark_list_fragment:delete_message";
  final String yes = "medicine_mark_list_fragment:yes";
  final String no = "medicine_mark_list_fragment:no";
}

class FilterStrings {
  final String integer_text_field_hint = "filter:integer_text_field_hint";
  final String string_text_field_hint = "filter:string_text_field_hint";
  final String integer_range_from_hint = "filter:integer_range_from_hint";
  final String integer_range_to_hint = "filter:integer_range_to_hint";
  final String clear_btn = "filter:clear_btn";
  final String apply_btn = "filter:apply_btn";
}
