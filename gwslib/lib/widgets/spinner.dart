import 'package:flutter/material.dart';
import 'package:gwslib/common/lazy_stream.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/mold/mold_stateful_widget.dart';
import 'package:gwslib/widgets/table.dart';
import 'package:gwslib/widgets/text.dart';

typedef SpinnerItemSelect<E> = void Function(E item);

class MySpinner<E> extends MoldStatefulWidget {
  LazyStream<DropdownMenuItem<E>> selectValueSubject = new LazyStream();
  bool startSelect = false;

  DropdownMenuItem<E> _selectValue;
  List<DropdownMenuItem<E>> _menus;
  Color _backgroundColor;
  IconData _dropIcon;
  bool _hasDropButton;
  String _title;
  double _borderRadius;

  SpinnerItemSelect<E> _onItemSelect;

  MySpinner(DropdownMenuItem<E> selectValue, List<DropdownMenuItem<E>> menus,
      {String title,
      Color backgroundColor,
      IconData dropIcon,
      bool hasDropButton,
      double borderRadius}) {
    this._selectValue = selectValue;
    this._menus = menus;
    this._title = title;
    this._backgroundColor = backgroundColor;
    this._dropIcon = dropIcon != null ? dropIcon : Icons.arrow_drop_down;
    this._hasDropButton = hasDropButton != null ? hasDropButton : true;
    this._borderRadius = borderRadius != null ? borderRadius : 8;

    selectValueSubject.add(_selectValue);
  }

  void setOnItemSelect(SpinnerItemSelect<E> onItemSelect) {
    this._onItemSelect = onItemSelect;
  }

  @override
  void onCreate() {
    super.onCreate();
    this.selectValueSubject.stream.listen((value) {
      if (startSelect && _onItemSelect != null) {
        _onItemSelect.call(value.value);
      }
    });
  }

  @override
  void onDestroy() {
    selectValueSubject.close();
    super.onDestroy();
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    List<Widget> widgets = <Widget>[];

    if (_title != null && _title.length > 0) {
      widgets.add(MyText(
        _title,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8),
        upperCase: true,
      ));
    }

    Widget body = StreamBuilder(
      initialData: selectValueSubject.value,
      stream: selectValueSubject.stream,
      builder: (buildContext, snapshot) {
        return _buildDropDown(snapshot.data);
      },
    );

    if (_backgroundColor != null) {
      widgets.add(MyTable(
        [body],
        width: double.infinity,
        mainAxisSize: MainAxisSize.max,
        borderRadius: MyTable.borderRadiusAll(_borderRadius),
        background: _backgroundColor,
        borderColor: Colors.black38,
        padding: EdgeInsets.only(left: 16, right: 16),
        margin: EdgeInsets.all(8),
      ));
    } else {
      widgets.add(MyTable(
        [body],
        width: double.infinity,
        mainAxisSize: MainAxisSize.max,
        borderRadius: MyTable.borderRadiusAll(_borderRadius),
        borderColor: Colors.black38,
        padding: EdgeInsets.only(left: 16, right: 16),
        margin: EdgeInsets.all(8),
      ));
    }

    return MyTable.vertical(
      widgets,
      mainAxisSize: MainAxisSize.max,
    );
  }

  Widget _buildDropDown(DropdownMenuItem<E> selectValue) {
    DropdownButton result = DropdownButton<E>(
      isExpanded: true,
      value: selectValue.value,
      icon: _hasDropButton ? MyIcon.icon(_dropIcon, color: Colors.black38) : Container(),
      underline: Container(),
      items: this._menus,
      onChanged: (newValue) {
        startSelect = true;
        final foundValue = _menus.firstWhere((e) => e.value == newValue);
        this.selectValueSubject.add(foundValue);
      },
    );

    return result;
  }
}

class SpinnerOption {
  String code;
  String name;
  Object tag;

  SpinnerOption(this.code, this.name, {this.tag});

  static final EMTRY = SpinnerOption("", "", tag: null);
  static final NOT_SELECTED =
      SpinnerOption("-1", "trade:spinner:not_selected".translate(), tag: null);
}
