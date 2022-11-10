import 'package:darmon/darmon_service_locator.dart';
import 'package:darmon/kernel/database.dart';
import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/localization/translates.dart';
import 'package:darmon/repository/sync_repository.dart';
import 'package:darmon/ui/about/about_program_fragment.dart';
import 'package:darmon/ui/barcode/barcode_fragment.dart';
import 'package:darmon/ui/intro/intro_content.dart';
import 'package:darmon/ui/lang/lang_fragment.dart';
import 'package:darmon/ui/main/main_fragment.dart';
import 'package:darmon/ui/main/search_index/search_index_fragment.dart';
import 'package:darmon/ui/medicine_item/instructions/medicine_instructions_fragment.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_list/medicine_list_fragment.dart';
import 'package:darmon/ui/medicine_mark_list/medicine_mark_list_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DarmonDatabase.newInstance();
  Mold.startApplication(DarmonApp.instance);
}

class DarmonApp extends MoldApplication {
  static final DarmonApp instance = DarmonApp();

  @override
  void onCreate() {
    super.onCreate();
    SyncRepository.init(UIDarmonDao(DarmonDatabase.getInstance().getDatabase()));
  }

  @override
  Map<String, WidgetBuilder> getRoutes() => {
        IntroFragment.ROUTE_NAME: (context) => IntroFragment().toFragment(),
        LangContentFragment.ROUTE_NAME: (context) => LangContentFragment().toFragment(),
        AboutProgramFragment.ROUTE_NAME: (context) => AboutProgramFragment().toFragment(),
        MainFragment.ROUTE_NAME: (context) => MainFragment().toFragment(),
        MedicineInstructionFragment.ROUTE_NAME: (context) =>
            MedicineInstructionFragment().toFragment(),
        SearchIndexFragment.ROUTE_NAME: (context) => SearchIndexFragment().toFragment(),
        BarcodeFragment.ROUTE_NAME: (context) => BarcodeFragment().toFragment(),
        MedicineListFragment.ROUTE_NAME: (context) => MedicineListFragment().toFragment(),
        MedicineMarkListFragment.ROUTE_NAME: (context) => MedicineMarkListFragment().toFragment(),
        MedicineItemFragment.ROUTE_NAME: (context) => MedicineItemFragment().toFragment()
      };

  DarmonServiceLocator _darmonServiceLocator;

  DarmonServiceLocator get darmonServiceLocator {
    if (_darmonServiceLocator == null)
      _darmonServiceLocator =
          DarmonServiceLocator(() => DarmonDatabase.getInstance().getDatabase());
    return _darmonServiceLocator;
  }

  @override
  Map<String, String> getTranslates(String langCode) {
    return super.getTranslates(langCode)..addAll(Translates.getTranslates(langCode));
  }
}
