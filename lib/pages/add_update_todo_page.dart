import 'package:flutter/material.dart';
import 'package:flutter_sqflite_revison/model/todo_model.dart';
import 'package:flutter_sqflite_revison/service/status_service.dart';
import 'package:flutter_sqflite_revison/service/todo_servie.dart';

class AddUpdateTodoPage extends StatefulWidget {
  static const String id = "add_todo_page";
  int? todoID;
  int? statusID;

  AddUpdateTodoPage({this.todoID, this.statusID});

  @override
  State<AddUpdateTodoPage> createState() => _AddUpdateTodoPageState();
}

class _AddUpdateTodoPageState extends State<AddUpdateTodoPage> {
  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDescriptionController = TextEditingController();
  StatusService statusService = StatusService();
  TodoService todoService = TodoService();
  Todo todos = Todo();
  dynamic updateTodo;
  dynamic loadStatusById;

  dynamic _selectedValue;
  final _statuses = <DropdownMenuItem>[];

  @override
  void initState() {
    if (widget.todoID != 0 &&
        widget.statusID != 0 &&
        widget.statusID != null &&
        widget.todoID != null) {
      loadTodosById(widget.todoID);
      loadStatusesById(widget.statusID);
    }
    super.initState();
    loadStatuses();
  }

  @override
  void dispose() {
    super.dispose();
    todoTitleController.dispose();
    todoDescriptionController.dispose();
  }

  void loadStatuses() async {
    var statusService = StatusService();
    var statuses = await statusService.readStatus();
    for (var element in statuses) {
      _statuses.add(DropdownMenuItem(
        value: element["id"],
        child: Text(element["name"].toString()),
      ));
    }
    setState(() {});
  }

  void loadTodosById(int? query) async {
    if (query == null) return;
    updateTodo = await todoService.readTodosById(query);
    todoTitleController.text = updateTodo[0]["title"].toString();
    todoDescriptionController.text = updateTodo[0]["description"].toString();
    setState(() {});
  }

  void loadStatusesById(int? query) async {
    if (query == null) return;
    loadStatusById = await statusService.readStatusById(query);
    _selectedValue = loadStatusById[0]["id"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add Todo"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: todoTitleController,
              decoration: const InputDecoration(
                  labelText: "Title", hintText: "Write Todo Title"),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: const InputDecoration(
                  labelText: "Description", hintText: "Write Todo Description"),
            ),
            DropdownButtonFormField(
                value: _selectedValue,
                hint: const Text("Status"),
                items: _statuses,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (widget.todoID != 0 &&
                      widget.statusID != 0 &&
                      widget.statusID != null &&
                      widget.todoID != null) {
                    updateOldTodo();
                  } else {
                    addNewTodo();
                  }
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }

  Future<void> addNewTodo() async {
    todos.title = todoTitleController.text;
    todos.description = todoDescriptionController.text;
    todos.statusId = _selectedValue;
    await todoService.saveTodo(todos).then((value) {
      Navigator.of(context).pop();
    });
  }

  Future<void> updateOldTodo() async {
    todos.id = updateTodo[0]["id"];
    todos.title = todoTitleController.text;
    todos.description = todoDescriptionController.text;
    todos.statusId = _selectedValue;
    await todoService
        .upDateTodo(todos)
        .then((_) => Navigator.of(context).pop());
  }
}
