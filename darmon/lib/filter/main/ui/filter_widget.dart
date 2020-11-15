import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/custom/date_picker_widet.dart';
import 'package:darmon/filter/main/filter.dart';
import 'package:darmon/filter/main/filter_collector.dart';
import 'package:darmon/filter/main/ui/filter_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwslib/gwslib.dart';

class FilterWidget extends StatefulWidget {
  final FilterProtocol _filterProtocol;
  final BuildContext _context;

  FilterWidget(this._context, this._filterProtocol);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  FilterViewModel viewmodel;

  BuildContext getContext() => widget._context;

  @override
  void initState() {
    super.initState();
    viewmodel = FilterViewModel(widget._filterProtocol);
    viewmodel.onCreate();
  }

  @override
  Widget build(BuildContext context) {
    return buildFilterWidget();
  }

  Widget buildFilterWidget() {
    return MyTable.vertical([
      _buildFilterBodyWidget(),
      _buildFilterErrorWidget(),
      _buildFilterFooterWidgets(),
    ]);
  }

  Widget _buildFilterBodyWidget() {
    return StreamBuilder<List<Filter>>(
        stream: viewmodel.filters.stream,
        builder: (_, snapshot) {
          if (snapshot?.data?.isNotEmpty == true) {
            return MyTable.vertical(snapshot.data.map(_buildFilterItemWidget).toList());
          } else {
            return Container();
          }
        });
  }

  Widget _buildFilterItemWidget(Filter filter) {
    switch (filter.runtimeType) {
      case TextFilter:
        return _buildStringFilterItemWidget(filter);
      case IntegerFilter:
        return _buildIntegerFilterItemWidget(filter);
      case BooleanFilter:
        return _buildBooleanFilterItemWidget(filter);
      case MultiSelectFilter:
        return _buildMultiSelectFilterItemWidget(filter);
      case IntRangeFilter:
        return _builIntRangeItemWidget(filter);
      case CustomMultiSelectFilter:
        return _buildCustomMultiSelectFilterItemWidget(filter);
      case DateRangeFilter:
        return _builDateRangeItemWidget(filter);
      case Filter:
        return _buildFilterItemWidgetWithValueType(filter);
    }
    return Container();
  }

  Widget _buildFilterItemWidgetWithValueType(Filter filter) {
    switch (filter.value.runtimeType) {
      case String:
        return _buildStringFilterItemWidget(filter);
      case int:
        return _buildIntegerFilterItemWidget(filter);
      case bool:
        return _buildBooleanFilterItemWidget(filter);
      case dynamic:
        return Container();
    }

    return Container();
  }

  Widget _buildIntegerFilterItemWidget(Filter filter) {
    return MyTable.vertical([
      if (filter.title?.isNotEmpty == true) MyText(filter.title, style: TS_Body_2()),
      TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        controller: TextEditingController(text: filter?.value?.toString() ?? ""),
        onChanged: (value) {
          filter.value = value?.isNotEmpty == true ? int.tryParse(value) : null;
        },
        decoration: InputDecoration(
          hintText: R.strings.filter.integer_text_field_hint.translate(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      )
    ]);
  }

  Widget _buildStringFilterItemWidget(Filter filter) {
    return MyTable.vertical([
      if (filter.title?.isNotEmpty == true) MyText(filter.title, style: TS_Body_2()),
      TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        controller: TextEditingController(text: filter.value),
        onChanged: (value) {
          filter.value = value;
        },
        decoration: InputDecoration(
          hintText: R.strings.filter.string_text_field_hint.translate(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      )
    ]);
  }

  Widget _buildBooleanFilterItemWidget(Filter filter) {
    return CheckboxListTile(
        value: (filter?.value != null && filter?.value is bool) ? filter?.value as bool : false,
        title: MyText(filter.title ?? "checkbox"),
        onChanged: (newValue) {
          filter.value = newValue;
        });
  }

  Widget _buildCustomMultiSelectFilterItemWidget(CustomMultiSelectFilter filter) {
    final fields = filter.filterFildes();
    return FutureBuilder<List<FilterField>>(
        future: fields,
        builder: (_, snapshot) {
          if (snapshot?.data != null) {
            return MyTable.vertical([
              if (filter.title?.isNotEmpty == true) MyText(filter.title, style: TS_Body_2()),
              MyTable.horizontal(_buildFilterChipList(snapshot.data))
            ]);
          } else {
            return Container();
          }
        });
  }

  Widget _buildMultiSelectFilterItemWidget(MultiSelectFilter filter) {
    final fields = filter.filterFildes();
    return FutureBuilder<List<FilterField>>(
        future: fields,
        builder: (_, snapshot) {
          if (snapshot?.data != null) {
            return MyTable.vertical([
              if (filter.title?.isNotEmpty == true) MyText(filter.title, style: TS_Body_2()),
              MyTable.horizontal(_buildFilterChipList(snapshot.data))
            ]);
          } else {
            return Container();
          }
        });
  }

  List<Widget> _buildFilterChipList(List<FilterField> fields) {
    if (fields == null || fields.isEmpty) return [Container()];
    return fields.map((field) => _buildFilterChipItem(field)).toList();
  }

  Widget _buildFilterChipItem(FilterField field) {
    return StreamBuilder<bool>(
        stream: field.onSelected,
        builder: (_, snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: 2, bottom: 2, left: 4, right: 4),
            child: FilterChip(
              label: MyText(field.title),
              onSelected: (bool value) {
                field.setOnSelected(value);
              },
              checkmarkColor: Colors.white,
              selected: snapshot?.data == true,
              selectedColor: R.colors.app_color,
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              backgroundColor: R.colors.status_success,
            ),
          );
        });
  }

  Widget _builIntRangeItemWidget(IntRangeFilter filter) {
    return MyTable.vertical([
      if (filter.title?.isNotEmpty == true) MyText(filter.title, style: TS_Body_2()),
      MyTable.horizontal([
        TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          controller: TextEditingController(text: filter?.value?.toString() ?? ""),
          onChanged: (value) {
            filter.first = value != null ? int.tryParse(value) : null;
          },
          decoration: InputDecoration(
            hintText: R.strings.filter.integer_range_from_hint.translate(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          controller: TextEditingController(text: filter?.value?.toString() ?? ""),
          onChanged: (value) {
            filter.second = value != null ? int.tryParse(value) : null;
          },
          decoration: InputDecoration(
            hintText: R.strings.filter.integer_range_to_hint.translate(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        )
      ])
    ]);
  }

  Widget _builDateRangeItemWidget(DateRangeFilter filter) {
    return MyTable.vertical([
      if (filter.title?.isNotEmpty == true) MyText(filter.title, style: TS_Body_2()),
      MyTable.horizontal([
        Expanded(
          flex: 1,
          child: DatePickerWidget(filter.dateFrom.stream, textStyle: TS_Body_1(R.colors.app_color),
              dateSelectedAction: (value) {
            if (value != null) {
              final newDate = DateUtil.format(value, DateUtil.FORMAT_AS_DATE);
              filter.dateFrom.add(newDate);
            }
          }),
        ),
        Expanded(
            flex: 1,
            child: DatePickerWidget(
              filter.dateTo.stream,
              textStyle: TS_Body_1(R.colors.app_color),
              dateSelectedAction: (value) {
                if (value != null) {
                  final newDate = DateUtil.format(value, DateUtil.FORMAT_AS_DATE);
                  filter.dateTo.add(newDate);
                }
              },
            )),
      ])
    ]);
  }

  Widget _buildFilterFooterWidgets() {
    return Container(
      padding: EdgeInsets.only(top: 12),
      alignment: Alignment.centerRight,
      child: MyTable.horizontal([
        MyTable(
          [MyText(R.strings.filter.clear_btn, style: TS_Button(Colors.white))],
          background: R.colors.status_error,
          padding: EdgeInsets.only(top: 11, bottom: 11, left: 16, right: 16),
          elevation: 0,
          borderColor: R.colors.status_error,
          borderRadius: BorderRadius.circular(4),
          onTapCallback: () {
            Navigator.of(getContext()).pop();
            viewmodel.clearAllFilter();
          },
        ),
        SizedBox(
          width: 8,
        ),
        MyTable(
          [MyText(R.strings.filter.apply_btn, style: TS_Button(Colors.white))],
          background: R.colors.status_success,
          padding: EdgeInsets.only(top: 11, bottom: 11, left: 16, right: 16),
          elevation: 0,
          borderColor: R.colors.status_success,
          borderRadius: BorderRadius.circular(4),
          onTapCallback: () {
            viewmodel.applyFilter().then((value) => Navigator.of(getContext()).pop());
          },
        ),
      ]),
      width: double.infinity,
    );
  }

  @override
  void dispose() {
    viewmodel.onDestroy();
    super.dispose();
  }

  Widget _buildFilterErrorWidget() {
    return StreamBuilder<ErrorMessage>(
        stream: viewmodel.errorMessageStream,
        builder: (_, snapshot) {
          if (snapshot?.data?.message?.isNotEmpty == true)
            return MyText(snapshot.data.message, style: TS_ErrorText());
          else
            return Container();
        });
  }
}
