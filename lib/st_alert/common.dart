import 'package:flutter/material.dart';

class STAlertConstant {
//定义的Color，带合并代码后迁移到ColorUtil中
//**************************************************************** */

  static const colorBlue = Color.fromRGBO(9, 91, 249, 0.12);
  static const colorGreen = Color.fromRGBO(73, 197, 100, 0.12);
  static const colorRed = Color.fromRGBO(255, 65, 65, 0.12);
  static const colorOrange = Color.fromRGBO(255, 169, 39, 0.12);
  static const colorBackground = Color.fromRGBO(255, 255, 255, 0.1);

//**************************************************************** */

  static const defaultWidth = 200.0; //默认宽度
  static const defaultHeight = 40.0;
  static const iconWidth = 17.0;

  static const cornerRadius = 4.0;

// Padding
  static const leftPadding = 16.0;
  static const rightPadding = 10.0;
  static const firstTextRightPadding = 5.0;
  static const iconTitlePadding = 14.0;

  static const secondTextWithIconLeftPadding =
      leftPadding + iconWidth + iconTitlePadding; //当类型为iconTitleText时，第二排文字的左边距
  static const firstTitleTopPading = 4.0;
  static const secondTextTopPading = 4.0;
  static const secondTextBottomPading = 4.0;

//Font
  static const textFontSize = 16.0;
  static const descriptionFontSize = 14.0;

  static const singleTextWidth = 15.0;
  static const rightTextCount = 4;
}

// alert类型,text纯文字，iconText图片加文字，textDescription 文字加说明,iconTextDescription 图片文字加说明
enum STAlertType { text, iconText, textDescription, iconTextDescription }
// alert状态
enum STAlertState { alert, success, danger, warning }
// alert右边按钮类型
enum STAlertRightButtonType { none, icon, text }
// alert是否自动消失
enum STAlertDisappearType { none, auto }
