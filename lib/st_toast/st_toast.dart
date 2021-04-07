import 'package:flutter/material.dart';

import 'common.dart';

class STToast extends StatefulWidget {
  final String message;
  final String icon;
  final bool iconUpText;
  final bool isIconAnimation;

  const STToast(
      {Key key, this.message, this.icon, this.iconUpText, this.isIconAnimation})
      : super(key: key);

  static void show(
      {@required BuildContext context,
      String message,
      String icon,
      bool iconUpText = false,
      bool isIconAnimation = false}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          final toast = STToast(
              message: message,
              icon: icon,
              iconUpText: iconUpText,
              isIconAnimation: isIconAnimation);
          return GestureDetector(
            onTap: () {
              STToast.hide(context);
            },
            child: toast,
          );
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  _STToastState createState() => _STToastState();
}

class _STToastState extends State<STToast> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    if (!isNullOrEmpty(widget.icon) && widget.isIconAnimation) {
      controller = AnimationController(
          duration: const Duration(seconds: 2), vsync: this);
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
  Widget build(BuildContext context) {
    Text messageWidget;
    if (!isNullOrEmpty(widget.message)) {
      messageWidget = Text(
        widget.message,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: STToastConstant.messageFontSize,
            decoration: TextDecoration.none),
      );
    }

    Widget imageWidget;
    if (!isNullOrEmpty(widget.icon)) {
      double curIconWidth = (widget.iconUpText || isNullOrEmpty(widget.message))
          ? STToastConstant.iconWidth
          : STToastConstant.smallIconWidth;
      Image innerImageWidget = Image.asset(widget.icon,
          width: curIconWidth, height: curIconWidth, fit: BoxFit.scaleDown);
      if (widget.isIconAnimation) {
        imageWidget =
            RotationTransition(turns: controller, child: innerImageWidget);
      } else {
        imageWidget = innerImageWidget;
      }
    }

    BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(STToastConstant.cornerRadius),
      color: STToastConstant.defaultBackgroundColor,
    );

    Widget returnWidget;
    if (isNullOrEmpty(widget.icon)) {
      returnWidget = Container(
          width: STToastConstant.textDefaultWidth,
          decoration: boxDecoration,
          child: Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: messageWidget));
    } else {
      if (isNullOrEmpty(widget.message)) {
        returnWidget = Container(
            width: STToastConstant.iconDefaultWidth,
            height: STToastConstant.iconDefaultWidth,
            decoration: boxDecoration,
            child: Padding(
                padding: EdgeInsets.fromLTRB(27, 27, 27, 27),
                child: imageWidget));
      } else {
        if (widget.iconUpText) {
          returnWidget = Container(
            width: STToastConstant.iconUpTextDefaultWidth,
            decoration: boxDecoration,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [imageWidget, SizedBox(height: 10), messageWidget],
              ),
            ),
          );
        } else {
          returnWidget = Container(
            width: STToastConstant.iconLeftTextDefaultWidth,
            decoration: boxDecoration,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [imageWidget, SizedBox(width: 10), messageWidget],
              ),
            ),
          );
        }
      }
    }
    return Center(
      child: returnWidget,
    );
  }

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.stop();
    }
    super.dispose();
  }
}
