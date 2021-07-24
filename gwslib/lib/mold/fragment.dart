import 'package:flutter/material.dart';
import 'package:gwslib/common/error_message.dart';
import 'package:gwslib/common/lazy_stream.dart';
import 'package:gwslib/gwslib.dart';

typedef OnProgressListener = void Function(bool progress);

abstract class ViewModel<A> {
  //------------------------------------------------------------------------------------------------

  LazyStream<Map<int, List<OnProgressListener>>> _progressListener = new LazyStream(() => {});

  LazyStream<Map<int, bool>> _progress = new LazyStream(() => {});

  Stream<Map<int, bool>> get progressStream =>
      _progress
          .get()
          .stream;

  bool isProgressListens() {
    return _progress.value.keys
        .toList()
        .where((e) => !_progressListener.value.containsKey(e))
        .isEmpty;
  }

  bool isProgress([int key]) {
    if (key != null) {
      return _progress
          .get()
          .value
          .containsKey(key);
    }
    return _progress
        .get()
        .value
        .isNotEmpty;
  }

  void setProgress(int key, bool progress) {
    final hasValue = _progress
        .get()
        .value
        .containsKey(key);

    if (progress && !hasValue) {
      final data = _progress
          .get()
          .value;
      data[key] = true;
      _progress.add(data);
    } else if (!progress && hasValue) {
      final data = _progress
          .get()
          .value;
      data.remove(key);
      _progress.add(data);
    }
  }

  void setProgressListener(int key, OnProgressListener listener) {
    final onProgressListener = (bool progress) {
      try {
        listener.call(progress);
      } catch (e, st) {
        Log.error(e, st);
        setError(e, st);
      }
    };

    var data = _progressListener.value;
    if (data.containsKey(key)) {
      var listenerList = data[key];
      if (listenerList == null) {
        listenerList = [onProgressListener];
      } else {
        listenerList.add(onProgressListener);
      }
      data[key] = listenerList;
    } else {
      data = {
        key: [onProgressListener]
      };
    }
    _progressListener.add(data);
  }

  //------------------------------------------------------------------------------------------------

  LazyStream<ErrorMessage> _errorMessage = new LazyStream();

  Stream<ErrorMessage> get errorMessageStream => _errorMessage.stream;

  ErrorMessage get errorMessageValue => _errorMessage.value;

  void setError(dynamic error, [dynamic stacktrace]) {
    if (!(error is ErrorMessage)) {
      error = ErrorMessage.parseWithStacktrace(error, stacktrace);
    }
    _errorMessage.add(error);

    Log.error("Error: $error \n Stack: $stacktrace");
  }

  //------------------------------------------------------------------------------------------------

  ViewModelFragment _content;

  A get argument => _content.argument as A;

  BuildContext get context => _content.getContext();

  void onCreate() {
    _progress.add({});
    _progressListener.add({});
    _errorMessage.add(null);
  }

  void onDestroy() {
    _progress.close();
    _progressListener.close();
    _errorMessage.close();
  }
}

class Fragment extends StatelessWidget {
  final RootFragment fragment;

  Fragment(this.fragment);

  @override
  Widget build(BuildContext context) {
    return _FragmentState(fragment);
  }
}

class _FragmentState extends MoldStatefulWidget {
  final RootFragment fragment;

  _FragmentState(this.fragment);

  BuildContext get ctx => getContext();

  @override
  void onCreate() {
    super.onCreate();
    fragment.context = ctx;
    fragment.onCreate(ctx);
  }

  @override
  void onDestroy() {
    fragment.onDestroy();
    super.onDestroy();
  }

  @override
  Widget onCreateWidget(_) {
    fragment.context = ctx;
    return Material(
      child: fragment.onCreateWidget(ctx),
    );
  }
}

abstract class RootFragment {
  BuildContext _context;
  Object _argument;
  GlobalKey<ScaffoldState> _scaffoldStateKey;

  set argument(Object newValue) {
    _argument = newValue;
  }

  get argument =>
      _argument ?? ModalRoute
          .of(getContext())
          .settings
          .arguments;

  set context(BuildContext newValue) {
    _context = newValue;
  }

  BuildContext getContext() => _context;

  set drawerScaffoldKey(GlobalKey<ScaffoldState> newValue) {
    _scaffoldStateKey = newValue;
  }

  get drawerScaffoldKey => _scaffoldStateKey;

  void onCreate(BuildContext context) {}

  void onDestroy() {}

  Widget onCreateWidget(BuildContext context);
}

abstract class ViewModelFragment<VM extends ViewModel> extends RootFragment {
  Fragment toFragment() => Mold.newInstance(this);

  ViewModel _viewmodel;

  VM get viewmodel => _viewmodel;

  VM onCreateViewModel(BuildContext buildContext) => null;

  @override
  void onCreate(BuildContext context) {
    if (this._viewmodel == null) {
      Log.debug("Fragment($this) onCreateViewModel");
      this._viewmodel = onCreateViewModel(context);
    } else {
      Log.debug("Fragment($this) onCreateViewModel != null");
    }

    this._viewmodel._content = this;
    this._viewmodel.onCreate();
  }

  @override
  void onDestroy() {
    this._viewmodel?.onDestroy();
    this._viewmodel = null;
  }
}
