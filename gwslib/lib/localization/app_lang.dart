import 'dart:io';
import 'dart:ui';

import 'package:gwslib/common/tuple.dart';
import 'package:gwslib/localization/pref.dart';
import 'package:gwslib/localization/util.dart';
import 'package:gwslib/log/logger.dart';
import 'package:gwslib/theme/theme.dart';

class AppLang extends AppStateNotifier {
  static final AppLang instance = AppLang._();

  final Map<String, String> _supportLangs = {};
  final Map<String, String> _localizations = {};

  String _defaultLangCode;
  String _langCode;

  AppLang._();

  @override
  Future<bool> init() async {
    await super.init();
    Tuple<String, Map<String, String>> supportLangs = await AppLangUtil.loadSupportLang();
    _defaultLangCode = supportLangs.first;
    _supportLangs.clear();
    _supportLangs.addAll(supportLangs.second);

    var langCode = await LocalizationPref.getLanguage();
    if (langCode == null) {
      final systemLangCode = Platform.localeName.toLowerCase().split("_").first.toLowerCase();
      if (_supportLangs.containsKey(systemLangCode)) {
        langCode = systemLangCode;
      } else {
        langCode = _defaultLangCode;
      }

      await LocalizationPref.setLanguage(langCode);
    }
    this._langCode = langCode;
    changeLanguage(langCode);
    return true;
  }

  get isInit => _langCode != null && _langCode.isNotEmpty;

  Future<void> changeLanguage(String langCode) async {
    if (!_supportLangs.containsKey(langCode)) {
      throw new Exception("This [$langCode] lang code not support, "
          "you can use [${_supportLangs.keys.join(", ")}]");
    }
    this._langCode = langCode;
    if (!(await LocalizationPref.setLanguage(langCode))) {
      throw new Exception("could not save to pref lang code");
    }

    final localizations = await AppLangUtil.loadLocalizations().catchError((e, st) {
      Log.error(e, st);
      return null;
    });

    if (localizations == null) {
      throw new Exception("could not load localization");
    }

    _localizations.clear();
    _localizations.addAll(localizations);

    notifyListeners();
  }

  List<Tuple<String, String>> getSupportLangText() =>
      _supportLangs.entries.map((e) => Tuple<String, String>(e.key, e.value)).toList();

  List<Locale> getSupportLangs() => _supportLangs.keys.map((e) => new Locale(e)).toList();

  Locale getLocale() => new Locale(_langCode);

  String getLangCode() => _langCode;

  String translate(String code, {List<String> args, Map<String, String> withKeys}) {
    if (_localizations.containsKey(code)) {
      var value = _localizations[code];
      if (value != null && value.length > 0) {
        // with arguments by index
        if (args != null && args.isNotEmpty) {
          for (int i = 0; i < args.length; i++) {
            value = value.replaceAll("%${i + 1}\s", args[i]);
          }
        }
        // with arguments by keys
        if (withKeys != null && withKeys.isNotEmpty) {
          for (final item in withKeys.entries) {
            value = value.replaceAll("[$item]", item.value);
          }
        }
      }
      return value;
    }
    return code;
  }
}

extension StringTranslator on String {
  String translate({List<String> args, Map<String, String> withKeys}) {
    return AppLang.instance.translate(this, args: args, withKeys: withKeys);
  }
}
