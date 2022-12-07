import 'package:flutter/material.dart';
import 'package:flutter_sqflite_revison/pages/all_status_page.dart';
import 'package:flutter_sqflite_revison/pages/sort_todo_by_status.dart';
import 'package:flutter_sqflite_revison/service/status_service.dart';

class DrawerNavigation extends StatefulWidget {
  static const String id = "drawer_nav";

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> list = [];
  StatusService statusService = StatusService();

  @override
  void initState() {
    super.initState();
    getAllStatus();
  }

  void getAllStatus() async {
    var statuses = await statusService.readStatus();
    for (var element in statuses) {
      String? statusName = element["name"].toString();
      int? statusId = int.tryParse(element["id"].toString());
      list.add(InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SortTodoByStatus(
                  statusId: statusId,
                  statusName: statusName,
                ),
              )).then((value) {
            list.clear();
            getAllStatus();
          });
        },
        child: ListTile(
          title: Text(element["name"].toString()),
        ),
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/image.jpeg")
            ),
            accountName: Text("Test User"),
            accountEmail: Text("test.testov@gmail.com"),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text("All status"),
            onTap: () {
              Navigator.of(context).pushNamed(AllStatusPage.id);
            },
          ),
          const Divider(),
          Column(children: list)
        ],
      ),
    );
  }
}
