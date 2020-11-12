import 'package:darmon/ui/intro/intro_pref.dart';
import 'package:gwslib/gwslib.dart';

class PresentationViewModel extends ViewModel {
  LazyStream<int> pagerCurrentPosition = LazyStream(() => 0);

  Future<void> presentationShowed() => IntroPref.setPresentationShowed(true);
}
