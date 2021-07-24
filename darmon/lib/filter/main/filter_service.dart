import 'package:darmon/filter/main/filter_helper.dart';
import 'package:sqflite/sqflite.dart';

///you can  use this function for network request
abstract class FilterService extends FilterController {
  Database db;
  String filterName;

  FilterService(Database db, String filterName) : super(db, filterName);
}
