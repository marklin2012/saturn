import 'package:example/main.dart';
import 'package:example/pages/web_breadcrumb/web_bread_a.dart';
import 'package:example/pages/web_breadcrumb/web_bread_b.dart';
import 'package:example/pages/web_breadcrumb/web_bread_c.dart';
import 'package:example/pages/web_breadcrumb/web_bread_d.dart';
import 'package:example/pages/web_breadcrumb/web_breadcrumb.dart';
import 'package:flutter/material.dart';

class WebRoutes {
  static final Map<String, WidgetBuilder> routes = {
    MyHomePage.routeName: (context) => MyHomePage(),
    WebBreadCrumbPage.routeName: (context) => WebBreadCrumbPage(),
    WebBreadAPage.routeName: (context) => WebBreadAPage(),
    WebBreadBPage.routeName: (context) => WebBreadBPage(),
    WebBreadCPage.routeName: (context) => WebBreadCPage(),
    WebBreadDPage.routeName: (context) => WebBreadDPage(),
    WebBread5Page.routeName: (context) => WebBread5Page(),
    WebBread6Page.routeName: (context) => WebBread6Page(),
    WebBread7Page.routeName: (context) => WebBread7Page(),
  };

  static Future push(BuildContext context, Widget widget,
      {String routeName}) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => widget,
          settings: RouteSettings(name: routeName),
        ));
  }

  static Future popUntil(BuildContext context, String routeName) async {
    return Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  static Future pushAndRemove(
      BuildContext context, String pushName, String removeName) async {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(pushName, ModalRoute.withName(removeName));
  }
}
