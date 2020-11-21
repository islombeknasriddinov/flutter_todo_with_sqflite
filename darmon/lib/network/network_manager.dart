import 'dart:collection';
import 'dart:convert';

import 'package:dio/src/multipart_file.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/log/logger.dart';
import 'package:http_parser/http_parser.dart';

class NetworkManager {
  static const String BASE_URL = "http://192.168.10.156:8080/darmon/";
  static const String SYNC = "b/darmon/dsph/r:sync_medicine";

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
}
