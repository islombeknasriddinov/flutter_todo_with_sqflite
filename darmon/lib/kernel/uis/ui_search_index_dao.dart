import 'package:darmon/filter/main/filter.dart';
import 'package:darmon/filter/main/filter_dao.dart';
import 'package:sqflite_common/sqlite_api.dart';

class UISearchIndexDao extends FilterDao {
  UISearchIndexDao(Database db) : super(db, "medicine_search");

  @override
  List<Filter> filters() {
    return [IntegerFilter("s", "id")];
  }
}
