import 'dart:math';

import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/custom/auto_complete_text_view.dart';
import 'package:darmon/main.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/main/search_index/search_index_viewmodel.dart';
import 'package:darmon/ui/medicine_item/medicine_item_fragment.dart';
import 'package:darmon/ui/medicine_list/medicine_list_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gwslib/gwslib.dart';

class SearchIndexFragment extends ViewModelFragment<SearchIndexViewModel> {
  @override
  SearchIndexViewModel onCreateViewModel(BuildContext buildContext) =>
      SearchIndexViewModel(DarmonApp.instance.darmonServiceLocator.darmonRepository);

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
          //filterContainer(),
          progressContainer(),

          StreamBuilder<List<String>>(
              stream: viewmodel.menuItems,
              builder: (_, snapshot) {
                if (snapshot?.data?.isNotEmpty == true) {
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        String menu = snapshot?.data[index];
                        return Center(
                          child: MyTable.vertical(
                            [
                              MyIcon.icon(Icons.menu, color: R.colors.iconColors),
                              MyText(menu, style: TS_Body_1(R.colors.textColor))
                            ],
                            padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                            width: double.infinity,
                            height: double.infinity,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            elevation: 2,
                            background: R.colors.cardColor,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        );
                      },
                      childCount: snapshot.data.length,
                    ),
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
              child: AutoCompleteTextView(
            suggestionsApiFetchDelay: 200,
            itemBuilder: (BuildContext _, UIMedicine item) {
              return MyText(
                "${item.nameRu}/${item.producerName}",
                style: TS_Body_2(R.colors.textColor),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                onTapListener: () {
                  openMedicineItemFragment(item);
                },
              );
            },
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
            onValueChanged: (text) {
              viewmodel.setSearchText(text);
            },
            onSubmitted: (medicineName) {
              openMedicineListFragment(medicineName);
            },
            suggestionBackground: R.colors.cardColor,
            placeholder: R.strings.search_index.search.translate(),
            cursorColor: R.colors.app_color,
            placeholderStyle: TS_Body_2(Color(0xffC4C6CC)),
            suffix: StreamBuilder<bool>(
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
                          openMedicineListFragment(barcodeScanRes);
                        }
                      },
                    );
                  }
                }),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: R.colors.cardColor,
            ),
            controller: _searchQuery,
            getSuggestionsMethod: viewmodel.getLocationSuggestionsList,
            style: TS_Body_1(R.colors.textColor),
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

  Widget progressContainer() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
          minHeight: 0,
          maxHeight: 40,
          child: StreamBuilder<Map<int, bool>>(
            stream: viewmodel.progressStream,
            builder: (_, snapshot) {
              if ((snapshot.data?.values?.where((element) => element)?.length ?? -1) > 0) {
                return MyTable.vertical(
                  [
                    LinearProgressIndicator(),
                    MyText("syncing", style: TS_Body_1(R.colors.textColor))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }

  void openMedicineItemFragment(UIMedicine medicine) {
    hideKeyboard();
    _searchQuery?.clear();
    MedicineItemFragment.open(getContext(), ArgMedicineItem(medicine.medicineId));
  }

  void hideKeyboard() {
    try {
      Mold.hideKeyboard(getContext());
    } catch (error, st) {
      Log.error("Error($error)\n$st");
    }
  }

  void openMedicineListFragment(String medicineName) {
    _searchQuery?.clear();
    hideKeyboard();
    MedicineListFragment.open(getContext(), medicineName);
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
