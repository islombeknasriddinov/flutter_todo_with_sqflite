import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

typedef BuildWidget = Widget Function(BuildContext context);

abstract class MoldApplication {
  MoldApplicationWidget _applicationWidget;

  void _onInit(MoldApplicationWidget applicationWidget) {
    this._applicationWidget = applicationWidget;
  }

  bool isInit() => _applicationWidget != null;

  void onCreate() {
    assert(this._applicationWidget != null);
  }

  void onDestroy() {}

  Map<String, WidgetBuilder> getRoutes();
}

class MoldApplicationWidget extends StatelessWidget {
  static MoldApplicationWidget _applicationWidget;

  static MoldApplicationWidget getInstance() {
    return _applicationWidget;
  }

  final MoldApplication application;
  final BuildWidget buildChildWidget;
  Widget _childWidget;

  MoldApplicationWidget(this.buildChildWidget, this.application) {
    _applicationWidget = this;
  }

  @override
  Widget build(BuildContext context) {
    if (!application.isInit()) {
      application._onInit(this);
      application.onCreate();
    }

    if (!AppLang.instance.isInit) {
      AppLang.instance.init();
    }

    if (_childWidget == null) {
      _childWidget = buildChildWidget.call(context);
    }
    return _AppState(this);
  }
}

class _AppState extends MoldStatefulWidget {
  MoldApplicationWidget appWidget;

  _AppState(this.appWidget);

  @override
  void onChangeAppLifecycleState(AppLifecycleState state) {
    super.onChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      appWidget.application.onDestroy();
    }
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return appWidget._childWidget;
  }
}
