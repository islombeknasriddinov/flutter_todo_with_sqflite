import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/custom/fade_on_scroll.dart';
import 'package:darmon/custom/fade_out_scroll.dart';
import 'package:darmon/ui/main/search_index/search_index_viewmodel.dart';
import 'package:darmon/ui/search/search_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';

class SearchIndexFragment extends ViewModelFragment<SearchIndexViewModel> {
  @override
  SearchIndexViewModel onCreateViewModel(BuildContext buildContext) => SearchIndexViewModel();

  final ScrollController scrollController = ScrollController();

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(controller: scrollController, slivers: [
      _searchAppBar(),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Center(
              child: MyTable.vertical(
                [
                  MyIcon.icon(
                    Icons.menu,
                  ),
                  MyText(
                    'menu item $index',
                  ),
                ],
                padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                width: double.infinity,
                height: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                elevation: 2,
                background: Colors.white,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            );
          },
          childCount: 30,
        ),
      )
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
        title: MyTable.horizontal(
          [
            Padding(
              padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 0.0, bottom: 5.0),
              child: MyIcon.icon(
                Icons.search,
                size: 18,
                color: Colors.black,
              ),
            ),
            MyText(
              R.strings.search_index.search.translate(),
              style: TS_Body_2(Color(0xffC4C6CC)),
            )
          ],
          onTapCallback: () {
            SearchFragment.open(getContext());
          },
          borderRadius: BorderRadius.circular(8),
          background: Colors.white,
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
}
