import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:uzphariminfo/model/history_model.dart';
import 'package:uzphariminfo/model/sync_model.dart';
import 'package:uzphariminfo/utils/prefs.dart';

import '../model/item_search_list_model.dart';

class SearchViewModel extends ChangeNotifier {
  List<MedicineName> name = [];
  List<MedicineMarkInn> inn = [];
  List<MedicineName> iList = [];
  List<MedicineMarkInn> mList = [];

  List<ItemSearchList> result = [];
  List<ItemSearchList>? items = [];

  List<SearchHistory> history = [];

  bool isVisible = false;
  bool isGone = true;

  int medicineListLimit = 5;
  int innListLimit = 5;

  void loadLists() async {
    var response = await Prefs.loadListFromPrefs(Prefs.KEY_LIST);
    name = response!.medicineMarkName;
    notifyListeners();

    inn = response.medicineMarkInn;
    notifyListeners();

    var res = await Prefs.loadSearchHistory(Prefs.KEY_HISTORY);
    if(res != null){
      history = res;
      notifyListeners();
    }

    if(history.isNotEmpty){
      isGone = true;
      notifyListeners();
    }
  }

  void visiblity(String char, BuildContext context){
    if(char != null || char != ""){
      isGone = false;
      notifyListeners();

      isVisible = true;
      notifyListeners();
    }

    if(char == ""){
      isGone = true;
      notifyListeners();

      innListLimit = 5;
      medicineListLimit = 5;

      isVisible = false;
      notifyListeners();
    }

    runFilter(char, context);
  }

  void addToSearchHistory(SearchHistory item) async{
    if(item != null){
      if(!history.any((element) => element.query == item.query)){
        history.add(item);
        notifyListeners();
      }

      var his = jsonEncode(history);
      Prefs.saveToPrefs(his, Prefs.KEY_HISTORY);

    }
  }

  void removeFromSearchHistory(SearchHistory item){
    history.remove(item);

    var his = jsonEncode(history);
    Prefs.saveToPrefs(his, Prefs.KEY_HISTORY);
    notifyListeners();
  }

  void runFilter(String char, BuildContext context) {
    if(char.isEmpty){
      iList = name;
      notifyListeners();
      mList = inn;
      notifyListeners();
    }else{
      if(context.locale == Locale('uz', 'UZ')){
        iList = name
            .where((element) => element.nameUz.toLowerCase().contains(char.toLowerCase())).toList();

        mList = inn.where((element) => element
            .innEn.toLowerCase().contains(char.toLowerCase())).toList();
      }else{
        iList = name
          .where((element) => element.nameRu.toLowerCase().contains(char.toLowerCase())).toList();

        mList = inn.where((element) => element
            .innRu.toLowerCase().contains(char.toLowerCase())).toList();
      }
    }
    refreshList(context);
  }

  void refreshList(BuildContext context) {
    result.clear();
    addToMedicineName(context);
    addToMedicineInn(context);

    items = result;
    notifyListeners();
  }

  void addToMedicineName(BuildContext context){
    String mark_name = "mark_name".tr();
    String btn_more = "btn_more".tr();

    result.add(ItemSearchList.header(mark_name));
    if (iList.length > medicineListLimit) {
      for (int i = 0; i < medicineListLimit; i++) {
        if(context.locale == Locale('uz', 'UZ')){
          result.add(ItemSearchList.medicine(iList[i].nameUz, medicineName: iList[i]));
        }else{
          result.add(ItemSearchList.medicine(iList[i].nameRu, medicineName: iList[i]));
        }
      }

      result.add(ItemSearchList.moreMedicine(btn_more));
    } else {
      if(context.locale == Locale('uz', 'UZ')){
        result.addAll(iList.map((e) => ItemSearchList.medicine(e.nameUz, medicineName: e)).toList());
      }else{
        result.addAll(iList.map((e) => ItemSearchList.medicine(e.nameRu, medicineName: e)).toList());
      }
    }
  }

  void addToMedicineInn(BuildContext context){
    String inn_name = "inn_name".tr();
    String btn_more = "btn_more".tr();

    result.add(ItemSearchList.header(inn_name));
    if(mList.length > innListLimit){
      for(int i=0; i < innListLimit; i++){
        if(context.locale == Locale('uz', 'UZ')){
          result.add(ItemSearchList.inn(mList[i].innEn, medicineMarkInn: mList[i]));
        }else{
          result.add(ItemSearchList.inn(mList[i].innRu, medicineMarkInn: mList[i]));
        }
      }

      result.add(ItemSearchList.moreInn(btn_more));
    }else{
      if(context.locale == Locale('uz', 'UZ')){
        result.addAll(mList.map((e) => ItemSearchList.inn(e.innEn, medicineMarkInn: e)).toList());
      }else{
        result.addAll(mList.map((e) => ItemSearchList.inn(e.innRu, medicineMarkInn: e)).toList());
      }
    }
  }

  void loadMoreMedicine(BuildContext context) {
    medicineListLimit += 5;
    refreshList(context);
    notifyListeners();
  }

  void loadMoreInn(BuildContext context) {
    innListLimit += 5;
    refreshList(context);
    notifyListeners();
  }
}