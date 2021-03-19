import 'package:flutter/material.dart';
import 'st_alerts.dart';

class STAlertIconText extends STAlertTypeBtnTypeState {
  final String title;
  final IconData icon;
  final String rightText;
  final IconData rightIcon;
  final VoidCallback onRightTap;
  final STAlertState alertState;
  final STAlertRightBtnType alertRightBtnType;

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
    rowChildren.add(SizedBox(width: 18));
    rowChildren.add(Icon(this.icon, size: 17.0, color: Colors.blue));
    rowChildren.add(SizedBox(width: 14));
    rowChildren.add(Text(this.title,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            decoration: TextDecoration.none)));
    List<Widget> rightChildren = [];
    rightChildren = this.addRightBtn(
        rightChildren, this.rightIcon, this.rightText, this.onRightTap);
    rightChildren.add(SizedBox(width: 16));

    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: STSizeW,
          height: STSizeDefaultH,
          decoration: new BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
