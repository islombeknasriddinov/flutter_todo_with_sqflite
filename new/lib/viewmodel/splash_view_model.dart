import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uzphariminfo/utils/prefs.dart';
import '../networking/networking.dart';

class SplashViewModel extends ChangeNotifier {
  bool hasData = false;
  bool _disposed = false;
  bool isConnected = false;
  bool isLoading = false;
  late StreamSubscription subscription;


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
      }else{
        return hasData;
      }
    }catch(e){
      print("Exeption:${e}");
    }

  }

  void checkInternetConnection(){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkStatus();
    });
  }

  void checkInternetConnectionCansel(){
    subscription.cancel();
  }

  void checkStatus() async{
    isLoading = true;
    notifyListeners();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile
        || connectivityResult == ConnectivityResult.wifi) {
      apiMedicineList();
      isConnected = false;
      notifyListeners();
      isLoading = false;
      notifyListeners();
    } else if(connectivityResult == ConnectivityResult.none){
      isConnected = true;
      notifyListeners();
      Timer(const Duration(milliseconds: 200), () {
        isLoading = false;
        notifyListeners();
      });
    }
  }

  void saveLanguage(BuildContext context){
    if (context.locale == Locale('ru', 'RU')) {
      Prefs.remove(Prefs.KEY_LANGUAGECODE);
      Prefs.saveToPrefs("ru", Prefs.KEY_LANGUAGECODE);
    } else {
      Prefs.remove(Prefs.KEY_LANGUAGECODE);
      Prefs.saveToPrefs("uz", Prefs.KEY_LANGUAGECODE);
    }
  }



  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
