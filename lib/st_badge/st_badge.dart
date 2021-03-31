import 'package:flutter/material.dart';
import 'package:saturn/st_badge/badge_positoned.dart';

const Color _defaultBgColor = Color(0xFFFF4141);
const double _maxHeight = 16.0;
const double _dotWidth = 10.0;
const double _badgefontSize = 12.0;

class STBadge extends StatelessWidget {
  final Widget child; // 与其他Widget配合使用,可空，空即为单独使用
  final String content; // 自定义的内容
  final String value; // 真实的数值
  final int maxNumber; // 自定义的最大值
  final Color backgroundColor; // 自定义的颜色
  final bool dot; // 是否小红点
  final STBadgePosition position; // 定位
  final Padding padding;

  const STBadge({
    Key key,
    this.child,
    this.content,
    this.value,
    this.maxNumber = 99,
    this.backgroundColor = _defaultBgColor,
    this.dot = false,
    this.position,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dot || child == null) {
      return _getBadget();
    } else {
      return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          child,
          STBadgePositioned(
            position: position ?? STBadgePosition.topEnd(),
            child: _getBadget(),
          ),
        ],
      );
    }
  }

  Widget _getBadget() {
    if (dot) {
      return Container(
        width: _dotWidth,
        height: _dotWidth,
        decoration: BoxDecoration(
          color: _defaultBgColor,
          borderRadius: BorderRadius.circular(_dotWidth / 2),
        ),
      );
    } else {
      return Container(
        height: _maxHeight,
        constraints: const BoxConstraints(
          minWidth: _maxHeight,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(_maxHeight / 2),
        ),
        padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
        child: Text(
          _getValue(),
          style: const TextStyle(color: Colors.white, fontSize: _badgefontSize),
        ),
      );
    }
  }

  String _getValue() {
    if (value != null && int.tryParse(value) != null) {
      final _intValue = int.parse(value);
      if (_intValue > maxNumber) {
        return '$maxNumber+';
      } else {
        return '$_intValue';
      }
    } else if (content != null) {
      return content;
    } else {
      return value;
    }
  }
}
