import 'dart:ffi';

import 'package:flutter/material.dart';

import 'st_alert_utils.dart';
import 'st_alert_icon_text.dart';
import 'st_alert_icon_title_text.dart';
import 'st_alert_text.dart';
import 'st_alert_title_text.dart';

class STAlerts extends StatelessWidget {
  static Widget show(
    BuildContext context,
    STAlertType alertType,
    STAlertState alertState,
    STAlertRightButtonType alertRightButtonType, {
    String text = "",
    String title = "",
    double width = STAlertConst.defaultWidth,
    String icon = "",
    String rightText = "",
    String rightIcon = "",
    VoidCallback onRightTap = null,
  }) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          var alert = null;

          switch (alertType) {
            case STAlertType.Text:
              {
                alert = new STAlertText(
                  title: title,
                  width: width,
                  rightText: rightText,
                  rightIcon: rightIcon,
                  alertState: alertState,
                  alertRightButtonType: alertRightButtonType,
                  onRightTap: onRightTap,
                );
              }
              break;

            case STAlertType.Icon:
              {
                alert = new STAlertIconText(
                  title: title,
                  width: width,
                  icon: icon,
                  rightText: rightText,
                  rightIcon: rightIcon,
                  alertState: alertState,
                  alertRightButtonType: alertRightButtonType,
                  onRightTap: onRightTap,
                );
              }
              break;

            case STAlertType.Title:
              {
                alert = new STAlertTitleText(
                  title: title,
                  width: width,
                  text: text,
                  rightText: rightText,
                  rightIcon: rightIcon,
                  alertState: alertState,
                  alertRightButtonType: alertRightButtonType,
                  onRightTap: onRightTap,
                );
              }
              break;

            case STAlertType.Icon_Title:
              {
                alert = new STAlertIconTitleText(
                  title: title,
                  width: width,
                  text: text,
                  icon: icon,
                  rightText: rightText,
                  rightIcon: rightIcon,
                  alertState: alertState,
                  alertRightButtonType: alertRightButtonType,
                  onRightTap: onRightTap,
                );
              }
              break;
          }
          return GestureDetector(
            child: alert,
            onTap: () {
              hide(context);
            },
          );
        });
  }

  static void hide(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
