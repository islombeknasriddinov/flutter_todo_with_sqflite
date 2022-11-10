import 'package:gwslib/preferences/pref.dart';

class DarmonPref {
  //------------------------------------------------------------------------------------------------

  static final String MODULE = "darmon";

  //------------------------------------------------------------------------------------------------

  static final String LAST_VISIT_TIMESTAMP = "LAST_VISIT_TIMESTAMP";

  static Future<String> getLastVisitTimestamp() => Pref.load(MODULE, LAST_VISIT_TIMESTAMP);

  static Future<void> saveLastVisitTimestamp(String timestamp) =>
      Pref.save(MODULE, LAST_VISIT_TIMESTAMP, timestamp);

//----------------------------------------------------------------------------

}
