import 'package:flutter/material.dart';

// alert 类型
enum STAlertType {
  info, // 信息 默认值
  success, // 成功
  error, // 危险
  warning, // 警告
}

class STAlertConstant {
//定义的Color，带合并代码后迁移到ColorUtil中
//**************************************************************** */

  static const colorInfo = Color(0xFF095BF9);
  static const colorSuccess = Color(0xFF49C564);
  static const colorError = Color(0xFFFF4141);
  static const colorWarnning = Color(0xFFFFA927);

//**************************************************************** */

  static const defaultWidth = 340.0; //默认宽度
  static const defaultHeight = 40.0;
  static const iconWidth = 18.0;

  static const cornerRadius = 4.0;

//Font
  static const titleFontSize = 18.0;
  static const messageFontSize = 16.0;
  static const closeTextFontSize = 16.0;

  static const closeTextMaxCount = 4;
  static const singleTextWidth = 16.0;

//Icon
  static const defaultLeftIcon = "assets/images/basketball_check.png";
  static const defaultRightIcon = "assets/images/basketball_check.png";

  //
  static const defaultDisappearMilliseconds = 3000;
}

abstract class STAlertInterface {
  Color bgColorFromAlertType(STAlertType state) {
    switch (state) {
      case STAlertType.info:
        return STAlertConstant.colorInfo.withOpacity(0.12);
      case STAlertType.success:
        return STAlertConstant.colorSuccess.withOpacity(0.12);
      case STAlertType.error:
        return STAlertConstant.colorError.withOpacity(0.12);
      case STAlertType.warning:
        return STAlertConstant.colorWarnning.withOpacity(0.12);
      default:
        return Colors.transparent;
    }
  }
}
