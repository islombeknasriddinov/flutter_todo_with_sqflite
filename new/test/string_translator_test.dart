import 'package:flutter_test/flutter_test.dart';
import 'package:uzphariminfo/utils/ext_functions.dart';

void main() {
  group("test to cyrill to latin", () {
    test("test with empty string", () {
      expect("".cyrillToLatin(), "");
    });

    test("test with cyrill text", () {
      expect("салом".cyrillToLatin(), "salom");
    });

    test("test with latin text", () {
      expect("salom".cyrillToLatin(), "salom");
    });

    test("test with number text", () {
      expect("12345".cyrillToLatin(), "12345");
    });

    test("test with sign text", () {
      expect("*%?/@".cyrillToLatin(), "*%?/@");
    });

    test("test with hybrid text", () {
      expect("саломsalom12#%".cyrillToLatin(), "salomsalom12#%");
    });
  });

  group("test to latin to cyrill", () {
    test("test with empty string", () {
      expect("".latinToCyrill(), "");
    });

    test("test with latin text", () {
      expect("salom".latinToCyrill(), "салом");
    });

    test("test with cyrill text", () {
      expect("салом".latinToCyrill(), "салом");
    });

    test("test with number text", () {
      expect("12345".latinToCyrill(), "12345");
    });

    test("test with sign text", () {
      expect("*%?/@".latinToCyrill(), "*%?/@");
    });

    test("test with hybrid text", () {
      expect("саломsalom12#%".latinToCyrill(), "саломсалом12#%");
    });
  });
}
