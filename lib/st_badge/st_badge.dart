import 'package:flutter/material.dart';
import 'package:saturn/st_badge/badge_positoned.dart';

class STBadge extends StatelessWidget {
  final Widget child; // 与其他Widget配合使用,可空，空即为单独使用
  final String value; // 真实的数值
  final int maxNumber; // 自定义的最大值
  final Color backgroundColor; // 自定义的颜色
  final bool dot; // 是否小红点
  final STBadgePosition position; // 显示在的位置
  final EdgeInsets padding; // 整个widget的内嵌

  const STBadge({
    Key key,
    this.child,
    this.value,
    this.maxNumber = 99,
    this.backgroundColor = _defaultBackgroundColor,
    this.dot = false,
    this.position,
    this.padding = _defaultPadding,
  }) : super(key: key);

  static const _defaultBackgroundColor = Color(0xFFFF4141);
  static const _maxHeight = 16.0;
  static const _dotWidth = 10.0;
  static const _badgefontSize = 12.0;
  static const _defaultPadding = EdgeInsets.fromLTRB(3, 1, 3, 1);

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
          color: backgroundColor,
          shape: BoxShape.circle,
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
        padding: padding,
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
    } else {
      return value;
    }
  }
}
