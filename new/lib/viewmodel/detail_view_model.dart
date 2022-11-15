import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:uzphariminfo/networking/networking.dart';
import '../model/detail_model.dart';

class DetailViewModel extends ChangeNotifier{
  bool isLoading = false;
  bool isReloading = false;
  bool isConnected = false;
  bool _disposed = false;
  List<Data> data = [];
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


  Future<String?> loadList(String query, String langCode, String type) async{
    isLoading = true;
    notifyListeners();

    try{
      var response = await Network.getDetailList(Network.API_DETAIL, Network.paramsGetDetails(query, langCode, type));
      if(response != null){
        data = Network.parseMedicineDetailList(response).data;
        notifyListeners();
      }else{
        print(response);
      }
    }catch(e){
      print("Exeption: ${e}");
    }

    isLoading = false;
    notifyListeners();
  }

  checkInternetConnection(String query, String langCode, String type){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if(result == ConnectivityResult.mobile
            || result == ConnectivityResult.wifi){
          checkStatus(query, langCode, type);
        }
    });
  }

  checkInternetConnectionCansel(){
    subscription.cancel();
  }

  void checkStatus(String query, String langCode, String type) async{
    isReloading = true;
    notifyListeners();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile
        || connectivityResult == ConnectivityResult.wifi) {
      loadList(query, langCode, type);
      isConnected = false;
      notifyListeners();
      isReloading = false;
      notifyListeners();
    } else if(connectivityResult == ConnectivityResult.none){
      isConnected = true;
      notifyListeners();
      Timer(const Duration(milliseconds: 200), () {
        isReloading = false;
        notifyListeners();
      });
    }

  }
}