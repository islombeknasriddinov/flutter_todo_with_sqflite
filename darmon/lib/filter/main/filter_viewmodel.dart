import 'package:darmon/filter/main/filter_collector.dart';
import 'package:darmon/filter/main/filter_dao.dart';
import 'package:gwslib/gwslib.dart';

abstract class FilterViewModel<A, D extends FilterDao> extends ViewModel<A> {
  FilterProtocol filterProtocol;
  D dao;

  D createDao() => null;

  @override
  void onCreate() {
    super.onCreate();
    if (dao == null) {
      dao = createDao();
    }
    if (filterProtocol == null) filterProtocol = FilterProtocol(dao, reload);
    reload();
  }

  void reload() {}
}
