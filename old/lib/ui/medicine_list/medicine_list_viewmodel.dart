import 'package:darmon/common/result.dart';
import 'package:darmon/repository/bean.dart';
import 'package:darmon/repository/medicine_list_repository.dart';
import 'package:darmon/ui/medicine_list/medicine_list_fragment.dart';
import 'package:darmon/ui/medicine_list/medicine_list_modules.dart';
import 'package:gwslib/gwslib.dart';

class MedicineListViewModel extends ViewModel<ArgMedicineList> {
  MedicineListRepository _repository;

  MedicineListViewModel();

  LazyStream<List<ProducerListItem>> _items = LazyStream();
  LazyStream<MyResultStatus> _statuse = LazyStream(() => null);
  LazyStream<ErrorMessage> _errorMessage = new LazyStream();

  Stream<ErrorMessage> get errorMessageStream => _errorMessage.stream;

  Stream<MyResultStatus> get statuse => _statuse.stream;

  Stream<List<ProducerListItem>> get items => _items.stream;

  ErrorMessage get errorMessage => _errorMessage.value;

  @override
  void onCreate() {
    super.onCreate();
    _repository = MedicineListRepository();
    loadFirstPage(
        argument.type,
        argument.type == UIMedicineMarkSearchResultType.BOX_GROUP
            ? argument.boxGroupId
            : argument.sendServerText);
    _statuse.get().listen((value) {
      print(value);
    });
  }

  void reload() {
    loadFirstPage(
        argument.type,
        argument.type == UIMedicineMarkSearchResultType.BOX_GROUP
            ? argument.boxGroupId
            : argument.sendServerText);
  }

  void loadPage() async {
    if (_statuse.value == MyResultStatus.SUCCESS && _repository.hasNextPage) {
      try {
        _statuse.add(MyResultStatus.LOADING);
        List<ProducerListItem> result = await _repository.loadList(
            argument.type,
            argument.type == UIMedicineMarkSearchResultType.BOX_GROUP
                ? argument.boxGroupId
                : argument.sendServerText);

        List<ProducerListItem> list = _items.value ?? [];
        ProducerListItem last = list?.isNotEmpty == true ? list?.last : null;
        ProducerListItem resultFirst = result?.isNotEmpty == true ? result?.first : null;

        if (last != null &&
            resultFirst != null &&
            last?.producerGenName == resultFirst?.producerGenName &&
            last?.producerGenName == resultFirst?.producerGenName) {
          last.medicines.addAll(resultFirst.medicines);
          result.remove(resultFirst);
        }
        list.addAll(result);
        if (result != null) _items.add(list);

        _statuse.add(MyResultStatus.SUCCESS);
      } catch (error, st) {
        Log.error("Error($error)\n$st");
        _errorMessage.add(ErrorMessage.parseWithStacktrace(error, st));
        _statuse.add(MyResultStatus.ERROR);
      }
    }
  }

  void loadFirstPage(UIMedicineMarkSearchResultType type, String sendServerText) async {
    try {
      _statuse.add(MyResultStatus.LOADING);
      List<ProducerListItem> result = await _repository.loadFirstList(type, sendServerText);

      List<ProducerListItem> list = _items.value ?? [];
      list.addAll(result);
      if (result != null) _items.add(list);

      _statuse.add(MyResultStatus.SUCCESS);
    } catch (error, st) {
      Log.error("Error($error)\n$st");
      _errorMessage.add(ErrorMessage.parseWithStacktrace(error, st));
      _statuse.add(MyResultStatus.ERROR);
    }
  }

  @override
  void onDestroy() {
    _items.close();
    _errorMessage.close();
    _statuse.close();
    super.onDestroy();
  }
}
