import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewModel extends ChangeNotifier {
  void openBrowserUrl() async {
    String url = "https://www.uzpharm-control.uz";
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false, forceWebView: false, enableJavaScript: true);
    }
  }

  void openPhone() async {
    String phone = "+998712424893";
    String url = "tel:$phone";

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void openEmail() async {
    String email = "farmokomitet@minzdrav.uz";
    String url = "mailto:$email";

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void openLocation() async {
    String url = "https://maps.app.goo.gl/9h8r8V7JDWxPJUpy7?g_st=ic";

    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
