import 'package:example/main.dart';
import 'package:example/pages/web_breadcrumb/web_bread_a.dart';
import 'package:example/pages/web_breadcrumb/web_bread_c.dart';
import 'package:example/pages/web_breadcrumb/web_routes.dart';
import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';

class WebBreadCrumbPage extends StatelessWidget {
  static const routeName = 'BreadCrumb';

  const WebBreadCrumbPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('WebBreadcrumb'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            STButton(
              text: 'next',
              onTap: () {
                WebRoutes.push(context, WebBreadAPage(),
                    routeName: WebBreadAPage.routeName);
              },
            ),
            SizedBox(height: 20),
            _buildBasic(context),
            SizedBox(height: 20),
            _buildHasIcon(context),
            SizedBox(height: 20),
            STButton(
              text: 'DropdownNext',
              onTap: () {
                WebRoutes.push(context, WebBreadCPage(),
                    routeName: WebBreadCPage.routeName);
              },
            ),
            SizedBox(height: 20),
            _buildHasDropdown(context),
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
        ],
        onChanged: (BreadRouteData data) {
          WebRoutes.popUntil(context, data.newRoute);
        },
      ),
    );
  }

  Widget _buildHasDropdown(BuildContext context) {
    return Container(
      height: 200,
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
