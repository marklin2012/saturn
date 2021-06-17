import 'package:flutter/material.dart';

enum STProgressType {
  primary,
  percent,
  stepRect,
  stepDot,
  circle,
  dashboard,
}

enum STProgressStatus {
  primary,
  done,
  warning,
  error,
}

class STProgressConstant {
  static const defaultBackgroundColor = Color(0xFFEFF3F9);

  static const defaultSpace = 3.0;

  static const colorPrimary = Colors.blue;
  static const colorDone = Color(0xFF49C564);
  static const colorWarnning = Color(0xFFFFA927);
  static const colorError = Color(0xFFFF4141);
}
