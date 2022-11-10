import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uzphariminfo/pages/about_page.dart';
import 'package:uzphariminfo/pages/detail_page.dart';
import 'package:uzphariminfo/pages/home_page.dart';
import 'package:uzphariminfo/pages/preparation_page.dart';
import 'package:uzphariminfo/pages/search_page.dart';
import 'package:uzphariminfo/pages/splash_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('uzphariminfo');

  runApp(
    EasyLocalization(
        child: MyApp(),
        supportedLocales: [
          Locale('ru', 'RU'),
          Locale('uz', 'UZ')
        ],
        fallbackLocale: Locale('ru', 'RU'),
        path: 'assets/translations'
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SplashPage.id: (context) => SplashPage(),
        SearchPage.id: (context) => SearchPage(),
        AboutPage.id: (context) => AboutPage(),
        DetailPage.id: (context) => DetailPage(),
        PreparationPage.id: (context) => PreparationPage()
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
