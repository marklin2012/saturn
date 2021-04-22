import 'package:flutter/material.dart';

class ShowSelectDialog extends Dialog {
  final Widget menu;
  final Offset offset; // dx代表左右的间距，dy代表距离顶部的偏移量
  final double height;

  const ShowSelectDialog({
    this.height,
    Key key,
    this.menu,
    this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            left: offset.dx,
            right: offset.dx,
            top: offset.dy,
            height: height,
            child: menu,
          ),
        ],
      ),
    );
  }
}
