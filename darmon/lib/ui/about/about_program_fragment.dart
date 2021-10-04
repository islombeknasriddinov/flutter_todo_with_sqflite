import 'dart:io';

import 'package:darmon/common/resources.dart';
import 'package:darmon/common/routes/slide_left_route.dart';
import 'package:darmon/common/smartup5x_styles.dart';
import 'package:darmon/ui/about/about_program_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gwslib/gwslib.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutProgramFragment extends ViewModelFragment<AboutProgramViewModel> {
  static final String ROUTE_NAME = "/about_program";

/*  static void open(BuildContext context) {
    Mold.openContent(context, ROUTE_NAME);
  }*/
  static void open(BuildContext context) {
    Navigator.push<dynamic>(context,
        SlideLeftRoute(routeName: ROUTE_NAME, page: Mold.newInstance(AboutProgramFragment())));
  }

  @override
  AboutProgramViewModel onCreateViewModel(BuildContext buildContext) => AboutProgramViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    final safeAreaBottomPadding= MediaQuery.of(context)?.padding?.bottom??0.0;

    return Scaffold(
        backgroundColor: R.colors.appBarColor,
        appBar: AppBar(
          backgroundColor: R.colors.appBarColor,
          elevation: 0,
          leading: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: MyIcon.icon(Icons.arrow_back, color: Colors.white, size: 24),
              ),
              onTap: () {
                Mold.onBackPressed(this);
              },
            ),
          ),
        ),
        body: SafeArea(
          bottom: !Platform.isIOS,
          child: MyTable([
            Align(
              child: Container(
                child: MyIcon.svg(R.asserts.uzpharminfo_logo),
                padding: EdgeInsets.only(top: 40),
              ),
              alignment: Alignment.topCenter,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                  child: MyTable.vertical(
                [
                  buildMenu(R.strings.about.address, R.strings.about.addressText, R.asserts.home,
                      onTapAction: openMap),
                  Divider(height: 0.5, color: Colors.grey),
                  buildMenu(R.strings.about.phone, R.strings.about.phoneText, R.asserts.phone,
                      onTapAction: openPhone),
                  Divider(height: 0.5, color: Colors.grey),
                  buildMenu(R.strings.about.fax, R.strings.about.faxText, R.asserts.fax),
                  Divider(height: 0.5, color: Colors.grey),
                  buildMenu(R.strings.about.site, R.strings.about.siteText, R.asserts.pager,
                      onTapAction: openSite),
                  Divider(height: 0.5, color: Colors.grey),
                  buildMenu(R.strings.about.mail, R.strings.about.mailText, R.asserts.envelope,
                      onTapAction: openMail),
                  SizedBox(height: 50),
                ],
                width: double.infinity,
                background: Colors.white,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    padding: Platform.isIOS?EdgeInsets.only(bottom: safeAreaBottomPadding):null,
              )),
            )
          ]),
        ));
  }

  Widget buildMenu(String title, String subtitle, String icon, {void Function() onTapAction}) {
    return MyTable.horizontal(
      [
        MyIcon.svg(icon, size: 20, padding: EdgeInsets.only(left: 4)),
        MyTable.vertical([
          MyText(title,
              style: TS_Subtitle_1(R.colors.textColor), padding: EdgeInsets.only(left: 16)),
          MyText(subtitle,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontFamily: "SourceSansPro",
                  fontWeight: FontWeight.w300),
              singleLine: true,
              padding: EdgeInsets.only(left: 16)),
        ], flex: 1)
      ],
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      crossAxisAlignment: CrossAxisAlignment.center,
      onTapCallback: onTapAction,
    );
  }

  void openMap() async {
    final url = "https://goo.gl/maps/RhEo6i1HVYUeQjNw7";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openPhone() async {
    String tel = R.strings.about.phone.translate();
    final url = "tel:${tel}";
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch ${url.toString()}';
    }
  }

  void openSite() async {
    final url = R.strings.about.site.translate();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openMail() async {
    String mail = R.strings.about.mail.translate();
    final url = Uri(scheme: "mailto", path: mail);
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch ${url.toString()}';
    }
  }

  void openTelegram() async {
    final url = "https://www.telegram.me/uzpharmagency_bot";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
