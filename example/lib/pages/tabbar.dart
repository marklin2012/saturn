import 'package:example/pages/tabbar_badge.dart';
import 'package:example/pages/tabbar_basic.dart';
import 'package:example/pages/tabbar_other.dart';
import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class TabbarPage extends StatefulWidget {
  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabbar'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            STButton(
              text: '基础样式',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TabbarBasicPage()));
              },
            ),
            SizedBox(height: 20),
            STButton(
              text: '其他样式',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TabbarOtherPage()));
              },
            ),
            SizedBox(height: 20),
            STButton(
              text: '微标样式',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TabbarBadgePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
