import 'package:darmon/common/dialogs.dart';
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
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:gwslib/gwslib.dart';

class ArgMedicineMarkList {
  final String query;

  ArgMedicineMarkList(this.query);
}

class MedicineMarkListFragment extends ViewModelFragment<MedicineMarkListViewModel> {
  static final String ROUTE_NAME = "/medicine_mark_list_fragment";

  static void open(BuildContext context, ArgMedicineMarkList arg) {
    Navigator.push<dynamic>(
        context,
        SizeRoute(
            routeName: ROUTE_NAME,
            page: Mold.newInstance(MedicineMarkListFragment()..argument = arg)));
    // Mold.openContent(context, ROUTE_NAME, arguments: medicineName);
  }

  static void popUntil(BuildContext context) {
    Navigator.popUntil(context, (route) => route.settings.name == ROUTE_NAME);
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
      MedicineMarkListViewModel(DarmonApp.instance.darmonServiceLocator.darmonRepository,
          DarmonApp.instance.darmonServiceLocator.searchHistoryDao);

  @override
  Widget onCreateWidget(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: Container(),
          leadingWidth: 0,
          elevation: 0,
          title: _buildSearchField(),
          backgroundColor: R.colors.appBarColor,
        ),
        body: Container(
          child: _buildListWidget(),
          color: R.colors.background,
        ));
  }

  void _clearSearchQuery() {
    print("close search box");
    _searchQuery.clear();
    viewmodel.setSearchText("");
  }

  Widget _buildSearchField() {
    return MyTable.horizontal(
      [
        StreamBuilder<String>(
            stream: viewmodel.searchText,
            builder: (_, snapshot) {
              if (snapshot?.data?.isNotEmpty == true) {
                return MyIcon.icon(
                  Icons.clear,
                  color: R.colors.app_color,
                  onTap: () {
                    if (_searchQuery == null || _searchQuery.text.isEmpty) {
                      Mold.onBackPressed(this);
                      return;
                    }
                    _clearSearchQuery();
                  },
                  padding: EdgeInsets.only(right: 12),
                );
              } else {
                return MyIcon.icon(
                  Icons.arrow_back,
                  color: R.colors.app_color,
                  onTap: () {
                    Mold.onBackPressed(this);
                  },
                  padding: EdgeInsets.only(right: 12),
                );
              }
            }),
        Expanded(
            child: TextField(
          controller: _searchQuery,
          autofocus: true,
          decoration: InputDecoration(
            hintText: R.strings.medicine_list.search.translate(),
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: R.colors.hintTextColor,
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.w300),
          ),
          style: TextStyle(
            color: R.colors.textColor,
            fontFamily: "SourceSansPro",
            fontWeight: FontWeight.w400,
          ),
          onChanged: updateSearchQuery,
        ))
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      background: Colors.white,
      borderRadius: BorderRadius.circular(12),
      padding: EdgeInsets.symmetric(horizontal: 12),
    );
  }

  void updateSearchQuery(String newQuery) {
    viewmodel.setSearchText(newQuery);
  }

  Widget _buildListWidget() {
    return StreamBuilder<void>(
        stream: viewmodel.reload,
        builder: (_, snapshot) {
          if ((viewmodel.getSearchText == null || viewmodel.getSearchText.isEmpty) &&
              viewmodel.searchHistoryList?.isNotEmpty == true)
            return CustomScrollView(
              slivers: [
                _buildSearchHistory(),
              ],
              reverse: false,
            );

          if ((viewmodel.medicineMarkInnListIsNotEmpty) ||
              (viewmodel.medicineMarkNameListIsNotEmpty)) {
            return CustomScrollView(
              slivers: [
                if (viewmodel.medicineMarkNameListIsNotEmpty) _buildMedicineMarkNameList(),
                if (viewmodel.medicineMarkInnListIsNotEmpty) _buildMedicineMarkInnList(),
              ],
              reverse: false,
            );
          } else {
            return Container();
          }
        });
  }

  Widget _buildSearchHistory() {
    List<UIMedicineMark> histories = viewmodel.searchHistoryList;
    return SliverStickyHeader(
      header: Container(
        color: R.colors.stickHeaderColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        alignment: Alignment.centerLeft,
        child: MyText(
          R.strings.medicine_mark_list.search_history,
          style: TS_Subtitle_2(Colors.white),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            print(histories.length);
            if (i == histories.length) {
              if (viewmodel.hasHistoryListNextPage)
                return buildMoreButtonWidget(() {
                  viewmodel.loadMoreHistory();
                });
              else {
                return Container();
              }
            }

            UIMedicineMark mark = histories[i];
            return populateSearchHistoryItem(mark.title, () {
              openMedicineListFragment(mark);
            }, () {
              viewmodel.deleteSearchHistory(mark);
            });
          },
          childCount: histories.length + 1,
        ),
      ),
    );
  }

  Widget populateSearchHistoryItem(
      String title, Function onTapCallback, Function onDeleteSearchHistory) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          child: MyTable.vertical(
            [
              MyTable.horizontal(
                [
                  MyIcon.svg(
                    R.asserts.history,
                    color: R.colors.iconColors,
                    size: 24,
                  ),
                  MyText(
                    title,
                    flex: 1,
                    style: TS_Subtitle_1(R.colors.textColor),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  MyIcon.icon(Icons.arrow_forward_rounded,
                      color: R.colors.iconColors, size: 16, padding: EdgeInsets.all(8))
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              Divider(color: R.colors.dividerColor, height: 1)
            ],
            background: Colors.white,
          ),
          onTap: onTapCallback,
          onLongPress: () {
            MyDialog.alert()
                .title(R.strings.medicine_mark_list.warning)
                .message(R.strings.medicine_mark_list.delete_message)
                .positive(R.strings.medicine_mark_list.yes, () {
                  onDeleteSearchHistory.call();
                })
                .negative(R.strings.medicine_mark_list.no, () {})
                .show(getContext());
          },
        ));
  }

  Widget _buildMedicineMarkNameList() {
    List<UIMedicineMark> names = viewmodel.medicineMarkNameList;
    return SliverStickyHeader(
      header: Container(
        color: R.colors.stickHeaderColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        alignment: Alignment.centerLeft,
        child: MyText(
          R.strings.medicine_mark_list.mark_name,
          style: TS_Subtitle_2(Colors.white),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            print(names.length);
            if (i == names.length) {
              if (viewmodel.hasMarkNameListNextPage)
                return buildMoreButtonWidget(() {
                  viewmodel.loadMedicineMarkNameMore();
                });
              else {
                return Container();
              }
            }

            UIMedicineMark name = names[i];
            return populateListItem(name.title, () {
              openMedicineListFragment(name);
            });
          },
          childCount: names.length + 1,
        ),
      ),
    );
  }

  Widget _buildMedicineMarkInnList() {
    List<UIMedicineMark> inns = viewmodel.medicineMarkInnList;
    Log.debug("inns.length=${inns.length}");
    return SliverStickyHeader(
      header: Container(
        color: R.colors.stickHeaderColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        alignment: Alignment.centerLeft,
        child: MyText(
          R.strings.medicine_mark_list.mark_inn,
          style: TS_Subtitle_2(Colors.white),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            if (i == inns.length) {
              if (viewmodel.hasMarkInnListNextPage)
                return buildMoreButtonWidget(() {
                  viewmodel.loadMedicineMarkInnMore();
                });
              else {
                return Container();
              }
            }
            UIMedicineMark inn = inns[i];
            return populateListItem(inn.title, () {
              openMedicineListFragment(inn);
            });
          },
          childCount: inns.length + 1,
        ),
      ),
    );
  }

  Widget populateListItem(String title, Function onTapCallback) {
    return MyTable.vertical(
      [
        MyTable.horizontal(
          [
            MyText(
              title,
              flex: 1,
              style: TS_Subtitle_1(R.colors.textColor),
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            MyIcon.icon(
              Icons.arrow_forward_ios_rounded,
              color: R.colors.iconColors,
              size: 18,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          padding: EdgeInsets.only(right: 12, top: 6, bottom: 6),
        ),
        Divider(color: R.colors.dividerColor, height: 1)
      ],
      background: Colors.white,
      padding: EdgeInsets.only(left: 12),
      onTapCallback: onTapCallback,
    );
  }

  void openMedicineListFragment(UIMedicineMark medicine) {
    viewmodel.saveMedicineMarkSearchHistory(medicine);
    hideKeyboard();
    MedicineListFragment.open(
        getContext(), ArgMedicineList(medicine.title, medicine.sendServerText, medicine.type));
  }

  void hideKeyboard() {
    try {
      Mold.hideKeyboard(getContext());
    } catch (error, st) {
      Log.error("Error($error)\n$st");
    }
  }

  Widget buildMoreButtonWidget(Function onTapCallback) {
    return MyTable.vertical(
      [
        MyTable.horizontal(
          [
            MyText(
              R.strings.medicine_mark_list.show_more,
              flex: 1,
              style: TS_Body_1(R.colors.app_color),
              padding: EdgeInsets.symmetric(vertical: 8),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          padding: EdgeInsets.only(right: 12, top: 6, bottom: 6),
        ),
        Divider(color: R.colors.dividerColor, height: 1)
      ],
      background: Colors.white,
      padding: EdgeInsets.only(left: 12),
      onTapCallback: onTapCallback,
    );
  }
}
