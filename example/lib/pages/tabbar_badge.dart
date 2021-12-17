import 'package:flutter/material.dart';
import 'package:saturn/saturn.dart';

class TabbarBadgePage extends StatefulWidget {
  const TabbarBadgePage({Key key}) : super(key: key);

  @override
  _TabbarBadgePageState createState() => _TabbarBadgePageState();
}

class _TabbarBadgePageState extends State<TabbarBadgePage> {
  @override
  Widget build(BuildContext context) {
    return STTabbar(
      pages: [
        Container(color: Colors.black),
        Container(color: Colors.yellow),
        Container(color: Colors.red),
      ],
      items: [
        const STBottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'home',
            style: TextStyle(fontSize: 12),
          ),
        ),
        STBottomNavigationBarItem(
          title: STBadge(dot: true, child: Text('history')),
        ),
        const STBottomNavigationBarItem(
          icon: STBadge(
            value: '100',
            child: Icon(Icons.lock_clock),
          ),
        ),
      ],
      selectedFontSize: 18,
      unselectedFontSize: 18,
      selectedFontWeight: FontWeight.w600,
      unselectedFontWeight: FontWeight.w600,
    );
  }
}
