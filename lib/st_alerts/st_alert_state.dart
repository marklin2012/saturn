import 'package:flutter/material.dart';
import 'st_alert_utils.dart';

abstract class STAlertTypeButtonTypeState extends Dialog {
  final STAlertType alertType;
  final STAlertState alertState;
  final STAlertRightButtonType alertRightButtonType;

  const STAlertTypeButtonTypeState(
      {this.alertType = STAlertType.Text,
      this.alertState = STAlertState.Alert,
      this.alertRightButtonType = STAlertRightButtonType.None,
      Key key})
      : super(key: key);

  Color get backgroundColor {
    switch (alertState) {
      case STAlertState.Alert:
        {
          return STAlertConst.colorAlertBlue;
        }
      case STAlertState.Success:
        {
          return STAlertConst.colorAlertGreen;
        }
      case STAlertState.Danger:
        {
          return STAlertConst.colorAlertRed;
        }
      case STAlertState.Warning:
        {
          return STAlertConst.colorAlertOrange;
        }
    }
  }

  List<Widget> addRightButton(
      List rowChildren, IconData icon, String text, VoidCallback tap) {
    switch (this.alertRightButtonType) {
      case STAlertRightButtonType.None:
        {}
        break;
      case STAlertRightButtonType.Icon:
        {
          rowChildren.add(GestureDetector(
            child: Icon(icon, size: 17.0, color: Colors.blue),
            onTap: tap,
          ));
        }
        break;
      case STAlertRightButtonType.Text:
        {
          rowChildren.add(GestureDetector(
            child: Text(text,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    decoration: TextDecoration.none)),
            onTap: tap,
          ));
        }
        break;
    }
    return rowChildren;
  }
}
