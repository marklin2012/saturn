import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/platform.dart';
import 'common.dart';

class STAlert extends StatefulWidget {
  final double width;
  final String icon;
  final String message;
  final String description;
  final String closeText;
  final STAlertType type;
  final bool showIcon;
  final bool autoClose;
  final bool closable;
  final int disappearMilliseconds;

  final VoidCallback onCloseTap;

  const STAlert({
    Key key,
    @required this.type,
    @required this.message,
    @required this.showIcon,
    @required this.autoClose,
    @required this.closable,
    this.width,
    this.icon,
    this.description,
    this.closeText,
    this.onCloseTap,
    this.disappearMilliseconds,
  }) : super(
          key: key,
        );

  static void show(
      {@required BuildContext context,
      STAlertType type = STAlertType.info,
      @required String message,
      bool showIcon = false,
      bool autoClose = false,
      bool closable = false,
      double width,
      String icon,
      String description,
      String closeText,
      VoidCallback onCloseTap,
      int disappearMilliseconds =
          STAlertConstant.defaultDisappearMilliseconds}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          if (closable && onCloseTap == null) {
            onCloseTap = () {
              hide(context);
            };
          }

          final alert = STAlert(
            type: type,
            message: message,
            showIcon: showIcon,
            autoClose: autoClose,
            description: description,
            width: width,
            icon: icon,
            closable: closable,
            closeText: closeText,
            onCloseTap: onCloseTap,
            disappearMilliseconds: disappearMilliseconds,
          );

          if (closable) {
            return alert;
          } else {
            return GestureDetector(
              onTap: () {
                STAlert.hide(context);
              },
              child: alert,
            );
          }
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  _STAlertState createState() => _STAlertState();
}

class _STAlertState extends State<STAlert> with STAlertInterface {
  Timer timer;

  @override
  void initState() {
    super.initState();

    if (widget.autoClose) {
      timer = Timer(Duration(milliseconds: widget.disappearMilliseconds), () {
        STAlert.hide(context);
      });
    }
  }

  TextStyle titleStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: STAlertConstant.titleFontSize,
      decoration: TextDecoration.none);

  TextStyle messageStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: STAlertConstant.messageFontSize,
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    double curWidth = widget.width;
    double defaultWidth;
    if (getIsWeb()) {
      defaultWidth = screenWidth / 2.0;
    } else {
      defaultWidth = screenWidth - 16 * 2;
    }
    curWidth ??= defaultWidth;

    Widget closeInsideWidget = const Padding(
        padding: EdgeInsets.only(top: 3.0),
        child: Icon(
          Icons.close,
          color: Colors.grey,
          size: STAlertConstant.iconWidth,
        ));
    if (!isNullOrEmpty(widget.closeText)) {
      final double closeTextWidth =
          (widget.closeText.length >= STAlertConstant.closeTextMaxCount
                  ? STAlertConstant.closeTextMaxCount
                  : widget.closeText.length) *
              STAlertConstant.singleTextWidth;

      closeInsideWidget = SizedBox(
        width: closeTextWidth,
        child: Text(widget.closeText,
            textAlign: TextAlign.right,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: STAlertConstant.closeTextFontSize,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      );
    }

    return Center(
        child: Container(
      width: curWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(STAlertConstant.cornerRadius)),
      ),
      child: Container(
        width: curWidth,
        decoration: BoxDecoration(
          color: bgColorFromAlertType(widget.type),
          borderRadius: const BorderRadius.all(
              Radius.circular(STAlertConstant.cornerRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showIcon)
                Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                    top: 4,
                  ),
                  child: iconFromAlertType(widget.type),
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isNullOrEmpty(widget.message))
                          Expanded(
                            child: Text(
                              widget.message,
                              softWrap: true,
                              style: isNullOrEmpty(widget.description)
                                  ? messageStyle
                                  : titleStyle,
                            ),
                          ),
                        if (widget.closable)
                          GestureDetector(
                            onTap: () {
                              if (widget.onCloseTap != null) {
                                widget.onCloseTap();
                              }
                            },
                            child: closeInsideWidget,
                          ),
                      ],
                    ),
                    if (!isNullOrEmpty(widget.description))
                      const SizedBox(height: 8.0),
                    if (!isNullOrEmpty(widget.description))
                      Text(
                        widget.description,
                        style: messageStyle,
                      ),
                    if (!isNullOrEmpty(widget.description))
                      const SizedBox(height: 6.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  bool isNullOrEmpty(String str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget iconFromAlertType(STAlertType type) {
    IconData iconData;
    Color iconColor;
    switch (type) {
      case STAlertType.success:
        iconData = Icons.check_circle_outline;
        iconColor = STAlertConstant.colorSuccess;
        break;
      case STAlertType.error:
        iconData = Icons.cancel_outlined;
        iconColor = STAlertConstant.colorError;
        break;
      case STAlertType.warning:
        iconData = Icons.error_outline;
        iconColor = STAlertConstant.colorWarnning;
        break;
      default:
        iconData = Icons.info_outline;
        iconColor = STAlertConstant.colorInfo;
    }
    return Icon(
      iconData,
      size: STAlertConstant.iconWidth,
      color: iconColor,
    );
  }
}
