import 'package:darmon/common/string_util.dart';
import 'package:gwslib/gwslib.dart';

class UIMedicineMarkName {
  final String nameRu;
  final String nameUz;
  final String nameEn;

  UIMedicineMarkName(this.nameRu, this.nameUz, this.nameEn);
}

class UIMedicineMarkInn {
  final String innRu;
  final String innEn;
  final String innIds;

  UIMedicineMarkInn(this.innRu, this.innEn, this.innIds);
}

class UIMedicineMark {
  final String title;
  int suitableQueryBeginPosition;
  int suitableQueryEndPosition;
  final String titleRu;
  final String titleUz;
  final String titleEn;
  final String sendServerText;
  final UIMedicineMarkSearchResultType type;

  UIMedicineMark(
    this.title,
    String latinQuery,
    this.titleRu,
    this.titleUz,
    this.titleEn,
    this.sendServerText,
    this.type,
  ) {
    this.suitableQueryBeginPosition = findQueryBeginPosition(latinQuery);
    this.suitableQueryEndPosition = findQueryEndPosition(latinQuery);
  }

  bool get titleSplitted => suitableQueryBeginPosition != -1 && suitableQueryEndPosition != -1;

  int findQueryBeginPosition(String latinQuery) {
    try {
      String lowerTitle = StringUtil.cyrillToLatin(title.toLowerCase());
      String lowerLatinQuery = latinQuery.toLowerCase();

      if (lowerTitle.contains(lowerLatinQuery)) {
        int index = lowerTitle.indexOf(lowerLatinQuery);

        if (index > title.length) {
          index = -1;
        }

        return index;
      }
    } catch (error, st) {
      Log.error(error, st);
    }

    return -1;
  }

  int findQueryEndPosition(String latinQuery) {
    try {
      String lowerTitle = StringUtil.cyrillToLatin(title.toLowerCase());
      String lowerLatinQuery = latinQuery.toLowerCase();

      if (lowerTitle.contains(lowerLatinQuery)) {
        int index = lowerTitle.indexOf(lowerLatinQuery);
        if (index == -1) {
          return index;
        }

        int result = index + lowerLatinQuery.length;

        if (result > title.length) {
          return -1;
        }

        return result;
      }
    } catch (error, st) {
      Log.error(error, st);
    }

    return -1;
  }

  String get beginTitle => title.substring(0, suitableQueryBeginPosition);

  String get middleTitle => title.substring(suitableQueryBeginPosition, suitableQueryEndPosition);

  String get endTitle => title.substring(suitableQueryEndPosition, title.length);
}

enum UIMedicineMarkSearchResultType { NAME, INN, BOX_GROUP }
