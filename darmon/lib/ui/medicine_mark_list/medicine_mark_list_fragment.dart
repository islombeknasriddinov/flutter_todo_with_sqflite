import 'package:darmon/common/resources.dart';
import 'package:darmon/common/routes/size_route.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/main.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/medicine_list/medicine_list_fragment.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:darmon/ui/medicine_mark_list/medicine_mark_list_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gwslib/gwslib.dart';

class ArgMedicineMarkList {
  final String query;

  ArgMedicineMarkList(this.query);
}

class MedicineMarkListFragment extends ViewModelFragment<MedicineMarkListViewModel> {
  static final String ROUTE_NAME = "/medicine_list_fragment";

  static void open(BuildContext context, ArgMedicineMarkList arg) {
    Navigator.push<dynamic>(
        context, SizeRoute(page: Mold.newInstance(MedicineMarkListFragment()..argument = arg)));
    // Mold.openContent(context, ROUTE_NAME, arguments: medicineName);
  }

  ArgMedicineMarkList get arg => argument as ArgMedicineMarkList;

  TextEditingController _searchQuery;

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);
    _searchQuery = new TextEditingController(text: arg.query?.isNotEmpty == true ? arg.query : "");
  }

  @override
  MedicineMarkListViewModel onCreateViewModel(BuildContext buildContext) =>
      MedicineMarkListViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: BackButton(
            color: R.colors.iconColors,
          ),
          elevation: 1,
          title: _buildSearchField(),
          actions: _buildActions(),
          backgroundColor: R.colors.background,
        ),
        body: MyTable.vertical([
          _searchIFieldsListWidget(),
          Divider(height: 1, color: R.colors.dividerColor),
          Expanded(child: _buildListWidget())
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
                color: R.colors.iconColors,
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
                color: R.colors.iconColors,
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
      autofocus: false,
      decoration: InputDecoration(
        hintText: R.strings.medicine_list_fragment.search.translate(),
        border: InputBorder.none,
        hintStyle: TextStyle(color: R.colors.textColor),
      ),
      style: TextStyle(color: R.colors.textColor, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    viewmodel.setSearchText(newQuery);
  }

  Widget _searchIFieldsListWidget() {
    return MyTable.horizontal(
      [
        MyText(R.strings.medicine_list_fragment.search_by, style: TS_Body_1(R.colors.textColor)),
        MyTable.horizontal(_buildSearchFields(viewmodel.searchFilterFields))
      ],
      background: R.colors.background,
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

  Widget _buildListWidget() {
    return StreamBuilder<List<UIMedicineMark>>(
      stream: viewmodel.items,
      builder: (_, snapshot) {
        print("snapshot?.data=${snapshot?.data}");
        if (snapshot?.data?.isNotEmpty == true) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return populateListItem(snapshot.data[index]);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget populateListItem(UIMedicineMark mark) {
    return MyTable.vertical(
      [
        MyText(
          mark.title,
          style: TS_HeadLine6(R.colors.textColor),
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
      ],
      onTapCallback: () {
        openMedicineListFragment(mark);
      },
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      background: R.colors.cardColor,
      borderRadius: BorderRadius.circular(4),
      elevation: 2,
    );
  }

  void openMedicineListFragment(UIMedicineMark medicine) {
    hideKeyboard();
    _searchQuery?.clear();
    MedicineListFragment.open(getContext(), ArgMedicineList(medicine.title, medicine.type));
  }

  void hideKeyboard() {
    try {
      Mold.hideKeyboard(getContext());
    } catch (error, st) {
      Log.error("Error($error)\n$st");
    }
  }
}
