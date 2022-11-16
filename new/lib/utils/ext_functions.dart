import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:uzphariminfo/utils/string_util.dart';

extension MoneyFormat on String {
  String toMoneyFormat() {
    if (isNotEmpty == true) {
      final oCcy = NumberFormat("#,##0.00", "en_US");
      return oCcy.format(num.tryParse(this));
    } else {
      return this;
    }
  }
}

extension TranslatorCrillAndLatin on String {
  String cyrillToLatin() {
    try {
      return StringUtil.cyrillToLatin(this);
    } catch (e, st) {
      if (kDebugMode) {
        print("Error: $e\nStacktrace: $st");
      }
      return this;
    }
  }

  String latinToCyrill() {
    try {
      return StringUtil.latinToCyrill(this);
    } catch (e, st) {
      if (kDebugMode) {
        print("Error: $e\nStacktrace: $st");
      }
      return this;
    }
  }
}
