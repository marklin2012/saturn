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

  static const defaultWidth = 200.0; //默认宽度
  static const defaultHeight = 40.0;
  static const iconWidth = 17.0;

  static const cornerRadius = 4.0;

// Padding
  static const leftPadding = 16.0;
  static const rightPadding = 16.0;
  static const iconTitlePadding = 14.0;

  static const secondTextWithIconLeftPadding =
      leftPadding + iconWidth + iconTitlePadding; //当类型为iconTitleText时，第二排文字的左边距
  static const firstTitleTopPading = 4.0;
  static const secondTextTopPading = 8.0;
  static const secondTextBottomPading = 4.0;

//Font
  static const titleFontSize = 18.0;
  static const textFontSize = 16.0;
}

// alert类型,text纯文字，iconText图片加文字，titleText标题加文字,iconTitleText 图片标题加文字
enum STAlertType { text, iconText, titleText, iconTitleText }
// alert状态
enum STAlertState { alert, success, danger, warning }
// alert右边按钮类型
enum STAlertRightButtonType { none, icon, text }
