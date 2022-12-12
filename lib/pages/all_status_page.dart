import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sqflite_revison/model/status_model.dart';
import 'package:flutter_sqflite_revison/pages/add_update_status_page.dart';
import 'package:flutter_sqflite_revison/pages/sort_todo_by_status.dart';
import 'package:flutter_sqflite_revison/service/status_service.dart';

class AllStatusPage extends StatefulWidget {
  static const String id = "all_status_page";

  @override
  State<AllStatusPage> createState() => _AllStatusPageState();
}

class _AllStatusPageState extends State<AllStatusPage> {
  StatusService statusService = StatusService();
  List<Status> statusList = [];
  Status status = Status();
  String? statusName;
  int? statusId;

  @override
  void initState() {
    getAllStatus();
    super.initState();
  }

  void getAllStatus() async {
    var readStatus = await statusService.readStatus();
    if (statusList.isNotEmpty) statusList.clear();
    for (var e in readStatus) {
      statusName = e["name"].toString();
      statusId = int.tryParse(e["id"].toString());

      status = Status();
      status.id = int.tryParse(e["id"].toString());
      status.name = e["name"].toString();
      status.color = int.tryParse(e["color"].toString());

      statusList.add(status);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("All statuses"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
          itemCount: statusList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          deleteStatus(statusList[index].id ?? 0)
                              .then((value) => getAllStatus());
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        flex: 1,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color(statusList[index].color ?? 00000)))),
                    margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(statusList[index].name!,
                                style: const TextStyle(color: Colors.black)),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              openEditStatusPage(statusList[index].id ?? 0);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SortTodoByStatus(
                        statusId: statusId,
                        statusName: statusName,
                      ),
                    )).then((value) {
                  getAllStatus();
                });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddUpdateStatusPage.id);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void openEditStatusPage(int id) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => AddUpdateStatusPage(
                  statusID: id,
                )))
        .then((_) => getAllStatus());
  }

  Future<void> deleteStatus(int statusId) async {
    await statusService.deleteStatus(statusId);
  }
}
