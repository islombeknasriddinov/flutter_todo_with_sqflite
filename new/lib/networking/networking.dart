import 'dart:convert';
import 'package:http/http.dart';
import 'package:uzphariminfo/model/detail_model.dart';
import 'package:uzphariminfo/model/sync_model.dart';
import '../model/preparation_model.dart';

class Network {
  static final String BASE = "uzpharminfo.uz";

  /*https Api*/
  static String API_SYNC = "/b/darmon/dsph/r:sync_medicine_mark";
  static String API_DETAIL = "/b/darmon/dsph/r:get_query";
  static String API_PREPARATION = "/b/darmon/dsph/r:get_box_group";
  static String API_INSTRUCTION = "/b/darmon/dsph/r:get_box_group_instructions";

  /*https request*/
  static Future<String?> getList(String api) async {
    var uri = Uri.https(BASE, api);
    var response = await get(uri);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> getDetailList(String api, Map<String, dynamic> params) async{
    var uri = Uri.https(BASE, api);
    var response = await post(uri, body: jsonEncode(params) );
    if(response.statusCode == 200){
      return response.body;
    }

    return null;
  }

  static Future<String?> getPreparationList(String api, Map<String, dynamic> params) async{
    var uri = Uri.https(BASE, api);
    var response = await post(uri, body: jsonEncode(params));
    if(response.statusCode == 200){
      return response.body;
    }

    return null;
  }

  /*https params*/
  static Map<String, dynamic> paramsGetDetails(String query, String langCode, String type){
    Map<String,dynamic> body = {
      "d": {
        "type": type,
        "query": query,
        "lang": langCode,
      },
      "p": {
        "column": Data.getColumnKeys(),
        "filter": [],
        "sort": Data.sortedBy(),
        "offset": 0,
        "limit": 10
      }
    };

    return body;
  }

  static Map<String, dynamic> paramsPreparation(String boxGroupId, String lang){
    Map<String, dynamic> body = {
      "box_group_id": boxGroupId,
      "lang":lang
    };

    return body;
  }

  /*https parsing*/
  static SyncMedicine parseMedicineList(String response) {
    dynamic json =jsonDecode(response);
    var data = SyncMedicine.fromJson(json);
    return data;
  }

  static MedicineDetail parseMedicineDetailList(String response){
    dynamic json = jsonDecode(response);
    var data = MedicineDetail.fromJson(json);
    return data;
  }

  static Preparation parsePreparationList(String response){
    dynamic json = jsonDecode(response);
    var data = Preparation.fromJson(json);
    return data;
  }
}
