import 'package:flutter/material.dart';
import 'package:flutter_sqflite_revison/model/todo_model.dart';
import 'package:flutter_sqflite_revison/service/todo_servie.dart';

class SortTodoByStatus extends StatefulWidget {
  static const String id = "sort_todo_by_status";
  final int? statusId;
  final String? statusName;

  SortTodoByStatus({this.statusId, this.statusName});

  @override
  State<SortTodoByStatus> createState() => _SortTodoByStatusState();
}

class _SortTodoByStatusState extends State<SortTodoByStatus> {
  List<Todo> list = [];
  TodoService todoService = TodoService();

  @override
  void initState() {
    super.initState();
    getTodosByStatus();
  }

  void getTodosByStatus() async {
    var todos = await todoService.readTodoByStatusName(widget.statusId!);
    for (var element in todos) {
      var model = Todo();
      model.title = element["title"].toString();
      model.description = element["description"].toString();

      list.add(model);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.statusName!.toUpperCase()),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(list[index].title ?? "No Title")],
                  ),
                  subtitle: Text(list[index].description ?? "No Description"),
                ),
              );
            }));
  }
}
