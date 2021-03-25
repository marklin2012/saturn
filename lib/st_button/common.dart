import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

// 按钮相关常量
class STButtonConstant {
  static const bigWidth = 172.0; // 大按钮的宽度
  static const smallWidth = 84.0; // 小按钮的宽度
  static const bigHeight = 38.0; // 大按钮的最小高度
  static const smallHeight = 24.0; // 小按钮的最小高度
  static const smallSpace = 4.0; // 小按钮中的间距以及圆角
  static const bigSpace = 8.0; // 大按钮中的间距以及圆角
  static const bigEdgetInset = EdgeInsets.fromLTRB(16, 6, 16, 6); // 大按钮内容的inset
  static const smallEdgetInset =
      EdgeInsets.fromLTRB(12, 3, 12, 3); // 小按钮内容的inset
  static const iconWidth = 44.0; // 图形按钮的宽度
  static const iconPadding = EdgeInsets.all(10); // 图形按钮的padding,图形与外部内容的inset
}

abstract class STButtonInterface {
  Color bgColorFromButtonState(STButtonState state) {
    switch (state) {
      case STButtonState.success:
        return STColor.assistGreen;
      case STButtonState.danger:
        return STColor.assistRed;
      case STButtonState.focus:
        return STColor.secRankBlue;
      case STButtonState.disable:
        return STColor.fourRankBlue;
      default:
        return STColor.firRankBlue;
    }
  }

  double heightFromButtonSize(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConstant.smallHeight;
    } else {
      return STButtonConstant.bigHeight;
    }
  }

  double widthFromButtonSize(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConstant.smallWidth;
    } else {
      return STButtonConstant.bigWidth;
    }
  }

  double spaceFromButtonSize(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConstant.smallSpace;
    } else {
      return STButtonConstant.bigSpace;
    }
  }

  EdgeInsets edgeInsetsFromButtonSize(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConstant.smallEdgetInset;
    } else {
      return STButtonConstant.bigEdgetInset;
    }
  }
}

class STColor {
  // 基础色
  static const colorBlack = Color(0xFF000000);
  static const colorWhite = Color(0xFFFFFFFF);
  static const firRankBlue = Color(0xFF095BF9);
  static const secRankBlue = Color(0xFF4585FF);
  static const thrRankBlue = Color(0xFFA6C4FF);
  static const fourRankBlue = Color(0xFFDCE8FF);
// 辅助色
  static const assistRed = Color(0xFFFF4141);
  static const assistOrange = Color(0xFFFFA927);
  static const assistGreen = Color(0xFF49C564);
// 灰色
  static const firRankGrey = Color(0xFF787878);
  static const secRankGrey = Color(0xFFC4C5C7);
  static const thrRankGrey = Color(0xFFDFE2E7);
  static const fourRankGrey = Color(0xFFEFF3F9);
  static const botBackground = Color(0xFFFAFCFF);
// 字体色
  static const firRankFont = Color(0xFF000000);
  static const secRankFont = Color(0xFF555555);
  static const thrRankFont = Color(0xFF888888);
  static const fourRankFont = Color(0xFFBBBBBB);
// 遮罩
  static const shadeEight = Color.fromARGB(204, 0, 0, 0);
  static const shadeSix = Color.fromARGB(153, 0, 0, 0);
  static const shadeFive = Color.fromARGB(128, 0, 0, 0);
}
