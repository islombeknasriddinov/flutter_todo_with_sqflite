import 'package:darmon/filter/kernel/my_filter_pref.dart';
import 'package:darmon/filter/kernel/tables/filter_fields.dart';
import 'package:gwslib/gwslib.dart';

class Filter<T> {
  final String key;
  final String title;
  final String type;
  T value;

  Filter(
    this.key,
    this.title,
    this.type,
  );

  bool get hasValue => value != null;
}

class FilterField {
  String id;
  String value;
  String title;
  LazyStream<bool> _onSelected = LazyStream(() => false);

  Stream<bool> get onSelected => _onSelected.stream;

  FilterField(this.id, this.title, {this.value});

  FilterField.id(this.id);

  FilterField.value(this.value);

  bool get getOnSelected => _onSelected.value;

  void setOnSelected(bool value) {
    _onSelected.add(value);
  }

  void dissmise() {
    _onSelected.close();
  }
}

class BooleanFilter extends Filter<bool> {
  LazyStream<bool> _booleanValue = LazyStream(() => false);

  Stream<bool> get booleanValue => _booleanValue.stream;

  BooleanFilter(String key, String title) : super(key, title, MyFilterPref.EQUAL_STRING);

  bool get getBooleanValue => _booleanValue.value;

  void setBooleanValue(bool value) {
    _booleanValue.add(value);
  }
}

class IntegerFilter extends Filter<int> {
  IntegerFilter(String key, String title, {String type = MyFilterPref.EQUAL_INT})
      : super(key, title, type);
}

class TextFilter extends Filter<String> {
  TextFilter(String key, String title, {String type = MyFilterPref.LIKE}) : super(key, title, type);
}

class CustomQueryFilter<T> extends Filter<T> {
  String Function(Filter) query;

  CustomQueryFilter(String title, this.query) : super("", title, MyFilterPref.CUSTOM);

  String getQuery() => query.call(this);
}

class MultiSelectFilter extends Filter<List<FilterField>> {
  Future<List<FilterField>> Function() _filterFieldsGeter;
  List<MyFilterFields> _selectedFields = [];

  MultiSelectFilter(String key, String title, this._filterFieldsGeter)
      : super(key, title, MyFilterPref.IN);

  Future<List<FilterField>> filterFildes() async {
    if (value == null || value.isEmpty) {
      value = await _filterFieldsGeter.call();
      for (var selectedField in _selectedFields) {
        value
            ?.firstWhere((element) => element.id == selectedField.filterFieldId)
            ?.setOnSelected(true);
      }
    }
    return value;
  }

  set selectedFields(List<MyFilterFields> value) {
    _selectedFields = value;
  }
}

class RangeFilter<T> extends Filter<List<T>> {
  RangeFilter(String key, String title, String type) : super(key, title, type);
}

class IntRangeFilter extends RangeFilter<int> {
  int first;
  int second;

  IntRangeFilter(
    String key,
    String title,
  ) : super(key, title, MyFilterPref.INT_RANGE) {
    first = null;
    second = null;
  }

  @override
  bool get hasValue => first != null || second != null;
}

class DateRangeFilter extends RangeFilter<String> {
  LazyStream<String> dateFrom = new LazyStream(() => null);
  LazyStream<String> dateTo = new LazyStream(() => null);

  DateRangeFilter(
    String key,
    String title,
  ) : super(key, title, MyFilterPref.DATE_RANGE);

  void onDestroy() {
    dateFrom.close();
    dateTo.close();
  }

  @override
  bool get hasValue => dateFrom?.value?.isNotEmpty == true || dateTo?.value?.isNotEmpty == true;
}

class DateTimeRangeFilter extends RangeFilter<String> {
  LazyStream<String> dateFrom = new LazyStream(() => null);
  LazyStream<String> dateTo = new LazyStream(() => null);

  DateTimeRangeFilter(
    String key,
    String title,
  ) : super(key, title, MyFilterPref.DATE_TIME_RANGE);

  void onDestroy() {
    dateFrom.close();
    dateTo.close();
  }

  @override
  bool get hasValue => dateFrom?.value?.isNotEmpty == true || dateTo?.value?.isNotEmpty == true;
}

class TimeRangeFilter extends RangeFilter<String> {
  LazyStream<String> dateFrom = new LazyStream(() => null);
  LazyStream<String> dateTo = new LazyStream(() => null);

  TimeRangeFilter(
    String key,
    String title,
  ) : super(key, title, MyFilterPref.TIME_RANGE);

  void onDestroy() {
    dateFrom.close();
    dateTo.close();
  }

  @override
  bool get hasValue => dateFrom?.value?.isNotEmpty == true || dateTo?.value?.isNotEmpty == true;
}

class CustomMultiSelectFilter extends Filter<List<FilterField>> {
  Future<List<FilterField>> Function() _filterFieldsGeter;
  List<MyFilterFields> _selectedFields = [];
  String Function(Filter) query;

  CustomMultiSelectFilter(String title, this._filterFieldsGeter, this.query)
      : super("", title, MyFilterPref.CUSTOM_IN);

  Future<List<FilterField>> filterFildes() async {
    if (value == null || value.isEmpty) {
      value = await _filterFieldsGeter.call();
      for (var selectedField in _selectedFields) {
        value
            ?.firstWhere((element) => element.id == selectedField.filterFieldId)
            ?.setOnSelected(true);
      }
    }
    return value;
  }

  set selectedFields(List<MyFilterFields> value) {
    _selectedFields = value;
  }

  String getQuery() => query.call(this);

  @override
  bool get hasValue => (value?.where((element) => element.getOnSelected)?.length ?? -1) > 0;
}
