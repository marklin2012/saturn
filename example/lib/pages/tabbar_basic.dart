import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class TabbarBasicPage extends StatefulWidget {
  const TabbarBasicPage({Key key}) : super(key: key);

  @override
  _TabbarBasicPageState createState() => _TabbarBasicPageState();
}

class _TabbarBasicPageState extends State<TabbarBasicPage> {
  @override
  Widget build(BuildContext context) {
    return STTabbar(pages: [
      Container(color: Colors.black),
      Container(color: Colors.yellow),
      Container(color: Colors.red),
    ]);
  }
}
