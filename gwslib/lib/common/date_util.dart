import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';
import 'package:gwslib/log/logger.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat DD_MM_EEE = DateFormat("dd:MM:EEE");
  static final DateFormat HH_MM = DateFormat("HH:mm");

  //----------------------------------------------------------------------------
  static final DateFormat FORMAT_AS_NUMBER = DateFormat("yyyyMMdd");
  static final DateFormat FORMAT_AS_DATE = DateFormat("dd.MM.yyyy");
  static final DateFormat FORMAT_AS_DATETIME = DateFormat("dd.MM.yyyy HH:mm:ss");
  static final DateFormat FORMAT_DD_MM_YYYY_HH_MM = DateFormat("dd.MM.yyyy HH:mm");
  static final DateFormat FORMAT_AS_TIME = DateFormat("HH:mm:ss");
  static final DateFormat FORMAT_AS_HH_MM = DateFormat("HH:mm");
  static final DateFormat YYYYMMDDHHMMSS = DateFormat("yyyyMMddHHmmss");
  static final DateFormat FORMAT_AS_WEEK_DATE = DateFormat("EEEE, dd.MM.yyyy");
  static final DateFormat FORMAT_DD_MMM_YYYY = DateFormat("dd MMM yyyy");
  static final DateFormat FORMAT_MM_YYYY = DateFormat("MM.yyyy");
  static final DateFormat FORMAT_DD_EEEE = DateFormat("dd EEEE");
  static final DateFormat FORMAT_DD_MMMM_YYYY_EEE = DateFormat("dd MMMM yyyy (EEE)");
  static final DateFormat FORMAT_AS_MONTH = DateFormat("yyyy:MM");
  static final DateFormat MONTH_YEAR = DateFormat("MM.yyyy");

  static DateFormat FORMAT_AS_NUMBER_WITH_LANG(String langCode) => DateFormat("yyyyMMdd", langCode);

  static DateFormat FORMAT_AS_DATE_WITH_LANG(String langCode) => DateFormat("dd.MM.yyyy", langCode);

  static DateFormat FORMAT_AS_DATETIME_WITH_LANG(String langCode) =>
      DateFormat("dd.MM.yyyy HH:mm:ss", langCode);

  static DateFormat FORMAT_DD_MM_YYYY_HH_MM_WITH_LANG(String langCode) =>
      DateFormat("dd.MM.yyyy HH:mm", langCode);

  static DateFormat YYYYMMDDHHMMSS_WITH_LANG(String langCode) =>
      DateFormat("yyyyMMddHHmmss", langCode);

  static DateFormat FORMAT_DD_MMMM_YYYY_EEEE_WITH_LANG(String langCode) =>
      DateFormat("dd MMMM yyyy (EEEE)", langCode);


  static DateTime today() {
    final now = DateTime.now();
    return parse("${format(now, DateUtil.FORMAT_AS_DATE)} 00:00:00");
  }

  static String getMonthYear({DateTime dateTime}) {
    final date = dateTime ?? DateTime.now();
    final month = DateFormat.MMMM(AppLang.instance.getLangCode()).format(date);
    final year = date.year.toString();
    return month + " " + year;
  }

  static bool theSameDay(String d1, String d2) {
    var date1 = FORMAT_AS_DATE.parse(d1);
    var date2 = FORMAT_AS_DATE.parse(d2);
    return date1.compareTo(date2) == 0;
  }

  static List<String> sortDates(List<String> dates) {
    var dateTimes = dates.map((e) => parse(e)).toList();
    dateTimes.sort();
    return dateTimes.map((e) => format(e, FORMAT_AS_DATETIME)).toList();
  }

  static DateTime switchDateTime(DateTime dateTime, int toMonth) {
    DateTime newDate = DateTime(dateTime.year, dateTime.month + toMonth, dateTime.day);
    return newDate;
  }

  static String getTimeHour(String time) {
    if (time.isEmpty) {
      return "00";
    }
    final minutes = int.parse(time);
    final String hours =
        minutes ~/ 60 > 9 ? (minutes ~/ 60).toString() : "0" + (minutes ~/ 60).toString();
    final String min =
        minutes % 60 > 9 ? (minutes % 60).toString() : "0" + (minutes % 60).toString();
    return hours + ":" + min;
  }

  static DateTime parse(String s) {
    if (s == null || s.length == 0) return null;
    try {
      switch (s.length) {
        case 8:
          return FORMAT_AS_NUMBER.parse(s);
        case 10:
          return FORMAT_AS_DATE.parse(s);
        case 14:
          return YYYYMMDDHHMMSS.parse(s);
        case 16:
          return FORMAT_DD_MM_YYYY_HH_MM.parse(s);
      }
      return FORMAT_AS_DATETIME.parse(s);
    } on FormatException catch (error, st) {
      Log.error("Error($error)\n$st");
    }
    return null;
  }

  static Future<DateTime> parseWithLang(String s) async {
    if (s == null || s.length == 0) return null;
    String langCode = await LocalizationPref.getLanguage();
    return parseWithLangCode(s, langCode);
  }

  static DateTime parseWithLangCode(String s, String langCode) {
    if (s == null || s.length == 0) return null;
    try {
      switch (s.length) {
        case 8:
          return FORMAT_AS_NUMBER_WITH_LANG(langCode).parse(s);
        case 10:
          return FORMAT_AS_DATE_WITH_LANG(langCode).parse(s);
        case 14:
          return YYYYMMDDHHMMSS_WITH_LANG(langCode).parse(s);
        case 16:
          return FORMAT_DD_MM_YYYY_HH_MM_WITH_LANG(langCode).parse(s);
      }
      return FORMAT_AS_DATETIME_WITH_LANG(langCode).parse(s);
    } on FormatException catch (error, st) {
      Log.error("Error($error)\n$st");
    }
    return null;
  }

  static String format(DateTime date, DateFormat fmt) {
    try {
      return fmt.format(date);
    } on FormatException catch (error, st) {
      Log.error("Error($error)\n$st");
    }
    return null;
  }

  static DateTime formatDateTime(DateTime date, DateFormat dateFormat) {
    String stringDate = format(date, dateFormat);
    return dateFormat.parse(stringDate);
  }

  static String convert(String s, DateFormat fmt) {
    return format(parse(s), fmt);
  }

  static String convertToTime(String s, DateFormat fmt) {
    try {
      if (s == null || s.length == 0) return null;
      if (s.contains(":")) return s;
      final timeInMillisecond = int.parse(s) * 60 * 1000;
      final date =
          DateTime.fromMillisecondsSinceEpoch(today().millisecondsSinceEpoch + timeInMillisecond);

      return format(date, fmt);
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      return s;
    }
  }

  static convertTimeToText(String minute) {
    final minuteInt = int.parse(minute);
    final h = (minuteInt ~/ 60).toString();
    final m = (minuteInt % 60).toInt().toString();
    if (minuteInt % 60 == 0) {
      return "gwslib:date_util:hour".translate(args: [h]);
    } else if (minuteInt / 60 == 0) {
      return "gwslib:date_util:minute".translate(args: [m]);
    } else {
      return "gwslib:date_util:hour_minute".translate(args: [h, m]);
    }
  }
}
