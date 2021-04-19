import 'dart:async';

import 'package:flutter/material.dart';

import 'common.dart';
import '../utils/string.dart';

class STMessageSharedInstance {
  BuildContext _curContext;
  OverlayEntry _curOverlayEntry;
  factory STMessageSharedInstance() => _sharedInstance();

  static STMessageSharedInstance _instance;

  STMessageSharedInstance._() {}

  static STMessageSharedInstance _sharedInstance() {
    return _instance ??= STMessageSharedInstance._();
  }

  void show({
    @required BuildContext context,
    String title,
    String message,
    String icon,
    Widget widget,
    bool showShadow = true,
    bool autoClose = false,
    int disappearTime = STMessageConstant.defaultDisappearTime,
    STMessageLocationType locationType = STMessageLocationType.top,
    bool haveSafeArea = true,
  }) {
    if (_curContext != null) {
      hide(context);
    }

    final _message = STMessage(
      title: title,
      message: message,
      icon: icon,
      widget: widget,
      showShadow: showShadow,
      autoClose: autoClose,
      disappearTime: disappearTime,
      locationType: locationType,
      haveSafeArea: haveSafeArea,
    );

    final OverlayState overlayState = Overlay.of(context);
    _curOverlayEntry =
        OverlayEntry(builder: (BuildContext context) => _message);
    overlayState.insert(_curOverlayEntry);
    _curContext = context;
  }

  void hide(
    BuildContext context,
  ) {
    _curOverlayEntry.remove();
    _curContext = null;
  }
}

class STMessage extends StatefulWidget {
  final String title;
  final String message;
  final String icon;
  final Widget widget;
  final bool showShadow;
  final bool autoClose;
  final int disappearTime;
  final STMessageLocationType locationType;
  final bool haveSafeArea;

  const STMessage({
    Key key,
    this.title,
    this.message,
    this.icon,
    this.widget,
    this.showShadow,
    this.autoClose,
    this.disappearTime,
    this.locationType,
    this.haveSafeArea,
  }) : super(key: key);

  @override
  _STMessageState createState() => _STMessageState();
}

class _STMessageState extends State<STMessage> {
  Timer timer;

  @override
  void initState() {
    super.initState();

    if (widget.autoClose) {
      timer = Timer(Duration(seconds: widget.disappearTime), () {
        STMessageSharedInstance().hide(context);
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

    Text messageWidget;
    if (!isNullOrEmpty(widget.message)) {
      messageWidget = Text(
        widget.message,
        softWrap: true,
        style: messageStyle,
      );
    }

    Color shadowColor = Colors.black26;
    if (!widget.showShadow) {
      shadowColor = Colors.transparent;
    }

    double topMargin = 0;
    double bottomMargin = 0;
    AlignmentGeometry curAlignment;
    switch (widget.locationType) {
      case STMessageLocationType.top:
        {
          curAlignment = Alignment.topCenter;
          topMargin =
              widget.haveSafeArea ? MediaQuery.of(context).padding.top : 0;
        }
        break;
      case STMessageLocationType.center:
        curAlignment = Alignment.center;
        break;
      case STMessageLocationType.bottom:
        {
          curAlignment = Alignment.bottomCenter;
          bottomMargin =
              widget.haveSafeArea ? MediaQuery.of(context).padding.bottom : 0;
        }
        break;
    }

    return Align(
      alignment: curAlignment,
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, topMargin, 0, bottomMargin),
          child: Container(
            width: containerWidth,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(STMessageConstant.cornerRadius),
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
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
          )),
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
