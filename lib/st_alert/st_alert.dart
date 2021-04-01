import 'package:flutter/material.dart';
import 'future_utils.dart';

class STAlertConstant {
//定义的Color，带合并代码后迁移到ColorUtil中
//**************************************************************** */

  static const colorInfo = Color(0xFF095BF9);
  static const colorSuccess = Color(0xFF49C564);
  static const colorError = Color(0xFFFF4141);
  static const colorWarnning = Color(0xFFFFA927);
  static const colorBackground = Color.fromRGBO(255, 255, 255, 0.1);

//**************************************************************** */

  static const defaultWidth = 200.0; //默认宽度
  static const defaultHeight = 40.0;
  static const iconWidth = 17.0;

  static const cornerRadius = 4.0;

// Padding
  static const verticalPadding = 8.0;
  static const horizontalPadding = 16.0;
  static const leftPadding = 16.0;
  static const rightPadding = 10.0;
  static const firstTextRightPadding = 5.0;
  static const iconTitlePadding = 14.0;
  static const rightButtonIconTopPadding = 4.0;
  static const rightButtonTextTopPadding = 2.0;

  static const secondTextWithIconLeftPadding =
      leftPadding + iconWidth + iconTitlePadding; //当类型为iconTitleText时，第二排文字的左边距
  static const firstTitleTopPading = 4.0;
  static const secondTextTopPading = 4.0;
  static const secondTextBottomPading = 4.0;

//Font
  static const textFontSize = 18.0;
  static const descriptionFontSize = 14.0;

  static const singleTextWidth = 15.0;
  static const closeTextCount = 4;

//Icon
  static const defaultLeftIcon = "assets/images/basketball_check.png";
  static const defaultRightIcon = "assets/images/basketball_check.png";
}

// alert 类型
enum STAlertType {
  info, // 信息 默认值
  success, // 成功
  error, // 危险
  warning, // 警告
}

class STAlert extends Dialog {
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
      String rightIcon,
      VoidCallback onCloseTap,
      int disappearTime = 5}) {
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
    Widget closeInsideWidget = const Icon(
      Icons.close,
      size: 16.0,
    );
    if (!isNullOrEmpty(closeText)) {
      closeInsideWidget = Text(
        closeText,
        style: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 16.0,
            decoration: TextDecoration.none),
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
                                  fontSize: STAlertConstant.textFontSize,
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
                            color: Colors.grey,
                            fontSize: STAlertConstant.descriptionFontSize,
                            decoration: TextDecoration.none),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
      size: 20.0,
      color: iconColor,
    );
  }

  Color bgColorFromAlertType(STAlertType state) {
    switch (state) {
      case STAlertType.info:
        return STAlertConstant.colorInfo.withOpacity(0.12);
      case STAlertType.success:
        return STAlertConstant.colorSuccess.withOpacity(0.12);
      case STAlertType.error:
        return STAlertConstant.colorError.withOpacity(0.12);
      case STAlertType.warning:
        return STAlertConstant.colorWarnning.withOpacity(0.12);
      default:
        return Colors.transparent;
    }
  }
}
