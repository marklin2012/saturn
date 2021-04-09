import 'package:flutter/material.dart';
import 'common.dart';

class STLoading extends StatefulWidget {
  final String icon;
  final String gifIcon;
  final String text;
  final Color textColor; // 文字颜色
  final bool showDefaultIcon; //show default icon 只有在icon 和 gificon都为空时，设置才有效
  final bool iconUpperText;

  const STLoading({
    Key key,
    this.icon,
    this.gifIcon,
    this.text,
    this.textColor,
    this.showDefaultIcon,
    this.iconUpperText,
  }) : super(key: key);

  @override
  _STLoadingState createState() => _STLoadingState();
}

class _STLoadingState extends State<STLoading>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

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

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget returnWidget;

    Color curThemeColor;
    if (widget.textColor == null) {
      curThemeColor = Colors.black;
    } else {
      curThemeColor = widget.textColor;
    }

    Text textWidget;
    if (!isNullOrEmpty(widget.text)) {
      textWidget = Text(widget.text,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: curThemeColor,
              fontSize: STLoadingConstant.textFontSize,
              decoration: TextDecoration.none));
    }

    Widget imageWidget;
    if (!isNullOrEmpty(widget.icon)) {
      imageWidget = RotationTransition(
          turns: controller,
          child: Image.asset(widget.icon,
              width: STLoadingConstant.iconWidth,
              height: STLoadingConstant.iconWidth,
              fit: BoxFit.contain));
    } else {
      if (!isNullOrEmpty(widget.gifIcon)) {
        imageWidget = Image.asset(widget.gifIcon,
            width: STLoadingConstant.iconWidth,
            height: STLoadingConstant.iconWidth,
            fit: BoxFit.contain);
      } else {
        imageWidget = RotationTransition(
            turns: controller,
            child: Icon(
              Icons.autorenew,
              color: curThemeColor,
            ));
      }
    }

    if (isNullOrEmpty(widget.icon) && isNullOrEmpty(widget.gifIcon)) {
      if (!isNullOrEmpty(widget.text)) {
        if (widget.showDefaultIcon) {
          returnWidget =
              Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            imageWidget,
            const SizedBox(width: 5),
            textWidget,
          ]);
        } else {
          returnWidget = textWidget;
        }
      } else {
        if (widget.showDefaultIcon) {
          returnWidget = imageWidget;
        }
      }
    } else {
      if (isNullOrEmpty(widget.text)) {
        returnWidget = imageWidget;
      } else {
        if (widget.iconUpperText == true) {
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
      }
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
