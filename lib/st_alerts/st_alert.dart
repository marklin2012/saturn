import 'package:flutter/material.dart';
import 'st_alert_state.dart';
import 'st_alert_utils.dart';

class STAlert extends Dialog with STAlertTypeButtonTypeState {
  final double width;
  final String icon;
  final String title;
  final String text;
  final String rightText;
  final String rightIcon;
  final VoidCallback onRightTap;
  final STAlertType alertType;
  final STAlertState alertState;
  final STAlertRightButtonType alertRightButtonType;

  const STAlert(
      {Key key,
      this.icon,
      this.title,
      this.text,
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConst.defaultWidth,
      this.onRightTap = null,
      this.alertType,
      this.alertState,
      this.alertRightButtonType})
      : super(
          key: key,
        );
  const STAlert.text(
      {Key key,
      @required this.text,
      this.icon = "",
      this.title = "",
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConst.defaultWidth,
      this.onRightTap = null,
      this.alertType = STAlertType.text,
      this.alertState,
      this.alertRightButtonType})
      : super(
          key: key,
        );

  const STAlert.iconText(
      {Key key,
      @required this.icon,
      @required this.text,
      this.title = "",
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConst.defaultWidth,
      this.onRightTap = null,
      this.alertType = STAlertType.iconText,
      this.alertState,
      this.alertRightButtonType})
      : super(
          key: key,
        );

  const STAlert.titleText(
      {Key key,
      @required this.title,
      @required this.text,
      this.icon = "",
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConst.defaultWidth,
      this.onRightTap = null,
      this.alertType = STAlertType.titleText,
      this.alertState,
      this.alertRightButtonType})
      : super(
          key: key,
        );

  const STAlert.iconTitleText(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.text,
      this.rightText = "",
      this.rightIcon = "",
      this.width = STAlertConst.defaultWidth,
      this.onRightTap = null,
      this.alertType = STAlertType.iconTitleText,
      this.alertState,
      this.alertRightButtonType})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    List<Widget> firRowChildren = [];
    firRowChildren.add(const SizedBox(width: STAlertConst.leftPadding));

    //第一行添加图片
    if (alertType == STAlertType.iconTitleText ||
        alertType == STAlertType.iconText) {
      firRowChildren.add(Image.asset(icon,
          width: STAlertConst.iconWidth,
          height: STAlertConst.iconWidth,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.contain));
      firRowChildren.add(const SizedBox(width: STAlertConst.iconTitlePadding));
    }

    //第一行添加左边文字
    if (alertType == STAlertType.titleText ||
        alertType == STAlertType.iconTitleText) {
      firRowChildren.add(Text(title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: STAlertConst.titleFontSize,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none)));
    } else {
      firRowChildren.add(Text(text,
          style: const TextStyle(
              color: Colors.black,
              fontSize: STAlertConst.textFontSize,
              decoration: TextDecoration.none)));
    }

    //添加右边控件
    List<Widget> rightChildren = [];
    rightChildren = addRightButton(
        alertRightButtonType, rightChildren, rightIcon, rightText, onRightTap);
    rightChildren.add(const SizedBox(width: STAlertConst.rightPadding));

    //添加第二排
    double curLeftPadding = 0;
    if (alertType == STAlertType.iconTitleText ||
        alertType == STAlertType.iconText) {
      curLeftPadding = STAlertConst.secondTextWithIconLeftPadding;
    } else {
      curLeftPadding = STAlertConst.leftPadding;
    }
    List<Widget> secRowChildren = [];
    secRowChildren.add(SizedBox(width: curLeftPadding));
    secRowChildren.add(SizedBox(
        width: (width > STAlertConst.defaultWidth
                ? width
                : STAlertConst.defaultWidth) -
            curLeftPadding -
            STAlertConst.rightPadding,
        child: Text(text,
            softWrap: true,
            style: const TextStyle(
                color: Colors.black,
                fontSize: STAlertConst.textFontSize,
                decoration: TextDecoration.none))));

    //搭建widget
    var widget;
    if (alertType == STAlertType.text || alertType == STAlertType.iconText) {
      widget = Center(
        child: Container(
          width: width > STAlertConst.defaultWidth
              ? width
              : STAlertConst.defaultWidth,
          height: STAlertConst.defaultHeight,
          decoration: BoxDecoration(
            color: stBackgroundColor(alertState),
            borderRadius: const BorderRadius.all(
                Radius.circular(STAlertConst.cornerRadius)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: firRowChildren,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: rightChildren,
                  )),
            ],
          ),
        ),
      );
    } else {
      widget = Center(
        child: Container(
          width: width > STAlertConst.defaultWidth
              ? width
              : STAlertConst.defaultWidth,
          decoration: BoxDecoration(
            color: stBackgroundColor(alertState),
            borderRadius: const BorderRadius.all(
                Radius.circular(STAlertConst.cornerRadius)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: STAlertConst.firstTitleTopPading),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: firRowChildren,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: rightChildren,
                      )),
                ],
              ),
              const SizedBox(height: STAlertConst.secondTextTopPading),
              Row(
                children: secRowChildren,
              ),
              const SizedBox(height: STAlertConst.secondTextBottomPading),
            ],
          ),
        ),
      );
    }
    return widget;
  }
}
