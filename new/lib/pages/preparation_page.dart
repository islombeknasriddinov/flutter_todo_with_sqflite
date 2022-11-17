import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:uzphariminfo/model/preparation_model.dart';
import 'package:uzphariminfo/viewmodel/preparation_view_model.dart';
import '../utils/colors.dart';
import '../utils/prefs.dart';
import '../views/view_of_preparation.dart';

class PreparationPage extends StatefulWidget {
  static final String id = "preparation_page";
  String? box_group_id;

  PreparationPage({
    this.box_group_id,
  });

  @override
  State<PreparationPage> createState() => _PreparationPageState();
}

class _PreparationPageState extends State<PreparationPage> {
  PreparationViewModel viewModel = PreparationViewModel();
  String langCode = "";

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

  reloadDates() async{
    langCode = await Prefs.loadFromPrefs(Prefs.KEY_LANGUAGECODE);
    viewModel.checkInternetConnection(widget.box_group_id!, langCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<PreparationViewModel>(
            builder: (ctx, model, index) => Scaffold(
              appBar: viewModel.isConnected != true
                  ?  AppBar(
                titleSpacing: 0,
                elevation: 0,
                backgroundColor: BColors.backgroundColor,
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
              )
                  : null,
              body: Stack(
                children: [
                  Column(
                    children: [
                      viewOfPreparation(viewModel.preparation)!,
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: _buildCarousel(context),
                          ))
                    ],
                  ),
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
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child:  viewModel.isReloading
                                        ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        CupertinoActivityIndicator(
                                            radius: 15.0,
                                            color: CupertinoColors.white
                                        ),
                                      ],
                                    )
                                        : Icon(Icons.warning_amber_rounded, color: Colors.white70, size: 100,),
                                  ),
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
                                  loadDates();
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
            )
        ),
      ),
      )
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 150,
          child: PageView.builder(
            itemCount: viewModel.item.length,
            allowImplicitScrolling: true,
            controller: PageController(viewportFraction: 0.8, initialPage: 2),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(item: viewModel.item[itemIndex]);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem({BuildContext? context, int? carouselIndex, int? itemIndex, AnalogMedicineItem? item}) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(57, 176, 112, 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item!.medicineName.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'manufacturer',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ).tr(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.retailBasePrice.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void loadDates() async {
    langCode = await Prefs.loadFromPrefs(Prefs.KEY_LANGUAGECODE);
    viewModel.checkStatus(widget.box_group_id!, langCode);
  }

}
