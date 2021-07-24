import 'dart:ui';

E nvl<E>(E value, [E defaultValue]) {
  return value == null ? defaultValue : value;
}

/// nvlTryInt function
int nvlTryInt(Object value) {
  if (value is String)
    return value?.isNotEmpty == true ? int.tryParse(value) : null;
  else if (value is int)
    return value;
  else
    return null;
}

/// nvlTryInt function
int nvlTryIntByZero(Object value) {
  if (value is String)
    return value?.isNotEmpty == true ? int.tryParse(value) ?? 0 : 0;
  else if (value is int)
    return value;
  else
    return 0;
}

/// nvlTryInt function
num nvlTryNumByZero(Object value) {
  if (value is String)
    return value?.isNotEmpty == true ? num.tryParse(value) ?? 0 : 0;
  else if (value is num)
    return value;
  else if (value is int)
    return value;
  else if (value is double)
    return value;
  else
    return 0;
}

int nvlInt(int value, [int defaultValue = 0]) {
  return value == null ? defaultValue : value;
}

String nvlString(String value, [String defaultValue]) {
  return value == null ? defaultValue ?? "" : value;
}

String nvlEmpty(String value, [String defaultValue = ""]) {
  return value == null || value.length == 0 ? defaultValue : value;
}

int tryParseToInt(String value, [int defaultValue]) {
  return value == null || value.length == 0 ? defaultValue : int.tryParse(value);
}

class Util {
  static String get(Map<String, dynamic> data, String key) {
    return data.containsKey(key) ? data[key] : "";
  }

  static String fazoGet(List<String> p, List<dynamic> data, String key) {
    return data[p.indexOf(key)];
  }

  static String capitalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  static bool nonEmpty(String value) => !isEmpty(value);

  static bool isEmpty(String value) => value == null || value.length == 0;

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 4) {
      hexString = hexString[0] +
          hexString[1] +
          hexString[1] +
          hexString[2] +
          hexString[2] +
          hexString[3] +
          hexString[3];
    }
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
