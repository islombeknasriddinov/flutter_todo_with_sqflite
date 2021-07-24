import 'package:flutter/material.dart';
import 'package:gwslib/common/util.dart';
import 'package:gwslib/widgets/container_elevation.dart';
import 'package:gwslib/widgets/table.dart';
import 'package:gwslib/widgets/text.dart';

class MyAvatar extends StatelessWidget {
  double radius;
  String imageUrl;
  final bool isSelected;
  final String text;

  MyAvatar({this.radius, this.imageUrl, this.isSelected = false, this.text = ""});

  @override
  Widget build(BuildContext context) {
    if (radius == null || radius == 0 || radius < 0) {
      radius = 20;
    }

    Widget widget;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      widget = CircleAvatar(
        radius: radius - 1,
        child: ClipRRect(
          child: Image.network(
            imageUrl,
            loadingBuilder: (_, widget, loading) {
              return MyTable([_buildWithText(), widget]);
            },
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        backgroundColor: Colors.white,
      );
    } else {
      widget = _buildWithText();
    }

    if (isSelected) {
      widget = Stack(
        children: <Widget>[
          widget,
          Positioned(
            bottom: 0,
            right: 0,
            child: ContainerElevation(
              Icon(Icons.done, size: 5, color: Colors.white),
              backgroundColor: Color(0xFF63C832),
              width: 12,
              height: 12,
              borderRadius: BorderRadius.circular(6),
            ),
          )
        ],
      );
    }

    return widget;
  }

  Widget _buildWithText() {
    if (Util.isEmpty(text)) {
      return _buildDefault();
    }
    return MyTable(
      [
        MyText(
          text.length > 1 ? text.substring(0, 1) : text,
          upperCase: true,
          textAlign: TextAlign.center,
          flex: 1,
        )
      ],
      borderRadius: BorderRadius.circular(radius),
      width: radius * 2,
      height: radius * 2,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      background: getBackgroundColor(),
      padding: EdgeInsets.all(2),
    );
  }

  Widget _buildDefault() {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.black26,
      child: CircleAvatar(
          radius: radius - 1,
          backgroundColor: Colors.grey[100],
          child: Icon(
            Icons.person,
            size: radius + 10,
            color: Colors.grey[400],
          )),
    );
  }

  Color getBackgroundColor() {
    List<Color> colors = [
      Colors.amber,
      Colors.amberAccent,
      Colors.blue,
      Colors.blueAccent,
      Colors.yellowAccent,
      Colors.yellow,
      Colors.cyanAccent,
      Colors.blueGrey,
      Colors.deepOrange,
      Colors.deepOrangeAccent,
      Colors.deepPurple,
      Colors.deepPurpleAccent,
      Colors.green,
      Colors.greenAccent,
      Colors.purple,
      Colors.pink,
      Colors.teal,
    ];
    int nameFirstCode = text.codeUnits.first;
    return colors[nameFirstCode % colors.length];
  }
}
