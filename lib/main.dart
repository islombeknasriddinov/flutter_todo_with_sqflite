import 'package:flutter/material.dart';
import 'package:flutter_sqflite_revison/pages/add_update_status_page.dart';
import 'package:flutter_sqflite_revison/pages/add_update_todo_page.dart';
import 'package:flutter_sqflite_revison/pages/all_status_page.dart';
import 'package:flutter_sqflite_revison/pages/drawer_navigation_page.dart';
import 'package:flutter_sqflite_revison/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.id : (context) => HomePage(),
        DrawerNavigation.id: (context) => DrawerNavigation(),
        AddUpdateStatusPage.id: (context) => AddUpdateStatusPage(),
        AddUpdateTodoPage.id: (context) => AddUpdateTodoPage(),
        AllStatusPage.id: (context) => AllStatusPage(),
      },
    );
  }
}
