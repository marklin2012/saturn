import 'package:flutter/material.dart';

class STTooltip extends StatelessWidget {
  final Color backgroundColor; // 提示框的背景颜色
  final double? height; // 提示框的高度
  final String message;
  final Widget child;
  final EdgeInsets padding; // 提示框的内嵌边距
  final EdgeInsets margin; // 提示框的外边距
  final double? verticalOffset;
  final TextStyle textStyle;

  const STTooltip({
    Key? key,
    this.backgroundColor = const Color.fromRGBO(0, 0, 0, 0.8),
    this.height,
    required this.message,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 12),
    this.margin = const EdgeInsets.symmetric(horizontal: 60.0),
    this.verticalOffset,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 16.0),
  })  : assert(message != null),
        assert(child != null),
        super(key: key);

  static const _defaultBorderRadius = BorderRadius.all(Radius.circular(8.0));

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      height: height,
      padding: padding,
      margin: margin,
      verticalOffset: verticalOffset,
      textStyle: textStyle,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: _defaultBorderRadius,
      ),
      child: child,
    );
  }
}
