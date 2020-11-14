import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/custom/animation_list/item_diff_utill.dart';
import 'package:darmon/custom/animation_list/list_model.dart';
import 'package:darmon/custom/fade_on_scroll.dart';
import 'package:darmon/custom/fade_out_scroll.dart';
import 'package:darmon/ui/main/search_index/search_index_viewmodel.dart';
import 'package:darmon/ui/main/search_index/search_item.dart';
import 'package:darmon/ui/main/search_index/search_item_widget.dart';
import 'package:darmon/ui/search/search_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gwslib/gwslib.dart';

class SearchIndexFragment extends ViewModelFragment<SearchIndexViewModel> {
  @override
  SearchIndexViewModel onCreateViewModel(BuildContext buildContext) => SearchIndexViewModel();

  final ScrollController scrollController = ScrollController();
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();

  double expandedHeight = 250;
  double collapsedHeight = 0;
  bool isExpanded = true;
  ListModel<String> _listController;
  TextEditingController _searchQuery;

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);

    _searchQuery = new TextEditingController();

    _listController = ListModel<String>(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
    );

    scrollController.addListener(() {
      if (scrollController.offset <= expandedHeight) {
        isExpanded = true;
      } else {
        isExpanded = false;
      }
    });

    viewmodel.items.listen((newList) {
      DiffUtil.calculate(_listController, viewmodel.lastItems.map((e) => MedisineDiff(e)).toList(),
          newList.map((e) => MedisineDiff(e)).toList());
    });
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(controller: scrollController, slivers: [
      _searchAppBar(),
      SliverAnimatedList(
        key: _listKey,
        initialItemCount: _listController.length,
        itemBuilder: _buildItem,
      )
    ]));
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _listController[index],
      onTap: () {},
    );
  }

  Widget _buildRemovedItem(String item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
    );
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
}
