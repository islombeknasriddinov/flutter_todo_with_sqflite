import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_sqflite_revison/model/status_model.dart';
import 'package:flutter_sqflite_revison/model/todo_model.dart';
import 'package:flutter_sqflite_revison/pages/add_update_status_page.dart';
import 'package:flutter_sqflite_revison/pages/add_update_todo_page.dart';
import 'package:flutter_sqflite_revison/pages/all_status_page.dart';
import 'package:flutter_sqflite_revison/pages/drawer_navigation_page.dart';
import 'package:flutter_sqflite_revison/service/status_service.dart';
import 'package:flutter_sqflite_revison/service/todo_servie.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StatusService statusService = StatusService();
  TodoService todoService = TodoService();
  Status status = Status();
  List<SpeedDialChild> statusList = [];
  List<Todo> list = [];

  @override
  void initState() {
    getAllTodos();
    super.initState();
    getAllStatus();
  }

  Future<void> getAllStatus() async {
    statusList = <SpeedDialChild>[];
    var readStatus = await statusService.readStatus();
    statusList.add(addStatus());
    int counter = 0;
    for (var element in readStatus) {
      counter++;
      if (counter < 5) {
        statusList.add(SpeedDialChild(
            child: Container(),
            backgroundColor:
                Color(int.tryParse(element['color'].toString()) ?? 0000000),
            label: element['name'].toString(),
            labelStyle: const TextStyle(fontSize: 10),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AddUpdateTodoPage.id)
                  .then((value) => getAllTodos());
            }));
      } else if (counter == 5) {
        statusList.add(addMore());
        return;
      }
    }
    setState(() {});
  }

  Future<void> getAllTodos() async {
    list = <Todo>[];
    var readTodos = await todoService.readTodos();
    for (var element in readTodos) {
      var model = Todo();
      model.id = int.tryParse(element["id"].toString());
      model.title = element["title"].toString();
      model.description = element["description"].toString();
      model.color = int.tryParse(element["color"].toString());
      model.statusId = int.tryParse(element["statusId"].toString());

      list.add(model);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Todo"),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                openEditStatusPage(
                    list[index].id ?? 0, list[index].statusId ?? 0);
              },
              child: Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          deleteTodo(list[index].id ?? 0)
                              .then((value) => getAllTodos());
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        flex: 1,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                strokeAlign: StrokeAlign.inside, width: 0.2))),
                    height: 80,
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          color: Color(list[index].color!),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[index].title.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(list[index].description.toString())
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Icon(Icons.edit_rounded)),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )),
            );
          }),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22.0),
        overlayColor: Colors.black,
        overlayOpacity: 0.1,
        spaceBetweenChildren: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
        children: statusList,
      ),
    );
  }

  void openAddStatusPage() {
    Navigator.of(context)
        .pushNamed(AddUpdateStatusPage.id)
        .then((value) => getAllStatus());
  }

  void openEditStatusPage(int todoID, int statusID) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddUpdateTodoPage(
                  todoID: todoID,
                  statusID: statusID,
                ))).then((value) => getAllTodos());
  }

  SpeedDialChild addStatus() {
    return SpeedDialChild(
      child: const Icon(
        Icons.edit,
        color: Colors.black54,
      ),
      backgroundColor: Colors.white,
      label: "Add Status",
      labelStyle: const TextStyle(fontSize: 10),
      onTap: () => openAddStatusPage(),
    );
  }

  SpeedDialChild addMore() {
    return SpeedDialChild(
      child: const Icon(
        Icons.more_horiz,
        color: Colors.black54,
      ),
      backgroundColor: Colors.white,
      label: "More",
      labelStyle: const TextStyle(fontSize: 10),
      onTap: () => openAllStatusPage(),
    );
  }

  Future<void> deleteTodo(int id) async {
    await todoService.deleteTodo(id);
  }

  void openAllStatusPage() {
    Navigator.of(context).pushNamed(AllStatusPage.id).then((value) {
      getAllStatus();
      getAllTodos();
    });
  }
}
