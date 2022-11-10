import 'package:darmon/common/resources.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class DatePickerWidget extends StatelessWidget {
  IconData icon;
  double iconsSize;
  TextStyle textStyle;
  Stream<String> dateStream;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry textPadding;
  Function(DateTime) dateSelectedAction;
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;

  DatePickerWidget(
    this.dateStream, {
    this.icon,
    this.padding,
    this.iconsSize,
    this.textStyle,
    this.textPadding,
    this.dateSelectedAction,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    dynamic mIcon = icon != null ? icon : Icons.date_range;
    double mIconSize = iconsSize != null && iconsSize != 0 ? iconsSize : 20;
    TextStyle mTextStyle = textStyle != null ? textStyle : TS_Caption(R.colors.app_color, true);
    EdgeInsetsGeometry mPadding = padding != null ? padding : EdgeInsets.only(top: 12);
    EdgeInsetsGeometry mTextPadding = textPadding != null ? textPadding : EdgeInsets.only(left: 8);

    MainAxisAlignment mMainAxisAlignment =
        mainAxisAlignment != null ? mainAxisAlignment : MainAxisAlignment.center;
    CrossAxisAlignment mCrossAxisAlignment =
        crossAxisAlignment != null ? crossAxisAlignment : CrossAxisAlignment.center;

    return MyTable.horizontal(
      [
        mIcon is IconData
            ? MyIcon.icon(mIcon, size: mIconSize)
            : MyIcon.svg(mIcon, size: mIconSize),
        Expanded(
          child: StreamBuilder<String>(
            initialData: "",
            stream: dateStream,
            builder: (context, snapshot) {
              String text = snapshot?.data?.isNotEmpty == true
                  ? snapshot.data
                  : "core:widgets:date_picker_select_date".translate();

              String dateValue = snapshot?.data ?? "";
              return MyText(
                text,
                style: mTextStyle,
                padding: mTextPadding,
                onTap: () => openSelectDateDialog(context, dateValue, dateSelectedAction),
              );
            },
          ),
        )
      ],
      mainAxisAlignment: mMainAxisAlignment,
      crossAxisAlignment: mCrossAxisAlignment,
      padding: mPadding,
    );
  }
}

class DateRangePickerWidget extends StatelessWidget {
  IconData icon;
  double iconsSize;
  TextStyle textStyle;
  Stream<String> dateStream;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry textPadding;
  Function(DateTimeRange) dateSelectedAction;
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;

  DateRangePickerWidget(
    this.dateStream, {
    this.icon,
    this.padding,
    this.iconsSize,
    this.textStyle,
    this.textPadding,
    this.dateSelectedAction,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    dynamic mIcon = icon != null ? icon : Icons.date_range;
    double mIconSize = iconsSize != null && iconsSize != 0 ? iconsSize : 20;
    TextStyle mTextStyle = textStyle != null ? textStyle : TS_Caption(R.colors.app_color, true);
    EdgeInsetsGeometry mPadding = padding != null ? padding : EdgeInsets.only(top: 12);
    EdgeInsetsGeometry mTextPadding = textPadding != null ? textPadding : EdgeInsets.only(left: 8);

    MainAxisAlignment mMainAxisAlignment =
        mainAxisAlignment != null ? mainAxisAlignment : MainAxisAlignment.center;
    CrossAxisAlignment mCrossAxisAlignment =
        crossAxisAlignment != null ? crossAxisAlignment : CrossAxisAlignment.center;

    return MyTable.horizontal(
      [
        mIcon is IconData
            ? MyIcon.icon(mIcon, size: mIconSize)
            : MyIcon.svg(mIcon, size: mIconSize),
        Expanded(
          child: StreamBuilder<String>(
            initialData: "",
            stream: dateStream,
            builder: (context, snapshot) {
              String text = snapshot?.data?.isNotEmpty == true
                  ? snapshot.data
                  : "core:widgets:date_picker:select_date_range_hint".translate();

              String dateValue = snapshot?.data ?? "";
              return MyText(
                text,
                style: mTextStyle,
                padding: mTextPadding,
                onTap: () => openSelectRangeDateDialog(context, dateValue, dateSelectedAction),
              );
            },
          ),
        )
      ],
      mainAxisAlignment: mMainAxisAlignment,
      crossAxisAlignment: mCrossAxisAlignment,
      padding: mPadding,
    );
  }
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

void openSelectDateDialog(BuildContext context, String date, Function(DateTime) selectedAction) {
  DateTime consignDate = date?.isNotEmpty == true ? DateUtil.parse(date) : DateTime.now();
  showDatePicker(
          context: context,
          initialDate: consignDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100))
      .then((value) => {selectedAction.call(value)});
}
