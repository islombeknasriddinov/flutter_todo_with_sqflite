import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:uzphariminfo/utils/colors.dart';
import 'package:uzphariminfo/viewmodel/about_view_model.dart';

class AboutPage extends StatefulWidget {
  static final String id = "about_page";

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  AboutViewModel viewModel = AboutViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
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
      ),
      backgroundColor: BColors.backgroundColor,
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<AboutViewModel>(
          builder: (ctx, model, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Column(children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 26),
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/images/ic_logo_w.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: BColors.whiteColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.1, color: Colors.black))),
                        child: TextButton(
                            onPressed: () {
                              viewModel.openLocation();
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.home_outlined,
                                    color: BColors.backgroundColor,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "about_location",
                                          style: TextStyle(
                                              color: BColors.about_TextColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300),
                                        ).tr(),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'about_address',
                                          style: TextStyle(
                                              color: BColors.about_TextColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ).tr(),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.1, color: Colors.black))),
                        child: TextButton(
                          onPressed: () {
                            viewModel.openPhone();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.call_outlined,
                                  color: BColors.backgroundColor,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "+998 (71) 242-48-93",
                                        style: TextStyle(
                                            color: BColors.about_TextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'about_phone',
                                        style: TextStyle(
                                            color: BColors.about_TextColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ).tr(),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.1, color: Colors.black))),
                        child: TextButton(
                          onPressed: () {},
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.fax_outlined,
                                  color: BColors.backgroundColor,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "+998 (71) 242-48-25",
                                        style: TextStyle(
                                            color: BColors.about_TextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'about_fax',
                                        style: TextStyle(
                                            color: BColors.about_TextColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ).tr(),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.1, color: Colors.black))),
                        child: TextButton(
                            onPressed: () {
                              viewModel.openBrowserUrl();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.web,
                                    color: BColors.backgroundColor,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "https://www.uzpharm-control.uz",
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.9),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'about_website',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.9),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ).tr(),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            )),
                      ),
                      TextButton(
                          onPressed: () {
                            viewModel.openEmail();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_post_office_outlined,
                                  color: BColors.appBarColor,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "farmkomitet@minzdrav.uz",
                                        style: TextStyle(
                                            color: BColors.about_TextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'about_email',
                                        style: TextStyle(
                                            color: BColors.about_TextColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ).tr(),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 45,
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
