import 'dart:ffi';

import 'package:flutter/material.dart';

import 'base.dart';
import 'common.dart';

class STAlert extends StatelessWidget {
  static void show(
      BuildContext context,
      STAlertType type,
      STAlertState state,
      STAlertRightButtonType rightButtonType,
      STAlertDisappearType disappearType,
      {String text = "",
      String description = "",
      double width = STAlertConstant.defaultWidth,
      String icon = "",
      String rightText = "",
      String rightIcon = "",
      VoidCallback onRightTap,
      int disappearTime = 5}) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          if (disappearType == STAlertDisappearType.auto) {
            Future.delayed(Duration(seconds: disappearTime), () {
              hide(context);
            });
          }

          STAlertBase alert;

          switch (type) {
            case STAlertType.text:
              {
                alert = STAlertBase.text(
                  text: text,
                  width: width,
                  rightText: rightText,
                  rightIcon: rightIcon,
                  state: state,
                  rightButtonType: rightButtonType,
                  onRightTap: onRightTap,
                );
              }
              break;

            case STAlertType.iconText:
              {
                alert = STAlertBase.iconText(
                  text: text,
                  icon: icon,
                  width: width,
                  rightText: rightText,
                  rightIcon: rightIcon,
                  state: state,
                  rightButtonType: rightButtonType,
                  onRightTap: onRightTap,
                );
              }
              break;

            case STAlertType.textDescription:
              {
                alert = STAlertBase.textDescription(
                  text: text,
                  description: description,
                  width: width,
                  rightText: rightText,
                  rightIcon: rightIcon,
                  state: state,
                  rightButtonType: rightButtonType,
                  onRightTap: onRightTap,
                );
              }
              break;

            case STAlertType.iconTextDescription:
              {
                alert = STAlertBase.iconTextDescription(
                  text: text,
                  description: description,
                  icon: icon,
                  width: width,
                  rightText: rightText,
                  rightIcon: rightIcon,
                  state: state,
                  rightButtonType: rightButtonType,
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
