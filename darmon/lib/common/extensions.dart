import 'package:intl/intl.dart';

extension StringToMoneyFormat on String {
  String toMoneyFormat() {
    final formatCurrency = new NumberFormat("#,##0.######", "en_US");
    return formatCurrency.format(num.tryParse(this) ?? 0.0);
  }
}

extension IntToMoneyFromat on int {
  String toMoneyFormat() {
    NumberFormat format = new NumberFormat("#,##0.######", "en_US");
    return format.format(this);
  }
}

extension DoubleToMoneyFromat on double {
  String toMoneyFormat() {
    NumberFormat format = new NumberFormat("#,##0.######", "en_US");
    return format.format(this);
  }
}
