import 'package:darmon/filter/kernel/my_filter_api.dart';
import 'package:darmon/filter/kernel/my_filter_util.dart';
import 'package:darmon/filter/kernel/tables/filter_fields.dart';
import 'package:darmon/filter/kernel/tables/filters.dart';
import 'package:darmon/filter/main/filter.dart';
import 'package:gwslib/gwslib.dart';
import 'package:sqflite/sqflite.dart';

///you can implement this class service or dao files
abstract class FilterController {
  ///db for save filter and read
  Database db;

  ///filter name must be unique. user found filters with this name
  String filterName;

  ///MyFilterHelper use read and write filters
  FilterController(this.db, this.filterName);

  ///this function abstract function. return used filters list
  List<Filter> filters() {}

  ///delete all filters with [filterName]
  Future<void> clear() => MyFilterUtil.clear(db, filterName);

  /// save filter to Filter database [filterCode]  filter unique code inside [filterName].
  /// [type] filter type.
  /// [query] nullable object. query contains custom queries
  ///
  /// @return Future<bool> if saved successfully return true else return false
  Future<bool> saveFilter(String filterCode, String type, String value, {String query}) async {
    await MyFilterApi.saveFilter(db, filterName, filterCode, type, value, query: query);

    return true;
  }

  Future<bool> saveFilterField(String filterCode, List<FilterField> filterFields) async {
    for (var filterField in filterFields) {
      await MyFilterApi.saveFilterField(
        db,
        filterName,
        filterCode,
        filterField.id,
        filterFieldValue: filterField.value,
      );
    }
    return true;
  }

  Future<List<Filter>> getFilters() async {
    List<Filter> result = filters();
    List<MyFilters> savedFilters = await MyFilterUtil.loadFilers(db, filterName);
    if (savedFilters?.isNotEmpty == true) {
      for (var savedFilter in savedFilters) {
        Filter filter = result.firstWhere((element) => element.key == savedFilter.filterCode,
            orElse: () => null);
        if (filter == null)
          throw Exception(
              "saved filter not found. Filter name=$filterName,  key = ${savedFilter.filterCode}");

        if (filter is BooleanFilter) {
          filter.setBooleanValue(savedFilter.filterValue == "Y");
        } else if (filter is TextFilter) {
          filter.value = savedFilter.filterValue;
        } else if (filter is IntegerFilter) {
          filter.value = savedFilter.filterValue?.isNotEmpty == true
              ? int.tryParse(savedFilter.filterValue)
              : null;
        } else if (filter is CustomQueryFilter) {
          filter.value = savedFilter.filterValue;
        } else if (filter is MultiSelectFilter) {
          List<MyFilterFields> selectedFields =
              await MyFilterUtil.loadFilerFields(db, filterName, savedFilter.filterCode);
          filter.selectedFields = selectedFields;
        } else if (filter is CustomMultiSelectFilter) {
          List<MyFilterFields> selectedFields =
              await MyFilterUtil.loadFilerFields(db, filterName, savedFilter.filterCode);
          filter.selectedFields = selectedFields;
        } else if (filter is IntRangeFilter) {
          List<MyFilterFields> selectedFields =
              await MyFilterUtil.loadFilerFields(db, filterName, savedFilter.filterCode);
          if (selectedFields.length == 2) {
            filter.first = selectedFields.first.filterFieldValue?.isNotEmpty == true
                ? int.tryParse(selectedFields.first.filterFieldValue)
                : null;
            filter.second = selectedFields[1].filterFieldValue?.isNotEmpty == true
                ? int.tryParse(selectedFields[1].filterFieldValue)
                : null;
          }
        } else if (filter is DateRangeFilter) {
          List<MyFilterFields> selectedFields =
              await MyFilterUtil.loadFilerFields(db, filterName, savedFilter.filterCode);
          if (selectedFields.length == 2) {
            filter.dateFrom.add(selectedFields.first.filterFieldValue);
            filter.dateTo.add(selectedFields[1].filterFieldValue);
          }
        }
      }
    }
    return result;
  }

  Future<bool> saveFilters(List<Filter> filters) async {
    try {
      await clear();
      for (Filter filter in filters) {
        if (filter.hasValue) {
          if (filter is BooleanFilter) {
            await saveFilter(filter.key, filter.type, filter.getBooleanValue ? "Y" : "N");
          } else if (filter is TextFilter) {
            await saveFilter(filter.key, filter.type, filter.value);
          } else if (filter is IntegerFilter) {
            await saveFilter(filter.key, filter.type, filter.value.toString());
          } else if (filter is CustomQueryFilter) {
            await saveFilter(filter.key, filter.type, filter.value, query: filter.getQuery());
          } else if (filter is MultiSelectFilter) {
            await saveFilter(filter.key, filter.type, "");
            await saveFilterField(
                filter.key,
                await filter
                    .filterFildes()
                    .then((value) => value.where((element) => element.getOnSelected).toList()));
          } else if (filter is CustomMultiSelectFilter) {
            await saveFilter(filter.key, filter.type, "", query: filter.getQuery());
            await saveFilterField(
                filter.key,
                await filter
                    .filterFildes()
                    .then((value) => value.where((element) => element.getOnSelected).toList()));
          } else if (filter is IntRangeFilter) {
            await saveFilter(filter.key, filter.type, "");
            await saveFilterField(filter.key, [
              FilterField("from", "core:filter:filter_widget:integer_range_from_title".translate(),
                  value: filter?.first?.toString()),
              FilterField("to", "core:filter:filter_widget:integer_range_to_title".translate(),
                  value: filter?.second?.toString())
            ]);
          } else if (filter is DateRangeFilter) {
            await saveFilter(filter.key, filter.type, "");
            await saveFilterField(filter.key, [
              FilterField("from", "core:filter:filter_widget:date_range_from_title",
                  value:
                      filter?.dateFrom?.value?.isNotEmpty == true ? filter?.dateFrom?.value : null),
              FilterField("to", "core:filter:filter_widget:date_range_to_title",
                  value: filter?.dateTo?.value?.isNotEmpty == true ? filter?.dateTo?.value : null)
            ]);
          } else {
            await saveFilter(filter.key, filter.type, filter.value.toString());
          }
        }
      }
      return Future.value(true);
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      return Future.error(ErrorMessage.parseWithStacktrace(error, st));
    }
  }
}
