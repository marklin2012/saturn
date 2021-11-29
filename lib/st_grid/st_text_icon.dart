import 'package:flutter/material.dart';

enum STTextDirection { textLeft, textTop, textRight, textBottom }

class STTextAndIcon extends StatelessWidget {
  const STTextAndIcon({
    Key key,
    @required this.text,
    @required this.icon,
    this.textDirection = STTextDirection.textBottom,
    this.space = 8.0,
    this.padding,
    this.decoration,
  }) : super(key: key);

  final Widget text;

  final Widget icon;

  final STTextDirection textDirection;

  final double space;

  final EdgeInsetsGeometry padding;

  final Decoration decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      decoration: decoration,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    List<Widget> _list = [];
    switch (textDirection) {
      case STTextDirection.textLeft:
        _list = [text, SizedBox(width: space), icon];
        break;
      case STTextDirection.textRight:
        _list = [icon, SizedBox(width: space), text];
        break;
      case STTextDirection.textTop:
        _list = [text, SizedBox(height: space), icon];
        break;
      default:
        _list = [icon, SizedBox(height: space), text];
        break;
    }
    if (textDirection == STTextDirection.textLeft ||
        textDirection == STTextDirection.textRight) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: _list,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: _list,
      );
    }
  }
}
