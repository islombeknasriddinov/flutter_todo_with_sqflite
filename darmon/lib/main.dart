import 'package:darmon/darmon_service_locator.dart';
import 'package:darmon/kernel/database_factory.dart';
import 'package:darmon/ui/barcode/barcode_fragment.dart';
import 'package:darmon/ui/intro/intro_content.dart';
import 'package:darmon/ui/lang/lang_fragment.dart';
import 'package:darmon/ui/main/main_fragment.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_list/medicine_list_fragment.dart';
import 'package:darmon/ui/presentation/presentation_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DarmonDatabaseFactory.instance.connectDatabase();
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
        MedicineListFragment.ROUTE_NAME: (context) => MedicineListFragment().toFragment(),
        MedicineItemFragment.ROUTE_NAME: (context) => MedicineItemFragment().toFragment()
      };

  DarmonServiceLocator _darmonServiceLocator;

  DarmonServiceLocator get darmonServiceLocator {
    if (_darmonServiceLocator == null)
      _darmonServiceLocator = DarmonServiceLocator(() => getDatabase());
    return _darmonServiceLocator;
  }

  DarmonDatabaseFactory getDatabaseFactory() => DarmonDatabaseFactory.instance;

  Database getDatabase() => instance.getDatabaseFactory().getDatabase();
}
