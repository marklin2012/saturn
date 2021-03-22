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
    IconData icon = null,
    String rightText = "",
    IconData rightIcon = null,
    VoidCallback onRightTap = null,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          switch (alertType) {
            case STAlertType.Text:
              return new STAlertText(
                title: title,
                width: width,
                rightText: rightText,
                rightIcon: rightIcon,
                alertState: alertState,
                alertRightButtonType: alertRightButtonType,
                onRightTap: onRightTap,
              );

            case STAlertType.Icon:
              return new STAlertIconText(
                title: title,
                width: width,
                icon: icon,
                rightText: rightText,
                rightIcon: rightIcon,
                alertState: alertState,
                alertRightButtonType: alertRightButtonType,
                onRightTap: onRightTap,
              );

            case STAlertType.Title:
              return new STAlertTitleText(
                title: title,
                width: width,
                text: text,
                rightText: rightText,
                rightIcon: rightIcon,
                alertState: alertState,
                alertRightButtonType: alertRightButtonType,
                onRightTap: onRightTap,
              );

            case STAlertType.Icon_Title:
              return new STAlertIconTitleText(
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
            default:
              return null;
          }
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
