import 'package:gwslib/preferences/pref.dart';

class IntroPref {
  //------------------------------------------------------------------------------------------------
  static final String _MODULE = "darmon:pref";
  static final String _FINGERPRINT = "fingerprint";
  static final String _PRESENTATION = "fingerprint";

  //------------------------------------------------------------------------------------------------
  static Future<bool> isEnableFingerprint(String serverId) =>
      Pref.load(_MODULE, "$_FINGERPRINT:$serverId").then((it) => "Y" == it);

  static Future<void> setEnableFingerprint(String serverId, bool enable) async {
    await Pref.save(_MODULE, "$_FINGERPRINT:$serverId", enable ? "Y" : "N");
  }

  //------------------------------------------------------------------------------------------------
  static Future<bool> isPresentationShowed() =>
      Pref.load(_MODULE, _PRESENTATION).then((it) => "Y" == it);

  static Future<void> setPresentationShowed(bool isShow) async {
    await Pref.save(_MODULE, _PRESENTATION, isShow ? "Y" : "N");
  }
}
