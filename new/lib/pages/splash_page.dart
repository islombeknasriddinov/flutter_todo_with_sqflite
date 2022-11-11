import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uzphariminfo/utils/colors.dart';
import 'package:uzphariminfo/utils/prefs.dart';
import 'package:uzphariminfo/viewmodel/splash_view_model.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  static final String id = "splash_page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashViewModel viewModel = SplashViewModel();

  @override
  void initState() {
    reloadDates();
    viewModel.addListener(viewModelListener);
    super.initState();
  }

  void reloadDates() {
    viewModel.checkInternetConnection();
  }

  void loadDates() {
    viewModel.checkStatus();
  }

  void viewModelListener() {
    if(viewModel.hasData == true){
      hideSplashPage(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.checkInternetConnectionCansel();
    viewModel.removeListener(viewModelListener);
  }

  @override
  Widget build(BuildContext context) {
    viewModel.saveLanguage(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: BColors.backgroundColor,
        body: ChangeNotifierProvider(
          create: (context) => viewModel,
          child: Consumer<SplashViewModel>(builder: (ctx, model, index) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Lottie.asset("assets/animations/intro_anim.json"),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
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
            );
          }),
        ));

  }

  void hideSplashPage(bool hasData){
    if(hasData){
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
  }
}
