import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqflite_revison/pages/all_status_page.dart';
import 'package:flutter_sqflite_revison/pages/sort_todo_by_status.dart';
import 'package:flutter_sqflite_revison/service/status_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_recoder_7/screen_recoder_7.dart';

class DrawerNavigation extends StatefulWidget {
  static const String id = "drawer_nav";

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> list = [];
  StatusService statusService = StatusService();
  Screenrecoder7? screenRecorder;
  Map<String, dynamic>? _response;
  bool inProgress = false;
  String? tempPath = "/storage/emulated/0/DCIM/ScreenRecorder/";

  @override
  void initState() {
    screenRecorder = Screenrecoder7();
    getAllStatus();
    super.initState();
  }

  Future<void> startRecord({required String fileName}) async {
    if (await Permission.storage.status.isGranted) {
      try {
        var startResponse = await screenRecorder?.startRecordScreen(
            directory: "screen_recorder_7",
            fileName: "VID",
            dirPathToSave: tempPath,
            audioEnable: true,
            wasHDSelected: true,
            videoBitrate: 6000000,
            videoFrame: 60);
        _response = startResponse;
        try {
          screenRecorder?.watcher?.events.listen(
            (event) {
              log(event.type.toString(), name: "Event: ");
            },
            onError: (e) =>
                kDebugMode ? debugPrint('ERROR ON STREAM: $e') : null,
            onDone: () => kDebugMode ? debugPrint('Watcher closed!') : null,
          );
        } catch (e) {
          kDebugMode ? debugPrint('ERROR WAITING FOR READY: $e') : null;
        }
      } on PlatformException {
        kDebugMode
            ? debugPrint(
                "Error: An error occurred while starting the recording!")
            : null;
      }
    } else if (await Permission.storage.status.isDenied) {
      if(await Permission.storage.request().isPermanentlyDenied){
        openAppSettings();
      }else{
        await Permission.storage.request();
      }
    }

    setState(() {});
  }

  Future<void> stopRecord() async {
    try {
      var stopResponse = await screenRecorder?.stopRecord();
      _response = stopResponse;
    } on PlatformException {
      kDebugMode
          ? debugPrint("Error: An error occurred while stopping recording.")
          : null;
    }
    setState(() {});
  }

  Future<void> pauseRecord() async {
    try {
      await screenRecorder?.pauseRecord();
    } on PlatformException {
      kDebugMode
          ? debugPrint("Error: An error occurred while pause recording.")
          : null;
    }
  }

  Future<void> resumeRecord() async {
    try {
      await screenRecorder?.resumeRecord();
    } on PlatformException {
      kDebugMode
          ? debugPrint("Error: An error occurred while resume recording.")
          : null;
    }
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
                backgroundImage: AssetImage("assets/images/image.jpeg")),
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
          ListTile(
            leading: const Icon(Icons.video_camera_back),
            title: const Text("Start Recorder"),
            onTap: () {
              startRecord(fileName: "VID");
              //Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.videocam_off),
            title: const Text("Stop Recorder"),
            onTap: () {
              stopRecord();
              //Navigator.of(context).pop();
            },
          ),
          const Divider(),
          Column(children: list)
        ],
      ),
    );
  }
}
