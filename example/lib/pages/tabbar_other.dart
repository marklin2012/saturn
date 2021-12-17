import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class TabbarOtherPage extends StatefulWidget {
  const TabbarOtherPage({Key key}) : super(key: key);

  @override
  _TabbarOtherPageState createState() => _TabbarOtherPageState();
}

class _TabbarOtherPageState extends State<TabbarOtherPage> {
  @override
  Widget build(BuildContext context) {
    return STTabbar(
      pages: [
        Container(color: Colors.black),
        Container(color: Colors.yellow),
        Container(color: Colors.red),
      ],
      items: [
        const STBottomNavigationBarItem(icon: Icon(Icons.home)),
        const STBottomNavigationBarItem(label: 'history'),
        const STBottomNavigationBarItem(label: 'clock'),
      ],
      selectedFontSize: 18,
      unselectedFontSize: 18,
      selectedFontWeight: FontWeight.w600,
      unselectedFontWeight: FontWeight.w600,
    );
  }
}
