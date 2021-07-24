import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;

  double width;
  double height;

  Color backgroundColor;

  EdgeInsetsGeometry margin;
  EdgeInsetsGeometry padding;
  TextAlign textAlign;

  Color textColor;
  double fontSize;

  ButtonWidget(this.text,
      {this.width,
      this.height,
      this.backgroundColor,
      this.margin,
      this.padding,
      this.textAlign,
      this.textColor,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: this.textColor,
      fontSize: this.fontSize,
    );

    return Card(
      margin: this.margin,
      color: this.backgroundColor,
      elevation: 3,
      child: Container(
        child: Text(this.text, style: textStyle, textAlign: this.textAlign),
        width: this.width,
        height: this.height,
        padding: this.padding,
      ),
    );
  }
}
