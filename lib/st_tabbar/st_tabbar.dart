import 'package:flutter/material.dart';
import 'package:saturn/st_button/common.dart';

class STTabbar extends StatefulWidget {
  final List<Widget> pages;
  final Color selectColor;
  final Color unSelectColor;
  final Color backgroundColor;
  final BottomNavigationBarType type;
  final List<BottomNavigationBarItem> items;

  const STTabbar({
    Key key,
    this.type,
    this.selectColor = STColor.firRankBlue,
    this.unSelectColor,
    this.backgroundColor,
    this.pages,
    this.items,
  }) : super(key: key);

  @override
  _STTabbarState createState() => _STTabbarState();
}

class _STTabbarState extends State<STTabbar> {
  int _curentIndex = 0;
  List<Widget> _pages;
  List<BottomNavigationBarItem> _items;
  Color _backgroundColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = widget.pages;
    _items = widget.items ??
        [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'history'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock), label: 'clock'),
        ];
  }

  @override
  Widget build(BuildContext context) {
    _backgroundColor = widget.backgroundColor ?? Theme.of(context).primaryColor;
    return MaterialApp(
      theme: ThemeData(
        brightness: Theme.of(context).brightness,
        primaryColor: Theme.of(context).primaryColor,
        accentColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        dividerColor: Theme.of(context).dividerColor,
        appBarTheme: Theme.of(context).appBarTheme,
        textTheme: Theme.of(context).textTheme,
        cardTheme: Theme.of(context).cardTheme,
        chipTheme: Theme.of(context).chipTheme,
        iconTheme: Theme.of(context).iconTheme,
        radioTheme: Theme.of(context).radioTheme,
        bannerTheme: Theme.of(context).bannerTheme,
        buttonTheme: Theme.of(context).buttonTheme,
        dialogTheme: Theme.of(context).dialogTheme,
        sliderTheme: Theme.of(context).sliderTheme,
        switchTheme: Theme.of(context).switchTheme,
        dividerTheme: Theme.of(context).dividerTheme,
      ),
      home: Scaffold(
        body: _pages[_curentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: widget.type ?? BottomNavigationBarType.fixed,
          selectedItemColor: widget.selectColor,
          unselectedItemColor: widget.unSelectColor,
          backgroundColor: _backgroundColor,
          currentIndex: _curentIndex,
          items: _items,
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
