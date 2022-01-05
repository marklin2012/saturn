import 'package:example/main.dart';
import 'package:example/pages/web_breadcrumb/web_bread_a.dart';
import 'package:example/pages/web_breadcrumb/web_breadcrumb.dart';
import 'package:example/pages/web_breadcrumb/web_routes.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class WebBreadBPage extends StatelessWidget {
  static const routeName = 'BreadCrumbB';
  const WebBreadBPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildBasic(context),
            SizedBox(height: 20),
            _buildHasIcon(context),
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
          ),
          STBreadCrumbData(
            title: 'A',
            routeKey: WebBreadAPage.routeName,
          ),
          STBreadCrumbData(
            title: 'B',
            routeKey: WebBreadBPage.routeName,
          ),
        ],
        onChanged: (BreadRouteData data) {
          WebRoutes.popUntil(context, data.newRoute);
        },
      ),
    );
  }

  Widget _buildHasIcon(BuildContext context) {
    return Container(
      height: 102,
      color: STColor.thrRankGrey,
      child: STBreadCrumb(
        padding: EdgeInsets.all(40.0),
        items: [
          STBreadCrumbData(
            title: 'Home',
            routeKey: MyHomePage.routeName,
            icon: STIcons.commonly_home_outline,
          ),
          STBreadCrumbData(
            title: 'BreadCrumb',
            routeKey: WebBreadCrumbPage.routeName,
            icon: STIcons.label_fire_outline,
          ),
          STBreadCrumbData(
            title: 'A',
            routeKey: WebBreadAPage.routeName,
            icon: STIcons.label_like_outline,
          ),
          STBreadCrumbData(
            title: 'B',
            routeKey: WebBreadBPage.routeName,
            icon: STIcons.label_star_outline,
          ),
        ],
        onChanged: (BreadRouteData data) {
          WebRoutes.popUntil(context, data.newRoute);
        },
      ),
    );
  }
}
