import 'package:darmon/filter/main/filter_collector.dart';
import 'package:darmon/filter/main/ui/filter_widget.dart';
import 'package:flutter/material.dart';

class FilterBottomSheetDialog extends StatefulWidget {
  final FilterProtocol _filterProtocol;
  BuildContext _context;

  FilterBottomSheetDialog._(this._filterProtocol);

  void _setBuildContext(BuildContext context) {
    this._context = context;
  }

  static void show(BuildContext context, FilterProtocol filterProtocol) {
    final f = FilterBottomSheetDialog._(filterProtocol);
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )),
        builder: (_) {
          f._setBuildContext(context);
          return f;
        });
  }

  @override
  _FilterBottomSheetDialogState createState() => _FilterBottomSheetDialogState();
}

class _FilterBottomSheetDialogState extends State<FilterBottomSheetDialog> {
  @override
  Widget build(BuildContext c) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(8),
              topRight: const Radius.circular(8),
            ),
          ),
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          child:
              SingleChildScrollView(child: FilterWidget(widget._context, widget._filterProtocol))),
    );
  }
}
