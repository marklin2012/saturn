import 'package:flutter/material.dart';
import 'st_alerts.dart';

class STAlertText extends STAlertTypeBtnTypeState {
  final String title;
  final String rightText;
  final IconData rightIcon;
  final VoidCallback onRightTap;
  final STAlertState alertState;
  final STAlertRightBtnType alertRightBtnType;

  const STAlertText(
      {Key key,
      @required this.title,
      this.rightText = "",
      this.rightIcon = null,
      this.onRightTap = null,
      this.alertState,
      this.alertRightBtnType})
      : super(
            key: key,
            alertState: alertState,
            alertRightBtnType: alertRightBtnType,
            alertType: STAlertType.Text);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    rowChildren.add(SizedBox(width: 16));
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
