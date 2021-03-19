import 'package:flutter/material.dart';
import 'st_alerts.dart';

class STAlertTitleText extends STAlertTypeBtnTypeState {
  final String title;
  final String text;
  final String rightText;
  final IconData rightIcon;
  final VoidCallback onRightTap;
  final STAlertState alertState;
  final STAlertRightBtnType alertRightBtnType;

  const STAlertTitleText(
      {Key key,
      @required this.title,
      @required this.text,
      this.rightText,
      this.rightIcon,
      this.onRightTap,
      this.alertState,
      this.alertRightBtnType})
      : super(
            key: key,
            alertState: alertState,
            alertRightBtnType: alertRightBtnType,
            alertType: STAlertType.Title);

  @override
  Widget build(BuildContext context) {
    List<Widget> firRowChildren = [];
    firRowChildren.add(SizedBox(width: 16));
    firRowChildren.add(Text(this.title,
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none)));
    List<Widget> rightChildren = [];
    rightChildren = this.addRightBtn(
        rightChildren, this.rightIcon, this.rightText, this.onRightTap);
    rightChildren.add(SizedBox(width: 16));

    List<Widget> secRowChildren = [];
    secRowChildren.add(SizedBox(width: 16));
    secRowChildren.add(SizedBox(
        width: STSizeW - 18 - 17 - 14 - 18,
        child: Text(this.text,
            softWrap: true,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                decoration: TextDecoration.none))));
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: STSizeW,
          decoration: new BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 4),
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
              SizedBox(height: 8),
              Row(
                children: secRowChildren,
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
