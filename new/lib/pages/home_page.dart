import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:uzphariminfo/pages/about_page.dart';
import 'package:uzphariminfo/pages/search_page.dart';
import 'package:uzphariminfo/utils/colors.dart';
import 'package:uzphariminfo/utils/prefs.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool language = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: BColors.home_appBarColor,
          actions: [
            GestureDetector(
              onTap: () {
                if (language) {
                  language = false;
                  context.locale = Locale('uz', 'UZ');
                  Prefs.saveToPrefs("uz", Prefs.KEY_LANGUAGECODE);
                } else {
                  language = true;
                  context.locale = Locale('ru', 'RU');
                  Prefs.saveToPrefs("ru", Prefs.KEY_LANGUAGECODE);
                }
              },
              child: Container(
                width: 60,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.white)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'language',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ).tr(),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 16,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg_splash.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  'homeText',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ).tr(),
              ),
              Container(
                margin:
                    EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 20),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: BColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextButton(
                  onPressed: () {
                    pushNamed(newPage: SearchPage.id, context: context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Color.fromRGBO(119, 119, 119, 1),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'search',
                          style: TextStyle(
                              color: BColors.hintTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ).tr()
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: TextButton(
                  onPressed: () {
                    slideRightWidget(newPage: AboutPage(), context: context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 15, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color.fromRGBO(0, 0, 0, 0.38),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'about',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.9),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16),
                            ).tr()
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: Color.fromRGBO(0, 0, 0, 0.38),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
