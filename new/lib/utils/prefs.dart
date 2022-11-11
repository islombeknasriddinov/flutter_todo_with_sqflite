import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uzphariminfo/model/history_model.dart';
import 'package:uzphariminfo/model/sync_model.dart';

class Prefs{
    static String KEY_LANGUAGECODE = "languageCode";
    static String KEY_HISTORY = "history";
    static String KEY_LIST = "list";


    static void saveToPrefs(dynamic list, String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString(key, list);
    }

    static void save(dynamic list, String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool(key, list);
    }

    static Future<bool> load(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.getBool(key)!;
    }

    static Future<String> loadFromPrefs(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.getString(key)!;
    }

    static Future<SyncMedicine?> loadListFromPrefs(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String stringUser = preferences.getString(key)!;
        if(stringUser == null || stringUser.isEmpty){
            return null;
        }

        Map<String, dynamic> map = jsonDecode(stringUser);
        return SyncMedicine.fromJson(map);
    }

    static Future<List<SearchHistory>> loadSearchHistory(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? stringHistory = preferences.getString(key);
        List<dynamic> data = jsonDecode(stringHistory!);
        List<SearchHistory> list = [];
        list = data.map((e) => SearchHistory.fromJson(e)).toList();
        return list;
    }

    static Future<bool> remove(String key) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.remove(key);
    }
}