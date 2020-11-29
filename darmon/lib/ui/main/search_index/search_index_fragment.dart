import 'dart:math';

import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/custom/auto_complete_text_view.dart';
import 'package:darmon/main.dart';
import 'package:darmon/repository/darmon_repository.dart';
import 'package:darmon/ui/main/search_index/search_index_viewmodel.dart';
import 'package:darmon/ui/medicine_list/medicine_list_fragment.dart';
import 'package:darmon/ui/medicine_mark_list/medicine_mark_list_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: R.colors.background,
        resizeToAvoidBottomPadding: true,
        body: CustomScrollView(controller: scrollController, slivers: [
          _searchAppBar(),
          //filterContainer(),
          progressContainer(),

        /*  StreamBuilder<List<String>>(
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
                    child: Container(
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
                    ),
                  );
                }
              })*/
        ]));
  }

/*

  Widget _searchAppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      floating: false,
      pinned: true,
      snap: false,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      flexibleSpace: FlexibleSpaceBar(
        title: MyTable.horizontal([
          Expanded(
              child: AutoCompleteTextView(
            suggestionsApiFetchDelay: 200,
            itemBuilder: (BuildContext _, UIMedicineMark item) {
              return MyText(
                item.title,
                style: TS_Body_2(R.colors.textColor),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                onTapListener: () {
                  openMedicineListFragment(item);
                },
              );
            },
            prefix: Padding(
              padding:
                  EdgeInsets.only(left: 5.0, top: 5.0, right: 0.0, bottom: 5.0),
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
              openMedicineMarkListFragment(medicineName);
            },
            suggestionBackground: R.colors.cardColor,
            placeholder: R.strings.search_index.search.translate(),
            cursorColor: R.colors.app_color,
            placeholderStyle: TS_Body_2(Color(0xffC4C6CC)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: R.colors.cardColor,
            ),
            controller: _searchQuery,
            moreBtnOnTapCallback: () {
              openMedicineMarkListFragment(_searchQuery.text ?? "");
            },
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
*/

  Widget _searchAppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      floating: false,
      backgroundColor: R.colors.appBarColor,
      pinned: true,
      snap: false,
      shape: ContinuousRectangleBorder(
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
      flexibleSpace: FlexibleSpaceBar(
        title: MyTable.horizontal(
          [
            Padding(
              padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 0.0, bottom: 5.0),
              child: MyIcon.icon(
                Icons.search,
                size: 18,
                color: R.colors.iconColors,
              ),
            ),
            MyText(
              R.strings.search_index.search.translate(),
              style: TS_Body_2(R.colors.textColor),
            )
          ],
          onTapCallback: () {
            MedicineMarkListFragment.open(getContext(), ArgMedicineMarkList(""));
          },
          borderRadius: BorderRadius.circular(8),
          background: R.colors.background,
          width: double.infinity,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          height: 40,
        ),
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
                    MyText(R.strings.search_index.syncing, style: TS_Body_1(R.colors.textColor))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                );
              } else {
                return Container(color: R.colors.background);
              }
            },
          )),
    );
  }

  void openMedicineListFragment(UIMedicineMark medicine) {
    hideKeyboard();
    _searchQuery?.clear();
    MedicineListFragment.open(
        getContext(), ArgMedicineList(medicine.title, medicine.sendServerText, medicine.type));
  }

  void openMedicineMarkListFragment(String text) {
    hideKeyboard();
    _searchQuery?.clear();
    MedicineMarkListFragment.open(getContext(), ArgMedicineMarkList(text));
  }

  void hideKeyboard() {
    try {
      Mold.hideKeyboard(getContext());
    } catch (error, st) {
      Log.error("Error($error)\n$st");
    }
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
