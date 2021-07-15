import 'package:flutter/material.dart';

enum STMessageLocation { top, center, bottom }

enum STMessageType {
  info, // 信息 默认值
  success, // 成功
  error, // 危险
  warning, // 警告
  none
}

class STMessageConstant {
  static const colorInfo = Color(0xFF095BF9);
  static const colorSuccess = Color(0xFF49C564);
  static const colorError = Color(0xFFFF4141);
  static const colorWarnning = Color(0xFFFFA927);

  static const defaultWidthPercent = 0.9;
  static const iconMessageDistance = 8.0;

  static const cornerRadius = 8.0;

  static const titleFontSize = 17.0;
  static const messageFontSize = 16.0;
  static const explainFontSize = 14.0;

  static const defaultDisappearMilliseconds = 3000;

  static const iconWidth = 25.0;
}
