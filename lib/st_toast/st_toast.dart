import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/string.dart';
import 'common.dart';

class STToast extends StatefulWidget {
  final String message;
  final Widget icon;
  final bool isIconTop;
  final bool rotateAnimation;
  final STToastPosition position;
  final bool closable;
  final bool autoClose;
  final int disappearMilliseconds;
  final bool hasSafeArea;

  const STToast(
      {Key key,
      this.message,
      this.icon,
      this.isIconTop,
      this.rotateAnimation,
      this.position,
      this.closable,
      this.autoClose,
      this.disappearMilliseconds,
      this.hasSafeArea})
      : super(key: key);

  static void show({
    @required BuildContext context,
    @required String message,
    Widget icon,
    bool isIconUpText = false,
    STToastPosition locationType = STToastPosition.center,
    bool closable = false,
    bool autoClose = true,
    int disappearMilliseconds = STToastConstant.defaultDisappearMilliseconds,
    bool hasSafeArea = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: closable,
        barrierColor: Colors.transparent,
        builder: (context) {
          final toast = STToast(
            message: message,
            icon: icon,
            isIconTop: isIconUpText,
            rotateAnimation: false,
            position: locationType,
            closable: closable,
            autoClose: autoClose,
            disappearMilliseconds: disappearMilliseconds,
            hasSafeArea: hasSafeArea,
          );
          return toast;
        });
  }

  static void showLoading({
    @required BuildContext context,
    Widget icon,
    STToastPosition locationType = STToastPosition.center,
    bool hasSafeArea = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          final toast = STToast(
            message: "",
            icon: icon,
            isIconTop: false,
            rotateAnimation: true,
            position: locationType,
            closable: false,
            autoClose: false,
            disappearMilliseconds: STToastConstant.defaultDisappearMilliseconds,
            hasSafeArea: hasSafeArea,
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
      timer = Timer(Duration(milliseconds: widget.disappearMilliseconds), () {
        STToast.hide(context);
      });
    }

    if (!(widget.icon == null) && widget.rotateAnimation) {
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

    Widget iconWidget;
    if (widget.icon != null) {
      if (widget.rotateAnimation) {
        iconWidget = RotationTransition(turns: controller, child: widget.icon);
      } else {
        iconWidget = widget.icon;
      }
    }

    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(STToastConstant.cornerRadius),
      color: STToastConstant.defaultBackgroundColor,
    );

    Widget content;
    if (widget.icon == null) {
      content = Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: messageWidget);
    } else {
      if (isNullOrEmpty(widget.message)) {
        content = Padding(padding: const EdgeInsets.all(28), child: iconWidget);
      } else {
        if (widget.isIconTop) {
          content = Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [iconWidget, const SizedBox(height: 10), messageWidget],
            ),
          );
        } else {
          content = Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                iconWidget,
                const SizedBox(width: 10),
                Expanded(child: messageWidget)
              ],
            ),
          );
        }
      }
    }
    AlignmentGeometry alignment;
    switch (widget.position) {
      case STToastPosition.top:
        alignment = Alignment.topCenter;
        break;
      case STToastPosition.center:
        alignment = Alignment.center;
        break;
      case STToastPosition.bottom:
        alignment = Alignment.bottomCenter;
        break;
    }

    content = Align(
      alignment: alignment,
      child: Container(
          constraints: BoxConstraints(maxWidth: containerMaxWidth),
          decoration: boxDecoration,
          child: content),
    );
    if (widget.hasSafeArea) {
      return SafeArea(
        child: content,
      );
    }
    return content;
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.stop();
      controller.dispose();
    }
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
