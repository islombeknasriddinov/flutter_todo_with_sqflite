import 'package:flutter_test/flutter_test.dart';
import 'package:uzphariminfo/model/detail_model.dart';
import 'package:uzphariminfo/model/history_model.dart';
import 'package:uzphariminfo/model/preparation_model.dart';
import 'package:uzphariminfo/model/sync_model.dart';
import 'package:uzphariminfo/networking/networking.dart';
import 'package:uzphariminfo/utils/prefs.dart';
import 'package:uzphariminfo/viewmodel/search_view_model.dart';
import 'package:uzphariminfo/viewmodel/splash_view_model.dart';

void main(){
  group("Splash page tests", () {
    SplashViewModel viewModel = SplashViewModel();

    test("is response not null", () async{
      var response = await Network.getList(Network.API_SYNC);
      SyncMedicine medicine = Network.parseMedicineList(response);
      expect(medicine, isNotNull);
      expect(medicine.medicineMarkInn, isNotNull);
      expect(medicine.medicineMarkName, isNotNull);
    });

    test("is response saved", () async{
      await viewModel.apiMedicineList().then((_) => {
          expect(viewModel.hasData, true)
      });
    });
  });

  group("Search page tests", () {
    SearchViewModel viewModel = SearchViewModel();

    test("is response loaded", () async {
      var response = await Prefs.loadListFromPrefs(Prefs.KEY_LIST);
      expect(response, isNotNull);
      expect(response.medicineMarkName, isNotNull);
      expect(response.medicineMarkInn, isNotNull);
    });

    test("is item added to search history", () async{
      SearchHistory history = SearchHistory(nameRu: "аспирин", nameUz: "aspirin", query: "aspirin", type: "M");
      List<SearchHistory> item = [];
      item.add(history);
      viewModel.addToSearchHistory(history);

      List<SearchHistory> response = await Prefs.loadSearchHistory(Prefs.KEY_HISTORY);
      expect(response.first.nameUz, item.first.nameUz);
    });
  });

  group("Home page tests", () { 
    test("is response not null", () async{
      var response = await Network.getDetailList(Network.API_DETAIL, Network.paramsGetDetails("Citramon P", "en", "M"));
      List<Data> data = Network.parseMedicineDetailList(response).data;
      expect(data.length, greaterThan(0));
      expect(data[0].medicineMarkName, isNotEmpty);
      expect(data[0].boxGenName, isNotEmpty);
      expect(data[0].retailPriceBase, isNotNull);
      expect(data[0].boxGroupId, isNotEmpty);
      expect(data[0].producerGenName, isNotEmpty);
    });
  });

  group("Preparation page tests", () {
    test("response is not null", () async{
      var response = await Network.getPreparationList(Network.API_PREPARATION, Network.paramsPreparation("16254", "en"));
      Preparation preparation = Network.parsePreparationList(response);
      expect(preparation, isNotNull);
      expect(preparation.producerGenName, isNotNull);
      expect(preparation.boxGroupId, isNotNull);
      expect(preparation.retailPriceBase, isNotNull);
      expect(preparation.boxGenName, isNotNull);
      expect(preparation.spreadKind, isNotNull);
      expect(preparation.inn, isNotNull);
    });
  });

}