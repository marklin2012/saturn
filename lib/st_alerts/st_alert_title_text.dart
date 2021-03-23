import 'package:flutter/material.dart';
import 'st_alert_state.dart';
import 'st_alert_utils.dart';

class STAlertTitleText extends STAlertTypeButtonTypeState {
  final double width;
  final String title;
  final String text;
  final String rightText;
  final String rightIcon;
  final VoidCallback onRightTap;
  final STAlertState alertState;
  final STAlertRightButtonType alertRightButtonType;

  const STAlertTitleText(
      {Key key,
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
            alertType: STAlertType.title);

  @override
  Widget build(BuildContext context) {
    List<Widget> firRowChildren = [];
    firRowChildren.add(const SizedBox(width: STAlertConst.leftPadding));
    firRowChildren.add(Text(title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: STAlertConst.titleFontSize,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none)));
    List<Widget> rightChildren = [];
    rightChildren =
        addRightButton(rightChildren, rightIcon, rightText, onRightTap);
    rightChildren.add(const SizedBox(width: STAlertConst.rightPadding));

    List<Widget> secRowChildren = [];
    secRowChildren.add(const SizedBox(width: STAlertConst.leftPadding));
    secRowChildren.add(SizedBox(
        width: (width > STAlertConst.defaultWidth
                ? width
                : STAlertConst.defaultWidth) -
            STAlertConst.secondTextLeftPadding -
            STAlertConst.rightPadding,
        child: Text(text,
            softWrap: true,
            style: const TextStyle(
                color: Colors.black,
                fontSize: STAlertConst.textFontSize,
                decoration: TextDecoration.none))));
    return Center(
      child: Container(
        width: STAlertConst.defaultWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
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
}
