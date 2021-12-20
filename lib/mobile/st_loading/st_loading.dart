import 'package:flutter/material.dart';
import 'package:saturn/mobile/st_icons/st_icons.dart';
import 'common.dart';

enum STLoadingIconPosition {
  left,
  top,
}

class STLoading extends StatefulWidget {
  final Widget icon; // 可支持图片或icon
  final String text;
  final bool alwaysLoading;
  final STLoadingIconPosition iconPosition;
  final TextStyle textStyle;
  final int durationMilliseconds; // 毫秒

  const STLoading(
      {Key key,
      this.icon = const Icon(
        STIcons.status_loading,
        color: STLoadingConstant.defaultTextColor,
      ),
      this.text = '加载中...',
      this.alwaysLoading = false,
      this.iconPosition = STLoadingIconPosition.left,
      this.textStyle = const TextStyle(
        color: STLoadingConstant.defaultTextColor,
        fontSize: STLoadingConstant.textFontSize,
        decoration: TextDecoration.none,
      ),
      this.durationMilliseconds = 2000})
      : super(key: key);

  @override
  _STLoadingState createState() => _STLoadingState();
}

class _STLoadingState extends State<STLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: widget.durationMilliseconds),
        vsync: this);
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alwaysLoading) {
      _controller.repeat();
    }

    if (widget.iconPosition == STLoadingIconPosition.left) {
      return Center(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null)
            RotationTransition(turns: _controller, child: widget.icon),
          Text(
            widget.text,
            style: widget.textStyle,
          )
        ],
      ));
    } else {
      return Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null)
            RotationTransition(turns: _controller, child: widget.icon),
          Text(
            widget.text,
            style: widget.textStyle,
          )
        ],
      ));
    }
  }
}
