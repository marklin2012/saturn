import 'dart:io';
import 'package:flutter/material.dart';

// 判断是否在Web上，Web上需要计算本身的高度
bool getIsWeb() {
  var kisWeb = false;
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      kisWeb = false;
    } else {
      kisWeb = true;
    }
  } catch (e) {
    kisWeb = true;
  }
  return kisWeb;
}

// 在Web平台上需要兼容鼠标移入事件
class STMouseRegion extends StatelessWidget {
  final Widget child;
  final Function onEnter;
  final Function onExit;
  final Function onHover;

  const STMouseRegion({
    Key key,
    this.child,
    this.onEnter,
    this.onExit,
    this.onHover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (getIsWeb()) {
      return MouseRegion(
        onEnter: onEnter,
        onExit: onExit,
        onHover: onHover,
        child: child,
      );
    }
    return child;
  }
}
