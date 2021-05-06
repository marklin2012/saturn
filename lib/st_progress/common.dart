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
}
