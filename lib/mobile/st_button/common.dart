import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

// 提供四种状态
enum STButtonState {
  primary, // 默认
  highlighted, // 高亮
  loading, // 加载
  disabled, // 禁用
}

// 按钮相关常量
class STButtonConstant {
  // static const bigHeight = 38.0; // 大按钮的最小高度
  // static const smallHeight = 30.0; // 小按钮的最小高度
  // static const circleBigHeight = 44.0; // 图标大按钮的高度
  // static const circleSmallHeight = 32.0; // 图标小按钮的高度
  // static const iconWidth = 44.0; // 图形按钮的宽度
  static const smallSpace = 4.0; // 小按钮中的间距以及圆角
  static const bigSpace = 8.0; // 大按钮中的间距以及圆角
  static const bigPadding =
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0); // 大按钮内容的inset
  static const smallPadding =
      EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0); // 小按钮内容的inset
  static const iconSmallPadding = EdgeInsets.all(8.0); // 图形按钮的padding
  static const iconBigPadding = EdgeInsets.all(12.0); // 图形按钮的padding
}

abstract class STButtonInterface {
  Color bgColorFromButtonType(STButtonType type) {
    switch (type) {
      case STButtonType.success:
        return STColor.assistGreen;
      case STButtonType.danger:
        return STColor.assistRed;
      default:
        return STColor.firRankBlue;
    }
  }

  Color textColorFromButton(STButtonType type) {
    switch (type) {
      case STButtonType.primary:
        return STColor.colorWhite;
      case STButtonType.success:
        return STColor.colorWhite;
      case STButtonType.danger:
        return STColor.colorWhite;
      default:
        return STColor.firRankBlue;
    }
  }

  double textFontFromButton(STButtonSize size) {
    if (size == STButtonSize.small) {
      return 16.0;
    } else {
      return 18.0;
    }
  }

  double opacityFromButtonState(STButtonState state) {
    switch (state) {
      case STButtonState.highlighted:
        return 0.8;
      case STButtonState.disabled:
        return 0.2;
      default:
        return 1.0;
    }
  }

  // double heightFromButtonSize(STButtonSize size, {bool circle = false}) {
  //   if (size == STButtonSize.small) {
  //     return circle
  //         ? STButtonConstant.circleSmallHeight
  //         : STButtonConstant.smallHeight;
  //   } else {
  //     return circle
  //         ? STButtonConstant.circleBigHeight
  //         : STButtonConstant.bigHeight;
  //   }
  // }

  double spaceFromButtonSize(STButtonSize size) {
    if (size == STButtonSize.small) {
      return STButtonConstant.smallSpace;
    } else {
      return STButtonConstant.bigSpace;
    }
  }

  EdgeInsets edgeInsetsFromButtonSize(STButtonSize size,
      {bool circle, STButtonType type}) {
    if (circle) {
      if (size == STButtonSize.small) {
        return STButtonConstant.iconSmallPadding;
      } else {
        return STButtonConstant.iconBigPadding;
      }
    } else if (type == STButtonType.text) {
      return const EdgeInsets.all(0);
    } else {
      if (size == STButtonSize.small) {
        return STButtonConstant.smallPadding;
      } else {
        return STButtonConstant.bigPadding;
      }
    }
  }
}

class STColor {
  //背景色
  static const backgroundColor = Color(0xFFFAFCFF);
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
