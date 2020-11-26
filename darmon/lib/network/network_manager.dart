import 'dart:convert';

import 'package:gwslib/gwslib.dart';
import 'package:gwslib/log/logger.dart';

class NetworkManager {
  static const String BASE_URL = "http://192.168.10.36:8080/smartup5x_darmon/";
  static const String SYNC = "b/darmon/dsph/r:sync_medicine_mark";
  static const String MEDICINE_LIST = "b/darmon/dsph/r:get_query";

  static NetworkManager _instance;

  factory NetworkManager.instance() {
    if (_instance == null) {
      _instance = NetworkManager();
    }
    return _instance;
  }

  NetworkManager();

  static Future<Map<String, dynamic>> sync() async {
    try {
      final jsonResult = await Network.get(BASE_URL, SYNC).param("laststamp", "").go();
      return jsonDecode(jsonResult);
    } catch (e, st) {
      Log.error("Sync(${e.toString()}\n${st.toString()})");
      throw e;
    }
  }

  static Future<Map<String, dynamic>> medicineList(dynamic body) async {
    try {
      final jsonResult = await Network.post(BASE_URL, MEDICINE_LIST).body(body).go();
      return jsonDecode(jsonResult);
    } catch (e, st) {
      Log.error("Sync(${e.toString()}\n${st.toString()})");
      throw e;
    }
  }
}
