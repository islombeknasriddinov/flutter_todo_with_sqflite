
import 'package:darmon/filter/main/filter_dao.dart';

class FilterProtocol {
  final FilterDao myFilterDao;
  final Function() applyCallback;

  FilterProtocol(this.myFilterDao, this.applyCallback) {
    assert(myFilterDao != null);
    assert(applyCallback != null);
    myFilterDao.clear();
  }
}
