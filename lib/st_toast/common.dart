import 'package:flutter/material.dart';

enum STToastPosition { top, center, bottom }

enum STToastType {
  info, // 信息 默认值
  success, // 成功
  error, // 危险
  warning, // 警告
  none
}

class STToastConstant {
  static const maxWidthPercent = 0.9;

  static const messageFontSize = 16.0;

  static const cornerRadius = 8.0;

  static const defaultBackgroundColor = Color.fromRGBO(0, 0, 0, 0.8);

  static const defaultDisappearMilliseconds = 3000;

  static const iconWidth = 25.0;
}
