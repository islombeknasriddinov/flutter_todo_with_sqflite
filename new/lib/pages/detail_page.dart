
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:uzphariminfo/model/detail_model.dart';
import 'package:uzphariminfo/utils/prefs.dart';
import 'package:uzphariminfo/viewmodel/detail_view_model.dart';
import '../utils/colors.dart';
import '../views/item_of_detail.dart';

class DetailPage extends StatefulWidget {
  static final String id = "detail_page";
  String? query;
  String? type;
  String? name;

  DetailPage({this.query, this.type, this.name});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailViewModel viewModel = DetailViewModel();
  String langCode = "";

  reloadDates() async{
    langCode = await Prefs.loadFromPrefs(Prefs.KEY_LANGUAGECODE);
    viewModel.checkInternetConnection(widget.query!, langCode, widget.type!);
  }


  @override
  void initState() {
    reloadDates();
    super.initState();
    loadDates();
  }

  @override
  dispose() {
    super.dispose();
    viewModel.checkInternetConnectionCansel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<DetailViewModel>(
        builder: (ctx, model, index) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: viewModel.isConnected != true ? AppBar(
            title: Text(
              widget.name!,
              style: TextStyle(fontSize: 20),
            ),
            elevation: 0,
            leading: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: BColors.backIconColor),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pop(context);
                    },
                  ),
                )),
            backgroundColor: BColors.backgroundColor,
          ) : null,
          body: Stack(
            children: [
              GroupedListView<Data, String>(
                  elements: viewModel.data,
                  groupBy: (element) => element.producerGenName,
                  groupComparator: (v1, v2) => v2.compareTo(v1),
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Container(
                    color: BColors.backgroundColor,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: Text(
                        value,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  itemBuilder: (ctx, element) {
                    return itemOfDetail(element, context);
                  }),
              viewModel.isLoading
                  ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : const SizedBox.shrink(),

              viewModel.isConnected
                  ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height:  MediaQuery.of(context).size.height,
                  color: BColors.backgroundColor,
                  child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Icon(Icons.warning_amber_rounded, color: Colors.white70, size: 100,),
                            SizedBox(height: 10,),
                            Text('dialog_title', style: TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center,).tr(),
                            SizedBox(height: 10,),
                            Text('dialog_context', style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.center,).tr(),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.white
                          ),
                          onPressed: () {
                            reloadDates();
                          },
                          child: Text(
                            'dialog_again',
                            style: TextStyle(color: Colors.black54, fontSize: 16),
                          ).tr(),
                        ),
                      )
                    ],
                  ),
                  )
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void loadDates() async {
    langCode = await Prefs.loadFromPrefs(Prefs.KEY_LANGUAGECODE);
    viewModel.checkStatus(widget.query!,langCode, widget.type!);
  }

}
