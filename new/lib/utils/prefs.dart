import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uzphariminfo/model/history_model.dart';
import 'package:uzphariminfo/model/sync_model.dart';

class Prefs{
    static String KEY_LANGUAGECODE = "languageCode";
    static String KEY_HISTORY = "history";
    static String KEY_LIST = "list";


    static Future<bool> saveToPrefs(dynamic list, String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(key, list);
        return await preferences.commit();
    }

    static Future<String> loadFromPrefs(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.getString(key)!;
    }

    static Future<SyncMedicine> loadListFromPrefs(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? stringUser = preferences.getString(key);
        Map<String, dynamic> map = {};
        if(stringUser != null || stringUser!.isNotEmpty){
            map = jsonDecode(stringUser);
            return SyncMedicine.fromJson(map);
        }

        return SyncMedicine.fromJson(map);
    }

    static Future<List<SearchHistory>> loadSearchHistory(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? stringHistory = preferences.getString(key);
        List<SearchHistory> list = [];
        if(stringHistory != null){
            List<dynamic> data = jsonDecode(stringHistory);
            list = data.map((e) => SearchHistory.fromJson(e)).toList();
            return list;
        }else{
            return [];
        }
    }

    static Future<bool> remove(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.remove(key);
    }
}