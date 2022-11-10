import 'package:darmon/common/string_util.dart';

class Phonex {
  static String calculate(String text) {
    String result = "";
    List<List<String>> vMatrix = [
      ["", "a", "e", "o", "i", "u", "y"],
      ["s", "z", "c"],
      ["b", "v", "p", "f", "w"],
      ["d", "t"],
      ["q", "g", "k", "h", "x"],
      ["m", "n"],
      ["j"],
      ["l"],
      ["r"]
    ];

    List<String> vDoubles = [
      "ts",
      "ng",
      "ch",
      "sh",
    ];

    String vDouble;
    String vChar;
    String vReplaced = "";

    bool isSkip = false;
    bool isFound;
    String word;

    List<String> texts = [];
    RegExp exp = new RegExp(r"[А-я0-9]+|\w+");
    Iterable<Match> matches = exp.allMatches(text);
    for (var i in matches) {
      final matchedText = i.group(0);
      texts.add(matchedText);
    }
    for (int count = 0; count < texts.length; count++) {
      word = StringUtil.cyrillToLatin(texts[count]);
      for (int i = 0; i < word.length; i++) {
        if (isSkip) {
          isSkip = false;
          continue;
        }

        isFound = false;

        String lowerWord = word.toLowerCase();
        vChar = lowerWord.substring(i, i + 1);
        vDouble = lowerWord.length > i + 1 ? lowerWord.substring(i, i + 2) : null;

        if (vDoubles.contains(vDouble)) {
          if (i == 0) {
            vReplaced = vDouble;
          } else if (vDouble == vDoubles[0]) {
            vReplaced = vReplaced + 's';
          } else if (vDouble == vDoubles[1]) {
            vReplaced = vReplaced + 'm';
          } else {
            vReplaced = vReplaced + 'j';
          }
          // Skip next character when double replace worked
          isSkip = true;
        } else {
          if (i == 0) {
            vReplaced = vChar;
          } else {
            for (int j = 0; j < vMatrix.length; j++) {
              if (vMatrix[j].contains(vChar)) {
                vReplaced = vReplaced + vMatrix[j][0];
                isFound = true;
                break;
              }
            }
            if (isFound) continue;
            vReplaced = vReplaced + vChar;
          }
        }
      }
      result = result + vReplaced;
    }
    String myResult = "";

    for (int i = 0; i < result.length; i++) {
      if (i + 1 < result.length &&
          result[i] == result[i + 1] &&
          (result.codeUnitAt(i) < 48 || result.codeUnitAt(i) > 57)) {
        continue;
      }

      myResult = myResult + result[i];
    }

    return myResult;
  }
}
