import 'package:example/main.dart';
import 'package:example/pages/web_breadcrumb/web_bread_c.dart';
import 'package:example/pages/web_breadcrumb/web_breadcrumb.dart';
import 'package:example/pages/web_breadcrumb/web_routes.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class WebBreadDPage extends StatelessWidget {
  static const routeName = 'BreadCrumbD';
  const WebBreadDPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('D'),
      ),
      body: Center(
        child: Column(
          children: [
            _buildBasic(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBasic(BuildContext context) {
    return Container(
      height: 102,
      color: STColor.thrRankGrey,
      child: STBreadCrumb(
        padding: EdgeInsets.all(40.0),
        items: [
          STBreadCrumbData(
            title: 'Home',
            routeKey: MyHomePage.routeName,
          ),
          STBreadCrumbData(
            title: 'BreadCrumb',
            routeKey: WebBreadCrumbPage.routeName,
            isDropdown: true,
            items: [
              STBreadCrumbData(
                  title: '5th menu', routeKey: WebBread5Page.routeName),
              STBreadCrumbData(
                  title: '6th menu', routeKey: WebBread6Page.routeName),
              STBreadCrumbData(
                  title: '7th menu', routeKey: WebBread7Page.routeName),
            ],
          ),
          STBreadCrumbData(
            title: 'C',
            routeKey: WebBreadCPage.routeName,
          ),
          STBreadCrumbData(
            title: 'D',
            routeKey: WebBreadDPage.routeName,
          ),
        ],
        onChanged: (BreadRouteData data) {
          if (data.untilRoute != null) {
            WebRoutes.pushAndRemove(context, data.newRoute, data.untilRoute);
          } else {
            WebRoutes.popUntil(context, data.newRoute);
          }
        },
      ),
    );
  }
}
