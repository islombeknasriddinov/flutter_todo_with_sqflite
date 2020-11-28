import 'package:darmon/common/phonex.dart';
import 'package:darmon/common/phonex.dart';
import 'package:darmon/common/phonex.dart';
import 'package:darmon/common/phonex.dart';
import 'package:darmon/common/phonex.dart';
import 'package:darmon/common/soundex.dart';
import 'package:darmon/kernel/medicine/medicine_pref.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_inn.dart';
import 'package:darmon/kernel/medicine/tables/medicine_mark_name.dart';
import 'package:sqflite/sqflite.dart';

class MedicineSync {
  static Future<void> sync(Database db, Map<String, dynamic> values) async {
    if (values.containsKey(MedicinePref.SYNC_MEDICINE_MARK_NAME)) {
      for (List<dynamic> row in values[MedicinePref.SYNC_MEDICINE_MARK_NAME] as List<dynamic>) {
        dynamic nameRu = row[0];
        dynamic nameRuSoundex = Phonex.calculate(nameRu);
        dynamic nameUz = row[1];
        dynamic nameUzSoundex = Phonex.calculate(nameUz);
        dynamic nameEn = row[2];
        dynamic nameEnSoundex = Phonex.calculate(nameEn);

        await Z_ZMedicineMarkName.saveOne(db,
            nameRu: nameRu,
            nameRuSoundex: nameRuSoundex,
            nameUz: nameUz,
            nameUzSoundex: nameUzSoundex,
            nameEn: nameEn,
            nameEnSoundex: nameEnSoundex);
      }
    }

    if (values.containsKey(MedicinePref.SYNC_MEDICINE_MARK_INN)) {
      for (List<dynamic> row in values[MedicinePref.SYNC_MEDICINE_MARK_INN] as List<dynamic>) {
        String innRu = row[0];
        String innRuSoundex = Phonex.calculate(innRu);
        String innEn = row[1];
        String innEnSoundex = Phonex.calculate(innEn);
        String innIds = row[2];
        await Z_ZMedicineMarkInn.saveOne(db,
            innRu: innRu,
            innRuSoundex: innRuSoundex,
            innEn: innEn,
            innEnSoundex: innEnSoundex,
            innIds: innIds);
      }
    }
  }
}
