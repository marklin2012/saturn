import 'package:flutter/material.dart';
import 'future_utils.dart';
import 'common.dart';

class STAlert extends Dialog with STAlertInterface {
  final double width;
  final String icon;
  final String message;
  final String description;
  final String closeText;
  final STAlertType type;
  final bool showIcon;
  final bool autoClose;
  final bool closable;
  final int disappearTime;

  final VoidCallback onCloseTap;

  const STAlert({
    Key key,
    @required this.type,
    @required this.message,
    @required this.showIcon,
    @required this.autoClose,
    this.width = STAlertConstant.defaultWidth,
    this.icon,
    this.description,
    this.closeText,
    this.onCloseTap,
    this.disappearTime,
    this.closable = false,
  }) : super(
          key: key,
        );

  static void show(
      {@required BuildContext context,
      @required STAlertType type,
      @required String message,
      bool showIcon = false,
      bool autoClose = false,
      bool closable = false,
      double width = STAlertConstant.defaultWidth,
      String icon,
      String description,
      String closeText,
      VoidCallback onCloseTap,
      int disappearTime = STAlertConstant.defaultDisappearTime}) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          if (autoClose) {
            FutureUtils().delayedAction(() {
              hide(context);
            }, disappearTime);
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
            disappearTime: disappearTime,
          );

          return GestureDetector(
            onTap: () {
              STAlert.hide(context);
            },
            child: alert,
          );
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double curWidth = width > STAlertConstant.defaultWidth
        ? width
        : STAlertConstant.defaultWidth;
    Widget closeInsideWidget = const Padding(
        padding: EdgeInsets.only(top: 3.0),
        child: Icon(
          Icons.close,
          size: STAlertConstant.iconWidth,
        ));
    if (!isNullOrEmpty(closeText)) {
      final double closeTextWidth =
          (closeText.length >= STAlertConstant.closeTextMaxCount
                  ? STAlertConstant.closeTextMaxCount
                  : closeText.length) *
              STAlertConstant.singleTextWidth;

      closeInsideWidget = SizedBox(
        width: closeTextWidth,
        child: Text(closeText,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: STAlertConstant.closeTextFontSize,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      );
    }

    return Center(
      child: Container(
        width: curWidth,
        decoration: BoxDecoration(
          color: bgColorFromAlertType(type),
          borderRadius: const BorderRadius.all(
              Radius.circular(STAlertConstant.cornerRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showIcon)
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 12.0),
                  child: iconFromAlertType(type),
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isNullOrEmpty(message))
                          Expanded(
                            child: Text(
                              message,
                              softWrap: true,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: STAlertConstant.messageFontSize,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        if (closable)
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                if (onCloseTap != null) {
                                  onCloseTap();
                                }
                              },
                              child: closeInsideWidget,
                            ),
                          ),
                      ],
                    ),
                    if (!isNullOrEmpty(description))
                      Text(
                        description,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: STAlertConstant.descriptionFontSize,
                            decoration: TextDecoration.none),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
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

  Widget iconFromAlertType(STAlertType type) {
    IconData iconData;
    Color iconColor;
    switch (type) {
      case STAlertType.success:
        iconData = Icons.check;
        iconColor = STAlertConstant.colorSuccess;
        break;
      case STAlertType.error:
        iconData = Icons.error;
        iconColor = STAlertConstant.colorError;
        break;
      case STAlertType.warning:
        iconData = Icons.info;
        iconColor = STAlertConstant.colorWarnning;
        break;
      default:
        iconData = Icons.info;
        iconColor = STAlertConstant.colorInfo;
    }
    return Icon(
      iconData,
      size: STAlertConstant.iconWidth,
      color: iconColor,
    );
  }
}
