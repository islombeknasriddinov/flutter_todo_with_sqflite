import 'package:darmon/gwslib/mold_content_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/common/lazy_stream.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/mold/fragment.dart';

abstract class MoldIndexFragment<VM extends ViewModel> extends ViewModelFragment<VM> {
  final LazyStream<RootFragment> _contentControler = LazyStream();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  ///close the drawer
  void closeDrawer() {
    Navigator.pop(_scaffoldKey.currentContext);
  }

  void openContent(RootFragment content) {
    content.drawerScaffoldKey = _scaffoldKey;
    _contentControler.value?.onDestroy();
    _contentControler.add(content);
  }

  Widget onCreateView(BuildContext context);

  @override
  Widget onCreateWidget(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: StreamBuilder(
            stream: _contentControler.stream,
            builder: (_, snapshot) {
              if (snapshot.data == null) {
                return Container();
              }

              MoldContentFragment fragment = snapshot.data;
              fragment.context = context;
              if (fragment.viewmodel == null) {
                fragment.onCreate(context);
              }
              return Container(child: fragment.onCreateWidget(context));
            },
          ),
        ),
        drawer: new Drawer(child: onCreateView(context)),
      ),
    );
  }

  @override
  void onDestroy() {
    super.onDestroy();
    _contentControler.value?.onDestroy();
    _contentControler.close();
  }
}
