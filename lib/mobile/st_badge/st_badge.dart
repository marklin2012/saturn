import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_badge/badge_positoned.dart';

class STBadge extends StatelessWidget {
  final Widget? child; // 与其他Widget配合使用,可空，空即为单独使用
  final String? value; // 真实的数值
  final int maxNumber; // 自定义的最大值
  final Color backgroundColor; // 自定义的颜色
  final bool dot; // 是否小红点
  final STBadgePosition? position; // 显示在的位置
  final EdgeInsets padding; // 数字提示的内嵌

  const STBadge({
    Key? key,
    this.child,
    this.value,
    this.maxNumber = 99,
    this.backgroundColor = _defaultBackgroundColor,
    this.dot = false,
    this.position,
    this.padding = _defaultPadding,
  }) : super(key: key);

  static const _defaultBackgroundColor = Color(0xFFFF4141);
  static const _minWidth = 16.0;
  static const _dotWidth = 10.0;
  static const _badgefontSize = 12.0;
  static const _defaultStyle = TextStyle(
    color: Colors.white,
    fontSize: _badgefontSize,
    fontWeight: FontWeight.w400,
  );
  static const _defaultPadding = EdgeInsets.symmetric(horizontal: 4);

  @override
  Widget build(BuildContext context) {
    if (dot && child == null) {
      return _getDot();
    } else if (child == null) {
      return _getBadget(value);
    } else {
      return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          child!,
          STBadgePositioned(
            position: position ?? STBadgePosition.topEnd(),
            child: _getBadget(value),
          ),
        ],
      );
    }
  }

  Widget _getDot() {
    return Container(
      width: _dotWidth,
      height: _dotWidth,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _getBadget(String? value) {
    if (dot) {
      return _getDot();
    } else {
      String? _value = value;
      if (_value != null && (int.tryParse(_value) ?? 0) > 0) {
        _value = _getValue();
      } else {
        _value = '0';
      }
      return Container(
        constraints: const BoxConstraints(
          minWidth: _minWidth,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(_minWidth / 2),
        ),
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _value!,
              style: _defaultStyle,
            )
          ],
        ),
      );
    }
  }

  String? _getValue() {
    if (value != null) {
      final _intValue = int.tryParse(value!) ?? 0;
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
