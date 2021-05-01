import 'package:flutter/material.dart';

enum STTagType {
  primary,
  success,
  error,
  warning,
}

enum STTagShape {
  primary, // 主色
  outline, // 空心边框
  roundRect, // 圆角
  rightRoundRect, // 右侧圆角
}
enum STTagSize {
  big,
  normal,
  small,
}

class STTagConstant {
  static const Color colorPrimary = Color(0xFF095BF9);
  static const Color colorSuccess = Color(0xFF49C564);
  static const Color colorError = Color(0xFFFF4141);
  static const Color colorWarnning = Color(0xFFFFA927);
  static const double bigTextFont = 18.0;
  static const double normalTextFont = 16.0;
  static const double smallTextFont = 14.0;
}
