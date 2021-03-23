import 'package:flutter/material.dart';

class STAlertConst {
//定义的Color，带合并代码后迁移到ColorUtil中
//**************************************************************** */

  static const colorAlertBlue = Color.fromRGBO(9, 91, 249, 0.12);
  static const colorAlertGreen = Color.fromRGBO(73, 197, 100, 0.12);
  static const colorAlertRed = Color.fromRGBO(255, 65, 65, 0.12);
  static const colorAlertOrange = Color.fromRGBO(255, 169, 39, 0.12);
  static const colorAlertBackground = Color.fromRGBO(255, 255, 255, 0.1);

//**************************************************************** */

  static const defaultWidth = 200.0;
  static const defaultHeight = 40.0;
  static const iconWidth = 17.0;

  static const cornerRadius = 4.0;

  static const leftPadding = 16.0;
  static const rightPadding = 16.0;
  static const iconTitlePadding = 14.0;
  static const secondTextLeftPadding =
      leftPadding + iconWidth + iconTitlePadding;
  static const firstTitleTopPading = 4.0;
  static const secondTextTopPading = 8.0;
  static const secondTextBottomPading = 4.0;

//Font
  static const titleFontSize = 18.0;
  static const textFontSize = 16.0;
}

enum STAlertType { text, icon, title, iconTitle }
enum STAlertState { alert, success, danger, warning }
enum STAlertRightButtonType { none, icon, text }
