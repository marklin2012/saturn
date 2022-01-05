import 'package:example/main.dart';
import 'package:example/pages/web_breadcrumb/web_bread_a.dart';
import 'package:example/pages/web_breadcrumb/web_bread_d.dart';
import 'package:example/pages/web_breadcrumb/web_breadcrumb.dart';
import 'package:example/pages/web_breadcrumb/web_routes.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class WebBreadCPage extends StatelessWidget {
  static const routeName = 'BreadCrumbC';
  const WebBreadCPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            STButton(
              text: 'next',
              onTap: () {
                WebRoutes.push(context, WebBreadDPage(),
                    routeName: WebBreadDPage.routeName);
              },
            ),
            SizedBox(height: 20),
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

class WebBread5Page extends StatelessWidget {
  static const routeName = 'BreadCrumb5';
  const WebBread5Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5'),
      ),
    );
  }
}

class WebBread6Page extends StatelessWidget {
  static const routeName = 'BreadCrumb6';
  const WebBread6Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('6'),
      ),
    );
  }
}

class WebBread7Page extends StatelessWidget {
  static const routeName = 'BreadCrumb7';
  const WebBread7Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7'),
      ),
    );
  }
}
