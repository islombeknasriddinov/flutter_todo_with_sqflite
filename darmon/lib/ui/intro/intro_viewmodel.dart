import 'package:darmon/ui/intro/intro_pref.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/localization/pref.dart';

class IntroViewModel extends ViewModel {
  Future<bool> isSelectedSystemLanguage() async {
    final langCode = await LocalizationPref.getLanguage();
    return langCode != null && langCode.isNotEmpty;
  }

  Future<bool> isShowedPresentation() => IntroPref.isPresentationShowed();
}
