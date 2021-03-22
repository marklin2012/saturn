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
      List rowChildren, String icon, String text, VoidCallback tap) {
    switch (this.alertRightButtonType) {
      case STAlertRightButtonType.None:
        {}
        break;
      case STAlertRightButtonType.Icon:
        {
          rowChildren.add(GestureDetector(
            child: Image.asset(icon,
                width: STAlertConst.iconWidth,
                height: STAlertConst.iconWidth,
                repeat: ImageRepeat
                    .noRepeat, //当一个图片占不满容器的时候这个可以控制图片水平ImageRepeat.repeatX， 或者垂直ImageRepeat.repeatY  或者依次排列ImageRepeat.repeat，来占满   或者正常ImageRepeat.noRepeat
                fit: BoxFit.contain),
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
