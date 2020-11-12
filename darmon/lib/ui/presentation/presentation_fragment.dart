import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/ui/lang/lang_fragment.dart';
import 'package:darmon/ui/presentation/presentation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/widgets/table.dart';

class PresentationFragment extends ViewModelFragment<PresentationViewModel> {
  static final String ROUTE_NAME = "/p/presentation";

  static void open(BuildContext context, {bool openSelectLang = false}) {
    Mold.openContent(context, ROUTE_NAME, arguments: openSelectLang);
  }

  static void replace(BuildContext context, {bool openSelectLang = false}) {
    Mold.replaceContent(context, ROUTE_NAME, arguments: openSelectLang);
  }

  PageController controller = PageController();

  bool get openSelectLang => argument ?? false;

  @override
  PresentationViewModel onCreateViewModel(BuildContext buildContext) => PresentationViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          MyTable.vertical(
            [
              // Inside build method
              Expanded(
                child: PageView(
                  onPageChanged: (newPage) {
                    viewmodel.pagerCurrentPosition.add(newPage);
                  },
                  controller: controller,
                  children: <Widget>[
                    _firstPage(),
                    _secondPage(),
                    _thirdPage(),
                  ],
                ),
              ),
              MyTable.vertical(
                [
                  StreamBuilder<int>(
                      stream: viewmodel.pagerCurrentPosition.stream,
                      builder: (_, snapshot) {
                        return Padding(
                          child: ContainerElevation(
                            MyText(
                              snapshot?.data == 2 ? R.strings.intro.done : R.strings.intro.next,
                              style: TS_Button(Color(0xDEFFFFFF)),
                              upperCase: true,
                            ),
                            backgroundColor: snapshot?.data == 2 ? Colors.green : Colors.grey,
                            padding: EdgeInsets.only(top: 11, bottom: 11, left: 16, right: 16),
                            elevation: 0,
                            borderRadius: BorderRadius.circular(4),
                            onClick: () {
                              if (snapshot?.data == 2) {
                                donePresentation();
                              } else {
                                controller.animateToPage(
                                  ((snapshot?.data ?? 0) + 1),
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              }
                            },
                          ),
                          padding: EdgeInsets.only(left: 6, right: 16, top: 16, bottom: 16),
                        );
                      })
                ],
                width: double.infinity,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
              )
            ],
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 36,
              height: 36,
              margin: EdgeInsets.all(16),
              decoration: new BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: MyIcon.icon(
                Icons.close,
                size: 24,
                color: Colors.white,
                onTap: () {
                  donePresentation();
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _firstPage() {
    return Container(
      color: Colors.red,
      child: Center(
          child: MyText(
        "first page",
        style: TS_HeadLine6(Colors.white),
      )),
    );
  }

  Widget _secondPage() {
    return Container(
      color: Colors.blue,
      child: Center(
          child: MyText(
        "second page",
        style: TS_HeadLine6(Colors.white),
      )),
    );
  }

  Widget _thirdPage() {
    return Container(
      color: Colors.amberAccent,
      child: Center(
          child: MyText(
        "third page",
        style: TS_HeadLine6(Colors.white),
      )),
    );
  }

  void donePresentation() {
    viewmodel.presentationShowed().then((value) {
      if (openSelectLang) {
        LangContentFragment.replace(getContext());
      } else {
        Mold.onContextBackPressed(getContext());
      }
    });
  }
}
