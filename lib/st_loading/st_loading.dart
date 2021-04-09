import 'package:flutter/material.dart';
import 'common.dart';

class STLoading extends StatefulWidget {
  final String icon;
  final String gifIcon;
  final String text;
  final Color textColor; // 文字颜色
  final bool showDefaultIcon; //show default icon 只有在icon 和 gificon都为空时，设置才有效
  final bool isIconUpperText; //icon默认在左边
  final bool haveIconAnimation; //icon是否有动画

  const STLoading(
      {Key key,
      this.icon,
      this.gifIcon,
      this.text,
      this.textColor,
      this.showDefaultIcon = false,
      this.isIconUpperText = false,
      this.haveIconAnimation = false})
      : super(key: key);

  @override
  _STLoadingState createState() => _STLoadingState();
}

class _STLoadingState extends State<STLoading>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    if (widget.haveIconAnimation) {
      controller = AnimationController(
          duration: const Duration(seconds: STLoadingConstant.animationTime),
          vsync: this);
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        }
      });
      controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.haveIconAnimation) {
      controller.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget returnWidget;

    Color curTextColor;
    if (widget.textColor == null) {
      curTextColor = Colors.black;
    } else {
      curTextColor = widget.textColor;
    }

    Text textWidget;
    if (!isNullOrEmpty(widget.text)) {
      textWidget = Text(widget.text,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: curTextColor,
              fontSize: STLoadingConstant.textFontSize,
              decoration: TextDecoration.none));
    }

    Widget imageWidget;

    if (isNullOrEmpty(widget.icon) && isNullOrEmpty(widget.gifIcon)) {
      if (widget.showDefaultIcon) {
        imageWidget = Icon(
          Icons.autorenew,
          color: curTextColor,
        );
      }
    } else {
      imageWidget = Image.asset(
          isNullOrEmpty(widget.icon) ? widget.gifIcon : widget.icon,
          width: STLoadingConstant.iconWidth,
          height: STLoadingConstant.iconWidth,
          fit: BoxFit.contain);
    }

    if ((imageWidget != null) && widget.haveIconAnimation) {
      imageWidget = RotationTransition(turns: controller, child: imageWidget);
    }

    if (imageWidget != null) {
      if (textWidget != null) {
        if (widget.isIconUpperText) {
          returnWidget =
              Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: STLoadingConstant.iconTextDistance),
            textWidget,
          ]);
        } else {
          returnWidget = Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: STLoadingConstant.iconTextDistance),
            textWidget
          ]);
        }
      } else {
        returnWidget = imageWidget;
      }
    } else {
      returnWidget = textWidget;
    }

    return Center(child: returnWidget);
  }

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
