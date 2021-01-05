import 'package:darmon/common/resources.dart';
import 'package:darmon/ui/intro/intro_viewmodel.dart';
import 'package:darmon/ui/lang/lang_fragment.dart';
import 'package:darmon/ui/main/main_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroFragment extends ViewModelFragment<IntroViewModel> {
  static final String ROUTE_NAME = "/";

  static void open(BuildContext context) {
    isSubjectRunning = false;
    Mold.replaceContent(context, ROUTE_NAME);
  }

  static bool isSubjectRunning = false;

  final LocalAuthentication auth = LocalAuthentication();

  PublishSubject<bool> subject;

  @override
  IntroViewModel onCreateViewModel(BuildContext buildContext) => IntroViewModel();

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);

    if (subject == null) {
      if (!isSubjectRunning) {
        isSubjectRunning = true;
        subject = PublishSubject<bool>();
        subject.debounceTime(Duration(seconds: 4,milliseconds:5 )).listen((_) => startWork());
        subject?.add(true);
      }
    }
  }

  void startWork() async {
    if (subject == null || subject.isClosed) {
      return;
    }

    if (!(await viewmodel.isSelectedSystemLanguage()) ||
        !(await viewmodel.isShowedPresentation())) {
      LangContentFragment.replace(getContext());
    } else {
      MainFragment.replace(getContext());
    }
  }

  @override
  void onDestroy() {
    isSubjectRunning = false;
    subject?.close();
    subject = null;
    super.onDestroy();
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.appBarColor,
      body: Stack(
        children: <Widget>[
          Align(
            child: Container(child: Lottie.asset(R.asserts.animation_intro)),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
