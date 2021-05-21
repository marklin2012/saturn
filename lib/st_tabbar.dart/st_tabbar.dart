import 'package:flutter/material.dart';

class STTabbar extends StatefulWidget {
  final List<Widget> pages;

  const STTabbar({Key key, this.pages}) : super(key: key);

  @override
  _STTabbarState createState() => _STTabbarState();
}

class _STTabbarState extends State<STTabbar> {
  int _curentIndex = 0;
  List<Widget> _pages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = widget.pages;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_curentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.cyan,
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _curentIndex,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'history'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.lock_clock), label: 'clock'),
          ],
          onTap: (index) {
            setState(() {
              _curentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
