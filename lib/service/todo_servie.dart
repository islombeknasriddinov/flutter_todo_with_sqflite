import 'package:flutter_sqflite_revison/model/todo_model.dart';
import 'package:flutter_sqflite_revison/repository/appmodule.dart';

class TodoService{
  AppModule appModule = AppModule();
  String tableName = "todos";

  ToDoService(){
    appModule = AppModule();
  }

  Future<int> saveTodo(Todo todo) async{
    return await appModule.insertData(tableName, todo.todoToMap());
  }

  Future<List<Map<String, Object?>>> readTodos() async{
    return await appModule.readTodoData();
  }

  Future<Future<int>> upDateTodo(Todo todo) async{
    return appModule.updateData(tableName, todo.todoToMap());
  }

  Future<List<Map<String, Object?>>> readTodosById(int id) async{
    return await appModule.readDataById(tableName, id);
  }

  Future<List<Map<String, Object?>>> readTodoByStatusName(int todo) async{
    return await appModule.readDataByStatusName(tableName, "statusId", todo);
  }

  Future<int> deleteTodo(int id) async{
    return await appModule.deleteData(tableName, id);
  }
}