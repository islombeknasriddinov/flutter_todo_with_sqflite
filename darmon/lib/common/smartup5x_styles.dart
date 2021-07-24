import 'package:flutter/material.dart';

TextStyle TS_ErrorText({Color textColor = Colors.redAccent, double fontSize = 14.0}) {
  return TextStyle(color: textColor, fontSize: fontSize, letterSpacing: 0.4);
}

TextStyle TS_LANG_TITLE([Color textColor = Colors.black87]) {
  return TextStyle(color: textColor, fontSize: 30.0, fontFamily: "SourceSansPro");
}

TextStyle TS_LANG([Color textColor = Colors.black87]) {
  return TextStyle(color: textColor, fontSize: 26.0, fontFamily: "SourceSansPro");
}

TextStyle TS_HeadLine6([Color textColor = Colors.black87]) {
  return TextStyle(
      color: textColor, fontSize: 22.0, fontFamily: "SourceSansPro", fontWeight: FontWeight.w500);
}

TextStyle TS_HeadLine5([Color textColor = Colors.black87]) {
  return TextStyle(
      color: textColor, fontSize: 24.0, fontFamily: "SourceSansPro", fontWeight: FontWeight.w400);
}

TextStyle TS_HeadLine4([Color textColor = Colors.black87]) {
  return TextStyle(
      color: textColor, fontSize: 32.0, fontWeight: FontWeight.w900, fontFamily: "SourceSansPro");
}

TextStyle TS_Body_2([Color textColor = Colors.black87]) {
  return TextStyle(
      color: textColor,
      fontSize: 16.0,
      letterSpacing: 0.25,
      fontFamily: "SourceSansPro",
      fontWeight: FontWeight.w400);
}

TextStyle TS_Body_1([Color textColor = Colors.black87]) {
  return TextStyle(
      color: textColor, fontSize: 18.0, letterSpacing: 0.5, fontFamily: "SourceSansPro");
}

TextStyle TS_Overline({Color textColor = Colors.black87}) {
  return TextStyle(
      color: textColor, fontSize: 12.0, letterSpacing: 1.5, fontFamily: "SourceSansPro");
}

TextStyle TS_Caption([Color color, bool underLine = false]) {
  Color textColor = color ?? Colors.black87;
  if (underLine) {
    return TextStyle(
        color: textColor,
        fontSize: 14,
        fontFamily: "SourceSansPro",
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        decoration: TextDecoration.underline);
  } else {
    return TextStyle(
      color: textColor,
      fontSize: 14,
      fontFamily: "SourceSansPro",
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    );
  }
}

TextStyle TS_Subtitle_1([Color textColor = Colors.black87,FontWeight fontWeight= FontWeight.w300]) {
  return TextStyle(
      color: textColor, fontSize: 18.0, fontFamily: "SourceSansPro", fontWeight: fontWeight);
}

TextStyle TS_List_Subtitle_1(
    [Color textColor = Colors.black87, FontWeight fontWeight = FontWeight.w300]) {
  return TextStyle(
      color: textColor, fontSize: 16.0, fontFamily: "SourceSansPro", fontWeight: fontWeight);
}

TextStyle TS_Subtitle_2([Color textColor = Colors.black]) {
  return TextStyle(
      color: textColor, fontSize: 16.0, letterSpacing: 0.1, fontFamily: "SourceSansPro");
}

TextStyle TS_CAPTION([Color textColor = Colors.black, double fontSize = 12]) {
  return TextStyle(
      color: textColor, fontSize: 12, fontFamily: "SourceSansPro", fontWeight: FontWeight.w600);
}

TextStyle TS_Button([Color textColor = Colors.black87]) {
  return TextStyle(
      color: textColor,
      fontSize: 16,
      letterSpacing: 0.4,
      fontFamily: "SourceSansPro",
      fontWeight: FontWeight.w500);
}
