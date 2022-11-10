import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:uzphariminfo/model/preparation_model.dart';
import 'package:uzphariminfo/networking/networking.dart';

class PreparationViewModel extends ChangeNotifier{
  Preparation preparation = Preparation();
  List<AnalogMedicineItem> item = [];
  bool isLoading = false;
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

  Future<String?> loadList(String boxGroupId, String lang) async{
    isLoading = true;
    notifyListeners();

    try{
      var response = await Network.getPreparationList(Network.API_PREPARATION, Network.paramsPreparation(boxGroupId, lang));
      print(response);
      if(response != null){
        preparation = Network.parsePreparationList(response);
        notifyListeners();
        item = preparation.similarBoxGroups!;
        notifyListeners();
      }
    }catch(e){
      print("Exeption: ${e}");
    }

    isLoading = false;
    notifyListeners();
  }

  checkInternetConnection(String boxGroupId, String langCode){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        checkStatus(boxGroupId, langCode);
      }
    });
  }

  checkInternetConnectionCansel(){
    subscription.cancel();
  }

  void checkStatus(String boxGroupId, String langCode) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      loadList(boxGroupId, langCode);
      notifyListeners();
      isConnected = false;
      notifyListeners();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      loadList(boxGroupId, langCode);
      notifyListeners();
      isConnected = false;
      notifyListeners();
    }else if(connectivityResult == ConnectivityResult.none){
      isConnected = true;
      notifyListeners();
    }

  }

}