// 在Web平台上需要兼容鼠标移入事件
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saturn/utils/include.dart';

// ignore: must_be_immutable
class STMouseRegion extends StatelessWidget {
  final Widget? child;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final Function(PointerHoverEvent)? onHover;

  STMouseRegion({
    Key? key,
    this.child,
    this.onEnter,
    this.onExit,
    this.onHover,
  }) : super(key: key);

  bool _onhover = false;

  @override
  Widget build(BuildContext context) {
    if (getIsWeb()) {
      return MouseRegion(
        key: key,
        cursor: SystemMouseCursors.click, // 鼠标切换成手指
        onEnter: onEnter,
        onExit: (PointerExitEvent event) {
          _onhover = false;
          if (onExit == null) return;
          onExit!(event);
        },
        onHover: (PointerHoverEvent event) {
          if (_onhover) return;
          if (onHover == null) return;
          _onhover = true;
          onHover!(event);
        },
        child: child,
      );
    }
    return child!;
  }
}
