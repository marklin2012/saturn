import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class TabbarPage extends StatefulWidget {
  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  @override
  Widget build(BuildContext context) {
    return STTabbar(pages: [
      Container(color: Colors.black),
      Container(color: Colors.yellow),
      Container(color: Colors.red),
    ]);
  }
}
