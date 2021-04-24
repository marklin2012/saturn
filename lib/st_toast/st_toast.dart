import 'dart:async';

import 'package:flutter/material.dart';

import 'common.dart';

class STToast extends StatefulWidget {
  final String message;
  final String icon;
  final bool isIconUpText;
  final bool haveIconAnimation;
  final STToastLocationType locationType;
  final bool closable;
  final bool autoClose;
  final int disappearTime;

  const STToast(
      {Key key,
      this.message,
      this.icon,
      this.isIconUpText,
      this.haveIconAnimation,
      this.locationType,
      this.closable,
      this.autoClose,
      this.disappearTime})
      : super(key: key);

  static void show(
      {@required BuildContext context,
      @required String message,
      String icon,
      bool isIconUpText = false,
      STToastLocationType locationType = STToastLocationType.center,
      bool closable = false,
      bool autoClose = true,
      int disappearTime = STToastConstant.defaultDisappearTime}) {
    showDialog(
        context: context,
        barrierDismissible: closable,
        barrierColor: Colors.transparent,
        builder: (context) {
          final toast = STToast(
            message: message,
            icon: icon,
            isIconUpText: isIconUpText,
            haveIconAnimation: false,
            locationType: locationType,
            closable: closable,
            autoClose: autoClose,
            disappearTime: disappearTime,
          );
          return toast;
        });
  }

  static void showLoading({
    @required BuildContext context,
    String icon,
    STToastLocationType locationType = STToastLocationType.center,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          final toast = STToast(
            message: "",
            icon: icon,
            isIconUpText: false,
            haveIconAnimation: true,
            locationType: locationType,
            closable: false,
            autoClose: false,
            disappearTime: STToastConstant.defaultDisappearTime,
          );
          return toast;
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
  Timer timer;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    if (widget.autoClose) {
      timer = Timer(Duration(milliseconds: widget.disappearTime * 1000), () {
        STToast.hide(context);
      });
    }

    if (!isNullOrEmpty(widget.icon) && widget.haveIconAnimation) {
      controller = AnimationController(
          duration: const Duration(seconds: 2), vsync: this);
      controller.addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            controller.reset();
            controller.forward();
          }
        },
      );
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerMaxWidth =
        screenWidth * STToastConstant.maxWidthPercent;

    Text messageWidget;
    if (!isNullOrEmpty(widget.message)) {
      messageWidget = Text(
        widget.message,
        softWrap: true,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: STToastConstant.messageFontSize,
            decoration: TextDecoration.none),
      );
    }

    Widget imageWidget;
    if (!isNullOrEmpty(widget.icon)) {
      final Image innerImageWidget =
          Image.asset(widget.icon, fit: BoxFit.fitWidth);
      if (widget.haveIconAnimation) {
        imageWidget =
            RotationTransition(turns: controller, child: innerImageWidget);
      } else {
        imageWidget = innerImageWidget;
      }
    }

    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(STToastConstant.cornerRadius),
      color: STToastConstant.defaultBackgroundColor,
    );

    Widget returnWidget;
    if (isNullOrEmpty(widget.icon)) {
      returnWidget = Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: messageWidget);
    } else {
      if (isNullOrEmpty(widget.message)) {
        returnWidget = Padding(
            padding: const EdgeInsets.fromLTRB(27, 27, 27, 27),
            child: imageWidget);
      } else {
        if (widget.isIconUpText) {
          returnWidget = Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                imageWidget,
                const SizedBox(height: 10),
                messageWidget
              ],
            ),
          );
        } else {
          returnWidget = Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                imageWidget,
                const SizedBox(width: 10),
                Expanded(child: messageWidget)
              ],
            ),
          );
        }
      }
    }
    AlignmentGeometry alignment;
    switch (widget.locationType) {
      case STToastLocationType.top:
        alignment = Alignment.topCenter;
        break;
      case STToastLocationType.center:
        alignment = Alignment.center;
        break;
      case STToastLocationType.bottom:
        alignment = Alignment.bottomCenter;
        break;
    }
    return SafeArea(
      child: Align(
        alignment: alignment,
        child: Container(
            constraints: BoxConstraints(maxWidth: containerMaxWidth),
            decoration: boxDecoration,
            child: returnWidget),
      ),
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
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
