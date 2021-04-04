import 'package:flutter/material.dart';

class STTooltip extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final String message;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double verticalOffset;
  final TextStyle textStyle;

  const STTooltip({
    Key key,
    this.backgroundColor,
    this.height,
    @required this.message,
    this.child,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.textStyle,
  })  : assert(message != null),
        super(key: key);

  static const _defaultMargin = EdgeInsets.symmetric(horizontal: 60.0);
  static const _defaultPadding = EdgeInsets.fromLTRB(20, 12, 20, 12);
  static const _defaultTextStyle =
      TextStyle(color: Colors.white, fontSize: 16.0);
  static const _defaultBackgroundColor = Color.fromRGBO(0, 0, 0, 0.8);
  static const _defaultBorderRadius = BorderRadius.all(Radius.circular(8.0));

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      height: height,
      padding: padding ?? _defaultPadding,
      margin: margin ?? _defaultMargin,
      verticalOffset: verticalOffset,
      textStyle: textStyle ?? _defaultTextStyle,
      decoration: BoxDecoration(
        color: backgroundColor ?? _defaultBackgroundColor,
        borderRadius: _defaultBorderRadius,
      ),
      child: child,
    );
  }
}
