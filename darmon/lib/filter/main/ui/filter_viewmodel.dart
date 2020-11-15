import 'package:darmon/filter/main/filter.dart';
import 'package:darmon/filter/main/filter_collector.dart';
import 'package:gwslib/common/lazy_stream.dart';
import 'package:gwslib/gwslib.dart';

class FilterViewModel {
  final FilterProtocol _filterProtocol;

  FilterViewModel(this._filterProtocol) {
    assert(_filterProtocol != null);
  }

  LazyStream<List<Filter>> filters = new LazyStream(() => []);

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

  void onCreate() {
    if (this.filters.value == null || this.filters.value.isEmpty) {
      _filterProtocol.myFilterDao.getFilters().then((value) {
        this.filters.add(value);
        //_filterProtocol.myFilterDao.clear();
      });
    }
  }

  Future<void> applyFilter() async {
    _filterProtocol.myFilterDao.saveFilters(filters.value).then((value) {
      if (value) _filterProtocol.applyCallback?.call();
    }).then((value) {
      setError(ErrorMessage.parse(value));
    });
  }

  void clearAllFilter() {
    for (var value in filters.value) {
      value.value = null;
    }
    applyFilter();
  }

  void onDestroy() {
    filters.close();
  }
}
