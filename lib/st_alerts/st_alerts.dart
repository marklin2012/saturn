import 'package:flutter/material.dart';

//定义的Color，带合并代码后迁移到ColorUtil中
//**************************************************************** */

const color_alert_blue = Color.fromRGBO(9, 91, 249, 0.12);
const color_alert_green = Color.fromRGBO(73, 197, 100, 0.12);
const color_alert_red = Color.fromRGBO(255, 65, 65, 0.12);
const color_alert_orange = Color.fromRGBO(255, 169, 39, 0.12);

//**************************************************************** */

const STSizeW = 343.0;
const STSizeDefaultH = 40.0;

enum STAlertType { Text, Icon, Title, Icon_Title }
enum STAlertState { Alert, Success, Danger, Warning }
enum STAlertRightBtnType { None, Icon, Text }

abstract class STAlertTypeBtnTypeState extends StatelessWidget {
  final STAlertType alertType;
  final STAlertState alertState;
  final STAlertRightBtnType alertRightBtnType;

  const STAlertTypeBtnTypeState(
      {this.alertType = STAlertType.Text,
      this.alertState = STAlertState.Alert,
      this.alertRightBtnType = STAlertRightBtnType.None,
      Key key})
      : super(key: key);

  Color get backgroundColor {
    switch (alertState) {
      case STAlertState.Alert:
        {
          return color_alert_blue;
        }
      case STAlertState.Success:
        {
          return color_alert_green;
        }
      case STAlertState.Danger:
        {
          return color_alert_red;
        }
      case STAlertState.Warning:
        {
          return color_alert_orange;
        }
    }
  }

  List<Widget> addRightBtn(
      List rowChildren, IconData icon, String text, VoidCallback tap) {
    switch (this.alertRightBtnType) {
      case STAlertRightBtnType.None:
        {}
        break;
      case STAlertRightBtnType.Icon:
        {
          rowChildren.add(GestureDetector(
            child: Icon(icon, size: 17.0, color: Colors.blue),
            onTap: tap,
          ));
        }
        break;
      case STAlertRightBtnType.Text:
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
