import 'package:gwslib/gwslib.dart';

class SearchField {
  String id;
  String value;
  String title;
  LazyStream<bool> _onSelected = LazyStream(() => true);

  Stream<bool> get onSelected => _onSelected.stream;

  SearchField(this.id, this.title, {this.value});

  SearchField.id(this.id);

  SearchField.value(this.value);

  bool get getOnSelected => _onSelected.value;

  void setOnSelected(bool value) {
    _onSelected.add(value);
  }

  void dissmise() {
    _onSelected.close();
  }
}
