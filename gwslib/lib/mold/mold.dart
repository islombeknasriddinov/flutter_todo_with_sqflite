import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gwslib/localization/app_lang.dart';
import 'package:gwslib/log/logger.dart';
import 'package:gwslib/mold/fragment.dart';
import 'package:gwslib/mold/mold_application.dart';
import 'package:provider/provider.dart';

class Mold {
  static void startApplication(
    MoldApplication application, {
    List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
    Function onError,
  }) {
    runZoned(() {
      runApp(
        MoldApplicationWidget(
          (context) {
            return ChangeNotifierProvider<AppLang>(
              create: (_) => AppLang.instance,
              child: Consumer<AppLang>(builder: (context, model, child) {
                if (!model.isInit) return Container();
                return MaterialApp(
                  routes: application.getRoutes(),
                  locale: model.getLocale(),
                  darkTheme: ThemeData.dark(),
                  theme: ThemeData.light(),
                  themeMode: model.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  supportedLocales: model.getSupportLangs(),
                  navigatorObservers: navigatorObservers,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                );
              }),
            );
          },
          application,
        ),
      );
    }, onError: (error, st) {
      Log.debug("###################\n$error\n$st");
      onError?.call(error, st);
    });
  }

  static Widget newInstance(RootFragment content) {
    return new Fragment(content);
  }

  static void openContent<R>(BuildContext context, dynamic content,
      {Object arguments, void onPopResult(R result)}) {
    Future<R> push;
    if (content is RootFragment) {
      push = Navigator.push<R>(context,
          new MaterialPageRoute(builder: (_) => Mold.newInstance(content..argument = arguments)));
    } else if (content is String) {
      push = Navigator.pushNamed(context, content, arguments: arguments);
    } else {
      throw new UnsupportedError("cannot openContent content not support");
    }

    push.then((value) => onPopResult?.call(value));
  }

  static void replaceContent<R>(BuildContext context, dynamic content,
      {Object arguments, void onPopResult(R result)}) {
    Future<R> push;
    if (content is RootFragment) {
      final fragment = Mold.newInstance(content..argument = arguments);
      push = Navigator.pushAndRemoveUntil<R>(
        context,
        new MaterialPageRoute(builder: (_) => fragment),
        (routes) => false,
      );
    } else if (content is String) {
      push = Navigator.pushNamedAndRemoveUntil(
        context,
        content,
        (routes) => false,
        arguments: arguments,
      );
    } else {
      throw new UnsupportedError("cannot replaceContent content not support");
    }

    push.then((value) => onPopResult?.call(value));
  }

  static void onBackPressed<T extends Object>(RootFragment content, [T result]) {
    onContextBackPressed(content.getContext(), result);
  }

  static void onContextBackPressed<T extends Object>(BuildContext context, [T result]) {
    Navigator.pop<T>(context, result);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void focusKeyboard(BuildContext context, [FocusNode node]) {
    FocusScope.of(context).requestFocus(node);
  }
}
