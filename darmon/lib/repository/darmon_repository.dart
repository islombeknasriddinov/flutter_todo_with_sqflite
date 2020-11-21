import 'package:darmon/common/darmon_pref.dart';
import 'package:darmon/kernel/database.dart';
import 'package:darmon/kernel/uis/ui_damon_dao.dart';
import 'package:darmon/network/network_manager.dart';
import 'package:gwslib/common/date_util.dart';
import 'package:gwslib/gwslib.dart';

class DarmonRepository {
  UIDarmonDao dao;

  DarmonRepository(this.dao);

  Future<bool> checkSync() async {
    DateTime now = DateTime.now();
    String timeStamp = await DarmonPref.getLastVisitTimestamp();
    if (timeStamp?.isNotEmpty == true) {
      int syncTime = DateUtil.parse(timeStamp).millisecondsSinceEpoch;
      if (syncTime >=
          DateTime(now.year, now.month, now.day, now.hour - 12).millisecondsSinceEpoch) {
        return Future.value(false);
      }
    }
    Map<String, dynamic> result = await NetworkManager.sync();
    print(result.toString());
    await DarmonDatabase.sync(result);
    DarmonPref.saveLastVisitTimestamp(result['laststamp']);
    return true;
  }

  Future<List<UIMedicine>> searchMedicine(String query) async {
    return dao.searchMedicine(query.trim()).then((value) => value
        .map((e) =>
            UIMedicine(e.medicineId, e.nameRu, e.nameUz, e.nameEn, e.producerId, e.producerName))
        .toList());
  }
}

class UIMedicine {
  final int medicineId;
  final String nameRu;
  final String nameUz;
  final String nameEn;
  final int producerId;
  final String producerName;

  UIMedicine(
      this.medicineId, this.nameRu, this.nameUz, this.nameEn, this.producerId, this.producerName);
}
