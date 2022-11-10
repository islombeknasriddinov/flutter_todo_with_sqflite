import 'package:flutter/material.dart';

class SizeRoute extends PageRouteBuilder {
  final Widget page;

  SizeRoute({this.page, @required String routeName})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: Duration(milliseconds: 200),
          reverseTransitionDuration: Duration(milliseconds: 200),
          settings: RouteSettings(name: routeName),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          ),
        );
}
