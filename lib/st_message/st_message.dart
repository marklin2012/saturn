import 'dart:async';

import 'package:flutter/material.dart';

import 'common.dart';

class STMessage extends StatefulWidget {
  final String title;
  final String message;
  final String icon;
  final Widget widget;
  final bool showShadow;
  final bool autoClose;
  final int disappearTime;

  const STMessage(
      {Key key,
      this.title,
      @required this.message,
      @required this.icon,
      this.widget,
      this.showShadow,
      this.autoClose,
      this.disappearTime})
      : super(key: key);

  static void show(
      {@required BuildContext context,
      String title,
      @required String message,
      @required String icon,
      Widget widget,
      bool showShadow = true,
      bool autoClose = false,
      int disappearTime = STMessageConstant.defaultDisappearTime}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) {
        final _message = STMessage(
            title: title,
            message: message,
            icon: icon,
            widget: widget,
            showShadow: showShadow,
            autoClose: autoClose,
            disappearTime: disappearTime);
        return _message;
      },
    );
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  _STMessageState createState() => _STMessageState();
}

class _STMessageState extends State<STMessage> {
  Timer timer;

  @override
  void initState() {
    super.initState();

    if (widget.autoClose) {
      timer = Timer(Duration(milliseconds: widget.disappearTime * 1000), () {
        STMessage.hide(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth =
        screenWidth * STMessageConstant.defaultWidthPercent;

    const TextStyle titleStyle = TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: STMessageConstant.titleFontSize,
        decoration: TextDecoration.none);

    const TextStyle messageStyle = TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: STMessageConstant.messageFontSize,
      decoration: TextDecoration.none,
    );

    Image imageWidget;
    if (!isNullOrEmpty(widget.icon)) {
      imageWidget = Image.asset(widget.icon,
          width: STMessageConstant.iconWidth,
          height: STMessageConstant.iconWidth,
          fit: BoxFit.contain);
    }

    Text titleWidget;
    if (!isNullOrEmpty(widget.title)) {
      titleWidget = Text(widget.title, softWrap: true, style: titleStyle);
    }

    final Text messageWidget = Text(
      widget.message,
      softWrap: true,
      style: messageStyle,
    );

    Color shadowColor = Colors.black26;
    if (!widget.showShadow) {
      shadowColor = Colors.transparent;
    }

    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(STMessageConstant.cornerRadius),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0),
            ],
          ),
          child: widget.widget ??
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 9, 14, 9),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              imageWidget,
                              const SizedBox(
                                width: STMessageConstant.iconMessageDistance,
                              ),
                              if (!isNullOrEmpty(widget.title))
                                Expanded(child: titleWidget)
                              else
                                Expanded(child: messageWidget)
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (!isNullOrEmpty(widget.title)) messageWidget,
                  ],
                ),
              ),
        ));
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
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
