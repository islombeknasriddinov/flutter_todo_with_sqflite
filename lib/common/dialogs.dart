
import 'package:darmon/common/resources.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

import 'smartup5x_styles.dart';

class MyDialog {
  static ProgressDialogBuilder get progressDialog => ProgressDialogBuilder();

  static AlertDialogDialogBuilder alert() => AlertDialogDialogBuilder();

  static SimpleListDialogDialogBuilder simpleList() => SimpleListDialogDialogBuilder();
}

class ProgressDialogBuilder {
  String _message;

  ProgressDialogBuilder message(String value) {
    _message = value;
    return this;
  }

  ProgressDialogController build(BuildContext context) {
    final message = _message ?? R.strings.please_wait;
    final alert = AlertDialog(
        content: MyTable.horizontal(
      [
        CircularProgressIndicator(),
        MyText(
          message,
          padding: EdgeInsets.only(left: 12),
          flex: 1,
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    ));
    return ProgressDialogController(context, alert);
  }
}

class ProgressDialogController {
  AlertDialog _dialog;
  BuildContext _context;
  Function hideAction;

  ProgressDialogController(this._context, this._dialog);

  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          hideAction = () {
            Mold.onContextBackPressed(context);
          };
          return _dialog;
        });
  }

  void hide() {
    if (hideAction != null) {
      hideAction.call();
    }
  }
}

class AlertDialogDialogBuilder {
  String _title;
  String _message;

  String positiveBtnText = "dialogs:accept";
  String negativeBtnText = "dialogs:cancel";

  VoidCallback positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;

  AlertDialogDialogBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  AlertDialogDialogBuilder message(String _message) {
    this._message = _message;
    return this;
  }

  AlertDialogDialogBuilder positive(String positiveBtnText, VoidCallback function) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    return this;
  }

  AlertDialogDialogBuilder positiveCallback(VoidCallback function) {
    this.positiveBtnClickAction = function;
    return this;
  }

  AlertDialogDialogBuilder negative(String negativeBtnText, VoidCallback function) {
    this.negativeBtnClickAction = function;
    this.negativeBtnText = negativeBtnText;
    return this;
  }

  AlertDialogDialogBuilder negativeCallback(VoidCallback function) {
    this.negativeBtnClickAction = function;
    return this;
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: MyText(
            _title,
            style: TS_Body_1(Colors.black87),
          ),
          content: _message.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: MyText(
                    _message,
                    style: TS_Body_2(Colors.black54),
                  ),
                )
              : Container(),
          actions: <Widget>[
            negativeBtnClickAction != null
                ? FlatButton(
                    onPressed: () {
                      Mold.onContextBackPressed(context);
                      negativeBtnClickAction.call();
                    },
                    child: MyText(
                      negativeBtnText,
                      style: TS_Button(Colors.blue),
                    ))
                : Container(),
            positiveBtnClickAction != null
                ? FlatButton(
                    onPressed: () {
                      Mold.onContextBackPressed(context);
                      positiveBtnClickAction.call();
                    },
                    child: MyText(
                      positiveBtnText,
                      style: TS_Button(Colors.blue),
                    ))
                : Container(),
          ],
        );
      },
    );
  }
}

class SimpleListDialogDialogBuilder {
  String _title;

  String btnText = "dialogs:cancel";

  VoidCallback btnClickAction;

  List<ConfirmationOption> _options = [];

  SimpleListDialogDialogBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  SimpleListDialogDialogBuilder button(String btnText, VoidCallback function) {
    this.btnClickAction = function;
    this.btnText = btnText;
    return this;
  }

  SimpleListDialogDialogBuilder buttonCallback(VoidCallback function) {
    this.btnClickAction = function;
    return this;
  }

  SimpleListDialogDialogBuilder options<T>(
      List<T> values,
      DialogsTitleFunction<T> titleFunction,
      DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
      DialogsItemSelectAction<T> itemSelectAction) {
    for (var value in values) {
      _options.add(ConfirmationOption(
          title: titleFunction.call(value),
          subTitle: subTitleTitleFunction.call(value),
          clickAction: () {
            itemSelectAction.call(value);
          }));
    }
    return this;
  }

  SimpleListDialogDialogBuilder option(String title, String subTitle, VoidCallback callBack) {
    _options.add(ConfirmationOption(title: title, subTitle: subTitle, clickAction: callBack));
    return this;
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (_title?.isNotEmpty == true) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            title: MyText(
              _title,
              style: TS_Body_1(R.colors.textColor),
            ),
            content: SingleChildScrollView(
                child: MyTable.vertical([
              MyTable.vertical(
                widgets(context),
              ),
              Center(
                child: FlatButton(
                    onPressed: () {
                      Mold.onContextBackPressed(context);
                      btnClickAction.call();
                    },
                    child: MyText(
                      btnText,
                      textAlign: TextAlign.center,
                      style: TS_Button(R.colors.app_color),
                    )),
              )
            ])),
          );
        } else {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: SingleChildScrollView(
                child: MyTable.vertical([
              MyTable.vertical(
                widgets(context),
              ),
              Center(
                child: FlatButton(
                    onPressed: () {
                      btnClickAction.call();
                      Mold.onContextBackPressed(context);
                    },
                    child: MyText(
                      btnText,
                      textAlign: TextAlign.center,
                      style: TS_Button(R.colors.app_color),
                    )),
              )
            ])),
          );
        }
      },
    );
  }

  List<Widget> widgets(BuildContext context) {
    return _options
        .map((e) => MyTable.vertical(
              [
                if (e.title?.isNotEmpty == true)
                  MyText(
                    e.title,
                    style: TS_Body_1(R.colors.textColor),
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: e.subTitle?.isNotEmpty == true ? 0 : 16),
                  ),
                if (e.subTitle?.isNotEmpty == true)
                  MyText(
                    e.subTitle,
                    style: TS_Caption(Colors.black54),
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: e.title?.isNotEmpty == true ? 0 : 16, bottom: 16),
                  ),
                Divider(height: 1, color: Colors.grey)
              ],
              width: double.infinity,
              onTapCallback: () {
                Mold.onContextBackPressed(context);
                e.clickAction.call();
              },
            ))
        .toList();
  }
}

class ConfirmationDialogBuilder {
  String _title;
  String _message;
  String positiveBtnText;
  String negativeBtnText;
  VoidCallback positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;
  List<ConfirmationOption> _options = [];

  ConfirmationDialogBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  ConfirmationDialogBuilder message(String _message) {
    this._message = _message;
    return this;
  }

  ConfirmationDialogBuilder positive(String positiveBtnText, VoidCallback function) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    return this;
  }

  ConfirmationDialogBuilder options<T>(
      List<T> values,
      DialogsTitleFunction<T> titleFunction,
      DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
      DialogsItemSelectAction<T> itemSelectAction) {
    for (var value in values) {
      _options.add(ConfirmationOption(
          title: titleFunction.call(value),
          subTitle: subTitleTitleFunction.call(value),
          clickAction: () {
            itemSelectAction.call(value);
          }));
    }
    return this;
  }

  ConfirmationDialogBuilder option(String title, String subTitle, VoidCallback callBack) {
    _options.add(ConfirmationOption(title: title, subTitle: subTitle, clickAction: callBack));
    return this;
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(_title),
          children: widgets(context),
        );
      },
    );
  }

  List<Widget> widgets(BuildContext context) {
    return _options
        .map((e) => SimpleDialogOption(
              child: ListTile(
                title: Text(
                  e.title,
                  style: TS_Body_1(R.colors.textColor),
                ),
                subtitle: Text(
                  e.subTitle,
                  style: TS_Caption(Colors.black54),
                ),
              ),
              onPressed: () {
                Mold.onContextBackPressed(context);
                e.clickAction.call();
              },
            ))
        .toList();
  }
}

class ConfirmationOption {
  String title;
  String subTitle;
  VoidCallback clickAction;

  ConfirmationOption({this.title, this.subTitle, this.clickAction});
}

// ignore: deprecated_extends_function
abstract class CommandFacade<T> extends Function {
  String getTitle(T obj);

  String getSubTitle(T obj);

  void apply(T obj);
}

typedef DialogsTitleFunction<E> = String Function(E element);
typedef DialogsSubTitleTitleFunction<E> = String Function(E element);
typedef DialogsItemSelectAction<E> = Function(E element);

void openSelectDateDialog(BuildContext context, String date, Function(DateTime) selectedAction) {
  DateTime consignDate = date?.isNotEmpty == true ? DateUtil.parse(date) : DateTime.now();
  showDatePicker(
          context: context,
          initialDate: consignDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030))
      .then((value) => {selectedAction.call(value)});
}

void openSelectDateDialog_(BuildContext context, DateTime date, Function(DateTime) selectedAction) {
  showDatePicker(
          context: context, initialDate: date, firstDate: DateTime(2010), lastDate: DateTime(2030))
      .then((value) => {selectedAction.call(value)});
}

void openSelectRangeDateDialog(
    BuildContext context, String date, Function(DateTimeRange) selectedAction) {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  if (date?.isNotEmpty == true) {
    final splitDate = date.split("-");
    start = splitDate[0]?.isNotEmpty == true ? DateUtil.parse(splitDate[0]) : DateTime.now();
    end = splitDate[1]?.isNotEmpty == true ? DateUtil.parse(splitDate[1]) : DateTime.now();
  }

  final dateRange = DateTimeRange(start: start, end: end);
  showDateRangePicker(
          context: context,
          initialDateRange: dateRange,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime(2030))
      .then((value) => {selectedAction.call(value)});
}


void openSelectTimeDialog_(
    BuildContext context, TimeOfDay time, Function(TimeOfDay) selectedAction) {
  showTimePicker(context: context, initialTime: time).then((value) => {selectedAction.call(value)});
}
