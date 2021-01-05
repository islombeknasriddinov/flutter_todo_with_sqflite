import 'dart:convert';

import 'package:darmon/common/darmon_pref.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/log/logger.dart';

class NetworkManager {
  //static const String BASE_URL = "http://orcl.smartup.uz:8080/xdarmon/";

  static const String BASE_URL = "http://uzpharminfo.uz/";
  static const String SYNC = "b/darmon/dsph/r:sync_medicine_mark";
  static const String MEDICINE_LIST = "b/darmon/dsph/r:get_query";
  static const String MEDICINE_ANALOGS_LIST = "b/darmon/dsph/r:get_box_group_analogues";
  static const String MEDICINE_ITEM = "b/darmon/dsph/r:get_box_group";
  static const String MEDICINE_INSTRUCTION =
      "b/darmon/dsph/r:get_box_group_instructions";

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
      String lastamp = (await DarmonPref.getLastVisitTimestamp()) ?? "";
      final jsonResult = await Network.get(BASE_URL, SYNC)
          .param("laststamp", lastamp)
          .connectionTimeout(120 * 1000) //120 second
          .go();
      return jsonDecode(jsonResult);
    } catch (e, st) {
      Log.error("Sync(${e.toString()}\n${st.toString()})");
      throw e;
    }
  }

  static Future<Map<String, dynamic>> medicineList(dynamic body) async {
    try {
      final jsonResult = await Network.post(BASE_URL, MEDICINE_LIST)
          .body(body)
          .connectionTimeout(120 * 1000) //120 second
          .go();
      return jsonDecode(jsonResult);
    } catch (e, st) {
      Log.error("Sync(${e.toString()}\n${st.toString()})");
      throw e;
    }
  }

  static Future<Map<String, dynamic>> medicineAnalogsList(dynamic body) async {
    try {
      final jsonResult = await Network.post(BASE_URL, MEDICINE_ANALOGS_LIST)
          .body(body)
          .connectionTimeout(120 * 1000) //120 second
          .go();
      return jsonDecode(jsonResult);
    } catch (e, st) {
      Log.error("Sync(${e.toString()}\n${st.toString()})");
      throw e;
    }
  }

  static Future<Map<String, dynamic>> medicineItem(dynamic body) async {
    try {
      final jsonResult = await Network.post(BASE_URL, MEDICINE_ITEM)
          .body(body)
          .connectionTimeout(120 * 1000) //120 second
          .go();
      return jsonDecode(jsonResult);
    } catch (e, st) {
      Log.error("Sync(${e.toString()}\n${st.toString()})");
      throw e;
    }
  }

  static medicineInstruction(dynamic body) async {
    try {
      final jsonResult = await Network.post(BASE_URL, MEDICINE_INSTRUCTION)
          .body(body)
          .connectionTimeout(120 * 1000) //120 second
          .go();
      return jsonDecode(jsonResult);
    } catch (e, st) {
      Log.error("Sync(${e.toString()}\n${st.toString()})");
      throw e;
    }
  }
}
