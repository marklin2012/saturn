import 'package:flutter/material.dart';
import 'st_alert_utils.dart';

abstract class STAlertTypeButtonTypeState {
  Color stBackgroundColor(STAlertState state) {
    switch (state) {
      case STAlertState.alert:
        {
          return STAlertConst.colorAlertBlue;
        }
      case STAlertState.success:
        {
          return STAlertConst.colorAlertGreen;
        }
      case STAlertState.danger:
        {
          return STAlertConst.colorAlertRed;
        }
      case STAlertState.warning:
        {
          return STAlertConst.colorAlertOrange;
        }
    }
  }

  List<Widget> addRightButton(STAlertRightButtonType alertRightButtonType,
      List rowChildren, String icon, String text, VoidCallback tap) {
    switch (alertRightButtonType) {
      case STAlertRightButtonType.none:
        {}
        break;
      case STAlertRightButtonType.icon:
        {
          rowChildren.add(GestureDetector(
            child: Image.asset(icon,
                width: STAlertConst.iconWidth,
                height: STAlertConst.iconWidth,
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.contain),
            onTap: tap,
          ));
        }
        break;
      case STAlertRightButtonType.text:
        {
          rowChildren.add(GestureDetector(
            child: Text(text,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: STAlertConst.textFontSize,
                    decoration: TextDecoration.none)),
            onTap: tap,
          ));
        }
        break;
    }
    return rowChildren;
  }
}
