import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:uzphariminfo/model/history_model.dart';
import 'package:uzphariminfo/model/item_search_list_model.dart';
import 'package:uzphariminfo/utils/colors.dart';
import 'package:uzphariminfo/viewmodel/search_view_model.dart';
import '../views/item_search_history.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  static final String id = "search_page";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchViewModel viewModel = SearchViewModel();
  final searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    viewModel.loadLists();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<SearchViewModel>(
          builder: (ctx, model, index) => Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  leadingWidth: 1,
                  titleSpacing: 0,
                  backgroundColor: BColors.appBarColor,
                  title: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: BColors.whiteColor),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.none,
                      onChanged: (value) {
                        viewModel.visiblity(value, context);
                      },
                      decoration: InputDecoration(
                          icon: Stack(
                            children: [
                              Visibility(
                                  visible: viewModel.isGone,
                                  child: GestureDetector(
                                    onTap: () {
                                      pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: BColors.iconColor,
                                    ),
                                  )),
                              Visibility(
                                  visible: viewModel.isVisible,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (searchController.text.isNotEmpty) {
                                        searchController.clear();
                                        viewModel.visiblity(
                                            searchController.text, context);
                                      } else {}
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: BColors.iconColor,
                                    ),
                                  )),
                            ],
                          ),
                          border: InputBorder.none,
                          hintText: 'searchText'.tr(),
                          hintStyle: TextStyle(color: BColors.hintTextColor)),
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    Visibility(
                      visible: viewModel.isVisible,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: viewModel.items!.length,
                              itemBuilder: (_, index) {
                                ItemSearchList item =
                                viewModel.items![index];
                                switch (item.type) {
                                  case ListType.HEADER:
                                    return buildHeaderWidget(item);
                                  case ListType.MEDICINE:
                                    return buildMedicineNameWidget(item);
                                  case ListType.INN:
                                    return buildMedicineInnWidget(item);
                                  case ListType.MORE_MEDICINE:
                                    return buttonMoreMedicineNameWidget(
                                        item);
                                  case ListType.MORE_INN:
                                    return buttonMoreMedicineInnWidget(
                                        item);
                                  default:
                                    return Container();
                                }
                              })
                      )
                    ),

                    //Search History
                    Visibility(
                      visible: viewModel.isGone,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: BColors.backgroundColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Row(
                              children: [
                                Text(
                                  'search_history',
                                  style: TextStyle(
                                      color: BColors.whiteColor, fontSize: 14),
                                ).tr()
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: viewModel.history.length,
                                itemBuilder: (ctx, index) {
                                  return itemSearchHistory(
                                       viewModel.history[index], context, viewModel
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
      ),
    );
  }

  Widget buildHeaderWidget(ItemSearchList item) {
    return Container(
      color: BColors.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Text(
            item.title!,
            style: TextStyle(color: BColors.whiteColor, fontSize: 14),
          ).tr()
        ],
      ),
    );
  }

  Widget buildMedicineNameWidget(ItemSearchList item) {
    String name = "";
    if(context.locale == Locale('uz', 'UZ')){
      name = item.medicineName!.nameUz;
    }else{
      name = item.medicineName!.nameRu;
    }
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 0.1,
                  color: Colors.black
              )
          )
      ),
      child: TextButton(
        onPressed: (){
          viewModel.addToSearchHistory(
              SearchHistory(
                  nameUz: item.medicineName!.nameUz,
                  nameRu: item.medicineName!.nameRu,
                  query: item.medicineName!.nameEn,
                  type: "M"
              )
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailPage(
                        query: item.medicineName!.nameEn,
                        type: "M",
                        name: name
                    ),

              )
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          item.title!,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: BColors.about_TextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: BColors.historyIconColor,
                size: 16,
              )
            ],
          ),
        )
      ),
    );
  }

  Widget buildMedicineInnWidget(ItemSearchList item) {
    String inn = "";
    if(context.locale == Locale('uz', 'UZ')){
      inn = item.medicineMarkInn!.innEn;
    }else{
      inn = item.medicineMarkInn!.innRu;
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 0.1,
                  color: Colors.black
              )
          )
      ),
      child: TextButton(
        onPressed: (){
          viewModel.addToSearchHistory(
              SearchHistory(
                  nameUz: item.medicineMarkInn!.innEn,
                  nameRu: item.medicineMarkInn!.innRu,
                  query: item.medicineMarkInn!.innIds,
                  type: "I"
              )
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                      query: item.medicineMarkInn?.innIds,
                      type: "I",
                      name: inn
                  )
              )
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            item.title!,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: BColors.about_TextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: BColors.historyIconColor,
                  size: 16,
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget buttonMoreMedicineNameWidget(ItemSearchList item) {
    return Container(
      color: BColors.whiteColor,
      child: TextButton(
          onPressed: () {
            viewModel.loadMoreMedicine(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    item.title!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: BColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget buttonMoreMedicineInnWidget(ItemSearchList item) {
    return Container(
      color: BColors.whiteColor,
      child: TextButton(
          onPressed: () {
            viewModel.loadMoreInn(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    item.title!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: BColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
