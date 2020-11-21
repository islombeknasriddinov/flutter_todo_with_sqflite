import 'package:darmon/common/resources.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:gwslib/gwslib.dart';

class MedicineListViewModel extends ViewModel {
  LazyStream<bool> _isClearActive = LazyStream(() => true);
  LazyStream<String> _searchText = LazyStream();

  Stream<String> get searchText => _searchText.stream;

  Stream<bool> get isClearActive => _isClearActive.stream;

  List<SearchField> searchFilterFields = [
    SearchField("by_name", R.strings.search_fragment.search_by_name.translate()),
    SearchField("by_mnn", R.strings.search_fragment.search_by_mnn.translate()),
  ];

  @override
  void onCreate() {
    super.onCreate();
    _searchText.get().listen((value) {
      if (value?.isNotEmpty == true) {
        if (_isClearActive.value != true) _isClearActive.add(true);
      } else {
        if (_isClearActive.value != false) _isClearActive.add(false);
      }
    });
  }

  void setSearchText(String txt) {
    _searchText.add(txt);
  }
}
