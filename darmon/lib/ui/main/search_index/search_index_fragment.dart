import 'dart:math';

import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/filter/main/filter.dart';
import 'package:darmon/filter/main/ui/filter_bottom_sheet_container.dart';
import 'package:darmon/main.dart';
import 'package:darmon/ui/main/search_index/search_index_viewmodel.dart';
import 'package:darmon/ui/medicine/medicine_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gwslib/gwslib.dart';

class SearchIndexFragment extends ViewModelFragment<SearchIndexViewModel> {
  @override
  SearchIndexViewModel onCreateViewModel(BuildContext buildContext) =>
      SearchIndexViewModel(DarmonApp.instance.darmonServiceLocator.searchIndexDao);

  final ScrollController scrollController = ScrollController();

  double expandedHeight = 250;
  double collapsedHeight = 0;
  bool isExpanded = true;
  TextEditingController _searchQuery;

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);

    _searchQuery = new TextEditingController();

    scrollController.addListener(() {
      if (scrollController.offset <= expandedHeight) {
        isExpanded = true;
      } else {
        isExpanded = false;
      }
    });
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: CustomScrollView(controller: scrollController, slivers: [
          _searchAppBar(),
          filterContainer(),
          StreamBuilder<List<String>>(
              stream: viewmodel.items,
              builder: (_, snapshot) {
                if (snapshot?.data?.isNotEmpty == true) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      String medicine = snapshot?.data[index];
                      return MyTable.vertical(
                          [MyText(medicine, style: TS_Body_1(R.colors.textColor))],
                          onTapCallback: () {
                        openMedicineItemFragment(medicine);
                      },
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          background: R.colors.cardColor,
                          height: 100.0,
                          elevation: 2,
                          margin: EdgeInsets.all(8));
                    }, childCount: snapshot.data.length),
                  );
                } else {
                  return SliverFillRemaining(
                    child: Center(
                        child: MyTable.vertical(
                      [
                        MyIcon.icon(Icons.list, color: R.colors.iconColors, size: 48),
                        MyText(
                          R.strings.search_index.list_is_empty,
                          style: TS_Body_1(R.colors.textColor),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                  );
                }
              })
        ]));
  }

  void editTextOnFocusChange() {
    if (isExpanded)
      scrollController
          .animateTo((expandedHeight) - collapsedHeight,
              duration: new Duration(milliseconds: 300), curve: Curves.linear)
          .then((_) {
        isExpanded = false;
      });
  }

  Widget _searchAppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      floating: false,
      pinned: true,
      snap: false,
      shape: ContinuousRectangleBorder(
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
      flexibleSpace: FlexibleSpaceBar(
        title: MyTable.horizontal([
          Expanded(
              child: CupertinoTextField(
            controller: _searchQuery,
            cursorColor: R.colors.app_color,
            style: TS_Body_1(R.colors.textColor),
            padding: EdgeInsets.all(8),
            keyboardType: TextInputType.text,
            placeholder: R.strings.search_index.search.translate(),
            placeholderStyle: TS_Body_2(Color(0xffC4C6CC)),
            onChanged: updateSearchQuery,
            onTap: editTextOnFocusChange,
            prefix: Padding(
              padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 0.0, bottom: 5.0),
              child: MyIcon.icon(
                Icons.search,
                size: 18,
                color: R.colors.iconColors,
                onTap: () async {
                  //  BarcodeFragment.open(getContext());
                },
              ),
            ),
            suffix: StreamBuilder<bool>(
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
                }),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: R.colors.cardColor,
            ),
          ))
        ]),
        background: Center(
          child: MyText(
            R.strings.search_index.search_text,
            style: TS_HeadLine6(Colors.white),
            padding: EdgeInsets.all(16),
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      ),
    );
  }

  void updateSearchQuery(String newQuery) {
    viewmodel.setSearchText(newQuery);
  }

  void _clearSearchQuery() {
    print("close search box");
    _searchQuery.clear();
    viewmodel.setSearchText("");
  }

  Widget filterContainer() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
          minHeight: 45,
          maxHeight: 45,
          child: StreamBuilder<List<Filter>>(
            stream: viewmodel.filters,
            builder: (_, snapshot) {
              return Container(
                color: R.colors.background,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (snapshot?.data?.length ?? 0) + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return MyTable.horizontal(
                        [
                          MyText(R.strings.search_index.filter,
                              style: TS_Body_1(R.colors.textColor)),
                          MyIcon.icon(Icons.filter_alt_rounded,
                              size: 18, color: R.colors.iconColors)
                        ],
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        onTapCallback: showFilterBottomSheetDialog,
                        elevation: 2,
                        borderRadius: BorderRadius.circular(6),
                        background: R.colors.cardColor,
                      );
                    } else {
                      Filter item = snapshot?.data[index - 1];
                      if (item == null) return Container();
                      return Chip(
                        elevation: 2,
                        backgroundColor: R.colors.cardColor,
                        label: MyText(item.value.toString(), style: TS_Body_2(R.colors.textColor)),
                        onDeleted: () {
                          viewmodel.clearFilterValue(item);
                        },
                      );
                    }
                  },
                ),
              );
            },
          )),
    );
  }

  void showFilterBottomSheetDialog() {
    FilterBottomSheetDialog.show(getContext(), viewmodel.filterProtocol);
  }

  void openMedicineItemFragment(String medicine) {
    MedicineFragment.open(getContext());
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
