import 'package:darmon/ui/barcode/barcode_fragment.dart';
import 'package:darmon/ui/intro/intro_content.dart';
import 'package:darmon/ui/lang/lang_fragment.dart';
import 'package:darmon/ui/main/main_fragment.dart';
import 'package:darmon/ui/presentation/presentation_fragment.dart';
import 'package:darmon/ui/search/search_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Mold.startApplication(DarmonApp.instance);
}

class DarmonApp extends MoldApplication {
  static final DarmonApp instance = DarmonApp();

  @override
  Map<String, WidgetBuilder> getRoutes() => {
        IntroFragment.ROUTE_NAME: (context) => IntroFragment().toFragment(),
        LangContentFragment.ROUTE_NAME: (context) => LangContentFragment().toFragment(),
        PresentationFragment.ROUTE_NAME: (context) => PresentationFragment().toFragment(),
        MainFragment.ROUTE_NAME: (context) => MainFragment().toFragment(),
        BarcodeFragment.ROUTE_NAME: (context) => BarcodeFragment().toFragment(),
        SearchFragment.ROUTE_NAME: (context) => SearchFragment().toFragment()
      };
}
