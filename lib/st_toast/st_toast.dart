import 'dart:async';

import 'package:flutter/material.dart';

import 'common.dart';

class STToast extends StatefulWidget {
  final String message;
  final String icon;
  final bool isIconUpText;
  final bool haveIconAnimation;
  final STToastLocationType locationType;
  final double topPadding;
  final double bottomPadding;
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
      this.topPadding,
      this.bottomPadding,
      this.closable,
      this.autoClose,
      this.disappearTime})
      : super(key: key);

  static void show(
      {@required BuildContext context,
      String message,
      String icon,
      bool isIconUpText = false,
      bool haveIconAnimation = false,
      STToastLocationType locationType = STToastLocationType.center,
      double topPadding = STToastConstant.defaultTopBottomPadding,
      double bottomPadding = STToastConstant.defaultTopBottomPadding,
      bool closable = false,
      bool autoClose = false,
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
            haveIconAnimation: haveIconAnimation,
            locationType: locationType,
            topPadding: topPadding,
            bottomPadding: bottomPadding,
            closable: closable,
            autoClose: autoClose,
            disappearTime: disappearTime,
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
    double curTopPadding = 0;
    double curBottomPadding = 0;
    AlignmentGeometry alignment;
    switch (widget.locationType) {
      case STToastLocationType.top:
        alignment = Alignment.topCenter;
        curTopPadding = widget.topPadding;
        break;
      case STToastLocationType.center:
        alignment = Alignment.center;
        break;
      case STToastLocationType.bottom:
        alignment = Alignment.bottomCenter;
        curBottomPadding = widget.bottomPadding;
        break;
    }
    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, curTopPadding, 0, curBottomPadding),
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
