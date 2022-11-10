import 'package:hive/hive.dart';
import 'package:uzphariminfo/model/sync_model.dart';

class HiveDB{
  var box = Hive.box("uzphariminfo");

  void saveResponse(String key, SyncMedicine list) async{
      box.put(key, list);
  }

  SyncMedicine loadMedicine(String key){
    var list = SyncMedicine.fromJson(box.get(key));
    return list;
  }

  void remove(String key){
    box.delete(key);
  }
}