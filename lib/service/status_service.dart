import 'package:flutter_sqflite_revison/model/status_model.dart';
import 'package:flutter_sqflite_revison/repository/appmodule.dart';

class StatusService{
    AppModule appModule = AppModule();
    final String table = "status";

    StatusService(){
      appModule = AppModule();
    }

    Future<int> saveStatus(Status status) async{
      return await appModule.insertData(table, status.statusToMap());
    }

    Future<List<Map<String, Object?>>> readStatus() async {
      return await appModule.readData(table);
    }

    Future<List<Map<String, Object?>>> readStatusById(int categoryId) async{
      return await appModule.readDataById(table, categoryId);
    }

    Future<int> upDateStatus(Status status) async{
      return await appModule.updateData(table, status.statusToMap());
    }

    Future<int> deleteStatus(int statusId) async{
      return await appModule.deleteData(table, statusId);
    }
}