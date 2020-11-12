import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gwslib/common/tuple.dart';
import 'package:gwslib/kernel/database.dart';
import 'package:gwslib/kernel/mt/mt_util.dart';
import 'package:gwslib/localization/app_lang.dart';
import 'package:gwslib/log/logger.dart';

class AppLangUtil {
  static Future<Tuple<String, Map<String, String>>> loadSupportLang() async {
    final filePath = 'assets/l10n/support_langs.json';
    final jsonString = await rootBundle.loadString(filePath).catchError((e, st) {
      Log.error(e, st);
      return "";
    });

    if (jsonString == null || jsonString.trim().isEmpty) {
      throw Exception("assets/l10n/support_langs.json not found");
    }

    Map<String, dynamic> data = json.decode(jsonString);
    final defaultLangCode = data["default"];
    data.remove("default");

    Map<String, String> langs = data.map((key, value) =>
        MapEntry(key.toLowerCase().split("_").first.trim(), value.toString().trim()));
    langs.removeWhere((key, value) => value.isEmpty);

    return new Tuple(defaultLangCode, langs);
  }

  static Future<Map<String, String>> loadLocalizations() async {
    final langCode = AppLang.instance.getLangCode();
    if (!MoldDatabase.isOpen()) {
      await MoldDatabase.init();
    }

    return MtUtil.loadAllTranslates(langCode).then((translates) async {
      if (translates != null && translates.isNotEmpty) {
        return translates;
      }

      final filePath = 'assets/l10n/$langCode.json';
      final jsonString = await rootBundle.loadString(filePath).catchError((e, st) {
        Log.error(e, st);
        return "";
      });

      if (jsonString != null && jsonString.trim().isNotEmpty) {
        Map<String, dynamic> data = json.decode(jsonString);
        if (data != null && data.isNotEmpty) {
          return data.map((key, value) => MapEntry(key, value.toString()));
        }
      }
      return <String, String>{};
    }).catchError((e, st) {
      Log.error(e, st);
      return <String, String>{};
    });
  }
}
