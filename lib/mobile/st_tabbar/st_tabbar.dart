import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/mobile/st_tabbar/st_bottom_navigation_bar.dart';

class STTabbar extends StatefulWidget {
  final List<Widget>? pages;
  final Color selectColor;
  final Color? unSelectColor;
  final Color? backgroundColor;
  final BottomNavigationBarType? type;
  final List<STBottomNavigationBarItem>? items;
  final double? selectedFontSize;
  final double? unselectedFontSize;
  final FontWeight? selectedFontWeight;
  final FontWeight? unselectedFontWeight;

  const STTabbar({
    Key? key,
    this.type,
    this.selectColor = STColor.firRankBlue,
    this.unSelectColor,
    this.backgroundColor,
    this.pages,
    this.items,
    this.selectedFontSize,
    this.unselectedFontSize,
    this.selectedFontWeight,
    this.unselectedFontWeight,
  }) : super(key: key);

  @override
  _STTabbarState createState() => _STTabbarState();
}

class _STTabbarState extends State<STTabbar> {
  int _curentIndex = 0;
  List<Widget>? _pages;
  late List<STBottomNavigationBarItem> _items;

  @override
  void initState() {
    super.initState();
    _pages = widget.pages;
    _items = widget.items ??
        [
          const STBottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          const STBottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'history',
          ),
          const STBottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: 'clock',
          ),
        ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Theme.of(context).brightness,
        primaryColor: Theme.of(context).primaryColor,
        accentColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        body: _pages![_curentIndex],
        bottomNavigationBar: STBottomNavigationBar(
          type: widget.type ?? BottomNavigationBarType.fixed,
          iconSize: 28,
          selectedFontSize: widget.selectedFontSize ?? 11,
          unselectedFontSize: widget.unselectedFontSize ?? 11,
          selectedItemColor: widget.selectColor,
          unselectedItemColor: widget.unSelectColor,
          selectedLabelStyle: TextStyle(
            fontSize: widget.selectedFontSize ?? 11,
            fontWeight: widget.selectedFontWeight ?? FontWeight.w400,
            color: widget.selectColor,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: widget.unselectedFontSize ?? 11,
            fontWeight: widget.unselectedFontWeight ?? FontWeight.w400,
            color: widget.unSelectColor,
          ),
          backgroundColor:
              widget.backgroundColor ?? Theme.of(context).backgroundColor,
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

class STBottomNavigationBarItem {
  /// Creates an item that is used with [BottomNavigationBar.items].
  ///
  /// The argument [icon] should not be null and the argument [label] should not be null when used in a Material Design's [BottomNavigationBar].
  const STBottomNavigationBarItem({
    this.icon,
    @Deprecated(
      'Use "label" instead, as it allows for an improved text-scaling experience. '
      'This feature was deprecated after v1.19.0.',
    )
        this.title,
    this.label,
    Widget? activeIcon,
    this.backgroundColor,
    this.tooltip,
  }) : activeIcon = activeIcon ?? icon;

  /// The icon of the item.
  ///
  /// Typically the icon is an [Icon] or an [ImageIcon] widget. If another type
  /// of widget is provided then it should configure itself to match the current
  /// [IconTheme] size and color.
  ///
  /// If [activeIcon] is provided, this will only be displayed when the item is
  /// not selected.
  ///
  /// To make the bottom navigation bar more accessible, consider choosing an
  /// icon with a stroked and filled version, such as [Icons.cloud] and
  /// [Icons.cloud_queue]. [icon] should be set to the stroked version and
  /// [activeIcon] to the filled version.
  ///
  /// If a particular icon doesn't have a stroked or filled version, then don't
  /// pair unrelated icons. Instead, make sure to use a
  /// [BottomNavigationBarType.shifting].
  final Widget? icon;

  final Widget? title;

  /// An alternative icon displayed when this bottom navigation item is
  /// selected.
  ///
  /// If this icon is not provided, the bottom navigation bar will display
  /// [icon] in either state.
  ///
  /// See also:
  ///
  ///  * [BottomNavigationBarItem.icon], for a description of how to pair icons.
  final Widget? activeIcon;

  /// The text label for this [BottomNavigationBarItem].
  ///
  /// This will be used to create a [Text] widget to put in the bottom navigation bar.
  final String? label;

  /// The color of the background radial animation for material [BottomNavigationBar].
  ///
  /// If the navigation bar's type is [BottomNavigationBarType.shifting], then
  /// the entire bar is flooded with the [backgroundColor] when this item is
  /// tapped. This will override [BottomNavigationBar.backgroundColor].
  ///
  /// Not used for [CupertinoTabBar]. Control the invariant bar color directly
  /// via [CupertinoTabBar.backgroundColor].
  ///
  /// See also:
  ///
  ///  * [Icon.color] and [ImageIcon.color] to control the foreground color of
  ///    the icons themselves.
  final Color? backgroundColor;

  /// The text to display in the tooltip for this [BottomNavigationBarItem], when
  /// the user long presses the item.
  ///
  /// The [Tooltip] will only appear on an item in a Material design [BottomNavigationBar], and
  /// when the string is not empty.
  ///
  /// Defaults to null, in which case the [label] text will be used.
  final String? tooltip;
}
