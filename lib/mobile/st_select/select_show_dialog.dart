import 'package:flutter/material.dart';

const _defaultContentHeight = 262.0;

class ShowSelectDialog extends Dialog {
  final Widget? menu;
  final Offset? offset; // dx代表左右的间距，dy代表距离顶部的偏移量
  final double height; // 内部的高度
  final bool limitHorizontal;

  const ShowSelectDialog({
    this.height = _defaultContentHeight,
    Key? key,
    this.menu,
    this.offset,
    this.limitHorizontal = true,
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
            left: offset!.dx,
            right: limitHorizontal ? offset!.dx : null,
            top: offset!.dy,
            height: height,
            child: menu!,
          ),
        ],
      ),
    );
  }
}
