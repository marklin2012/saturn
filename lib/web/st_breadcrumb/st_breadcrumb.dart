import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_button/common.dart';
import 'package:saturn/saturn.dart';
import 'package:saturn/web/st_dropdown/st_dropdown_simple.dart';

class STBreadCrumbData {
  final String title;
  final String? routeKey;
  final IconData? icon;
  final bool isDropdown;
  final List<STBreadCrumbData>? items;

  const STBreadCrumbData({
    required this.title,
    this.routeKey,
    this.icon,
    this.isDropdown = false,
    this.items,
  });
}

class BreadRouteData {
  final String newRoute;
  final String? untilRoute;

  const BreadRouteData({
    required this.newRoute,
    this.untilRoute,
  });
}

class STBreadCrumb extends StatefulWidget {
  const STBreadCrumb({
    Key? key,
    required this.items,
    this.height = 22.0,
    this.padding = EdgeInsets.zero,
    this.onChanged,
  }) : super(key: key);

  final double height;
  final EdgeInsets padding;
  final List<STBreadCrumbData> items;
  final Function(BreadRouteData)? onChanged;

  @override
  _STBreadCrumbState createState() => _STBreadCrumbState();
}

class _STBreadCrumbState extends State<STBreadCrumb> {
  late ValueNotifier<Color> _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier(STColor.thrRankFont);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: widget.padding,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        scrollBehavior: STCustomScrollBehavior(),
        slivers: [
          SliverToBoxAdapter(
            child: _buildConent(),
          ),
        ],
      ),
    );
  }

  Widget _buildConent() {
    final List<Widget> _children = [];
    for (int i = 0; i < widget.items.length; i++) {
      var _current = false;
      final _item = widget.items[i];
      if (i == widget.items.length - 1) {
        _current = true;
      }
      final _temp = _item.isDropdown
          ? _buildDropdownItem(_item, current: _current)
          : _buildItem(_item, current: _current);
      _children.add(_temp);
      if (i != widget.items.length - 1) {
        _children.add(_buildSlash());
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _children,
    );
  }

  Widget _buildItem(STBreadCrumbData data, {bool current = false}) {
    final _color = current ? STColor.firRankFont : STColor.thrRankFont;
    return GestureDetector(
      onTap: () {
        _tapAction(data);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (data.icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                data.icon,
                size: 16,
                color: _color,
              ),
            ),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: _color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(STBreadCrumbData data, {bool current = false}) {
    final _color = current ? STColor.firRankFont : STColor.thrRankFont;
    _notifier.value = _color;
    return ValueListenableBuilder(
      valueListenable: _notifier,
      builder: (ctx, Color stausColor, _) {
        return STDropdownSimple(
          items: data.items!.map((e) => e.title).toList(),
          offsetH: 0.0,
          onChanged: (String selected) {
            for (final item in data.items!) {
              if (selected == item.title) {
                _tapAction(
                  item,
                  isDropdown: true,
                  currentData: data,
                );
                return;
              }
            }
          },
          statusChanged: (bool highlight) {
            if (highlight) {
              _notifier.value = STColor.firRankBlue;
            } else {
              _notifier.value = _color;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: stausColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  STIcons.direction_downoutlined,
                  size: 14,
                  color: stausColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSlash() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        '/',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: STColor.thrRankFont,
        ),
      ),
    );
  }

  void _tapAction(
    STBreadCrumbData data, {
    bool? isDropdown,
    STBreadCrumbData? currentData,
  }) {
    final _last = widget.items.last;
    if (data.routeKey == _last.routeKey) return;
    if (widget.onChanged == null) return;
    var _routeData = BreadRouteData(newRoute: data.routeKey ?? data.title);
    if (isDropdown != null && isDropdown && currentData != null) {
      late int i;
      for (int j = 0; j < widget.items.length; j++) {
        final _temp = widget.items[j];
        if (_temp == currentData) {
          i = j - 1;
          break;
        }
      }
      final _untilItem = widget.items[i];
      _routeData = BreadRouteData(
        newRoute: data.routeKey ?? data.title,
        untilRoute: _untilItem.routeKey ?? _untilItem.title,
      );
    }
    STDebounce().start(
      key: 'STBreadCrumbKey',
      func: () {
        widget.onChanged!(_routeData);
      },
      time: 100,
    );
  }
}
