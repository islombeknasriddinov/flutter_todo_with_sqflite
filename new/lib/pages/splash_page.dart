import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uzphariminfo/utils/colors.dart';
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
    super.initState();
    loadDates();
  }

  void reloadDates(){
    viewModel.checkInternetConnection();
  }

  void loadDates() {
    viewModel.checkStatus();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.checkInternetConnectionCansel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.saveLanguage(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: BColors.backgroundColor,
        body: ChangeNotifierProvider(
          create: (context) => viewModel,
          child: Consumer<SplashViewModel>(
            builder: (ctx, model, index) => Stack(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Lottie.asset("assets/animations/intro_anim.json"),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
                viewModel.isConnected
                    ? AlertDialog(
                  title: Text('dialog_title', textAlign: TextAlign.start, style: TextStyle(fontSize: 17),).tr(),
                  content: Text('dialog_context', textAlign: TextAlign.start, style: TextStyle(fontSize: 15)).tr(),
                  actions: [
                    TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Text('dialog_cancel').tr()),
                    TextButton(
                        onPressed: () {
                          loadDates();
                          Navigator.of(context).pop();
                        },
                        child: Text('dialog_again').tr()),
                  ],
                )
                    : Container()
              ],
            ),
          ),
        )
    );
  }
}
