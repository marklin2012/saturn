import 'package:flutter/material.dart';
import 'st_alert_state.dart';
import 'st_alert_utils.dart';

class STAlertText extends STAlertTypeButtonTypeState {
  final double width;
  final String title;
  final String rightText;
  final String rightIcon;
  final VoidCallback onRightTap;
  final STAlertState alertState;
  final STAlertRightButtonType alertRightButtonType;

  const STAlertText(
      {Key key,
      @required this.title,
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
            alertType: STAlertType.text);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    rowChildren.add(const SizedBox(width: STAlertConst.leftPadding));
    rowChildren.add(Text(title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: STAlertConst.textFontSize,
            decoration: TextDecoration.none)));
    List<Widget> rightChildren = [];
    rightChildren =
        addRightButton(rightChildren, rightIcon, rightText, onRightTap);
    rightChildren.add(const SizedBox(width: STAlertConst.rightPadding));
    return Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: Center(
          child: Container(
            width: width > STAlertConst.defaultWidth
                ? width
                : STAlertConst.defaultWidth,
            height: STAlertConst.defaultHeight,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(
                  Radius.circular(STAlertConst.cornerRadius)),
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
        ));
  }
}
