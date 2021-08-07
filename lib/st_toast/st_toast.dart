import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/platform.dart';
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
  final STToastType type;

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
      this.hasSafeArea,
      this.type})
      : super(key: key);

  static void show(
      {@required BuildContext context,
      @required String message,
      Widget icon,
      bool isIconTop = false,
      STToastPosition position = STToastPosition.center,
      bool closable = false,
      bool autoClose = true,
      int disappearMilliseconds = STToastConstant.defaultDisappearMilliseconds,
      bool hasSafeArea = true,
      STToastType type = STToastType.none}) {
    showDialog(
        context: context,
        barrierDismissible: closable,
        barrierColor: Colors.transparent,
        builder: (context) {
          final toast = STToast(
              message: message,
              icon: icon,
              isIconTop: isIconTop,
              rotateAnimation: false,
              position: position,
              closable: closable,
              autoClose: autoClose,
              disappearMilliseconds: disappearMilliseconds,
              hasSafeArea: hasSafeArea,
              type: type);
          return toast;
        });
  }

  static void showLoading(
      {@required BuildContext context,
      Widget icon,
      STToastPosition position = STToastPosition.center,
      bool hasSafeArea = true,
      STToastType type = STToastType.none}) {
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
            position: position,
            closable: false,
            autoClose: false,
            disappearMilliseconds: STToastConstant.defaultDisappearMilliseconds,
            hasSafeArea: hasSafeArea,
            type: type,
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

    Widget iconWidget = widget.icon;
    if (iconWidget == null && widget.type != STToastType.none) {
      iconWidget = iconFromAlertType(widget.type);
    }
    if (iconWidget != null && widget.rotateAnimation) {
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

    Widget iconWidget = widget.icon;
    if (iconWidget == null && widget.type != STToastType.none) {
      iconWidget = iconFromAlertType(widget.type);
    }
    if (iconWidget != null && widget.rotateAnimation) {
      iconWidget = RotationTransition(turns: controller, child: iconWidget);
    }

    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(STToastConstant.cornerRadius),
      color: STToastConstant.defaultBackgroundColor,
    );

    Widget content;
    if (iconWidget == null) {
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
                if (getIsWeb())
                  messageWidget
                else
                  Expanded(
                    child: messageWidget,
                  ),
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

  Widget iconFromAlertType(STToastType type) {
    IconData iconData;
    Color iconColor = Colors.white;
    switch (type) {
      case STToastType.success:
        iconData = Icons.check_circle_outline;
        break;
      case STToastType.error:
        iconData = Icons.cancel_outlined;
        break;
      case STToastType.warning:
        iconData = Icons.error_outline;
        break;
      case STToastType.info:
        iconData = Icons.info_outline;
        break;
      default:
    }
    return Icon(
      iconData,
      size: STToastConstant.iconWidth,
      color: iconColor,
    );
  }
}
