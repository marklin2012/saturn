import 'package:flutter/material.dart';
import 'st_alerts.dart';
import 'st_alert_utils.dart';

class STAlertIconText extends STAlertTypeButtonTypeState {
  final String title;
  final IconData icon;
  final String rightText;
  final IconData rightIcon;
  final VoidCallback onRightTap;
  final STAlertState alertState;
  final STAlertRightButtonType alertRightBtnType;

  const STAlertIconText(
      {Key key,
      @required this.title,
      this.icon,
      this.rightText,
      this.rightIcon,
      this.onRightTap,
      this.alertState,
      this.alertRightBtnType})
      : super(
            key: key,
            alertState: alertState,
            alertRightBtnType: alertRightBtnType,
            alertType: STAlertType.Icon);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    rowChildren.add(SizedBox(width: STAlertConst.leftPadding));
    rowChildren
        .add(Icon(this.icon, size: STAlertConst.iconWidth, color: Colors.blue));
    rowChildren.add(SizedBox(width: STAlertConst.iconTitlePadding));
    rowChildren.add(Text(this.title,
        style: TextStyle(
            color: Colors.black,
            fontSize: STAlertConst.textFontSize,
            decoration: TextDecoration.none)));
    List<Widget> rightChildren = [];
    rightChildren = this.addRightBtn(
        rightChildren, this.rightIcon, this.rightText, this.onRightTap);
    rightChildren.add(SizedBox(width: STAlertConst.rightPadding));

    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: STAlertConst.defaultWidth,
          height: STAlertConst.defaultHeight,
          decoration: new BoxDecoration(
            color: backgroundColor,
            borderRadius:
                BorderRadius.all(Radius.circular(STAlertConst.cornerRadius)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: rowChildren,
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
      ),
    );
  }
}
