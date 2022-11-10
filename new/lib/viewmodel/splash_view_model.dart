import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uzphariminfo/utils/prefs.dart';
import '../networking/networking.dart';
import '../pages/home_page.dart';

class SplashViewModel extends ChangeNotifier {
  bool hasData = false;
  bool _disposed = false;
  bool isConnected = false;
  late StreamSubscription subscription;

  @override
  dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  Future<bool?> apiMedicineList() async {
    try{
      var response = await Network.getList(Network.API_SYNC);
      if (response != null){
        Prefs.saveToPrefs(response, Prefs.KEY_LIST);
        hasData = true;
        notifyListeners();
        return hasData;
      }
    }catch(e){
      print("Exeption:${e}");
    }


  }

  checkInternetConnection(){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkStatus();
    });
  }

  checkInternetConnectionCansel(){
    subscription.cancel();
  }

  Future<bool?> checkStatus() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      await apiMedicineList().then((value) =>
      hasData = value!
      );
      isConnected = false;
      notifyListeners();
      return hasData;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      await apiMedicineList().then((value) =>
      hasData = value!
      );
      isConnected = false;
      notifyListeners();
      return hasData;
    }else if(connectivityResult == ConnectivityResult.none){
      isConnected = true;
      notifyListeners();
    }

  }

  saveLanguage(BuildContext context){
    if (context.locale == Locale('ru', 'RU')) {
      Prefs.remove("languageCode");
      Prefs.saveToPrefs("ru", Prefs.KEY_LANGUAGECODE);
    } else {
      Prefs.remove("languageCode");
      Prefs.saveToPrefs("uz", Prefs.KEY_LANGUAGECODE);
    }
  }

}
