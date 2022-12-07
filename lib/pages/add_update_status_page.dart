import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_sqflite_revison/model/status_model.dart';
import 'package:flutter_sqflite_revison/service/status_service.dart';
import 'package:flutter_sqflite_revison/utils/colors.dart';

class AddUpdateStatusPage extends StatefulWidget {
  static const String id = "add_status_page";
  int? statusID;

  AddUpdateStatusPage({this.statusID});

  @override
  State<AddUpdateStatusPage> createState() => _AddUpdateStatusPageState();
}

class _AddUpdateStatusPageState extends State<AddUpdateStatusPage> {
  final showStatusController = TextEditingController();
  Color currentColor = SColors.colors[0];
  dynamic newColor;
  Status status = Status();
  dynamic statusById;
  StatusService statusService = StatusService();

  @override
  void initState() {
    getStatusById(widget.statusID);
    super.initState();
  }

  Future<void> getStatusById(int? statusID) async {
    if (statusID != 0 && statusID != null) {
      statusById = await statusService.readStatusById(statusID);
      showStatusController.text = statusById[0]["name"].toString();
      newColor = Color(int.tryParse(statusById[0]["color"].toString()) ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.statusID != 0 && widget.statusID != null) {
                  updateStatus();
                } else {
                  addNewStatus();
                }
              },
              icon: const Icon(Icons.check))
        ],
        title: const Text("Create Status"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: showStatusController,
              decoration: const InputDecoration(
                hintText: "Status name",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Choose Status color",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            BlockPicker(
              availableColors: SColors.colors,
              pickerColor: currentColor,
              onColorChanged: changeColor,
              layoutBuilder: pickerLayoutBuilder,
              itemBuilder: pickerItemBuilder,
            ),
          ],
        ),
      ),
    );
  }

  Widget pickerLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 7,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: [for (Color color in colors) child(color)],
      ),
    );
  }

  Widget pickerItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(50),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: 24,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    currentColor = color;
    setState(() {});
  }

  void addNewStatus() async {
    status.name = showStatusController.text;
    status.color = currentColor.value;
    await statusService
        .saveStatus(status)
        .then((value) => Navigator.of(context).pop());
  }

  void updateStatus() async {
    status.id = statusById[0]["id"];
    status.name = showStatusController.text;
    status.color = currentColor.value;
    await statusService
        .upDateStatus(status)
        .then((value) => Navigator.of(context).pop());
  }
}
