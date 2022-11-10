import 'package:easy_localization/easy_localization.dart';

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
