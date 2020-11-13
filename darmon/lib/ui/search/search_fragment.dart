import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/ui/search/search_modules.dart';
import 'package:darmon/ui/search/search_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gwslib/gwslib.dart';

class SearchFragment extends ViewModelFragment<SearchViewModel> {
  static final String ROUTE_NAME = "/search_fragment";

  static void open(BuildContext context) {
    Mold.openContent(context, ROUTE_NAME);
  }

  TextEditingController _searchQuery;

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);
    _searchQuery = new TextEditingController();
  }

  @override
  SearchViewModel onCreateViewModel(BuildContext buildContext) => SearchViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: BackButton(
            color: Colors.black87,
          ),
          elevation: 1,
          title: _buildSearchField(),
          actions: _buildActions(),
          backgroundColor: Colors.white,
        ),
        body: MyTable.vertical([
          _searchIFieldsListWidget(),
          Divider(height: 1, color: Colors.grey),
        ]));
  }

  List<Widget> _buildActions() {
    return <Widget>[
      StreamBuilder<bool>(
          stream: viewmodel.isClearActive,
          builder: (_, snapshot) {
            if (snapshot?.data == true) {
              return MyIcon.icon(
                Icons.clear,
                color: Colors.black87,
                onTap: () {
                  if (_searchQuery == null || _searchQuery.text.isEmpty) {
                    Mold.onBackPressed(this);
                    return;
                  }
                  _clearSearchQuery();
                },
              );
            } else {
              return MyIcon.icon(
                Icons.qr_code,
                color: Colors.black87,
                onTap: () async {
                  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", null, true, ScanMode.DEFAULT);
                  print(barcodeScanRes);
                  if (barcodeScanRes?.isNotEmpty == true && barcodeScanRes != "-1") {
                    _searchQuery.text = barcodeScanRes;
                    viewmodel.setSearchText(barcodeScanRes);
                  }
                },
              );
            }
          })
    ];
  }

  void _clearSearchQuery() {
    print("close search box");
    _searchQuery.clear();
    viewmodel.setSearchText("");
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: InputDecoration(
        hintText: R.strings.search_fragment.search.translate(),
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.black54),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    viewmodel.setSearchText(newQuery);
  }

  Widget _searchIFieldsListWidget() {
    return MyTable.horizontal(
      [
        MyText(R.strings.search_fragment.search_by, style: TS_Body_1()),
        MyTable.horizontal(_buildSearchFields(viewmodel.searchFilterFields))
      ],
      background: Colors.white,
      crossAxisAlignment: CrossAxisAlignment.center,
      padding: EdgeInsets.only(left: 16, right: 16),
      width: double.infinity,
    );
  }

  List<Widget> _buildSearchFields(List<SearchField> fields) {
    if (fields == null || fields.isEmpty) return [Container()];
    return fields.map((field) => _buildFilterChipItem(field)).toList();
  }

  Widget _buildFilterChipItem(SearchField field) {
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
              backgroundColor: R.colors.server_hint,
            ),
          );
        });
  }
}
