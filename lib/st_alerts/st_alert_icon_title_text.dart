import 'package:flutter/material.dart';
import 'st_alert_state.dart';
import 'st_alert_utils.dart';

class STAlertIconTitleText extends STAlertTypeButtonTypeState {
  final double width;
  final IconData icon;
  final String title;
  final String text;
  final String rightText;
  final IconData rightIcon;
  final VoidCallback onRightTap;
  final STAlertState alertState;
  final STAlertRightButtonType alertRightButtonType;

  const STAlertIconTitleText(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.text,
      this.rightText = "",
      this.rightIcon = null,
      this.width = STAlertConst.defaultWidth,
      this.onRightTap = null,
      this.alertState,
      this.alertRightButtonType})
      : super(
            key: key,
            alertState: alertState,
            alertRightButtonType: alertRightButtonType,
            alertType: STAlertType.Icon_Title);

  @override
  Widget build(BuildContext context) {
    List<Widget> firRowChildren = [];
    firRowChildren.add(SizedBox(width: STAlertConst.leftPadding));
    firRowChildren
        .add(Icon(this.icon, size: STAlertConst.iconWidth, color: Colors.blue));
    firRowChildren.add(SizedBox(width: STAlertConst.iconTitlePadding));
    firRowChildren.add(Text(this.title,
        style: TextStyle(
            color: Colors.black,
            fontSize: STAlertConst.titleFontSize,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none)));
    List<Widget> rightChildren = [];
    rightChildren = this.addRightButton(
        rightChildren, this.rightIcon, this.rightText, this.onRightTap);
    rightChildren.add(SizedBox(width: STAlertConst.rightPadding));

    List<Widget> secRowChildren = [];
    secRowChildren.add(SizedBox(width: STAlertConst.secondTextLeftPadding));
    secRowChildren.add(SizedBox(
        width: (this.width > STAlertConst.defaultWidth
                ? this.width
                : STAlertConst.defaultWidth) -
            STAlertConst.secondTextLeftPadding -
            STAlertConst.rightPadding,
        child: Text(this.text,
            softWrap: true,
            style: TextStyle(
                color: Colors.black,
                fontSize: STAlertConst.textFontSize,
                decoration: TextDecoration.none))));

    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: this.width > STAlertConst.defaultWidth
              ? this.width
              : STAlertConst.defaultWidth,
          decoration: new BoxDecoration(
            color: backgroundColor,
            borderRadius:
                BorderRadius.all(Radius.circular(STAlertConst.cornerRadius)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: STAlertConst.firstTitleTopPading),
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
              SizedBox(height: STAlertConst.secondTextTopPading),
              Row(
                children: secRowChildren,
              ),
              SizedBox(height: STAlertConst.secondTextBottomPading),
            ],
          ),
        ),
      ),
    );
  }
}
